Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B6CC67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 03:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C4E20671
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 03:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE2IXBqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C4E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbeG1E1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 00:27:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39018 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeG1E1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 00:27:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so2338354pff.6;
        Fri, 27 Jul 2018 20:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GpakFfEDqryGEy6++JYYrObaoedZ7wDazvR4vyyeqBk=;
        b=XE2IXBqveh7oOqPFvSO6RZIQ7wibYRFgGnVzJ5L+ctcQZx2iRVZNt5DsxIpu09alrL
         wTFalOBiRTQOftTuDJg+pX29PT/swg63oCMud7fNB/EdLPBUDmQMprNk4/bY0pdjUFMC
         eQXBmtla23UdJIfZ3DBVzX4YWrgN+qlTXOzUqLxI4i4OofrahWRDeg0tYQBG8c+AP7K9
         cZrO6rnOZAtUvh00/buOSjpue4BVoYsPStxejmxHdPTzV/Ma8T4MePKElxTRdrD3KdaZ
         r1Ogh9ECMzMWlLr+uUaKWNSRiWzHfaASh0sJ5yShFRFi/s78oxSPhVVbZ7VLBye3LK+I
         dyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GpakFfEDqryGEy6++JYYrObaoedZ7wDazvR4vyyeqBk=;
        b=OzAwounugnea11FAsFbCbpW2ApejVxPx1p7se9WTg1qtHxWH8k4poXC/7wnyRtlCON
         zIKz7OTQeJUCPesUmDDZNy5XtPFBXoI7Cp/JphiDpvsznwTUOw0HYO+3leGm0ONEWWga
         DzLYNrkzYxbd95EOzwj5J6KCc0Idnn2Y+1NIXTBq5bY1EkgVtIn8jR6jqXA6DZnQeKoz
         7vXA2WAOGgxFrd8/RYbwmJezwYnTRW5KtWuSVgedEQan/ZueYw50YlNm9+iaa4jg/glM
         kpQp7xBXLU9p49JsiVPt8u9toPI/2gy19KLRtJzG3gYcSCdbNp5kXdr5QtPOQKc5bjuf
         qRPg==
X-Gm-Message-State: AOUpUlETSJbZAF/sIesljN1IBU1kNXkOuuSrsCioby9WvtEsRnZ+gPQ+
        vV7FwTUC1nOCqEr/99INe2/i4L9r1qk=
X-Google-Smtp-Source: AAOMgpcN1ARKidVKf9ELfCFIcLnALbidu4U062onx1uyjumbFI4/a+qiF3L+zPHBWkxoT+NMaDZswA==
X-Received: by 2002:a62:4bc6:: with SMTP id d67-v6mr8953576pfj.175.1532746940432;
        Fri, 27 Jul 2018 20:02:20 -0700 (PDT)
Received: from bogon.didichuxing.com ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id z10-v6sm7329196pfh.83.2018.07.27.20.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 20:02:19 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next 2/2] tcp: propagate GSO to the new skb built in tcp collapse
Date:   Sat, 28 Jul 2018 11:01:40 +0800
Message-Id: <1532746900-11710-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1532746900-11710-1-git-send-email-laoar.shao@gmail.com>
References: <1532746900-11710-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the collapsed SKB doesn't propagate the GSO information to the
new SKB.
The GSO should be propagated for better tracking, i.e. when this SKB is
dropped we could know how many network segments are dropped.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/ipv4/tcp_input.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 90f83eb..af52e4e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4893,6 +4893,8 @@ void tcp_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
 		if (!nskb)
 			break;
 
+		skb_shinfo(nskb)->gso_size = skb_shinfo(skb)->gso_size;
+		skb_shinfo(nskb)->gso_type = skb_shinfo(skb)->gso_type;
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 #ifdef CONFIG_TLS_DEVICE
 		nskb->decrypted = skb->decrypted;
@@ -4906,18 +4908,24 @@ void tcp_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
 
 		/* Copy data, releasing collapsed skbs. */
 		while (copy > 0) {
-			int offset = start - TCP_SKB_CB(skb)->seq;
 			int size = TCP_SKB_CB(skb)->end_seq - start;
+			int offset = start - TCP_SKB_CB(skb)->seq;
 
 			BUG_ON(offset < 0);
 			if (size > 0) {
-				size = min(copy, size);
+				if (copy >= size)
+					skb_shinfo(nskb)->gso_segs +=
+						max_t(u16, 1, skb_shinfo(skb)->gso_segs);
+				else
+					size = copy;
+
 				if (skb_copy_bits(skb, offset, skb_put(nskb, size), size))
 					BUG();
 				TCP_SKB_CB(nskb)->end_seq += size;
 				copy -= size;
 				start += size;
 			}
+
 			if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
 				skb = tcp_collapse_one(sk, skb, list, root);
 				if (!skb ||
-- 
1.8.3.1

