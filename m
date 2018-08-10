Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1490C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802FF223B7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802FF223B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeHJFU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:20:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50444 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725725AbeHJFU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:20:26 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3044523C56798;
        Fri, 10 Aug 2018 10:52:36 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Fri, 10 Aug 2018 10:52:34 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <linux@armlinux.org.uk>, <vz@mleia.com>, <slemieux.tyco@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm:pm: Use kmemdup to replace duplicating its implementation
Date:   Fri, 10 Aug 2018 10:40:51 +0800
Message-ID: <1533868851-316-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is better than kmalloc() + memcpy(), and we do not like
open code. So just use kmemdup instead.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/arm/mach-lpc32xx/pm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
index 6247157..6eefff8 100644
--- a/arch/arm/mach-lpc32xx/pm.c
+++ b/arch/arm/mach-lpc32xx/pm.c
@@ -86,7 +86,8 @@ static int lpc32xx_pm_enter(suspend_state_t state)
 	void *iram_swap_area;
 
 	/* Allocate some space for temporary IRAM storage */
-	iram_swap_area = kmalloc(lpc32xx_sys_suspend_sz, GFP_KERNEL);
+	iram_swap_area = kmemdup((void *)TEMP_IRAM_AREA,
+				lpc32xx_sys_suspend_sz, GFP_KERNEL);
 	if (!iram_swap_area) {
 		printk(KERN_ERR
 		       "PM Suspend: cannot allocate memory to save portion "
@@ -94,10 +95,6 @@ static int lpc32xx_pm_enter(suspend_state_t state)
 		return -ENOMEM;
 	}
 
-	/* Backup a small area of IRAM used for the suspend code */
-	memcpy(iram_swap_area, (void *) TEMP_IRAM_AREA,
-		lpc32xx_sys_suspend_sz);
-
 	/*
 	 * Copy code to suspend system into IRAM. The suspend code
 	 * needs to run from IRAM as DRAM may no longer be available
-- 
1.7.12.4

