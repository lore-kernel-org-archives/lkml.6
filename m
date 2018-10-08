Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628D5C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E359214C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SK+MHcPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E359214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbeJICBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbeJICA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:00:59 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F68D204FD;
        Mon,  8 Oct 2018 18:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024472;
        bh=2FHM7imDNLwTlUppCa6ZvIYx3O+BSlvO5RCQt+Ly+F4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SK+MHcPMv4r+NowG2FWQc3IyhggkGvx/kLqsVD3mdpL+uJAdJ1jciEYZxxmRCV7zc
         rl3ztdCgJSWXrybZCROL+/vJGJerTep0iIOdhMYAUVlxH1A/XlZGiIBh/QHgyUVhQx
         u8Cuv26TmM2WDSDeEdugor5LuuGKD8TSA/2nIzcE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tushar Dave <tushar.n.dave@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 051/168] bpf: Fix bpf_msg_pull_data()
Date:   Mon,  8 Oct 2018 20:30:31 +0200
Message-Id: <20181008175621.993081117@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tushar Dave <tushar.n.dave@oracle.com>

[ Upstream commit 9db39f4d4f94b61e4b64b077f6ddb2bdfb533a88 ]

Helper bpf_msg_pull_data() mistakenly reuses variable 'offset' while
linearizing multiple scatterlist elements. Variable 'offset' is used
to find first starting scatterlist element
    i.e. msg->data = sg_virt(&sg[first_sg]) + start - offset"

Use different variable name while linearizing multiple scatterlist
elements so that value contained in variable 'offset' won't get
overwritten.

Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/filter.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2282,7 +2282,7 @@ static const struct bpf_func_proto bpf_m
 BPF_CALL_4(bpf_msg_pull_data,
 	   struct sk_msg_buff *, msg, u32, start, u32, end, u64, flags)
 {
-	unsigned int len = 0, offset = 0, copy = 0;
+	unsigned int len = 0, offset = 0, copy = 0, poffset = 0;
 	int bytes = end - start, bytes_sg_total;
 	struct scatterlist *sg = msg->sg_data;
 	int first_sg, last_sg, i, shift;
@@ -2338,16 +2338,15 @@ BPF_CALL_4(bpf_msg_pull_data,
 	if (unlikely(!page))
 		return -ENOMEM;
 	p = page_address(page);
-	offset = 0;
 
 	i = first_sg;
 	do {
 		from = sg_virt(&sg[i]);
 		len = sg[i].length;
-		to = p + offset;
+		to = p + poffset;
 
 		memcpy(to, from, len);
-		offset += len;
+		poffset += len;
 		sg[i].length = 0;
 		put_page(sg_page(&sg[i]));
 


