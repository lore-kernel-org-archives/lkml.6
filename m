Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2B5C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512CA21528
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512CA21528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387492AbeITPlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:41:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732412AbeITPlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:41:17 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4FCF48125E7B9;
        Thu, 20 Sep 2018 17:58:34 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 17:58:34 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] bpf: remove redundant null pointer check before consume_skb
Date:   Thu, 20 Sep 2018 17:46:12 +0800
Message-ID: <1537436772-42545-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

consume_skb has taken the null pointer into account. hence it is safe
to remove the redundant null pointer check before consume_skb.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 kernel/bpf/sockmap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index 488ef96..a9359cb 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -590,8 +590,7 @@ static int free_sg(struct sock *sk, int start,
 		if (i == MAX_SKB_FRAGS)
 			i = 0;
 	}
-	if (md->skb)
-		consume_skb(md->skb);
+	consume_skb(md->skb);
 
 	return free;
 }
@@ -973,8 +972,7 @@ static int bpf_tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		if (!sg->length && md->sg_start == md->sg_end) {
 			list_del(&md->list);
-			if (md->skb)
-				consume_skb(md->skb);
+			consume_skb(md->skb);
 			kfree(md);
 		}
 	}
-- 
1.7.12.4

