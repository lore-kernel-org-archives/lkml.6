Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbeD3Hjy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:39:54 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34876 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeD3Hib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:38:31 -0400
X-Google-Smtp-Source: AB8JxZo/Qc8Zq6s9aaHvng/uoZwc9EycKRZ7Z5DxQzxEgX01FGhEuMC9AgPJNDdUG14CD0cpMPEc1w==
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] gpio: pca953x: Use of_device_get_match_data()
Date: Mon, 30 Apr 2018 09:38:14 +0200
Message-Id: <20180430073819.31827-7-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430073819.31827-1-thierry.reding@gmail.com>
References: <20180430073819.31827-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Use of_device_get_match_data() instead of open-coding it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/gpio-pca953x.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index d2ead4b1cf61..9a06b8a4f5be 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -810,13 +810,11 @@ static int pca953x_probe(struct i2c_client *client,
 		chip->driver_data = i2c_id->driver_data;
 	} else {
 		const struct acpi_device_id *acpi_id;
-		const struct of_device_id *match;
+		struct device *dev = &client->dev;
 
-		match = of_match_device(pca953x_dt_ids, &client->dev);
-		if (match) {
-			chip->driver_data = (int)(uintptr_t)match->data;
-		} else {
-			acpi_id = acpi_match_device(pca953x_acpi_ids, &client->dev);
+		chip->driver_data = (uintptr_t)of_device_get_match_data(dev);
+		if (!chip->driver_data) {
+			acpi_id = acpi_match_device(pca953x_acpi_ids, dev);
 			if (!acpi_id) {
 				ret = -ENODEV;
 				goto err_exit;
-- 
2.17.0
