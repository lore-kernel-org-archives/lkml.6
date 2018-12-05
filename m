Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9029C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71A82133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qH8YQjG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71A82133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeLEVOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:14:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53872 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbeLEVOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:14:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id y1so14657519wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=voaN3ll+2wzFcFzcZZWq17UVHOj7IO+So5pVAZfUs6U=;
        b=qH8YQjG1I1N1KjexUt48cpYfv2FNT/FdbP/Lxe9xNYWeyKTmjRHspAdOdcAVMAnXls
         h8p7ejEjUqfxgS4gXzQ6uHoBF3eYUuBINDDEoNSDwH28V/wGOLoD4rXOeaJ7pDXelWLd
         soYYtQFc+esFqcapmguxGoHU+9wrzYUwuGGAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=voaN3ll+2wzFcFzcZZWq17UVHOj7IO+So5pVAZfUs6U=;
        b=QPrGf8A3IBQU6230BEEWjsnAmhY073AW2T6D8uOBggyWm4y+GoHCIWmWo4ZwVcK/Pj
         9H4SGo4naHUl0cuZdijXAZrzE/GZgb9uXbTpdPDXCYeqJ/FL1vw6KuraAQCnEYDoIDq4
         yr89CJJLItamwUxHOUZoE1cv8pO3zFfGcubNx/H5lwAfbCfsvYlRl1ZHLNlg7Di24Sse
         At1x7WuwDXwNL0cx+0+eRKDYcS9LuGlTj+QCGqr4hAvMrU/j4UMUa2un1RMfHjj4bOpf
         0lpEerEZ8Zluvln1b0iyMYeZ+6jO4yqksNMCFGciNKisVUf8WA4bp1JvuwuuLTRgLxrI
         1kWQ==
X-Gm-Message-State: AA+aEWaHIhkqwqUEEm7xHBgBmnLXjybjcULp9C1ijDDEgdpHDyZdaBr8
        WA/j8W9SW3YOlESh2Q19+lTIuw==
X-Google-Smtp-Source: AFSGD/VmsgFDBTxsVcyYdsnvxqi/P8ahAsNbyj+GAvO/jobnk6RhxP9eQf8GDXBppxboDf2oTOmFzw==
X-Received: by 2002:a1c:60c3:: with SMTP id u186mr18642596wmb.66.1544044470951;
        Wed, 05 Dec 2018 13:14:30 -0800 (PST)
Received: from localhost.localdomain (ip-146-204.sn3.clouditalia.com. [213.136.146.204])
        by smtp.gmail.com with ESMTPSA id a17sm18740220wrs.58.2018.12.05.13.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 13:14:30 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] hwmon: (lm75) Add STLM75 support
Date:   Thu,  6 Dec 2018 02:44:22 +0530
Message-Id: <20181205211422.22266-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STLM75 is a high-precision digital CMOS temperature sensor
IC with a sigma-delta temperature-to-digital converter.

The configuration register mapping is similar to existing lm75
but the sample rate is 150ms(max).

Tested on real hardware and verified temperature readings are correct.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/hwmon/lm75 |  5 +++++
 drivers/hwmon/Kconfig    |  1 +
 drivers/hwmon/lm75.c     | 10 ++++++++++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/hwmon/lm75 b/Documentation/hwmon/lm75
index 2f1120f88c16..010583608f12 100644
--- a/Documentation/hwmon/lm75
+++ b/Documentation/hwmon/lm75
@@ -42,6 +42,11 @@ Supported chips:
     Addresses scanned: none
     Datasheet: Publicly available at the ST website
                http://www.st.com/internet/analog/product/121769.jsp
+  * ST Microelectronics STLM75
+    Prefix: 'stlm75'
+    Addresses scanned: none
+    Datasheet: Publicly available at the ST website
+	       https://www.st.com/resource/en/datasheet/stlm75.pdf
   * Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75, TMP75C, TMP175, TMP275
     Prefixes: 'tmp100', 'tmp101', 'tmp105', 'tmp112', 'tmp175', 'tmp75', 'tmp75c', 'tmp275'
     Addresses scanned: none
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 532a0532d01b..515b2ad872c8 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1035,6 +1035,7 @@ config SENSORS_LM75
 		- National Semiconductor LM75, LM75A
 		- NXP's LM75A
 		- ST Microelectronics STDS75
+		- ST Microelectronics STLM75
 		- TelCom (now Microchip) TCN75
 		- Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75,
 		  TMP175, TMP275
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index c7f20543b2bf..62acb9f16ec5 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -50,6 +50,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
 	max31725,
 	mcp980x,
 	stds75,
+	stlm75,
 	tcn75,
 	tmp100,
 	tmp101,
@@ -316,6 +317,10 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		data->resolution = 11;
 		data->sample_time = MSEC_PER_SEC;
 		break;
+	case stlm75:
+		data->resolution = 9;
+		data->sample_time = MSEC_PER_SEC / 5;
+		break;
 	case ds7505:
 		set_mask |= 3 << 5;		/* 12-bit mode */
 		data->resolution = 12;
@@ -424,6 +429,7 @@ static const struct i2c_device_id lm75_ids[] = {
 	{ "max31726", max31725, },
 	{ "mcp980x", mcp980x, },
 	{ "stds75", stds75, },
+	{ "stlm75", stlm75, },
 	{ "tcn75", tcn75, },
 	{ "tmp100", tmp100, },
 	{ "tmp101", tmp101, },
@@ -494,6 +500,10 @@ static const struct of_device_id lm75_of_match[] = {
 		.compatible = "st,stds75",
 		.data = (void *)stds75
 	},
+	{
+		.compatible = "st,stlm75",
+		.data = (void *)stlm75
+	},
 	{
 		.compatible = "microchip,tcn75",
 		.data = (void *)tcn75
-- 
2.18.0.321.gffc6fa0e3

