Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33129C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E855A20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SFZLKqa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E855A20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbeLEXwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:52:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33136 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbeLEXwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:52:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so12885994wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rBYjCviXbp1GB9pLzlbZBcnM5Y0HUWSor8mlLMpmZyM=;
        b=SFZLKqa07jB+I+9eKm/4rEpndVBtrkls+WtaeK//lYJ70sIBn921bc3UrDOUl7o+cH
         iuTSK1kY1gKmCK5ghMdhMwZfGOJlZjxdm8DIfzb6VgLA6OOtd3yHi9bQnrNDnObYXwks
         gcD/1l75Mf6FjBOWHVcX+vSwEYaKtF866HsuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rBYjCviXbp1GB9pLzlbZBcnM5Y0HUWSor8mlLMpmZyM=;
        b=mS3r08DQzf7dXA4Enx2GUnIpNdwiGD4cZasimdUjxouf44WXh3+oYy+4bozL7T3JpG
         1003qZzOTn+iqFP3m86j1FBAFZIzx+rh1cKMDBH1HImQJN6s1SynNKdwNEQDlLoOHHVF
         cWkl05aM/i6jFvAtQWVh4/7n4r5a9nRwusKgep0LOU6x6/Wx+KFqqNsx5tQ4tFF3QrmL
         lT3/EeAgW6OG7NyiwDNy9Ew3tQ09J2L3QWpGYfaJCu3TzmdHEjkSePfZmvv6tl9iZ3QU
         PDb78ORC0DDw6K2gU54WZKl8k+92eU/jTA/UoCavAqQWj5Nb7HazSEIljCoaABBYMd3C
         +eww==
X-Gm-Message-State: AA+aEWa1C2BiinnqAavdaFdCJMp4xcnhvW12xQun96g4QsKV8gptm0O3
        HB6HAudoogMRCL/1W3UXfiSQ8g==
X-Google-Smtp-Source: AFSGD/XQDNliKlJmlnBnT0V5lCbVyFo0/Mnwytx7hEowZ/u54DhqIbdefL5WpZooQ8qwGr6IzCxRLA==
X-Received: by 2002:a1c:f8f:: with SMTP id 137mr17208559wmp.96.1544053951508;
        Wed, 05 Dec 2018 15:52:31 -0800 (PST)
Received: from localhost.localdomain (ip-161-243.sn-213-198.clouditalia.com. [213.198.161.243])
        by smtp.gmail.com with ESMTPSA id x15sm19113324wrs.27.2018.12.05.15.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 15:52:30 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 2/4] Input: goodix - Add ADVV28-supply regulator support
Date:   Thu,  6 Dec 2018 05:22:18 +0530
Message-Id: <20181205235220.3461-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181205235220.3461-1-jagan@amarulasolutions.com>
References: <20181205235220.3461-1-jagan@amarulasolutions.com>
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
Changes for v2:
- disable regulator in remove
- fix to setup regulator in probe code

 drivers/input/touchscreen/goodix.c | 33 +++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f2d9c2c41885..7371f6946098 100644
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
@@ -786,25 +788,41 @@ static int goodix_ts_probe(struct i2c_client *client,
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
@@ -823,23 +841,28 @@ static int goodix_ts_probe(struct i2c_client *client,
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
 {
 	struct goodix_ts_data *ts = i2c_get_clientdata(client);
 
+	regulator_disable(ts->avdd28);
 	if (ts->gpiod_int && ts->gpiod_rst)
 		wait_for_completion(&ts->firmware_loading_complete);
 
-- 
2.18.0.321.gffc6fa0e3

