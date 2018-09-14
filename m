Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCC5FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C562820882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlb4nVdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C562820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbeINP1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:27:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36667 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbeINP1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:27:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id e1-v6so9947577wrt.3;
        Fri, 14 Sep 2018 03:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8pXDek8ZnrmjczAVnmQjU/AsOxmvJrcBH5KF6yK3Dzk=;
        b=dlb4nVdw5HTnxFtaAsbUYEw+BkbjDdyaJJOuo5wet0S0KlmqJ4lneuPGwg3Tweq8bg
         x1FyKECxMxWs8uU3Ew0K0T6YFHZWQYdUOvtYwUMsY0KLL23u3fq9WEozgENy9Gsx/QjC
         B5myXHWfXbXcG1POIqs6qVtphtKHBkbnG1uWOtY35LOEd6VdBm4aYu+C4dN6G8Aa1TKU
         UJrIE+J31f0uzVBgjWGfQi89XPSalpcwkCVrI4JOK+gXiuUYPo7Qrxt0FmOv8pNVRRW/
         dc3P6+7a1V/bmlXrasW6ccNQkeFqhoWjyUw8xxySkwARDu7EBy50edHpM8unup4yVWHw
         j/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8pXDek8ZnrmjczAVnmQjU/AsOxmvJrcBH5KF6yK3Dzk=;
        b=cCfBHxpxHC00G8svfY3FpE9bV1uXCDJsLnmFcv+2w55r77m0a+mCPrpDG17XvEXzhM
         +IHQuTjsF7Ay9DmRDiFX+vGIytvdST//tFlKMlGR0KgSgfqPbJHKiJVZ8bGf3xMSgzZA
         4CXBMlvqWGrgpHmJiSDYMjBfgfnpdUGq49bi3yGsOaasSJqj4rksKzyFFYrQt/plEqby
         cpKM8/AnVaW7xD1FrNwkm9fTzcrQMUmQLsFwqZbhytf7M05vs/CDMenxVT9DszidUtJI
         k01bd93CBLipmDxMA3Hg1t+YsZje1KivKpvch9g2pi4+IuiILsUyRKOH945X+R7dO0L/
         Bafg==
X-Gm-Message-State: APzg51D3FDR7Ax772+kqEuIfBKSryFiE/NiojuhoXwQtJiHzT36xOSPy
        BMofO96sNiBDKcY6KvUNlX+T0LZT
X-Google-Smtp-Source: ANB0Vdb+j3PuUK6bFY5ESy++Ho91fghuKNst5FC737O8vv0WGDBl04xj4qr3kf0qs26cP/9WaAXnNQ==
X-Received: by 2002:adf:959a:: with SMTP id p26-v6mr8542795wrp.202.1536920038176;
        Fri, 14 Sep 2018 03:13:58 -0700 (PDT)
Received: from localhost.localdomain (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id x15-v6sm5618524wrt.53.2018.09.14.03.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 03:13:57 -0700 (PDT)
From:   Romain Izard <romain.izard.pro@gmail.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH 2/2] watchdog: sama5d4: write the mode register in two steps
Date:   Fri, 14 Sep 2018 12:13:39 +0200
Message-Id: <20180914101339.7382-3-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180914101339.7382-1-romain.izard.pro@gmail.com>
References: <20180914101339.7382-1-romain.izard.pro@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The specification for SAMA5D2 and SAMA5D4 chips, that use this IP for
their watchdog timer, has the following advice regarding the Mode Register:

"When setting the WDDIS bit, and while it is set, the fields WDV and WDD
must not be modified."

I have observed on a board based on a SAMA5D2 chip that using any other
timeout duration than the default 16s in the device tree will reset the
board when the watchdog device is opened; this is probably due to ignoring
the aforementioned constraint.

To fix this, read the content of the Mode Register before writing it,
and split the access into two parts if WDV or WDD need to be changed.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/watchdog/sama5d4_wdt.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index 1e93c1b0e3cf..1e05268ad94b 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -46,7 +46,10 @@ MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
 	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-#define wdt_enabled (!(wdt->mr & AT91_WDT_WDDIS))
+#define wdt_enabled(reg) (!((reg) & AT91_WDT_WDDIS))
+
+#define wdt_different_counters(reg_a, reg_b) \
+	(((reg_a) ^ (reg_b)) & (AT91_WDT_WDV | AT91_WDT_WDD))
 
 #define wdt_read(wdt, field) \
 	readl_relaxed((wdt)->reg_base + (field))
@@ -78,8 +81,11 @@ static void wdt_write_nosleep(struct sama5d4_wdt *wdt, u32 field, u32 val)
 static int sama5d4_wdt_start(struct watchdog_device *wdd)
 {
 	struct sama5d4_wdt *wdt = watchdog_get_drvdata(wdd);
+	u32 reg = wdt_read(wdt, AT91_WDT_MR);
 
 	wdt->mr &= ~AT91_WDT_WDDIS;
+	if (!wdt_enabled(reg) && wdt_different_counters(reg, wdt->mr))
+		wdt_write(wdt, AT91_WDT_MR, reg & ~AT91_WDT_WDDIS);
 	wdt_write(wdt, AT91_WDT_MR, wdt->mr);
 
 	return 0;
@@ -88,8 +94,11 @@ static int sama5d4_wdt_start(struct watchdog_device *wdd)
 static int sama5d4_wdt_stop(struct watchdog_device *wdd)
 {
 	struct sama5d4_wdt *wdt = watchdog_get_drvdata(wdd);
+	u32 reg = wdt_read(wdt, AT91_WDT_MR);
 
 	wdt->mr |= AT91_WDT_WDDIS;
+	if (wdt_enabled(reg) && wdt_different_counters(reg, wdt->mr))
+		wdt_write(wdt, AT91_WDT_MR, wdt->mr & ~AT91_WDT_WDDIS);
 	wdt_write(wdt, AT91_WDT_MR, wdt->mr);
 
 	return 0;
@@ -122,7 +131,7 @@ static int sama5d4_wdt_set_timeout(struct watchdog_device *wdd,
 	 * If the watchdog is enabled, then the timeout can be updated. Else,
 	 * wait that the user enables it.
 	 */
-	if (wdt_enabled)
+	if (wdt_enabled(wdt->mr))
 		wdt_write(wdt, AT91_WDT_MR, wdt->mr & ~AT91_WDT_WDDIS);
 
 	wdd->timeout = timeout;
@@ -186,13 +195,17 @@ static int sama5d4_wdt_init(struct sama5d4_wdt *wdt)
 	 * If the watchdog is already running, we can safely update it.
 	 * Else, we have to disable it properly.
 	 */
-	if (wdt_enabled) {
+	reg = wdt_read(wdt, AT91_WDT_MR);
+	if (wdt_enabled(reg)) {
+		if (!wdt_enabled(wdt->mr))
+			wdt_write_nosleep(wdt, AT91_WDT_MR,
+					  wdt->mr & ~AT91_WDT_WDDIS);
 		wdt_write_nosleep(wdt, AT91_WDT_MR, wdt->mr);
-	} else {
-		reg = wdt_read(wdt, AT91_WDT_MR);
-		if (!(reg & AT91_WDT_WDDIS))
+	} else if (wdt_enabled(wdt->mr)) {
+		if (wdt_different_counters(reg, wdt->mr))
 			wdt_write_nosleep(wdt, AT91_WDT_MR,
-					  reg | AT91_WDT_WDDIS);
+					  reg & ~AT91_WDT_WDDIS);
+		wdt_write_nosleep(wdt, AT91_WDT_MR, wdt->mr);
 	}
 	return 0;
 }
-- 
2.17.1

