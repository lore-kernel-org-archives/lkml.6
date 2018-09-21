Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C35ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C05A2154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ejBM1933"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C05A2154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390460AbeIUTan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:30:43 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35022 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390304AbeIUT3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:49 -0400
Received: by mail-it1-f194.google.com with SMTP id 139-v6so1929875itf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KwrD04MgFgOeUQZBSrXnx47IBYL7knnGsXG4NHQ+G6s=;
        b=ejBM1933gCBH9ofQzSyD7pAEVip49gPG0FYMekfu6JhOgcsiliY/+7ZWzGghCo2ltx
         S5RAhEa9YUvKFM868iZzNnh4CE1eBBgDhPThTz3EJUx4p0FURNMLmxec7hpPFeLTM/gf
         /agSECnH5F9adK9YAPb8fISPwPqmUX0Ve4stE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KwrD04MgFgOeUQZBSrXnx47IBYL7knnGsXG4NHQ+G6s=;
        b=OLv5BdYPzG0cy3uluuhPTRTRF5f4oErfyGG74H5843ImCTdfK3rDq6SrEQNyrhCExh
         tqclgG5KbMhAdSObgU96Gr1Wb0EO2E53UFXTLBU9dG+QD8TmlIy0yspwdevykyxP/GwA
         bgqCsELTIqLOlpjtRXyo4hyMA4SAjDMUoF33Hk4CqxCGJsiSzFO8bXXZuSdbpPYHIvxN
         fo9y3afLmWlZw4uqCRs/o5T6CA9vgmjCvsQU21inWNbm1mjy9HcVZEXbdSxQuFiJUV/g
         7GIaYyZGS3OL/oiNbm3obKIXc1SLCM7L1Bt9wBb95F168zVxpEJmDfCHXV+jHAwXu/ik
         uCOQ==
X-Gm-Message-State: APzg51BtTZx1teCFujs9pkeQ4xxpdDq4s4BUNR+sMWfz4e72u4oTyWre
        B+T+1aQe9Yk5M73ciaDE5M5rhQ==
X-Google-Smtp-Source: ANB0VdbbYOmECLBAqpGS0ETpQFVrdJjXNsBOkGjdsb9A9Q4YA594VGmr/QOcWFp+0/5CaNyYCXNxSw==
X-Received: by 2002:a24:cd81:: with SMTP id l123-v6mr5874663itg.7.1537537253968;
        Fri, 21 Sep 2018 06:40:53 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:53 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 17/26] nvmem: add support for cell lookups from machine code
Date:   Fri, 21 Sep 2018 06:40:17 -0700
Message-Id: <20180921134026.4596-18-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a way for machine code users to associate devices with nvmem cells.

This restores the support for non-DT systems but following a different
approach. Cells must now be associated with devices using provided
routines and data structures before they can be retrieved using
nvmem_cell_get().

It's still possible to define cells statically in nvmem_config but
cells created this way still need to be associated with consumers using
lookup entries.

Note that nvmem_find() must be moved higher in the source file as we
want to call it from __nvmem_device_get() for devices that don't have
a device node.

The signature of __nvmem_device_get() is also changed as it's no longer
used to retrieve cells.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 129 ++++++++++++++++++++++++++-------
 include/linux/nvmem-consumer.h |  28 +++++++
 2 files changed, 131 insertions(+), 26 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 74b6b97680d5..9cc86d131e1e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -62,6 +62,9 @@ static DEFINE_IDA(nvmem_ida);
 static DEFINE_MUTEX(nvmem_cell_mutex);
 static LIST_HEAD(nvmem_cell_tables);
 
+static DEFINE_MUTEX(nvmem_lookup_mutex);
+static LIST_HEAD(nvmem_lookup_list);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
@@ -283,6 +286,18 @@ static struct nvmem_device *of_nvmem_find(struct device_node *nvmem_np)
 	return to_nvmem_device(d);
 }
 
