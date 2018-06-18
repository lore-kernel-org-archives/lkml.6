Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46637C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025F9208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025F9208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966146AbeFRJhY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:37:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55850 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935917AbeFRIXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:23:40 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 95D03C74;
        Mon, 18 Jun 2018 08:23:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 182/279] bpf: use array_index_nospec in find_prog_type
Date:   Mon, 18 Jun 2018 10:12:47 +0200
Message-Id: <20180618080616.472099979@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit d0f1a451e33d9ca834422622da30aa68daade56b ]

Commit 9ef09e35e521 ("bpf: fix possible spectre-v1 in find_and_alloc_map()")
converted find_and_alloc_map() over to use array_index_nospec() to sanitize
map type that user space passes on map creation, and this patch does an
analogous conversion for progs in find_prog_type() as it's also passed from
user space when loading progs as attr->prog_type.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/syscall.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -872,11 +872,17 @@ static const struct bpf_prog_ops * const
 
 static int find_prog_type(enum bpf_prog_type type, struct bpf_prog *prog)
 {
-	if (type >= ARRAY_SIZE(bpf_prog_types) || !bpf_prog_types[type])
+	const struct bpf_prog_ops *ops;
+
+	if (type >= ARRAY_SIZE(bpf_prog_types))
+		return -EINVAL;
+	type = array_index_nospec(type, ARRAY_SIZE(bpf_prog_types));
+	ops = bpf_prog_types[type];
+	if (!ops)
 		return -EINVAL;
 
 	if (!bpf_prog_is_dev_bound(prog->aux))
-		prog->aux->ops = bpf_prog_types[type];
+		prog->aux->ops = ops;
 	else
 		prog->aux->ops = &bpf_offload_prog_ops;
 	prog->type = type;


