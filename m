Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568CBC468C7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF4620878
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lRWqz9gV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF4620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbeGLFQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:16:20 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42834 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbeGLFQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:16:20 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6C589oR083934;
        Thu, 12 Jul 2018 00:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531372089;
        bh=01zvnLuGGa3qa4nGhhqaZLuSB4OGSs29nyasUmOVMq8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lRWqz9gVvjU7Ruaj1kC8VbFTNmikrsHSpFSfYd1yGrEOeo6A9dhgGoBvJKZZGRrY+
         RfdKp87YuGoPBv3Sk00k2vTYEov1FoDE9GEpPgLvE2I6rBvQlUQGi48WUrjEFgurrb
         xh8c0RK4XKBnpNiit+vVhAeH3tjkGv4YCadEtnIw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6C589RC007407;
        Thu, 12 Jul 2018 00:08:09 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 12
 Jul 2018 00:08:09 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 12 Jul 2018 00:08:09 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6C583Mj024383;
        Thu, 12 Jul 2018 00:08:06 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <t-kristo@ti.com>, <j-keerthy@ti.com>, <linux-rtc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan@kernel.org>
Subject: [PATCH v4 1/4] rtc: omap: Cut down the shutdown time from 2 seconds to 1 sec
Date:   Thu, 12 Jul 2018 10:37:37 +0530
Message-ID: <1531372060-10532-2-git-send-email-j-keerthy@ti.com>
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

Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
over try again.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v4:

  * Fixed a compilation issue.
  * Extended the roll over check post interrupt programming.

 drivers/rtc/rtc-omap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 323ff55..88da927 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -435,17 +435,23 @@ static void omap_rtc_power_off(void)
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
+	/* Clear any existing ALARM2 event */
+	rtc_writel(rtc, OMAP_RTC_STATUS_REG, OMAP_RTC_STATUS_ALARM2);
+
+	/* set alarm one second from now */
 	omap_rtc_read_time_raw(rtc, &tm);
+	seconds = tm.tm_sec;
 	bcd2tm(&tm);
 	rtc_tm_to_time(&tm, &now);
-	rtc_time_to_tm(now + 2, &tm);
+	rtc_time_to_tm(now + 1, &tm);
 
 	if (tm2bcd(&tm) < 0) {
 		dev_err(&rtc->rtc->dev, "power off failed\n");
@@ -470,6 +476,9 @@ static void omap_rtc_power_off(void)
 	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
 	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
 			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
+	/* Our calculations started right before the rollover, try again */
+	if (seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
+		goto again;
 	rtc->type->lock(rtc);
 
 	/*
-- 
1.9.1

