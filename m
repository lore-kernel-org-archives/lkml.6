Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7813CC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E38E2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Ipleb2NB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E38E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbeLLWTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:19:04 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40712 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbeLLWQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:16:50 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v8 09/26] watchdog: jz4740: Avoid starting watchdog in set_timeout
Date:   Wed, 12 Dec 2018 23:09:04 +0100
Message-Id: <20181212220922.18759-10-paul@crapouillou.net>
In-Reply-To: <20181212220922.18759-1-paul@crapouillou.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1544652590; bh=T4se2QGr/ApBJ0rIVfm4Ho9meBkMEzLAcagRVPLBG0A=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ipleb2NB35ciKMlYy7MzElF6A0bJFBLwIEI9spHff6VHEv3tfhxo4hkcmgoQdk7QEJaDlyrOQsLONdR9NbN/rVZ4YLtZuCIvb66x4W9CmxQM2mkRcJnLwrLRC8GlUPcegCIy6kvbmGQuomQLcHugX/u0aXQ5g0NIH/E8VP4dtmU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the jz4740_wdt_set_timeout() function was starting the timer
unconditionally, even if it was stopped when that function was entered.

Now, the timer will be restarted only if it was already running before
this function is called.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

Notes:
     v6: New patch
    
     v7: No change

     v8: No change

 drivers/watchdog/jz4740_wdt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 0f54306aee25..45d9495170e5 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -64,13 +64,15 @@ static int jz4740_wdt_set_timeout(struct watchdog_device *wdt_dev,
 {
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
 	u16 timeout_value = (u16)(drvdata->clk_rate * new_timeout);
+	u32 tcer;
 
+	regmap_read(drvdata->map, TCU_REG_WDT_TCER, &tcer);
 	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
 
 	regmap_write(drvdata->map, TCU_REG_WDT_TDR, timeout_value);
 	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
 
-	regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCER, tcer & TCU_WDT_TCER_TCEN);
 
 	wdt_dev->timeout = new_timeout;
 	return 0;
@@ -86,6 +88,7 @@ static int jz4740_wdt_start(struct watchdog_device *wdt_dev)
 		return ret;
 
 	jz4740_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
 
 	return 0;
 }
-- 
2.11.0

