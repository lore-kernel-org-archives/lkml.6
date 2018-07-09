Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8053C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA782089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Klw8H7sX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA782089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbeGIHeJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:34:09 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35122 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932231AbeGIHeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:34:06 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w697XoGR121734;
        Mon, 9 Jul 2018 02:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531121630;
        bh=0j/qYz0YZirBLGhk2tm7yRf5C+NWczomXCyazpkm0dI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Klw8H7sXTKqRk+/1qQC5LF15WMWxmZEd7V2PrO+N8HLWwYq+7H05SS4lJK/S8NdaS
         8XmRMZVNiILFMeprLiCnIPweK4sd07bzNHP9lOR2+dc9/Su9rj2QYmYV2sn7J4Z3xe
         vDR4qx8iJ57AXUc6YVR9BOaEejn8ibLZAeq1jmLc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w697Xoqq004366;
        Mon, 9 Jul 2018 02:33:50 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 9 Jul
 2018 02:33:49 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 9 Jul 2018 02:33:49 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w697XTvS014047;
        Mon, 9 Jul 2018 02:33:47 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <tony@atomide.com>
CC:     <t-kristo@ti.com>, <ssantosh@kernel.org>, <j-keerthy@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v2 2/2] ARM: OMAP2+: sleep33/43xx: Add RTC-Mode support
Date:   Mon, 9 Jul 2018 13:03:17 +0530
Message-ID: <1531121597-19150-2-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531121597-19150-1-git-send-email-j-keerthy@ti.com>
References: <1531121597-19150-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for RTC mode to low level suspend code. This includes
providing the rtc base address for the assembly code to configuring the
PMIC_PWR_EN line late in suspend to enter RTC+DDR mode.

Note: This patch also fold in left out space parameter for
am33xx_emif_sram_table and am43xx_emif_sram_table

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Swapped the bit definitons from patch 2 to 1

 arch/arm/mach-omap2/pm-asm-offsets.c |  2 ++
 arch/arm/mach-omap2/pm33xx-core.c    | 10 +++++++
 arch/arm/mach-omap2/sleep33xx.S      |  5 ++--
 arch/arm/mach-omap2/sleep43xx.S      | 54 ++++++++++++++++++++++++++++++++++--
 drivers/soc/ti/pm33xx.c              |  1 +
 include/linux/platform_data/pm33xx.h |  3 ++
 6 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-asm-offsets.c b/arch/arm/mach-omap2/pm-asm-offsets.c
index b9846b1..d202306 100644
--- a/arch/arm/mach-omap2/pm-asm-offsets.c
+++ b/arch/arm/mach-omap2/pm-asm-offsets.c
@@ -27,6 +27,8 @@ int main(void)
 	       offsetof(struct am33xx_pm_ro_sram_data, amx3_pm_sram_data_virt));
 	DEFINE(AMX3_PM_RO_SRAM_DATA_PHYS_OFFSET,
 	       offsetof(struct am33xx_pm_ro_sram_data, amx3_pm_sram_data_phys));
+	DEFINE(AMX3_PM_RTC_BASE_VIRT_OFFSET,
+	       offsetof(struct am33xx_pm_ro_sram_data, rtc_base_virt));
 	DEFINE(AMX3_PM_RO_SRAM_DATA_SIZE,
 	       sizeof(struct am33xx_pm_ro_sram_data));
 
diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index e363b97..f4971e4 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -26,6 +26,7 @@
 static struct powerdomain *cefuse_pwrdm, *gfx_pwrdm, *per_pwrdm, *mpu_pwrdm;
 static struct clockdomain *gfx_l4ls_clkdm;
 static void __iomem *scu_base;
+static struct omap_hwmod *rtc_oh;
 
 static int __init am43xx_map_scu(void)
 {
@@ -153,16 +154,25 @@ static struct am33xx_pm_sram_addr *amx3_get_sram_addrs(void)
 		return NULL;
 }
 
