Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD586ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B2F20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EJgWsOc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B2F20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbeGWJiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:38:04 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43791 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387996AbeGWJiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:38:04 -0400
Received: by mail-qt0-f193.google.com with SMTP id f18-v6so15723976qtp.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+OrlBq8S8fZTsNiUaTgi7Se0vBRKinGE10j/lTT7NWI=;
        b=EJgWsOc4GPfFhAqwXOj/DsF3HAli7GefMkCDPDoP1J4dvRJMFSltb421AcjTzd6vL1
         6GUiQRSXcYI5RylHTd0yfY/tinqhdBjYJSBA/3jKnR5qeTUrJfSXH4TdmfuwYUi5511K
         okkDkJjas2ltXWBWEPJ+x1zwUFf6DMoE0fyw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+OrlBq8S8fZTsNiUaTgi7Se0vBRKinGE10j/lTT7NWI=;
        b=noN7GuL2eDHo6yxChDQI01wO7AYWLHnSsaDdO96aK8uhFSIl2mMrEKpNYhImN1YKyR
         UIIUGKt9VMcFEeuHvMRsotl0RM5DOY0UBflVQz7zyLIIDif6WlIJQFACX7ElqzAbhlrJ
         9zrin7/qU2tQiaRVjvZWxug5WhYmN5NfbLr1ZUdNHaPdNrZ4GzGpZCubTfgZSjKOAYgE
         dzDADUP1ApZG9fr7Wub1WXmtJQDHaT6HHjd5Icdvfp+3mF56PE7Pr8fdjT3W6yhcapsH
         JCdj5Rsg1kusClaVdds010KOk8vx72CD1UO6YeplwhfrW6J2RlH2ClOf85hCByCxabdQ
         lhYA==
X-Gm-Message-State: AOUpUlF+sK9ligadQ00H5htUqfxyD6rRWF8x8mlPZjYRRgTo6hZIMUNd
        n8JJg1ExyOIK9hg/FBbiu7Y5Qw==
X-Google-Smtp-Source: AAOMgpdoynIrk6J4XbzhHK2hNv6TIBrWWyIirUSPuIJelnu+33XaCcGoPgUzcycTftVU70afu7ri4g==
X-Received: by 2002:a0c:af42:: with SMTP id j2-v6mr10380397qvc.191.1532335078149;
        Mon, 23 Jul 2018 01:37:58 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id v4-v6sm6589434qth.23.2018.07.23.01.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 01:37:57 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     ray.jui@broadcom.com, vladimir.olovyannikov@broadcom.com,
        vikram.prakash@broadcom.com, scott.branden@broadcom.com,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH] watchdog: sp805: Add clock-frequency property
Date:   Mon, 23 Jul 2018 14:07:40 +0530
Message-Id: <1532335060-686-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clock-frequency property given in _DSD object
of ACPI device to calculate Watchdog rate as binding
clock devices are not available as device tree.

Note: There is no formal review process for _DSD
properties

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/watchdog/sp805_wdt.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 9849db0..a896b1c 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -11,6 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/resource.h>
 #include <linux/amba/bus.h>
@@ -22,6 +23,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -65,6 +67,7 @@ struct sp805_wdt {
 	spinlock_t			lock;
 	void __iomem			*base;
 	struct clk			*clk;
+	u64				rate;
 	struct amba_device		*adev;
 	unsigned int			load_val;
 };
@@ -80,7 +83,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
 	u64 load, rate;
 
-	rate = clk_get_rate(wdt->clk);
+	rate = wdt->rate;
 
 	/*
 	 * sp805 runs counter with given value twice, after the end of first
@@ -106,9 +109,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
 static unsigned int wdt_timeleft(struct watchdog_device *wdd)
 {
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
-	u64 load, rate;
-
-	rate = clk_get_rate(wdt->clk);
+	u64 load;
 
 	spin_lock(&wdt->lock);
 	load = readl_relaxed(wdt->base + WDTVALUE);
@@ -118,7 +119,7 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
 		load += wdt->load_val + 1;
 	spin_unlock(&wdt->lock);
 
-	return div_u64(load, rate);
+	return div_u64(load, wdt->rate);
 }
 
 static int
@@ -228,11 +229,25 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
-	wdt->clk = devm_clk_get(&adev->dev, NULL);
-	if (IS_ERR(wdt->clk)) {
-		dev_warn(&adev->dev, "Clock not found\n");
-		ret = PTR_ERR(wdt->clk);
-		goto err;
+	if (adev->dev.of_node) {
+		wdt->clk = devm_clk_get(&adev->dev, NULL);
+		if (IS_ERR(wdt->clk)) {
+			dev_err(&adev->dev, "Clock not found\n");
+			return PTR_ERR(wdt->clk);
+		}
+		wdt->rate = clk_get_rate(wdt->clk);
+	} else if (has_acpi_companion(&adev->dev)) {
+		/*
+		 * When Driver probe with ACPI device, clock devices
+		 * are not available, so watchdog rate get from
+		 * clock-frequency property given in _DSD object.
+		 */
+		device_property_read_u64(&adev->dev, "clock-frequency",
+					 &wdt->rate);
+		if (!wdt->rate) {
+			dev_err(&adev->dev, "no clock-frequency property\n");
+			return -ENODEV;
+		}
 	}
 
 	wdt->adev = adev;
-- 
2.7.4

