Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6443EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCD82087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCD82087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbeITPcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:32:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12633 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727633AbeITPcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:32:53 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A8941EA16A8D6;
        Thu, 20 Sep 2018 17:50:12 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 17:50:12 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
        <santosh@chelsio.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] net: cxgb3_main: remove redundant null pointer check before kfree_skb
Date:   Thu, 20 Sep 2018 17:37:45 +0800
Message-ID: <1537436266-41955-6-git-send-email-zhongjiang@huawei.com>
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
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index a19172d..680c6fe 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -3423,8 +3423,7 @@ static void remove_one(struct pci_dev *pdev)
 				free_netdev(adapter->port[i]);
 
 		iounmap(adapter->regs);
-		if (adapter->nofail_skb)
-			kfree_skb(adapter->nofail_skb);
+		kfree_skb(adapter->nofail_skb);
 		kfree(adapter);
 		pci_release_regions(pdev);
 		pci_disable_device(pdev);
-- 
1.7.12.4

