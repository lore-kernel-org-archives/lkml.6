Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2DCC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CB120880
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CB120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732238AbeITPcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:32:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbeITPcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:32:53 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A2D2569083768;
        Thu, 20 Sep 2018 17:50:12 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 17:50:11 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
        <santosh@chelsio.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] net: nci: remove redundant null pointer check before kfree_skb
Date:   Thu, 20 Sep 2018 17:37:44 +0800
Message-ID: <1537436266-41955-5-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1537436266-41955-1-git-send-email-zhongjiang@huawei.com>
References: <1537436266-41955-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree_skb has taken the null pointer into account. hence it is safe
to remove the redundant null pointer check before kfree_skb.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 net/nfc/nci/uart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index a66f102..4503937 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -192,10 +192,8 @@ static void nci_uart_tty_close(struct tty_struct *tty)
 	if (!nu)
 		return;
 
-	if (nu->tx_skb)
-		kfree_skb(nu->tx_skb);
-	if (nu->rx_skb)
-		kfree_skb(nu->rx_skb);
+	kfree_skb(nu->tx_skb);
+	kfree_skb(nu->rx_skb);
 
 	skb_queue_purge(&nu->tx_q);
 
-- 
1.7.12.4

