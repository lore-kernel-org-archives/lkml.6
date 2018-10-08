Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55364C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB73214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPvuemjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB73214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbeJIB77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeJIB77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:59:59 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4456721479;
        Mon,  8 Oct 2018 18:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024412;
        bh=xo/S2Fwp4pTP/WIoom9cLdR3OtD7UoW87lKcBbgYcks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uPvuemjXPOzqhqcpX9+oqvBbQEZZKG18D/dnh3Ihbb7EWDvMlrlguwGW8RH2zsS6l
         q4kHE4J0eAXPxIrjrY6QOYLyqH+1W3K1F/EfmXgONT3xqKu275LPYbxOUFW/ySlTgA
         9vVCkmfA88ZkVBpa1z5LO369QYETC1nVY7NJvtVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 030/168] bpf: fix sg shift repair start offset in bpf_msg_pull_data
Date:   Mon,  8 Oct 2018 20:30:10 +0200
Message-Id: <20181008175621.194130044@linuxfoundation.org>
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

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit a8cf76a9023bc6709b1361d06bb2fae5227b9d68 ]

When we perform the sg shift repair for the scatterlist ring, we
currently start out at i = first_sg + 1. However, this is not
correct since the first_sg could point to the sge sitting at slot
MAX_SKB_FRAGS - 1, and a subsequent i = MAX_SKB_FRAGS will access
the scatterlist ring (sg) out of bounds. Add the sk_msg_iter_var()
helper for iterating through the ring, and apply the same rule
for advancing to the next ring element as we do elsewhere. Later
work will use this helper also in other places.

Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/filter.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2272,6 +2272,13 @@ static const struct bpf_func_proto bpf_m
 	.arg2_type      = ARG_ANYTHING,
 };
 
+#define sk_msg_iter_var(var)			\
+	do {					\
+		var++;				\
+		if (var == MAX_SKB_FRAGS)	\
+			var = 0;		\
+	} while (0)
+
 BPF_CALL_4(bpf_msg_pull_data,
 	   struct sk_msg_buff *, msg, u32, start, u32, end, u64, flags)
 {
@@ -2292,9 +2299,7 @@ BPF_CALL_4(bpf_msg_pull_data,
 		if (start < offset + len)
 			break;
 		offset += len;
-		i++;
-		if (i == MAX_SKB_FRAGS)
-			i = 0;
+		sk_msg_iter_var(i);
 	} while (i != msg->sg_end);
 
 	if (unlikely(start >= offset + len))
@@ -2320,9 +2325,7 @@ BPF_CALL_4(bpf_msg_pull_data,
 	 */
 	do {
 		copy += sg[i].length;
-		i++;
-		if (i == MAX_SKB_FRAGS)
-			i = 0;
+		sk_msg_iter_var(i);
 		if (bytes_sg_total <= copy)
 			break;
 	} while (i != msg->sg_end);
@@ -2348,9 +2351,7 @@ BPF_CALL_4(bpf_msg_pull_data,
 		sg[i].length = 0;
 		put_page(sg_page(&sg[i]));
 
-		i++;
-		if (i == MAX_SKB_FRAGS)
-			i = 0;
+		sk_msg_iter_var(i);
 	} while (i != last_sg);
 
 	sg[first_sg].length = copy;
@@ -2367,7 +2368,8 @@ BPF_CALL_4(bpf_msg_pull_data,
 	if (!shift)
 		goto out;
 
-	i = first_sg + 1;
+	i = first_sg;
+	sk_msg_iter_var(i);
 	do {
 		int move_from;
 
@@ -2384,9 +2386,7 @@ BPF_CALL_4(bpf_msg_pull_data,
 		sg[move_from].page_link = 0;
 		sg[move_from].offset = 0;
 
-		i++;
-		if (i == MAX_SKB_FRAGS)
-			i = 0;
+		sk_msg_iter_var(i);
 	} while (1);
 	msg->sg_end -= shift;
 	if (msg->sg_end < 0)