+static struct nvmem_device *nvmem_find(const char *name)
+{
+	struct device *d;
+
+	d = bus_find_device_by_name(&nvmem_bus_type, NULL, name);
+
+	if (!d)
+		return NULL;
+
+	return to_nvmem_device(d);
+}
+
 static void nvmem_cell_drop(struct nvmem_cell *cell)
 {
 	mutex_lock(&nvmem_mutex);
@@ -472,6 +487,21 @@ nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
 	return cell;
 }
 
+static struct nvmem_cell *
+nvmem_find_cell_by_name(struct nvmem_device *nvmem, const char *cell_id)
+{
+	struct nvmem_cell *cell = NULL;
+
+	mutex_lock(&nvmem_mutex);
+	list_for_each_entry(cell, &nvmem->cells, node) {
+		if (strcmp(cell_id, cell->name) == 0)
+			break;
+	}
+	mutex_unlock(&nvmem_mutex);
+
+	return cell;
+}
+
 static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 {
 	struct device_node *parent, *child;
@@ -719,16 +749,12 @@ int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 EXPORT_SYMBOL(devm_nvmem_unregister);
 
 static struct nvmem_device *__nvmem_device_get(struct device_node *np,
-					       struct nvmem_cell **cellp,
-					       const char *cell_id)
+					       const char *nvmem_name)
 {
 	struct nvmem_device *nvmem = NULL;
 
-	if (!np)
-		return ERR_PTR(-ENOENT);
-
 	mutex_lock(&nvmem_mutex);
-	nvmem = of_nvmem_find(np);
+	nvmem = np ? of_nvmem_find(np) : nvmem_find(nvmem_name);
 	mutex_unlock(&nvmem_mutex);
 	if (!nvmem)
 		return ERR_PTR(-EPROBE_DEFER);
@@ -752,18 +778,6 @@ static void __nvmem_device_put(struct nvmem_device *nvmem)
 	kref_put(&nvmem->refcnt, nvmem_device_release);
 }
 
-static struct nvmem_device *nvmem_find(const char *name)
-{
-	struct device *d;
-
-	d = bus_find_device_by_name(&nvmem_bus_type, NULL, name);
-
-	if (!d)
-		return ERR_PTR(-ENOENT);
-
-	return to_nvmem_device(d);
-}
-
 #if IS_ENABLED(CONFIG_OF)
 /**
  * of_nvmem_device_get() - Get nvmem device from a given id
@@ -786,7 +800,7 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
 	if (!nvmem_np)
 		return ERR_PTR(-EINVAL);
 
-	return __nvmem_device_get(nvmem_np, NULL, NULL);
+	return __nvmem_device_get(nvmem_np, NULL);
 }
 EXPORT_SYMBOL_GPL(of_nvmem_device_get);
 #endif
@@ -890,15 +904,43 @@ struct nvmem_device *devm_nvmem_device_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL_GPL(devm_nvmem_device_get);
 
-static struct nvmem_cell *nvmem_cell_get_from_list(const char *cell_id)
+static struct nvmem_cell *
+nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 {
-	struct nvmem_cell *cell = NULL;
+	struct nvmem_cell *cell = ERR_PTR(-ENOENT);
+	struct nvmem_cell_lookup *lookup;
 	struct nvmem_device *nvmem;
+	const char *dev_id;
 
-	nvmem = __nvmem_device_get(NULL, &cell, cell_id);
-	if (IS_ERR(nvmem))
-		return ERR_CAST(nvmem);
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	dev_id = dev_name(dev);
+
+	mutex_lock(&nvmem_lookup_mutex);
+
+	list_for_each_entry(lookup, &nvmem_lookup_list, node) {
+		if ((strcmp(lookup->dev_id, dev_id) == 0) &&
+		    (strcmp(lookup->con_id, con_id) == 0)) {
+			/* This is the right entry. */
+			nvmem = __nvmem_device_get(NULL, lookup->nvmem_name);
+			if (!nvmem) {
+				/* Provider may not be registered yet. */
+				cell = ERR_PTR(-EPROBE_DEFER);
+				goto out;
+			}
+
+			cell = nvmem_find_cell_by_name(nvmem,
+						       lookup->cell_name);
+			if (!cell) {
+				__nvmem_device_put(nvmem);
+				goto out;
+			}
+		}
+	}
 
