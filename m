Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6CAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359252064A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359252064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388180AbeHPIFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 04:05:21 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58606 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeHPIFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 04:05:21 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7G59MgP027775;
        Thu, 16 Aug 2018 00:09:22 -0500
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7G59MO9020545;
        Thu, 16 Aug 2018 00:09:22 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 16
 Aug 2018 00:09:22 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 16 Aug 2018 00:09:21 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7G59HS8001100;
        Thu, 16 Aug 2018 00:09:20 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <johan@kernel.org>,
        <j-keerthy@ti.com>
Subject: [PATCH v6 2/2] rtc: omap: Cut down the shutdown time from 2 seconds to 1 sec
Date:   Thu, 16 Aug 2018 10:39:00 +0530
Message-ID: <1534396140-1161-2-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534396140-1161-1-git-send-email-j-keerthy@ti.com>
References: <1534396140-1161-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
over try again.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/rtc/rtc-omap.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 44ff4cc..320b4a5 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -421,12 +421,6 @@ static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
  * The RTC can be used to control an external PMIC via the pmic_power_en pin,
  * which can be configured to transition to OFF on ALARM2 events.
  *
- * Notes:
- * The two-second alarm offset is the shortest offset possible as the alarm
- * registers must be set before the next timer update and the offset
- * calculation is too heavy for everything to be done within a single access
- * period (~15 us).
- *
  * Called with local interrupts disabled.
  */
 static void omap_rtc_power_off(void)
@@ -434,6 +428,7 @@ static void omap_rtc_power_off(void)
 	struct omap_rtc *rtc = omap_rtc_power_off_rtc;
 	struct rtc_time tm;
 	unsigned long now;
+	int seconds;
 	u32 val;
 
 	rtc->type->unlock(rtc);
@@ -441,11 +436,13 @@ static void omap_rtc_power_off(void)
 	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
 	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
 
-	/* set alarm two seconds from now */
+again:
+	/* set alarm one second from now */
 	omap_rtc_read_time_raw(rtc, &tm);
+	seconds = tm.tm_sec;
 	bcd2tm(&tm);
 	rtc_tm_to_time(&tm, &now);
-	rtc_time_to_tm(now + 2, &tm);
+	rtc_time_to_tm(now + 1, &tm);
 
 	if (tm2bcd(&tm) < 0) {
 		dev_err(&rtc->rtc->dev, "power off failed\n");
@@ -470,14 +467,22 @@ static void omap_rtc_power_off(void)
 	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
 	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
 			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
+
+	/* Retry in case roll over happened before alarm was armed. */
+	if (rtc_read(rtc, OMAP_RTC_SECONDS_REG) != seconds) {
+		val = rtc_read(rtc, OMAP_RTC_STATUS_REG);
+		if (!(val & OMAP_RTC_STATUS_ALARM2))
+			goto again;
+	}
+
 	rtc->type->lock(rtc);
 
 	/*
-	 * Wait for alarm to trigger (within two seconds) and external PMIC to
+	 * Wait for alarm to trigger (within one second) and external PMIC to
 	 * power off the system. Add a 500 ms margin for external latencies
 	 * (e.g. debounce circuits).
 	 */
-	mdelay(2500);
+	mdelay(1500);
 }
 
 static const struct rtc_class_ops omap_rtc_ops = {
-- 
1.9.1

