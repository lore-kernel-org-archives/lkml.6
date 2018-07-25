Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82F9C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A35F20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GXq42lMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A35F20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeGYHCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:02:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51608 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbeGYHCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:02:11 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6P5pYur120857;
        Wed, 25 Jul 2018 00:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532497894;
        bh=LbvYNADZP+exWg3FyOeOKhToIJGavSjBb9q/TnHICuE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GXq42lMrQzCOIyZQsdwrox8w09naNNbLkL9dlzbMy13fFqEAOPJpFFv65EnPe1FUP
         jU0GhwcDpMIkLjTdwuJrX4x3eBysxmoRi8Ay6OoR68C4/KxZIyw8j89iCZNuMlFLwL
         PjAd4+ywchGoywsAXTbCAXp/qrPrmHac12/kBA+g=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6P5pYLU027159;
        Wed, 25 Jul 2018 00:51:34 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 25
 Jul 2018 00:51:33 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 25 Jul 2018 00:51:33 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6P5pSXi024328;
        Wed, 25 Jul 2018 00:51:31 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <t-kristo@ti.com>, <j-keerthy@ti.com>, <linux-rtc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan@kernel.org>
Subject: [PATCH v5 2/2] rtc: omap: Cut down the shutdown time from 2 seconds to 1 sec
Date:   Wed, 25 Jul 2018 11:21:22 +0530
Message-ID: <1532497882-8828-2-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532497882-8828-1-git-send-email-j-keerthy@ti.com>
References: <1532497882-8828-1-git-send-email-j-keerthy@ti.com>
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

Changes in v5:

  * Added an additional check to see if ALARM2 status is not set
    before retrying.
  * Cleaned up comments
  * Also reduced mdelay to 1S lesser as per this commit

 drivers/rtc/rtc-omap.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 44ff4cc..caa6da6 100644
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
@@ -435,17 +429,20 @@ static void omap_rtc_power_off(void)
 	struct rtc_time tm;
 	unsigned long now;
 	u32 val;
+	int seconds;
 
 	rtc->type->unlock(rtc);
 	/* enable pmic_power_en control */
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
@@ -470,14 +467,25 @@ static void omap_rtc_power_off(void)
 	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
 	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
 			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
+
+	/*
+	 * first check if ALARM2 has fired, if not then check if
+	 * our calculations started right before the rollover, try again
+	 * in case of rollover
+	 */
+	if (!(OMAP_RTC_STATUS_ALARM2 && rtc_read(omap_rtc_power_off_rtc,
+						 OMAP_RTC_STATUS_REG)) &&
+	    seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
+		goto again;
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