+out:
+	mutex_unlock(&nvmem_lookup_mutex);
 	return cell;
 }
 
@@ -935,7 +977,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 	if (!nvmem_np)
 		return ERR_PTR(-EINVAL);
 
-	nvmem = __nvmem_device_get(nvmem_np, NULL, NULL);
+	nvmem = __nvmem_device_get(nvmem_np, NULL);
 	of_node_put(nvmem_np);
 	if (IS_ERR(nvmem))
 		return ERR_CAST(nvmem);
@@ -975,7 +1017,7 @@ struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *cell_id)
 	if (!cell_id)
 		return ERR_PTR(-EINVAL);
 
-	return nvmem_cell_get_from_list(cell_id);
+	return nvmem_cell_get_from_lookup(dev, cell_id);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_get);
 
@@ -1405,6 +1447,41 @@ void nvmem_del_cell_table(struct nvmem_cell_table *table)
 }
 EXPORT_SYMBOL_GPL(nvmem_del_cell_table);
 
+/**
+ * nvmem_add_cell_lookups() - register a list of cell lookup entries
+ *
+ * @entries: array of cell lookup entries
+ * @nentries: number of cell lookup entries in the array
+ */
+void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries)
+{
+	int i;
+
+	mutex_lock(&nvmem_lookup_mutex);
+	for (i = 0; i < nentries; i++)
+		list_add_tail(&entries[i].node, &nvmem_lookup_list);
+	mutex_unlock(&nvmem_lookup_mutex);
+}
+EXPORT_SYMBOL_GPL(nvmem_add_cell_lookups);
+
+/**
+ * nvmem_del_cell_lookups() - remove a list of previously added cell lookup
+ *                            entries
+ *
+ * @entries: array of cell lookup entries
+ * @nentries: number of cell lookup entries in the array
+ */
+void nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries)
+{
+	int i;
+
+	mutex_lock(&nvmem_lookup_mutex);
+	for (i = 0; i < nentries; i++)
+		list_del(&entries[i].node);
+	mutex_unlock(&nvmem_lookup_mutex);
+}
+EXPORT_SYMBOL_GPL(nvmem_del_cell_lookups);
+
 /**
  * nvmem_dev_name() - Get the name of a given nvmem device.
  *
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 0389fe00b177..27eee3945405 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -29,6 +29,24 @@ struct nvmem_cell_info {
 	unsigned int		nbits;
 };
 
+/**
+ * struct nvmem_cell_lookup - cell lookup entry
+ *
+ * @nvmem_name:	Name of the provider.
+ * @cell_name:	Name of the nvmem cell as defined in the name field of
+ *		struct nvmem_cell_info.
+ * @dev_id:	Name of the consumer device that will be associated with
+ *		this cell.
+ * @con_id:	Connector id for this cell lookup.
+ */
+struct nvmem_cell_lookup {
+	const char		*nvmem_name;
+	const char		*cell_name;
+	const char		*dev_id;
+	const char		*con_id;
+	struct list_head	node;
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 /* Cell based interface */
@@ -57,6 +75,11 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
 
 const char *nvmem_dev_name(struct nvmem_device *nvmem);
 
+void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries,
+			    size_t nentries);
+void nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries,
+			    size_t nentries);
+
 #else
 
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
@@ -151,6 +174,11 @@ static inline const char *nvmem_dev_name(struct nvmem_device *nvmem)
 	return NULL;
 }
 
+static inline void
+nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
+static inline void
+nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
+
 #endif /* CONFIG_NVMEM */
 
 #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
-- 
2.19.0

