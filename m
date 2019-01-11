Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F609C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE452133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJJH+94B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfAKUyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:54:53 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38345 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfAKUyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:54:52 -0500
Received: by mail-io1-f66.google.com with SMTP id l14so13208516ioj.5;
        Fri, 11 Jan 2019 12:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DCso5ZbmVHYu/esiOc82HERwOygGoElOLZSw3fJOn90=;
        b=rJJH+94B+3BsUApjTPkw9iyErUzgDiZ02H7IpUnzyc/MNLEA9QJx4BzBeTeG1oqkeB
         eazkyGMBaUgFF5p2Y5K7UI959sQOpTBpDhyU4kib+TiIMRuLqc0FIftJiwTTlj4CgDvY
         9pA2b91r7tcVItXZuKBSQYNaOylcf0nBGuOnKltPwh3T49TVSiUAMcjSQO2K0LTRgG5s
         jOCmV5MVmz0VBC+6ZudIoK0+A9ghm7zxbuneuOqTVpck3HFJlU83BN5jAVec9KzN1bSg
         OL/tGQHafHygjU6bvyjjRYbEtwP0ZoYbA5jgjPhxXVLviBoepbFgOQ3999McC2DgzhYV
         ydHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DCso5ZbmVHYu/esiOc82HERwOygGoElOLZSw3fJOn90=;
        b=qqy/kfYzojhWjlQG8UqYjL9SN8s4hPdmdP63NBhfIpudRngHGKLNuomsSBC2yoxEJt
         KTDFds7DcERNnvvXnhPbi+1CHO4BTQJzDwj9FClWYg8QsVwcGDxyOU/r0AYguH8ZfOyL
         HS0N/i/L1UxV2/Ni+QSl9g5795IbEEF6N4o0YALMeKxNshZKBD2SqddLa+FM+iTlFPmL
         OuXyzWUmmhe48yHXIDZlwONEzp14driKV7UALcMIyvqNmZgDQZu9rne3MeHyzwHifSLP
         Pe1faNeMZvNBmQXP0K2FYEl1BKPzpui+ctnocUZYLFkzqUeNQh4Y5w8sUwMcGPMTCChy
         FPhQ==
X-Gm-Message-State: AJcUukfpamXQHUincuhAAnCiTyK05AKnDlZmAwJEzJ/tErZWGIrtfFZP
        68BO0m+PHTw+lCwjMF+3gZSL7NqejNc=
X-Google-Smtp-Source: ALg8bN7e15QPTz4u1A9iq1oP9X5mHo2ASVKl2+EHBCMFftn3nKxpNQdnbQnzsRicxN24r8SEDXEAaQ==
X-Received: by 2002:a6b:c9c8:: with SMTP id z191mr10823236iof.13.1547240090421;
        Fri, 11 Jan 2019 12:54:50 -0800 (PST)
Received: from localhost ([67.218.223.154])
        by smtp.gmail.com with ESMTPSA id i135sm12115821iti.34.2019.01.11.12.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 12:54:49 -0800 (PST)
From:   Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        himanshujha199640@gmail.com, mark.rutland@arm.com,
        robh+dt@kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org,
        Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Subject: [PATCH v2 1/2] iio: chemical: bme680: Add device-tree support
Date:   Fri, 11 Jan 2019 15:53:58 -0500
Message-Id: <20190111205359.14158-1-sebastien.bourdelin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit allow the driver to work with device-tree.

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
---
v1 -> v2:
  - add missing of.h header in bme680_spi.c
---
 drivers/iio/chemical/bme680_i2c.c | 7 +++++++
 drivers/iio/chemical/bme680_spi.c | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
index 06d4be539d2e..94a36ebdf0b2 100644
--- a/drivers/iio/chemical/bme680_i2c.c
+++ b/drivers/iio/chemical/bme680_i2c.c
@@ -70,10 +70,17 @@ static const struct acpi_device_id bme680_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
 
+static const struct of_device_id bme680_of_i2c_match[] = {
+	{ .compatible = "bosch,bme680", },
+	{},
+}
+MODULE_DEVICE_TABLE(of, bme680_of_i2c_match);
+
 static struct i2c_driver bme680_i2c_driver = {
 	.driver = {
 		.name			= "bme680_i2c",
 		.acpi_match_table       = ACPI_PTR(bme680_acpi_match),
+		.of_match_table		= of_match_ptr(bme680_of_i2c_match),
 	},
 	.probe = bme680_i2c_probe,
 	.id_table = bme680_i2c_id,
diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
index c9fb05e8d0b9..caa57287a911 100644
--- a/drivers/iio/chemical/bme680_spi.c
+++ b/drivers/iio/chemical/bme680_spi.c
@@ -6,9 +6,11 @@
  */
 #include <linux/acpi.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
+
 #include "bme680.h"
 
 static int bme680_regmap_spi_write(void *context, const void *data,
@@ -110,10 +112,17 @@ static const struct acpi_device_id bme680_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
 
+static const struct of_device_id bme680_of_spi_match[] = {
+	{ .compatible = "bosch,bme680", },
+	{},
+}
+MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
+
 static struct spi_driver bme680_spi_driver = {
 	.driver = {
 		.name			= "bme680_spi",
 		.acpi_match_table	= ACPI_PTR(bme680_acpi_match),
+		.of_match_table		= of_match_ptr(bme680_of_spi_match),
 	},
 	.probe = bme680_spi_probe,
 	.id_table = bme680_spi_id,
-- 
2.20.1

