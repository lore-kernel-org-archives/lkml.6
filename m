Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbeCPPBY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:01:24 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36009 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752942AbeCPPBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:01:19 -0400
X-Google-Smtp-Source: AG47ELt0LjOD8UGNQO5gvyz4uf/lleqDt+KoE/uMdIEleHieT6G8H6kPjzy3BML8kT/xB2kEBoXUxg==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvmem: meson-efuse: add write support
Date: Fri, 16 Mar 2018 16:01:13 +0100
Message-Id: <20180316150113.9779-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180316150113.9779-1-jbrunet@baylibre.com>
References: <20180316150113.9779-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add write support to the meson-gx efuse driver.
Beware, this efuse is one time programmable !

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/nvmem/meson-efuse.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 7ad80b80b293..30da5e1abf84 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -35,6 +35,20 @@ static int meson_efuse_read(void *context, unsigned int offset,
 	return 0;
 }
 
+static int meson_efuse_write(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	u8 *buf = val;
+	int ret;
+
+	ret = meson_sm_call_write(buf, bytes, SM_EFUSE_WRITE, offset,
+				  bytes, 0, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static const struct of_device_id meson_efuse_match[] = {
 	{ .compatible = "amlogic,meson-gxbb-efuse", },
 	{ /* sentinel */ },
@@ -59,8 +73,8 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	econfig->name = dev_name(dev);
 	econfig->stride = 1;
 	econfig->word_size = 1;
-	econfig->read_only = true;
 	econfig->reg_read = meson_efuse_read;
+	econfig->reg_write = meson_efuse_write;
 	econfig->size = size;
 
 	nvmem = nvmem_register(econfig);
-- 
2.14.3
