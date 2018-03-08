Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966636AbeCHTQq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:16:46 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35882 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756003AbeCHTMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:12:22 -0500
X-Google-Smtp-Source: AG47ELtBaOeVzP5MifJurjzcGfmk+GPPLFGfCzDzqeyrJMS2fz5Evmwn7MPUuKPNwr2K3iN2UdkdnQ==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, cphealy@gmail.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 02/21] nvmem: core: Allow specifying device name verbatim
Date: Thu,  8 Mar 2018 11:11:46 -0800
Message-Id: <20180308191205.26943-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308191205.26943-1-andrew.smirnov@gmail.com>
References: <20180308191205.26943-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add code to allow avoid having nvmem core append a numeric suffix to
the end of the name by passing config->id of -1.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: cphealy@gmail.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/nvmem/core.c           | 11 ++++++++---
 include/linux/nvmem-provider.h |  3 +++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 35a3dbeea324..99e04cfcc723 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -473,9 +473,14 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
 	nvmem->dev.of_node = config->dev->of_node;
-	dev_set_name(&nvmem->dev, "%s%d",
-		     config->name ? : "nvmem",
-		     config->name ? config->id : nvmem->id);
+
+	if (config->id == -1 && config->name) {
+		dev_set_name(&nvmem->dev, "%s", config->name);
+	} else {
+		dev_set_name(&nvmem->dev, "%s%d",
+			     config->name ? : "nvmem",
+			     config->name ? config->id : nvmem->id);
+	}
 
 	nvmem->read_only = device_property_present(config->dev, "read-only") |
 			   config->read_only;
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index a39f76ff2ccd..b00567a07496 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -43,6 +43,9 @@ typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
  * Note: A default "nvmem<id>" name will be assigned to the device if
  * no name is specified in its configuration. In such case "<id>" is
  * generated with ida_simple_get() and provided id field is ignored.
+ *
+ * Note: Specifying name and setting id to -1 implies a unique device
+ * whose name is provided as-is (kept unaltered).
  */
 struct nvmem_config {
 	struct device		*dev;
-- 
2.14.3
