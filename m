Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A86C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E7C20817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w1FbohHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E7C20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389902AbeKLJGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:06:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389780AbeKLIVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:39 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D99542243E;
        Sun, 11 Nov 2018 22:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975502;
        bh=mbUzGSq3+gn6eNkkPyAr7PJ/6ZCvcZhwnXb0yqd7zb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w1FbohHpOtRcqdZHHkInE2JVbpTWBzl6b9JoMfQjiugSa1/d1JIrFujPLF+DnxTrc
         r3zXRR1IYs3ihnpUjUB5F/LeJWG5MNA6J/R77aJB7mbik3GDTzW1K/ISUtC3/l/XbI
         H98DEXXHeXDmlxhrMgLH4tmvhxNGTosS40WrI/Mo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.18 279/350] rtc: cmos: Remove the `use_acpi_alarm module parameter for !ACPI
Date:   Sun, 11 Nov 2018 14:22:23 -0800
Message-Id: <20181111221719.710488067@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@linux-mips.org>

commit bc51098cdd9573bfdecfd02fc8ed474419d73ea0 upstream.

Fix a problem with commit 311ee9c151ad ("rtc: cmos: allow using ACPI for
RTC alarm instead of HPET") defining `use_acpi_alarm' module parameter
even for non-ACPI platforms, which ignore it.  Wrap the definition into
#ifdef CONFIG_ACPI and use a static inline wrapper function, hardcoded
to return 0 and consequently optimized away for !ACPI, following the
existing pattern with HPET handling functions.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Fixes: 311ee9c151ad ("rtc: cmos: allow using ACPI for RTC alarm instead of HPET")
Cc: stable@vger.kernel.org # 4.18+
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/rtc-cmos.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
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


