Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56234C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B0021473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B0021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeJBHtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:49:39 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:34050 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeJBHtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:49:39 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994583AbeJBBJFBBww3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Tue, 2 Oct 2018 03:09:05 +0200
Date:   Tue, 2 Oct 2018 02:09:05 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rtc: cmos: Remove the `use_acpi_alarm' module parameter
 for !ACPI
In-Reply-To: <alpine.LFD.2.21.1810020122330.20762@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1810020154530.20762@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1810020122330.20762@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a problem with commit 311ee9c151ad ("rtc: cmos: allow using ACPI for 
RTC alarm instead of HPET") defining `use_acpi_alarm' module parameter 
even for non-ACPI platforms, which ignore it.  Wrap the definition into 
#ifdef CONFIG_ACPI and use a static inline wrapper function, hardcoded 
to return 0 and consequently optimized away for !ACPI, following the 
existing pattern with HPET handling functions.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Fixes: 311ee9c151ad ("rtc: cmos: allow using ACPI for RTC alarm instead of HPET")
Cc: stable@vger.kernel.org # 4.18+
---
 drivers/rtc/rtc-cmos.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

linux-rtc-cmos-use-acpi-alarm.diff
Index: linux-20180812-4maxp64/drivers/rtc/rtc-cmos.c
===================================================================
--- linux-20180812-4maxp64.orig/drivers/rtc/rtc-cmos.c
+++ linux-20180812-4maxp64/drivers/rtc/rtc-cmos.c
@@ -50,6 +50,7 @@
 /* this is for "generic access to PC-style RTC" using CMOS_READ/CMOS_WRITE */
 #include <linux/mc146818rtc.h>
 
+#ifdef CONFIG_ACPI
 /*
  * Use ACPI SCI to replace HPET interrupt for RTC Alarm event
  *
@@ -61,6 +62,18 @@
 static bool use_acpi_alarm;
 module_param(use_acpi_alarm, bool, 0444);
 
+static inline int cmos_use_acpi_alarm(void)
+{
+	return use_acpi_alarm;
+}
+#else /* !CONFIG_ACPI */
+
+static inline int cmos_use_acpi_alarm(void)
+{
+	return 0;
+}
+#endif
+
 struct cmos_rtc {
 	struct rtc_device	*rtc;
 	struct device		*dev;
@@ -169,7 +182,7 @@ static inline int hpet_unregister_irq_ha
 /* Don't use HPET for RTC Alarm event if ACPI Fixed event is used */
 static inline int use_hpet_alarm(void)
 {
-	return is_hpet_enabled() && !use_acpi_alarm;
+	return is_hpet_enabled() && !cmos_use_acpi_alarm();
 }
 
 /*----------------------------------------------------------------*/
@@ -340,7 +353,7 @@ static void cmos_irq_enable(struct cmos_
 	if (use_hpet_alarm())
 		hpet_set_rtc_irq_bit(mask);
 
-	if ((mask & RTC_AIE) && use_acpi_alarm) {
+	if ((mask & RTC_AIE) && cmos_use_acpi_alarm()) {
 		if (cmos->wake_on)
 			cmos->wake_on(cmos->dev);
 	}
@@ -358,7 +371,7 @@ static void cmos_irq_disable(struct cmos
 	if (use_hpet_alarm())
 		hpet_mask_rtc_irq_bit(mask);
 
-	if ((mask & RTC_AIE) && use_acpi_alarm) {
+	if ((mask & RTC_AIE) && cmos_use_acpi_alarm()) {
 		if (cmos->wake_off)
 			cmos->wake_off(cmos->dev);
 	}
@@ -980,7 +993,7 @@ static int cmos_suspend(struct device *d
 	}
 	spin_unlock_irq(&rtc_lock);
 
-	if ((tmp & RTC_AIE) && !use_acpi_alarm) {
+	if ((tmp & RTC_AIE) && !cmos_use_acpi_alarm()) {
 		cmos->enabled_wake = 1;
 		if (cmos->wake_on)
 			cmos->wake_on(dev);
@@ -1031,7 +1044,7 @@ static void cmos_check_wkalrm(struct dev
 	 * ACPI RTC wake event is cleared after resume from STR,
 	 * ACK the rtc irq here
 	 */
-	if (t_now >= cmos->alarm_expires && use_acpi_alarm) {
+	if (t_now >= cmos->alarm_expires && cmos_use_acpi_alarm()) {
 		cmos_interrupt(0, (void *)cmos->rtc);
 		return;
 	}
@@ -1053,7 +1066,7 @@ static int __maybe_unused cmos_resume(st
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
 	unsigned char tmp;
 
-	if (cmos->enabled_wake && !use_acpi_alarm) {
+	if (cmos->enabled_wake && !cmos_use_acpi_alarm()) {
 		if (cmos->wake_off)
 			cmos->wake_off(dev);
 		else
@@ -1132,7 +1145,7 @@ static u32 rtc_handler(void *context)
 	 * Or else, ACPI SCI is enabled during suspend/resume only,
 	 * update rtc irq in that case.
 	 */
-	if (use_acpi_alarm)
+	if (cmos_use_acpi_alarm())
 		cmos_interrupt(0, (void *)cmos->rtc);
 	else {
 		/* Fix me: can we use cmos_interrupt() here as well? */
