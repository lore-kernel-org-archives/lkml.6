Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0FEECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C47A2086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQ8aq3lN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C47A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390302AbeIUT3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35654 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390271AbeIUT3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:47 -0400
Received: by mail-io1-f67.google.com with SMTP id w11-v6so12244587iob.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Be5Wxl/ZhFGQZlTZi2pcgnpIkLC81q8e0uMdVQBLmAo=;
        b=fQ8aq3lNT7/EcKAsyjoDtHm2fMnSeiakQpbwaU6iGpuXRQJ9jWSzJPvTZmQ0TTcqVa
         1KirwLdhSoxtNcqjWLLNiBysjezqM2gOQzxYppiicGM2BhH+V62J540diAGQcuv7hVAr
         Weh6GUB5xzJW3nGsj6CuA7q8g512x+kUO48Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Be5Wxl/ZhFGQZlTZi2pcgnpIkLC81q8e0uMdVQBLmAo=;
        b=t1HcYrY0aLJAd5EZ6x9pIXJSRmEyPuWVS4lrMbLEErV4Ua2r9sHLFKlxiDY7mO5oWs
         JoLyH4ONSyQZ5KK6Yi5dmACfmUs/CcXB92zta27HxUYmqgglHLt7PxO1989ifSK8cnq+
         3K13Hg8cUpw1G6hQbxwB1E73w+poxCZqabF0gzwkoyHuuq+64IbSHMdByKLDz6rKb8M+
         2M+8Rg7xdYWPL9Lvl+UlJoEdGR1kvnNG0VYE02n/jzQIoLWazW5y9+H/R8QbgD+g0b+q
         nG6Fcys4qp/0NvuOCufM2OJy+9rS8KeEyLfpaeIUxMtpO9dWPfJRmNBhGSocFUNafABD
         iN3g==
X-Gm-Message-State: APzg51BTirN7p2zk4QsSD6O5L/wfgHqBYg5tNb3SQU3jMvW8EFcLOjvJ
        mBsp4MpzsEkAjgssy7oO+8wMdA==
X-Google-Smtp-Source: ANB0Vdah5t7zDZ2s9SPtzLZH7oZOodqwG3vh0s07TyMo5i8BOG9LNP2aWwWaF1Ckc8EG5uSgB4ACOQ==
X-Received: by 2002:a6b:d307:: with SMTP id s7-v6mr34023840iob.190.1537537251587;
        Fri, 21 Sep 2018 06:40:51 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:50 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 15/26] nvmem: add support for cell info
Date:   Fri, 21 Sep 2018 06:40:15 -0700
Message-Id: <20180921134026.4596-16-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add new structs and routines allowing users to define nvmem cells from
machine code. This global list of entries is parsed when a provider
is registered and cells are associated with the relevant nvmem_device
struct.

