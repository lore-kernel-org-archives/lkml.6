Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9F8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A7D2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7QHgD9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfANUUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:20:15 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35839 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfANUUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:20:14 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so1342057itp.0;
        Mon, 14 Jan 2019 12:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7/vljl9wcoslPN7/8KEh45eFBFCMxetW0Cqy/5oxxQ=;
        b=E7QHgD9duPz+gnRc2u6DwA2n0U2nX+1R2MgkCV0sJc16rkvYhAxma7KygNBz4cXA2M
         ValihZGYgm4prV3qZQxmvmlV3E+a2bOkDgYqQ5VuGP7LaMNndKItew8VlOD6GQL+wys0
         Hm7bwN0H9YeU0c6owmG2J9BiseIBnls9Ns4dQg12FFDcuhI2mxuaY2+CGY1cjPjbPdz/
         MXWRRnPKTcDTj65z4TOkuhR+gqunnjji/5ZWkb+r3I+gy1oZawiwqeF9+fOnJgel87RG
         KnCA7JwIJdVQXFT6UMxPGoJ0ULqoArpYV7zHmNgn97HTZe0sLrSfK8MYz4/IYgU7HANl
         S3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7/vljl9wcoslPN7/8KEh45eFBFCMxetW0Cqy/5oxxQ=;
        b=PvPBCigK8tBdm3Ux+CGoc0oYm/0qnmvz9TcQhrrO67ho3892s67EDEmCY1KKQda3Hq
         ur/vd9PAXi+q60jRvTYhw+KEdmamPJdnszBmyL32D0Kdz/CBzrnoKqblLtkEP57ZDtWU
         TVD77DlOwKc5t5dxk+voKB1GPHGrnAzkmlyQ+3q6u7i2n3NE8gnFVXuL84T0sv0ptyz7
         c01wp7vQ1kjaNE0XhF18yJUvol+0auccTwoNwJdGyGwArqpVlTWXw6AYVZp4nWi0W8Tg
         LUoblvM4bSOdiqfrTjJyo11sCXeW4Rc5tLgOKD4hKc28H6GXs+3oMlp0zjucYkz6vVOm
         htpA==
X-Gm-Message-State: AJcUukdoBM9lRQiYFGJKkwY7TdBIF7mODexxDsZ6nABRpCptu81m2iKs
        bMfZGLXNHY6ot4QttUYr+5khyiCkoME=
X-Google-Smtp-Source: ALg8bN5hiQIH/S3mEzwLbYo7t3s+JiqywbbS7H9vxmRYJ+15ExKHO1hSKnU/JmJSdHPxJLxN06I8mQ==
X-Received: by 2002:a05:660c:914:: with SMTP id s20mr571441itj.160.1547497213108;
        Mon, 14 Jan 2019 12:20:13 -0800 (PST)
Received: from localhost ([67.218.223.154])
        by smtp.gmail.com with ESMTPSA id m37sm704233iti.6.2019.01.14.12.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:20:12 -0800 (PST)
From:   Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        himanshujha199640@gmail.com, mark.rutland@arm.com,
        robh+dt@kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org,
        Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Subject: [PATCH v3 1/2] iio: chemical: bme680: Add device-tree support
Date:   Mon, 14 Jan 2019 15:19:13 -0500
Message-Id: <20190114201914.24572-1-sebastien.bourdelin@gmail.com>
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
v2 -> v3:
  - remove of_match_ptr: Suggested by Jonathan Cameron <jic23@kernel.org>
  - minor style fixup
  - rebase on master
v1 -> v2:
  - add missing of.h header in bme680_spi.c
---
 drivers/iio/chemical/bme680_i2c.c | 7 +++++++
 drivers/iio/chemical/bme680_spi.c | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
index 06d4be539d2e..b2f805b6b36a 100644
--- a/drivers/iio/chemical/bme680_i2c.c
+++ b/drivers/iio/chemical/bme680_i2c.c
@@ -70,10 +70,17 @@ static const struct acpi_device_id bme680_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
 
+static const struct of_device_id bme680_of_i2c_match[] = {
+	{ .compatible = "bosch,bme680", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bme680_of_i2c_match);
+
 static struct i2c_driver bme680_i2c_driver = {
 	.driver = {
 		.name			= "bme680_i2c",
 		.acpi_match_table       = ACPI_PTR(bme680_acpi_match),
+		.of_match_table		= bme680_of_i2c_match,
 	},
 	.probe = bme680_i2c_probe,
 	.id_table = bme680_i2c_id,
diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
index c9fb05e8d0b9..d0b7bdd3f066 100644
--- a/drivers/iio/chemical/bme680_spi.c
+++ b/drivers/iio/chemical/bme680_spi.c
@@ -6,6 +6,7 @@
  */
 #include <linux/acpi.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
@@ -110,10 +111,17 @@ static const struct acpi_device_id bme680_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
 
+static const struct of_device_id bme680_of_spi_match[] = {
+	{ .compatible = "bosch,bme680", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
+
 static struct spi_driver bme680_spi_driver = {
 	.driver = {
 		.name			= "bme680_spi",
 		.acpi_match_table	= ACPI_PTR(bme680_acpi_match),
+		.of_match_table		= bme680_of_spi_match,
 	},
 	.probe = bme680_spi_probe,
 	.id_table = bme680_spi_id,
-- 
2.20.1

