Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2B3C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69713206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OMjXcPzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfBLLZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:25:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39312 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbfBLLY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:24:58 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so1152116pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 03:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KymeUwjgm1K3Y8XpxtdBBwhSts22Nd+Sh6iYQzrT0QA=;
        b=OMjXcPzd7yYj9evtSeUM1prt5u0z6HVdH8LS6bH42VWdypGwM9vtoVklqWPDQkHeTf
         ti/kuDFFLwT8nyVH7ey2UklJ5mL/btGhac3KGK9n/SbO3kGY5x3tBlZpEdldidnjwsk7
         gh6HPtkGzpyqBNf6qpkxv+fUgyEKOx/+P3fFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KymeUwjgm1K3Y8XpxtdBBwhSts22Nd+Sh6iYQzrT0QA=;
        b=d7mHVLACVpz1hUOa+MZpwez98NbYoxVwPuSgU/px3LMvpdcjQm1M8IJ37PR4n8YuCp
         QtInE6qQk2ROtHIkTjfNzxCGxfnZ0CaIQD8cmyafiHgjCHc6k5OaC4Je7dHhLV32JLGM
         rjSri33LihZhh5V2P/j/WE+G9KXLFKXeWPqZ014O11nR65zVjnepMOo771aL1MIPelY0
         jdnwXDp2UeZr+S/0zbsJTamHyZNssjAQVY615lE5hvXd6gpWEsTSX0CiWzB/F32z0eQP
         /VCNYxlg9+V6lzwY+A4LxUxxVyY16oWZEpiUZ8GtTB8/1OFtWmtDY6i8UWD4huKflrTk
         BOGA==
X-Gm-Message-State: AHQUAubQ2fzhB1Evaq7pa0I39EiCN4yi5pdHnygj0s+oT7cw33oTLpQr
        okp1r7cqwNLqf6/v6zqrhjvNFA==
X-Google-Smtp-Source: AHgI3IZw60aAAchUpY16XpvuA+i8sfcAb3jxXBzGpTa0jZ273epu3pEv6Q9I0VV1zHZffTgRjiSqyQ==
X-Received: by 2002:a17:902:b615:: with SMTP id b21mr3533559pls.338.1549970697857;
        Tue, 12 Feb 2019 03:24:57 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id q28sm22399460pgl.35.2019.02.12.03.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 03:24:57 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 2/4] Input: goodix - Add AVDD28-supply regulator support
Date:   Tue, 12 Feb 2019 16:54:37 +0530
Message-Id: <20190212112439.2025-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190212112439.2025-1-jagan@amarulasolutions.com>
References: <20190212112439.2025-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goodix CTP controllers have AVDD28 pin connected to voltage
regulator which may not be turned on by default, like for GT5663.

Add support for such ctp used boards by adding voltage regulator
handling code to goodix ctp driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/input/touchscreen/goodix.c | 44 ++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f2d9c2c41885..e92b90be1ac2 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -27,6 +27,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
@@ -47,6 +48,7 @@ struct goodix_ts_data {
 	struct touchscreen_properties prop;
 	unsigned int max_touch_num;
 	unsigned int int_trigger_type;
+	struct regulator *avdd28;
 	struct gpio_desc *gpiod_int;
 	struct gpio_desc *gpiod_rst;
 	u16 id;
@@ -761,6 +763,13 @@ static void goodix_config_cb(const struct firmware *cfg, void *ctx)
 	complete_all(&ts->firmware_loading_complete);
 }
 
+static void goodix_disable_regulator(void *arg)
+{
+	struct goodix_ts_data *ts = arg;
+
+	regulator_disable(ts->avdd28);
+}
+
 static int goodix_ts_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
@@ -786,25 +795,46 @@ static int goodix_ts_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
+	ts->avdd28 = devm_regulator_get(&client->dev, "AVDD28");
+	if (IS_ERR(ts->avdd28)) {
+		error = PTR_ERR(ts->avdd28);
+		if (error != -EPROBE_DEFER)
+			dev_err(&client->dev,
+				"Failed to get AVDD28 regulator: %d\n", error);
+		return error;
+	}
+
+	/* power the controller */
+	error = regulator_enable(ts->avdd28);
+	if (error) {
+		dev_err(&client->dev, "Controller fail to enable AVDD28\n");
+		return error;
+	}
+
+	error = devm_add_action_or_reset(&client->dev,
+					 goodix_disable_regulator, ts);
+	if (error)
+		return error;
+
 	if (ts->gpiod_int && ts->gpiod_rst) {
 		/* reset the controller */
 		error = goodix_reset(ts);
 		if (error) {
 			dev_err(&client->dev, "Controller reset failed.\n");
-			return error;
+			goto error;
 		}
 	}
 
 	error = goodix_i2c_test(client);
 	if (error) {
 		dev_err(&client->dev, "I2C communication failure: %d\n", error);
-		return error;
+		goto error;
 	}
 
 	error = goodix_read_version(ts);
 	if (error) {
 		dev_err(&client->dev, "Read version failed.\n");
-		return error;
+		goto error;
 	}
 
 	ts->chip = goodix_get_chip_data(ts->id);
@@ -823,17 +853,21 @@ static int goodix_ts_probe(struct i2c_client *client,
 			dev_err(&client->dev,
 				"Failed to invoke firmware loader: %d\n",
 				error);
-			return error;
+			goto error;
 		}
 
 		return 0;
 	} else {
 		error = goodix_configure_dev(ts);
 		if (error)
-			return error;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	regulator_disable(ts->avdd28);
+	return error;
 }
 
 static int goodix_ts_remove(struct i2c_client *client)
-- 
2.18.0.321.gffc6fa0e3

