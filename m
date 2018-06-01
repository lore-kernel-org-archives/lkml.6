Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbeFAJGD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:06:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43344 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbeFAJFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:05:52 -0400
X-Google-Smtp-Source: ADUXVKJAJJxQJKFSTC6OwK8fGSPtdlwz5bP3UoEHm71zQSZhzbwVfTqoWAtgCT+rM6WHlDbuUU+mDQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: ohad@wizery.com, bjorn.andersson@linaro.org, broonie@kernel.org
Cc: baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] hwspinlock: Add devm_xxx() APIs to request/free hwlock
Date: Fri,  1 Jun 2018 17:04:53 +0800
Message-Id: <51d01c563a00774b4db87a01d5fdcdbc342b075c.1527843425.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1be6adeb558fada77de79a40cd5ef7dc2719c945.1527843425.git.baolin.wang@linaro.org>
References: <1be6adeb558fada77de79a40cd5ef7dc2719c945.1527843425.git.baolin.wang@linaro.org>
In-Reply-To: <1be6adeb558fada77de79a40cd5ef7dc2719c945.1527843425.git.baolin.wang@linaro.org>
References: <1be6adeb558fada77de79a40cd5ef7dc2719c945.1527843425.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces some devm_xxx() APIs to help to request or free
the hwlocks, which will help to simplify the cleanup code for drivers
requesting one hwlock, ensuring that the hwlock is automatically freed
whenever the device is unbound.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/hwspinlock_core.c |  110 ++++++++++++++++++++++++++++++++++
 include/linux/hwspinlock.h           |   22 +++++++
 2 files changed, 132 insertions(+)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index 00bde06..6aa9ea1 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -743,6 +743,116 @@ int hwspin_lock_free(struct hwspinlock *hwlock)
 }
 EXPORT_SYMBOL_GPL(hwspin_lock_free);
 
+static int devm_hwspin_lock_match(struct device *dev, void *res, void *data)
+{
+	struct hwspinlock **hwlock = res;
+
+	if (WARN_ON(!hwlock || !*hwlock))
+		return 0;
+
+	return *hwlock == data;
+}
+
+static void devm_hwspin_lock_release(struct device *dev, void *res)
+{
+	hwspin_lock_free(*(struct hwspinlock **)res);
+}
+
+/**
+ * devm_hwspin_lock_free() - free a specific hwspinlock for a managed device
+ * @dev: the device to free the specific hwspinlock
+ * @hwlock: the specific hwspinlock to free
+ *
+ * This function mark @hwlock as free again.
+ * Should only be called with an @hwlock that was retrieved from
+ * an earlier call to omap_hwspin_lock_request{_specific}.
+ *
+ * Should be called from a process context (might sleep)
+ *
+ * Returns 0 on success, or an appropriate error code on failure
+ */
+int devm_hwspin_lock_free(struct device *dev, struct hwspinlock *hwlock)
+{
+	int ret;
+
+	ret = devres_release(dev, devm_hwspin_lock_release,
+			     devm_hwspin_lock_match, hwlock);
+	WARN_ON(ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_hwspin_lock_free);
+
+/**
+ * devm_hwspin_lock_request() - request an hwspinlock for a managed device
+ * @dev: the device to request an hwspinlock
+ *
+ * This function should be called by users of the hwspinlock device,
+ * in order to dynamically assign them an unused hwspinlock.
+ * Usually the user of this lock will then have to communicate the lock's id
+ * to the remote core before it can be used for synchronization (to get the
+ * id of a given hwlock, use hwspin_lock_get_id()).
+ *
+ * Should be called from a process context (might sleep)
+ *
+ * Returns the address of the assigned hwspinlock, or NULL on error
+ */
+struct hwspinlock *devm_hwspin_lock_request(struct device *dev)
+{
+	struct hwspinlock **ptr, *hwlock;
+
+	ptr = devres_alloc(devm_hwspin_lock_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	hwlock = hwspin_lock_request();
+	if (!IS_ERR(hwlock)) {
+		*ptr = hwlock;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return hwlock;
+}
+EXPORT_SYMBOL_GPL(devm_hwspin_lock_request);
+
+/**
+ * devm_hwspin_lock_request_specific() - request for a specific hwspinlock for
+ *					 a managed device
+ * @dev: the device to request the specific hwspinlock
+ * @id: index of the specific hwspinlock that is requested
+ *
+ * This function should be called by users of the hwspinlock module,
+ * in order to assign them a specific hwspinlock.
+ * Usually early board code will be calling this function in order to
+ * reserve specific hwspinlock ids for predefined purposes.
+ *
+ * Should be called from a process context (might sleep)
+ *
+ * Returns the address of the assigned hwspinlock, or NULL on error
+ */
+struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
+						     unsigned int id)
+{
+	struct hwspinlock **ptr, *hwlock;
+
+	ptr = devres_alloc(devm_hwspin_lock_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	hwlock = hwspin_lock_request_specific(id);
+	if (!IS_ERR(hwlock)) {
+		*ptr = hwlock;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return hwlock;
+}
+EXPORT_SYMBOL_GPL(devm_hwspin_lock_request_specific);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Hardware spinlock interface");
 MODULE_AUTHOR("Ohad Ben-Cohen <ohad@wizery.com>");
diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index f165cc8..4f1f943 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -75,6 +75,10 @@ int __hwspin_lock_timeout(struct hwspinlock *, unsigned int, int,
 int __hwspin_trylock(struct hwspinlock *, int, unsigned long *);
 void __hwspin_unlock(struct hwspinlock *, int, unsigned long *);
 int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name);
+int devm_hwspin_lock_free(struct device *dev, struct hwspinlock *hwlock);
+struct hwspinlock *devm_hwspin_lock_request(struct device *dev);
+struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
+						     unsigned int id);
 
 #else /* !CONFIG_HWSPINLOCK */
 
@@ -140,6 +144,24 @@ int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name)
 	return 0;
 }
 
+static inline
+int devm_hwspin_lock_free(struct device *dev, struct hwspinlock *hwlock)
+{
+	return 0;
+}
+
+static inline struct hwspinlock *devm_hwspin_lock_request(struct device *dev)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline
+struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
+						     unsigned int id)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 #endif /* !CONFIG_HWSPINLOCK */
 
 /**
-- 
1.7.9.5
