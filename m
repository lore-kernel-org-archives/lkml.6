Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B427C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4718020883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JGQHzVRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4718020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933027AbeFUIPq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:15:46 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:22936 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932466AbeFUIPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:15:42 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelnx193.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5L8Fd8W004585;
        Thu, 21 Jun 2018 03:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529568939;
        bh=Uq3A54GnZNE9r4RFF3Za3IIJ+dBkYif7mqeB593tL50=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JGQHzVRm41Xy7dApK3FTmBX4kxdxk6g/X2ihLwG0GKGJROUxEnuDcGsKxoh7YNBNM
         /uF3vpYaVO7ENusSpwzRk2bubWDQ77oCBE5VG6ZYwoenUGqqQ3UibIc+s+o0qitfYu
         nLdz2PmaX1EgPrbQwhuOLdyDI/kkXkhuJhHP+Yp0=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5L8Fd4x028988;
        Thu, 21 Jun 2018 03:15:39 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 21
 Jun 2018 03:15:39 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 21 Jun 2018 03:15:39 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5L8FCTh025379;
        Thu, 21 Jun 2018 03:15:37 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <t-kristo@ti.com>, <sboyd@kernel.org>, <tony@atomide.com>
CC:     <linux-clk@vger.kernel.org>, <d-gerlach@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-keerthy@ti.com>
Subject: [PATCH v3 4/4] soc: ti: pm33xx: Save/restore clk context based on enable_off_mode setting
Date:   Thu, 21 Jun 2018 13:45:07 +0530
Message-ID: <1529568907-19930-5-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529568907-19930-1-git-send-email-j-keerthy@ti.com>
References: <1529568907-19930-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save/restore clk context based on enable_off_mode setting.
The context needs to be saved at the very end of suspend path
and restored at the beginning of resume path.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

No Changes in v2

 arch/arm/mach-omap2/pm33xx-core.c    | 15 +++++++++++++++
 drivers/soc/ti/pm33xx.c              | 13 +++++++++++++
 include/linux/platform_data/pm33xx.h |  1 +
 3 files changed, 29 insertions(+)

diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index 9b3755a..29f848f 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -37,6 +37,20 @@ static int __init am43xx_map_scu(void)
 	return 0;
 }
 
+static int am43xx_check_off_mode_enable(void)
+{
+	/*
+	 * Check for am437x-sk-evm which due to HW design cannot support
+	 * this mode reliably.
+	 */
+	if (of_machine_is_compatible("ti,am437x-sk-evm") && enable_off_mode) {
+		pr_warn("WARNING: This platform does not support off-mode, entering DeepSleep suspend.\n");
+		return 0;
+	}
+
+	return enable_off_mode;
+}
+
 static int amx3_common_init(void)
 {
 	gfx_pwrdm = pwrdm_lookup("gfx_pwrdm");
@@ -161,6 +175,7 @@ static struct am33xx_pm_sram_addr *amx3_get_sram_addrs(void)
 	.init = am43xx_suspend_init,
 	.soc_suspend = am43xx_suspend,
 	.get_sram_addrs = amx3_get_sram_addrs,
+	.check_off_mode_enable = am43xx_check_off_mode_enable,
 };
 
 static struct am33xx_pm_platform_data *am33xx_pm_get_pdata(void)
diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index 652739c..e749b8d 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -6,6 +6,7 @@
  *	Vaibhav Bedia, Dave Gerlach
  */
 
+#include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/err.h>
 #include <linux/genalloc.h>
@@ -52,6 +53,14 @@ static int am33xx_pm_suspend(suspend_state_t suspend_state)
 {
 	int i, ret = 0;
 
+	/*
+	 * For RTC only mode with DDR in selfresh we need to save
+	 * clocks context at the very end
+	 */
+	if (suspend_state == PM_SUSPEND_MEM &&
+	    pm_ops->check_off_mode_enable())
+		clk_save_context();
+
 	ret = pm_ops->soc_suspend((unsigned long)suspend_state,
 				  am33xx_do_wfi_sram);
 
@@ -77,6 +86,10 @@ static int am33xx_pm_suspend(suspend_state_t suspend_state)
 		}
 	}
 
+	if (suspend_state == PM_SUSPEND_MEM &&
+	    pm_ops->check_off_mode_enable())
+		clk_restore_context();
+
 	return ret;
 }
 
diff --git a/include/linux/platform_data/pm33xx.h b/include/linux/platform_data/pm33xx.h
index f9bed2a..36f7007 100644
--- a/include/linux/platform_data/pm33xx.h
+++ b/include/linux/platform_data/pm33xx.h
@@ -25,6 +25,7 @@ struct am33xx_pm_platform_data {
 	int	(*init)(void);
 	int	(*soc_suspend)(unsigned int state, int (*fn)(unsigned long));
 	struct  am33xx_pm_sram_addr *(*get_sram_addrs)(void);
+	int (*check_off_mode_enable)(void);
 };
 
 struct am33xx_pm_sram_data {
-- 
1.9.1