+void __iomem *am43xx_get_rtc_base_addr(void)
+{
+	rtc_oh = omap_hwmod_lookup("rtc");
+
+	return omap_hwmod_get_mpu_rt_va(rtc_oh);
+}
+
 static struct am33xx_pm_platform_data am33xx_ops = {
 	.init = am33xx_suspend_init,
 	.soc_suspend = am33xx_suspend,
 	.get_sram_addrs = amx3_get_sram_addrs,
+	.get_rtc_base_addr = am43xx_get_rtc_base_addr,
 };
 
 static struct am33xx_pm_platform_data am43xx_ops = {
 	.init = am43xx_suspend_init,
 	.soc_suspend = am43xx_suspend,
 	.get_sram_addrs = amx3_get_sram_addrs,
+	.get_rtc_base_addr = am43xx_get_rtc_base_addr,
 };
 
 static struct am33xx_pm_platform_data *am33xx_pm_get_pdata(void)
diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
index 8d0d53b..47a8164 100644
--- a/arch/arm/mach-omap2/sleep33xx.S
+++ b/arch/arm/mach-omap2/sleep33xx.S
@@ -228,8 +228,6 @@ ENDPROC(am33xx_resume_from_deep_sleep)
  * Local variables
  */
 	.align
-resume_addr:
-	.word	cpu_resume - PAGE_OFFSET + 0x80000000
 kernel_flush:
 	.word   v7_flush_dcache_all
 virt_mpu_clkctrl:
@@ -252,6 +250,9 @@ ENTRY(am33xx_pm_sram)
 	.word am33xx_emif_sram_table
 	.word am33xx_pm_ro_sram_data
 
+resume_addr:
+.word  cpu_resume - PAGE_OFFSET + 0x80000000
+
 .align 3
 ENTRY(am33xx_pm_ro_sram_data)
 	.space AMX3_PM_RO_SRAM_DATA_SIZE
diff --git a/arch/arm/mach-omap2/sleep43xx.S b/arch/arm/mach-omap2/sleep43xx.S
index cd7e95f..5b9343b 100644
--- a/arch/arm/mach-omap2/sleep43xx.S
+++ b/arch/arm/mach-omap2/sleep43xx.S
@@ -48,6 +48,13 @@
 					AM43XX_CM_PER_EMIF_CLKCTRL_OFFSET)
 #define AM43XX_PRM_EMIF_CTRL_OFFSET			0x0030
 
+#define RTC_SECONDS_REG					0x0
+#define RTC_PMIC_REG					0x98
+#define RTC_PMIC_POWER_EN				BIT(16)
+#define RTC_PMIC_EXT_WAKEUP_STS				BIT(12)
+#define RTC_PMIC_EXT_WAKEUP_POL				BIT(4)
+#define RTC_PMIC_EXT_WAKEUP_EN				BIT(0)
+
 	.arm
 	.align 3
 
