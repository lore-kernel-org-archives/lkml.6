Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754703AbeEWP7n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:59:43 -0400
Received: from zulu.geekplace.eu ([5.45.100.158]:38418 "EHLO zulu.geekplace.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754430AbeEWP7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:59:19 -0400
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Schmaus <flo@geekplace.eu>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] driver-core: record error on bus registration
Date: Wed, 23 May 2018 17:59:12 +0200
Message-Id: <20180523155913.29679-3-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180523155913.29679-1-flo@geekplace.eu>
References: <20180523155913.29679-1-flo@geekplace.eu>
In-Reply-To: <20180516160816.20251-1-flo@geekplace.eu>
References: <20180516160816.20251-1-flo@geekplace.eu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bus_register() fails on a driver then record the error code so that
it can be inspected later on.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---

Notes:
    Also record ENOMEM error

 drivers/base/bus.c     | 9 +++++++--
 include/linux/device.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ef6183306b40..6e27741eb03e 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -152,6 +152,7 @@ static void bus_release(struct kobject *kobj)
 
 	kfree(priv);
 	bus->p = NULL;
+	bus->bus_register_error = 0;
 }
 
 static struct kobj_type bus_ktype = {
@@ -848,8 +849,10 @@ int bus_register(struct bus_type *bus)
 	struct lock_class_key *key = &bus->lock_key;
 
 	priv = kzalloc(sizeof(struct subsys_private), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	if (!priv) {
+		retval = -ENOMEM;
+		goto bus_alloc_fail;
+	}
 
 	priv->bus = bus;
 	bus->p = priv;
@@ -914,7 +917,9 @@ int bus_register(struct bus_type *bus)
 	kset_unregister(&bus->p->subsys);
 out:
 	kfree(bus->p);
+bus_alloc_fail:
 	bus->p = NULL;
+	bus->bus_register_error = retval;
 	return retval;
 }
 EXPORT_SYMBOL_GPL(bus_register);
diff --git a/include/linux/device.h b/include/linux/device.h
index 0059b99e1f25..5b1f3c08bebe 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -135,6 +135,7 @@ struct bus_type {
 	const struct iommu_ops *iommu_ops;
 
 	struct subsys_private *p;
+	int bus_register_error;
 	struct lock_class_key lock_key;
 
 	bool force_dma;
-- 
2.16.1
