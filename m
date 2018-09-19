Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DC4C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80542150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80542150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbeISXbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:31:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58481 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731366AbeISXbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:31:20 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2AF3D20763; Wed, 19 Sep 2018 19:52:17 +0200 (CEST)
Received: from localhost (unknown [15.65.243.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 261BB204AE;
        Wed, 19 Sep 2018 19:52:15 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/3] rtc: ds1685: drop RTC_DS1685_PROC_REGS
Date:   Wed, 19 Sep 2018 19:52:09 +0200
Message-Id: <20180919175211.25150-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc is not the correct ABI to display debugging info. Remove
RTC_DS1685_PROC_REGS as the driver hasn't seen any real development since
it was included.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/Kconfig      | 11 --------
 drivers/rtc/rtc-ds1685.c | 61 ----------------------------------------
 2 files changed, 72 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 4df9a3ec064b..a819ef07b7ec 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1008,17 +1008,6 @@ config RTC_DRV_DS17885
 
 endchoice
 
-config RTC_DS1685_PROC_REGS
-	bool "Display register values in /proc"
-	depends on RTC_DRV_DS1685_FAMILY && PROC_FS
-	help
-	  Enable this to display a readout of all of the RTC registers in
-	  /proc/drivers/rtc.  Keep in mind that this can potentially lead
-	  to lost interrupts, as reading Control Register C will clear
-	  all pending IRQ flags.
-
-	  Unless you are debugging this driver, choose N.
-
 config RTC_DRV_DS1742
 	tristate "Maxim/Dallas DS1742/1743"
 	depends on HAS_IOMEM
diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 6f39f683a98c..2bad1f50414f 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -770,33 +770,6 @@ static const char *ds1685_rtc_sqw_freq[16] = {
 	"512Hz", "256Hz", "128Hz", "64Hz", "32Hz", "16Hz", "8Hz", "4Hz", "2Hz"
 };
 
-#ifdef CONFIG_RTC_DS1685_PROC_REGS
-/**
- * ds1685_rtc_print_regs - helper function to print register values.
- * @hex: hex byte to convert into binary bits.
- * @dest: destination char array.
- *
- * This is basically a hex->binary function, just with extra spacing between
- * the digits.  It only works on 1-byte values (8 bits).
- */
-static char*
-ds1685_rtc_print_regs(u8 hex, char *dest)
-{
-	u32 i, j;
-	char *tmp = dest;
-
-	for (i = 0; i < NUM_BITS; i++) {
-		*tmp++ = ((hex & 0x80) != 0 ? '1' : '0');
-		for (j = 0; j < NUM_SPACES; j++)
-			*tmp++ = ' ';
-		hex <<= 1;
-	}
-	*tmp++ = '\0';
-
-	return dest;
-}
-#endif
-
 /**
  * ds1685_rtc_proc - procfs access function.
  * @dev: pointer to device structure.
@@ -809,9 +782,6 @@ ds1685_rtc_proc(struct device *dev, struct seq_file *seq)
 	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
 	u8 ctrla, ctrlb, ctrlc, ctrld, ctrl4a, ctrl4b, ssn[8];
 	char *model;
-#ifdef CONFIG_RTC_DS1685_PROC_REGS
-	char bits[NUM_REGS][(NUM_BITS * NUM_SPACES) + NUM_BITS + 1];
-#endif
 
 	/* Read all the relevant data from the control registers. */
 	ds1685_rtc_switch_to_bank1(rtc);
@@ -859,28 +829,7 @@ ds1685_rtc_proc(struct device *dev, struct seq_file *seq)
 	   "Periodic IRQ\t: %s\n"
 	   "Periodic Rate\t: %s\n"
 	   "SQW Freq\t: %s\n"
-#ifdef CONFIG_RTC_DS1685_PROC_REGS
-	   "Serial #\t: %8phC\n"
-	   "Register Status\t:\n"
-	   "   Ctrl A\t: UIP  DV2  DV1  DV0  RS3  RS2  RS1  RS0\n"
-	   "\t\t:  %s\n"
-	   "   Ctrl B\t: SET  PIE  AIE  UIE  SQWE  DM  2412 DSE\n"
-	   "\t\t:  %s\n"
-	   "   Ctrl C\t: IRQF  PF   AF   UF  ---  ---  ---  ---\n"
-	   "\t\t:  %s\n"
-	   "   Ctrl D\t: VRT  ---  ---  ---  ---  ---  ---  ---\n"
-	   "\t\t:  %s\n"
-#if !defined(CONFIG_RTC_DRV_DS1685) && !defined(CONFIG_RTC_DRV_DS1689)
-	   "   Ctrl 4A\t: VRT2 INCR BME  ---  PAB   RF   WF   KF\n"
-#else
-	   "   Ctrl 4A\t: VRT2 INCR ---  ---  PAB   RF   WF   KF\n"
-#endif
-	   "\t\t:  %s\n"
-	   "   Ctrl 4B\t: ABE  E32k  CS  RCE  PRS  RIE  WIE  KSE\n"
-	   "\t\t:  %s\n",
-#else
 	   "Serial #\t: %8phC\n",
-#endif
 	   model,
 	   ((ctrla & RTC_CTRL_A_DV1) ? "enabled" : "disabled"),
 	   ((ctrlb & RTC_CTRL_B_2412) ? "24-hour" : "12-hour"),
@@ -894,17 +843,7 @@ ds1685_rtc_proc(struct device *dev, struct seq_file *seq)
 	    ds1685_rtc_pirq_rate[(ctrla & RTC_CTRL_A_RS_MASK)] : "none"),
 	   (!((ctrl4b & RTC_CTRL_4B_E32K)) ?
 	    ds1685_rtc_sqw_freq[(ctrla & RTC_CTRL_A_RS_MASK)] : "32768Hz"),
-#ifdef CONFIG_RTC_DS1685_PROC_REGS
-	   ssn,
-	   ds1685_rtc_print_regs(ctrla, bits[0]),
-	   ds1685_rtc_print_regs(ctrlb, bits[1]),
-	   ds1685_rtc_print_regs(ctrlc, bits[2]),
-	   ds1685_rtc_print_regs(ctrld, bits[3]),
-	   ds1685_rtc_print_regs(ctrl4a, bits[4]),
-	   ds1685_rtc_print_regs(ctrl4b, bits[5]));
-#else
 	   ssn);
-#endif
 	return 0;
 }
 #else
-- 
2.19.0