@@ -147,6 +154,20 @@ sync:
 	ldr	r4, [r2, #AMX3_PM_WFI_FLAGS_OFFSET]
 
 cache_skip_flush:
+	/*
+	 * If we are trying to enter RTC+DDR mode we must perform
+	 * a read from the rtc address space to ensure translation
+	 * presence in the TLB to avoid page table walk after DDR
+	 * is unavailable.
+	 */
+	tst	r4, #WFI_FLAG_RTC_ONLY
+	beq	skip_rtc_va_refresh
+
+	adr	r3, am43xx_pm_ro_sram_data
+	ldr	r1, [r3, #AMX3_PM_RTC_BASE_VIRT_OFFSET]
+	ldr	r0, [r1]
+
+skip_rtc_va_refresh:
 	/* Check if we want self refresh */
 	tst	r4, #WFI_FLAG_SELF_REFRESH
 	beq	emif_skip_enter_sr
@@ -182,6 +203,34 @@ wait_emif_disable:
 	bne	wait_emif_disable
 
 emif_skip_disable:
+	tst	r4, #WFI_FLAG_RTC_ONLY
+	beq	skip_rtc_only
+
+	adr	r3, am43xx_pm_ro_sram_data
+	ldr	r1, [r3, #AMX3_PM_RTC_BASE_VIRT_OFFSET]
+
+	ldr	r0, [r1, #RTC_PMIC_REG]
+	orr	r0, r0, #RTC_PMIC_POWER_EN
+	orr	r0, r0, #RTC_PMIC_EXT_WAKEUP_STS
+	orr	r0, r0, #RTC_PMIC_EXT_WAKEUP_EN
+	orr	r0, r0, #RTC_PMIC_EXT_WAKEUP_POL
+	str	r0, [r1, #RTC_PMIC_REG]
+	ldr	r0, [r1, #RTC_PMIC_REG]
+	/* Wait for 2 seconds to lose power */
+	mov	r3, #2
+	ldr	r2, [r1, #RTC_SECONDS_REG]
+rtc_loop:
+	ldr	r0, [r1, #RTC_SECONDS_REG]
+	cmp	r0, r2
+	beq	rtc_loop
+	mov	r2, r0
+	subs	r3, r3, #1
+	bne	rtc_loop
+
+	b	re_enable_emif
+
+skip_rtc_only:
+
 	tst	r4, #WFI_FLAG_WAKE_M3
 	beq	wkup_m3_skip
 
@@ -247,6 +296,7 @@ wkup_m3_skip:
 	mov	r2, #AM33XX_CM_CLKCTRL_MODULEMODE_ENABLE
 	str	r2, [r1]
 
+re_enable_emif:
 	/* Re-enable EMIF */
 	ldr	r1, am43xx_virt_emif_clkctrl
 	mov	r2, #AM33XX_CM_CLKCTRL_MODULEMODE_ENABLE
@@ -381,8 +431,6 @@ ENDPROC(am43xx_resume_from_deep_sleep)
  * Local variables
  */
 	.align
-resume_addr:
-	.word	cpu_resume - PAGE_OFFSET + 0x80000000
 kernel_flush:
 	.word   v7_flush_dcache_all
 ddr_start:
@@ -429,6 +477,8 @@ ENTRY(am43xx_pm_sram)
 	.word am43xx_emif_sram_table
 	.word am43xx_pm_ro_sram_data
 
+resume_addr:
+	.word   cpu_resume - PAGE_OFFSET + 0x80000000
 .align 3
 
 ENTRY(am43xx_pm_ro_sram_data)
diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index 0011c8f..d0dab32 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -229,6 +229,7 @@ static int am33xx_push_sram_idle(void)
 	ro_sram_data.amx3_pm_sram_data_virt = ocmcram_location_data;
 	ro_sram_data.amx3_pm_sram_data_phys =
 		gen_pool_virt_to_phys(sram_pool_data, ocmcram_location_data);
+	ro_sram_data.rtc_base_virt = pm_ops->get_rtc_base_addr();
 
 	/* Save physical address to calculate resume offset during pm init */
 	am33xx_do_wfi_sram_phys = gen_pool_virt_to_phys(sram_pool,
diff --git a/include/linux/platform_data/pm33xx.h b/include/linux/platform_data/pm33xx.h
index d231265..fbf5ed7 100644
--- a/include/linux/platform_data/pm33xx.h
+++ b/include/linux/platform_data/pm33xx.h
@@ -42,6 +42,7 @@ struct am33xx_pm_sram_addr {
 	unsigned long *resume_offset;
 	unsigned long *emif_sram_table;
 	unsigned long *ro_sram_data;
+	unsigned long resume_address;
 };
 
 struct am33xx_pm_platform_data {
@@ -49,6 +50,7 @@ struct am33xx_pm_platform_data {
 	int	(*soc_suspend)(unsigned int state, int (*fn)(unsigned long),
 			       unsigned long args);
 	struct  am33xx_pm_sram_addr *(*get_sram_addrs)(void);
+	void __iomem *(*get_rtc_base_addr)(void);
 };
 
 struct am33xx_pm_sram_data {
@@ -60,6 +62,7 @@ struct am33xx_pm_sram_data {
 struct am33xx_pm_ro_sram_data {
 	u32 amx3_pm_sram_data_virt;
 	u32 amx3_pm_sram_data_phys;
+	void __iomem *rtc_base_virt;
 } __packed __aligned(8);
 
 #endif /* __ASSEMBLER__ */
-- 
1.9.1

