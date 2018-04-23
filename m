Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755161AbeDWMmV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:42:21 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46409 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755063AbeDWMl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:41:57 -0400
X-Google-Smtp-Source: AIpwx4/bfb1Ax1H9m3GPO8g+M888wgG2leplcKef1fMwQF342E6a/KlEZn0xzIuh/XE6x8h8M8EBBQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] nvmem: meson-efuse: add write support
Date: Mon, 23 Apr 2018 14:41:49 +0200
Message-Id: <20180423124149.3077-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180423124149.3077-1-jbrunet@baylibre.com>
References: <20180423124149.3077-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add write support to the meson-gx efuse driver.
Beware, this efuse is one time programmable !

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/nvmem/meson-efuse.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 4623249dfd87..d769840d1e18 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -28,6 +28,13 @@ static int meson_efuse_read(void *context, unsigned int offset,
 				  bytes, 0, 0, 0);
 }
 
+static int meson_efuse_write(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	return meson_sm_call_write((u8 *)val, bytes, SM_EFUSE_WRITE, offset,
+				   bytes, 0, 0, 0);
+}
+
 static const struct of_device_id meson_efuse_match[] = {
 	{ .compatible = "amlogic,meson-gxbb-efuse", },
 	{ /* sentinel */ },
@@ -52,8 +59,8 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	econfig->name = dev_name(dev);
 	econfig->stride = 1;
 	econfig->word_size = 1;
-	econfig->read_only = true;
 	econfig->reg_read = meson_efuse_read;
+	econfig->reg_write = meson_efuse_write;
 	econfig->size = size;
 
 	nvmem = devm_nvmem_register(&pdev->dev, econfig);
-- 
2.14.3