A possible improvement for the future is to allow users to register
cell tables after the nvmem provider has been registered by updating
the cell list at each call to nvmem_(add|del)_cell_table().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 72 ++++++++++++++++++++++++++++++++++
 include/linux/nvmem-provider.h | 33 +++++++++++-----
 2 files changed, 96 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ee794613024c..8e0108806e65 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -59,6 +59,9 @@ struct nvmem_cell {
 static DEFINE_MUTEX(nvmem_mutex);
 static DEFINE_IDA(nvmem_ida);
 
+static DEFINE_MUTEX(nvmem_cell_mutex);
+static LIST_HEAD(nvmem_cell_tables);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
@@ -416,6 +419,43 @@ static int nvmem_setup_compat(struct nvmem_device *nvmem,
 	return 0;
 }
 
+static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
+{
+	const struct nvmem_cell_info *info;
+	struct nvmem_cell_table *table;
+	struct nvmem_cell *cell;
+	int rval = 0, i;
+
+	mutex_lock(&nvmem_cell_mutex);
+	list_for_each_entry(table, &nvmem_cell_tables, node) {
+		if (strcmp(nvmem_dev_name(nvmem), table->nvmem_name) == 0) {
+			for (i = 0; i < table->ncells; i++) {
+				info = &table->cells[i];
+
+				cell = kzalloc(sizeof(*cell), GFP_KERNEL);
+				if (!cell) {
+					rval = -ENOMEM;
+					goto out;
+				}
+
+				rval = nvmem_cell_info_to_nvmem_cell(nvmem,
+								     info,
+								     cell);
+				if (rval) {
+					kfree(cell);
+					goto out;
+				}
+
+				nvmem_cell_add(cell);
+			}
+		}
+	}
+
+out:
+	mutex_unlock(&nvmem_cell_mutex);
+	return rval;
+}
+
 /**
  * nvmem_register() - Register a nvmem device for given nvmem_config.
  * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
@@ -502,8 +542,14 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_teardown_compat;
 	}
 
+	rval = nvmem_add_cells_from_table(nvmem);
+	if (rval)
+		goto err_remove_cells;
+
 	return nvmem;
 
+err_remove_cells:
+	nvmem_device_remove_all_cells(nvmem);
 err_teardown_compat:
 	if (config->compat)
 		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
@@ -1306,6 +1352,32 @@ int nvmem_device_write(struct nvmem_device *nvmem,
 }
 EXPORT_SYMBOL_GPL(nvmem_device_write);
 
+/**
+ * nvmem_add_cell_table() - register a table of cell info entries
+ *
+ * @table: table of cell info entries
+ */
+void nvmem_add_cell_table(struct nvmem_cell_table *table)
+{
+	mutex_lock(&nvmem_cell_mutex);
+	list_add_tail(&table->node, &nvmem_cell_tables);
+	mutex_unlock(&nvmem_cell_mutex);
+}
+EXPORT_SYMBOL_GPL(nvmem_add_cell_table);
+
+/**
+ * nvmem_del_cell_table() - remove a previously registered cell info table
+ *
+ * @table: table of cell info entries
+ */
+void nvmem_del_cell_table(struct nvmem_cell_table *table)
+{
+	mutex_lock(&nvmem_cell_mutex);
+	list_del(&table->node);
+	mutex_unlock(&nvmem_cell_mutex);
+}
+EXPORT_SYMBOL_GPL(nvmem_del_cell_table);
+
 /**
  * nvmem_dev_name() - Get the name of a given nvmem device.
  *
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 0f357d0c1e75..5c9f205cac8f 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -67,6 +67,25 @@ struct nvmem_config {
 	struct device		*base_dev;
 };
 
+/**
+ * struct nvmem_cell_table - NVMEM cell definitions for given provider
+ *
+ * @nvmem_name:		Provider name.
+ * @cells:		Array of cell definitions.
+ * @ncells:		Number of cell definitions in the array.
+ * @node:		List node.
+ *
+ * This structure together with related helper functions is provided for users
+ * that don't can't access the nvmem provided structure but wish to register
+ * cell definitions for it e.g. board files registering an EEPROM device.
+ */
+struct nvmem_cell_table {
+	const char		*nvmem_name;
+	const struct nvmem_cell_info	*cells;
+	size_t			ncells;
+	struct list_head	node;
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
@@ -77,9 +96,9 @@ struct nvmem_device *devm_nvmem_register(struct device *dev,
 
 int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem);
 
-int nvmem_add_cells(struct nvmem_device *nvmem,
-		    const struct nvmem_cell_info *info,
-		    int ncells);
+void nvmem_add_cell_table(struct nvmem_cell_table *table);
+void nvmem_del_cell_table(struct nvmem_cell_table *table);
+
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -102,12 +121,8 @@ devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 
 }
 
-static inline int nvmem_add_cells(struct nvmem_device *nvmem,
-				  const struct nvmem_cell_info *info,
-				  int ncells)
-{
-	return -ENOSYS;
-}
+static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
+static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
 
 #endif /* CONFIG_NVMEM */
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.19.0

