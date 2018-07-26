Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE363C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D6520685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IGOiM4iO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D6520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbeGZGOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:14:03 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34172 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbeGZGOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:14:02 -0400
Received: by mail-qt0-f196.google.com with SMTP id m13-v6so403991qth.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 21:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=a5IZjJ9vvxmZFoOe/10y6NAmKt7hxPPp1FmGv4zbml8=;
        b=IGOiM4iOlBXH8UahT9ibM5s5ZqmsFdgBI7q8ykmd8VPPbNehpM2SYg2H7BSEsm+4gE
         iFqOLIgX73ltlDSBq1YW0JlVfaTphWyZm0B4ydQ2eM11Pb0gmWux+5Iskbs3uAFY8Krj
         AusACC23H3ZnWtbP97ujQmobXdoJRQTOxeWFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a5IZjJ9vvxmZFoOe/10y6NAmKt7hxPPp1FmGv4zbml8=;
        b=ZN0332w+86t6ecCkj3a+UeqMc2U2Wl7dTtVQpUuolOz2ubsBGCUJD42hWI67aQs52Y
         KrIY87thW2EFZGZlJ7BLMFDWIADjjIDxM6cg10hhTJZjojUN+9Cacldblp0MkYtR1XNC
         kU3/eVHwgao3cxu0oqprssLq5wqV0K9KZ3JuqqPjxW37Oi1OGTXxf8TaMgttufYRCvaa
         3PaxPYZAodr4JlX5y5vPDmjaDV/lXRE5ed+rarQCSlGimtHdtEwyGasjvRcsGdfyPZVd
         1gyn+icFNNOVxT25uPu8xAH71ToChmD+w4IImtBuRNaetWR9r42RO2mWAMqXFew/XcCn
         z9KA==
X-Gm-Message-State: AOUpUlG06iIbcXzlFLL38S3VTqQ2rfMtoKUxPvaooN3GwA+Xc7dYBCA0
        P84HsBYdd/q8MatTCMxaOGMlRg==
X-Google-Smtp-Source: AAOMgpdOWy7ZFNITjbqeieD2wKIDsEDeShmgXgG3tNlGcPVyNhNWziLN4BOIBWn72+Ng+z+XhtONyw==
X-Received: by 2002:a0c:886d:: with SMTP id 42-v6mr348739qvm.242.1532581142554;
        Wed, 25 Jul 2018 21:59:02 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id m129-v6sm300285qkb.8.2018.07.25.21.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jul 2018 21:59:01 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     ray.jui@broadcom.com, vladimir.olovyannikov@broadcom.com,
        vikram.prakash@broadcom.com, scott.branden@broadcom.com,
        sudeep.holla@arm.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2] watchdog: sp805: Add clock-frequency property
Date:   Thu, 26 Jul 2018 10:28:42 +0530
Message-Id: <1532581122-4919-1-git-send-email-srinath.mannam@broadcom.com>
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

