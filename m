Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A01C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829F3208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b3og1lno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829F3208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeGLFQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:16:15 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57976 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbeGLFQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:16:15 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6C58CmJ040358;
        Thu, 12 Jul 2018 00:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531372092;
        bh=pC7oIkBEdgPM445OHPho47Oi2O/4Ongom4xRneK/Bgk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=b3og1lno+kz7c3N9Q0t9Y2LdVqpUfrbjEuzr7e2M7guW1bSeoO7ELnZPt1LLxqq2h
         xR34YC7bi28sLGk2hI+AsVvm+8+6QashBpnFOrX/nXbyedjWSrPBcX79HW8MUl9R9x
         Rj0ZdznQbqJxRjtt5lAW4IJJVl/wS6NMWwlroFTE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6C58Cw3008003;
        Thu, 12 Jul 2018 00:08:12 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 12
 Jul 2018 00:08:12 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 12 Jul 2018 00:08:12 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6C583Mk024383;
        Thu, 12 Jul 2018 00:08:09 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <t-kristo@ti.com>, <j-keerthy@ti.com>, <linux-rtc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan@kernel.org>
Subject: [PATCH v4 2/4] rtc: OMAP: Add support for rtc-only mode
Date:   Thu, 12 Jul 2018 10:37:38 +0530
Message-ID: <1531372060-10532-3-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare rtc driver for rtc-only with DDR in self-refresh mode.
omap_rtc_power_off now should cater to two features:

1) RTC plus DDR in self-refresh is power a saving mode where in the
entire system including the different voltage rails from PMIC are
shutdown except the ones feeding on to RTC and DDR. DDR is kept in
self-refresh hence the contents are preserved. RTC ALARM2 is connected
to PMIC_EN line once we the ALARM2 is triggered we enter the mode with
DDR in self-refresh and RTC Ticking. After a predetermined time an RTC
ALARM1 triggers waking up the system[1]. The control goes to bootloader.
The bootloader then checks RTC scratchpad registers to confirm it was an
rtc_only wakeup and follows a different path, configure bare minimal
clocks for ddr and then jumps to the resume address in another RTC
scratchpad registers and transfers the control to Kernel. Kernel then
restores the saved context. omap_rtc_power_off_program does the ALARM2
programming part.

     [1] http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf Page 2884

2) Power-off: This is usual poweroff mode. omap_rtc_power_off calls the
above omap_rtc_power_off_program function and in addition to that
programs the OMAP_RTC_PMIC_REG for any external wake ups for PMIC like
the pushbutton and shuts off the PMIC.

Hence the split in omap_rtc_power_off.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/rtc/rtc-omap.c | 53 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 88da927..cb19ece 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -415,21 +415,12 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 
 static struct omap_rtc *omap_rtc_power_off_rtc;
 
-/*
- * omap_rtc_poweroff: RTC-controlled power off
- *
- * The RTC can be used to control an external PMIC via the pmic_power_en pin,
- * which can be configured to transition to OFF on ALARM2 events.
- *
- * Notes:
- * The two-second alarm offset is the shortest offset possible as the alarm
- * registers must be set before the next timer update and the offset
- * calculation is too heavy for everything to be done within a single access
- * period (~15 us).
- *
- * Called with local interrupts disabled.
+/**
+ * omap_rtc_power_off_program: Set the pmic power off sequence. The RTC
+ * generates pmic_pwr_enable control, which can be used to control an external
+ * PMIC.
  */
-static void omap_rtc_power_off(void)
+static int omap_rtc_power_off_program(struct device *dev)
 {
 	struct omap_rtc *rtc = omap_rtc_power_off_rtc;
 	struct rtc_time tm;
@@ -456,7 +447,7 @@ static void omap_rtc_power_off(void)
 	if (tm2bcd(&tm) < 0) {
 		dev_err(&rtc->rtc->dev, "power off failed\n");
 		rtc->type->lock(rtc);
-		return;
+		return -EINVAL;
 	}
 
 	rtc_wait_not_busy(rtc);
@@ -481,6 +472,38 @@ static void omap_rtc_power_off(void)
 		goto again;
 	rtc->type->lock(rtc);
 
+	return 0;
+}
+
+/*
+ * omap_rtc_poweroff: RTC-controlled power off
+ *
+ * The RTC can be used to control an external PMIC via the pmic_power_en pin,
+ * which can be configured to transition to OFF on ALARM2 events.
+ *
+ * Notes:
+ * The one-second alarm offset is the shortest offset possible as the alarm
+ * registers must be set before the next timer update and the offset
+ * calculation is too heavy for everything to be done within a single access
+ * period (~15 us).
+ *
+ * Called with local interrupts disabled.
+ */
+static void omap_rtc_power_off(void)
+{
+	struct rtc_device *rtc = omap_rtc_power_off_rtc->rtc;
+	u32 val;
+
+	omap_rtc_power_off_program(rtc->dev.parent);
+
+	/* Set PMIC power enable and EXT_WAKEUP in case PB power on is used */
+	omap_rtc_power_off_rtc->type->unlock(omap_rtc_power_off_rtc);
+	val = rtc_readl(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG);
+	val |= OMAP_RTC_PMIC_POWER_EN_EN | OMAP_RTC_PMIC_EXT_WKUP_POL(0) |
+			OMAP_RTC_PMIC_EXT_WKUP_EN(0);
+	rtc_writel(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG, val);
+	omap_rtc_power_off_rtc->type->lock(omap_rtc_power_off_rtc);
+
 	/*
 	 * Wait for alarm to trigger (within two seconds) and external PMIC to
 	 * power off the system. Add a 500 ms margin for external latencies
-- 
1.9.1

