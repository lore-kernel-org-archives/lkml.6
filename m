Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB495C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2D32148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbeL1AhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 19:37:20 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:23364 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbeL1AhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 19:37:20 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 02DBD70D09EEB5C69BB0;
        Fri, 28 Dec 2018 08:37:17 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wBS0b8bH014847;
        Fri, 28 Dec 2018 08:37:08 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018122808374251-19198379 ;
          Fri, 28 Dec 2018 08:37:42 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     vz@mleia.com, slemieux.tyco@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  arm/mach-lpc32xx/pm : use kmemdup instead of duplicating
Date:   Fri, 28 Dec 2018 08:57:59 +0800
Message-Id: <1545958679-89146-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-28 08:37:42,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-28 08:36:52,
        Serialize complete at 2018-12-28 08:36:52
X-MAIL: mse01.zte.com.cn wBS0b8bH014847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup has implemented the function that kmalloc() + memcpy().
Prefer to kmemdup rather than code opened implementation.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/arm/mach-lpc32xx/pm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
index 6247157..1a2535c 100644
--- a/arch/arm/mach-lpc32xx/pm.c
+++ b/arch/arm/mach-lpc32xx/pm.c
@@ -85,8 +85,11 @@ static int lpc32xx_pm_enter(suspend_state_t state)
 	int (*lpc32xx_suspend_ptr) (void);
 	void *iram_swap_area;
 
-	/* Allocate some space for temporary IRAM storage */
-	iram_swap_area = kmalloc(lpc32xx_sys_suspend_sz, GFP_KERNEL);
+	/* Allocate some space for temporary IRAM storage. Then
+	 * backup a small area of IRAM used for the suspend code.
+	 */
+	iram_swap_area = kmemdup((void *) TEMP_IRAM_AREA,
+				 lpc32xx_sys_suspend_sz, GFP_KERNEL);
 	if (!iram_swap_area) {
 		printk(KERN_ERR
 		       "PM Suspend: cannot allocate memory to save portion "
@@ -94,10 +97,6 @@ static int lpc32xx_pm_enter(suspend_state_t state)
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
1.8.3.1

