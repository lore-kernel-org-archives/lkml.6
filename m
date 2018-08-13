Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1723EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE5621767
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE5621767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbeHMNsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:48:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728402AbeHMNsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:48:41 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 962ED5D8FEC57;
        Mon, 13 Aug 2018 19:06:49 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.399.0; Mon, 13 Aug 2018 19:06:46 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <sergio.paracuellos@gmail.com>, <neil@brown.name>,
        <peter.vernia@gmail.com>, <oliver.huebers@web.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging:pci-mt7621: Use PTR_ERR_OR_ZERO to replace the open code
Date:   Mon, 13 Aug 2018 18:54:59 +0800
Message-ID: <1534157699-23637-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR, So
just replace them rather than duplicating its implement.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index a49e279..9a8ff1d 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -403,10 +403,8 @@ static int mt7621_pcie_parse_dt(struct mt7621_pcie *pcie)
 	}
 
 	pcie->base = devm_ioremap_resource(dev, &regs);
-	if (IS_ERR(pcie->base))
-		return PTR_ERR(pcie->base);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(pcie->base);
 }
 
 static int mt7621_pcie_request_resources(struct mt7621_pcie *pcie,
-- 
1.7.12.4

