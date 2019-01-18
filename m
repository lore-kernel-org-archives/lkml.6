Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B39C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DB120823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547816303;
	bh=a3MFxRbkHlEMNLU4LFrt4AA7jVDj/AkT0ntlpJzBIDU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=OoXeFPqqTSjYPOUFMQSkzc2KicZKA93ngbzCus+aPqAhfBdMsb1YrZ/eB9DX8hWag
	 Cypq/KS2DXFoHlnU11UMifFyvsSi5lpCLGk2/OuA+Ka9GHRQf1sSZTE6kkvyxcYBiS
	 rjVkKLXNf2u5d+8Wcpm4bWHRhD8gsupQOqPOlEzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfARM6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:58:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfARM6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:58:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51F9C2CD7EB;
        Fri, 18 Jan 2019 12:58:20 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.205.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E8C519741;
        Fri, 18 Jan 2019 12:58:18 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Lance Digby <ldigby@redhat.com>
Subject: [PATCH] bpftool: Fix prog dump by tag
Date:   Fri, 18 Jan 2019 13:58:17 +0100
Message-Id: <20190118125817.10763-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 18 Jan 2019 12:58:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lance reported an issue with bpftool not being able to
dump program if there are more programs loaded and you
want to dump any but the first program, like:

  # bpftool prog
  28: kprobe  name trace_req_start  tag 1dfc28ba8b3dd597  gpl
  	loaded_at 2019-01-18T17:02:40+1100  uid 0
  	xlated 112B  jited 109B  memlock 4096B  map_ids 13
  29: kprobe  name trace_req_compl  tag 5b6a5ecc6030a683  gpl
  	loaded_at 2019-01-18T17:02:40+1100  uid 0
  	xlated 928B  jited 575B  memlock 4096B  map_ids 13,14
  #  bpftool prog dum jited tag 1dfc28ba8b3dd597
   0:	push   %rbp
   1:	mov    %rsp,%rbp
  ...

  #  bpftool prog dum jited tag 5b6a5ecc6030a683
  Error: can't get prog info (29): Bad address

The problem is in the prog_fd_by_tag function not cleaning
the struct bpf_prog_info before another request, so the
previous program length is still in there and kernel assumes
it needs to dump the program, which fails because there's no
user pointer set.

Moving the struct bpf_prog_info declaration into the loop,
so it gets cleaned before each query.

Reported-by: Lance Digby <ldigby@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/prog.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 2d1bb7d6ff51..b54ed82b9589 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -78,13 +78,14 @@ static void print_boot_time(__u64 nsecs, char *buf, unsigned int size)
 
 static int prog_fd_by_tag(unsigned char *tag)
 {
-	struct bpf_prog_info info = {};
-	__u32 len = sizeof(info);
 	unsigned int id = 0;
 	int err;
 	int fd;
 
 	while (true) {
+		struct bpf_prog_info info = {};
+		__u32 len = sizeof(info);
+
 		err = bpf_prog_get_next_id(id, &id);
 		if (err) {
 			p_err("%s", strerror(errno));
-- 
2.17.2

