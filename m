Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F2AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460E621479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbfBRWJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 17:09:29 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46935 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbfBRWJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 17:09:28 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id acadc6c5712d3779; Mon, 18 Feb 2019 23:09:24 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [RFT/RFC][PATCH] driver core: Fix PM-runtime for links added during consumer probe
Date:   Mon, 18 Feb 2019 23:08:00 +0100
Message-ID: <14371356.imFjPFOrCi@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage
counter imbalance") introduced a regression that causes suppliers
to be suspended prematurely for device links added during consumer
driver probe if the initial PM-runtime status of the consumer is
"suspended" and the consumer is resumed after adding the link and
before pm_runtime_put_suppliers() is called.  In that case,
pm_runtime_put_suppliers() will drop the rpm_active refcount for
the link by one and (since rpm_active is equal to two after the
preceding consumer resume) the supplier's PM-runtime usage counter
will be decremented, which may cause the supplier to suspend even
though the consumer's PM-runtime status is "active".

For this reason, partially revert commit 4c06c4e6cf63 as the problem
it tried to fix needs to be addressed somewhat differently, and
change pm_runtime_get_suppliers() and pm_runtime_put_suppliers() so
that the latter only drops rpm_active references acquired by the
former.  [This requires adding a new field to struct device_link,
but I coulnd't find a cleaner way to address the issue that would
work in all cases.]

Fixes: 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage counter imbalance")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of driver-core/driver-core-next.

Jon, Ulf, please test!

---
 drivers/base/core.c          |    4 ++--
 drivers/base/power/runtime.c |   29 ++++++-----------------------
 include/linux/device.h       |    1 +
 include/linux/pm_runtime.h   |    4 ----
 4 files changed, 9 insertions(+), 29 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -277,7 +277,7 @@ struct device_link *device_link_add(stru
 				link->flags |= DL_FLAG_PM_RUNTIME;
 			}
 			if (flags & DL_FLAG_RPM_ACTIVE)
-				pm_runtime_active_link(link, supplier);
+				refcount_inc(&link->rpm_active);
 		}
 
 		if (flags & DL_FLAG_STATELESS) {
@@ -310,7 +310,7 @@ struct device_link *device_link_add(stru
 
 	if (flags & DL_FLAG_PM_RUNTIME) {
 		if (flags & DL_FLAG_RPM_ACTIVE)
-			pm_runtime_active_link(link, supplier);
+			refcount_inc(&link->rpm_active);
 
 		pm_runtime_new_link(consumer);
 	}
Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1656,6 +1656,7 @@ void pm_runtime_get_suppliers(struct dev
 
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
 		if (link->flags & DL_FLAG_PM_RUNTIME) {
+			link->supplier_preactivated = true;
 			refcount_inc(&link->rpm_active);
 			pm_runtime_get_sync(link->supplier);
 		}
@@ -1675,9 +1676,11 @@ void pm_runtime_put_suppliers(struct dev
 	idx = device_links_read_lock();
 
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
-		if (link->flags & DL_FLAG_PM_RUNTIME &&
-		    refcount_dec_not_one(&link->rpm_active))
-			pm_runtime_put(link->supplier);
+		if (link->supplier_preactivated) {
+			link->supplier_preactivated = false;
+			if (refcount_dec_not_one(&link->rpm_active))
+				pm_runtime_put(link->supplier);
+		}
 
 	device_links_read_unlock(idx);
 }
@@ -1689,26 +1692,6 @@ void pm_runtime_new_link(struct device *
 	spin_unlock_irq(&dev->power.lock);
 }
 
-/**
- * pm_runtime_active_link - Set up new device link as active for PM-runtime.
- * @link: Device link to be set up as active.
- * @supplier: Supplier end of the link.
- *
- * Add 2 to the rpm_active refcount of @link and increment the PM-runtime
- * usage counter of @supplier once more in case the link is being added while
- * the consumer driver is probing and pm_runtime_put_suppliers() will be called
- * subsequently.
- *
- * Note that this doesn't prevent rpm_put_suppliers() from decreasing the link's
- * rpm_active refcount down to one, so runtime suspend of the consumer end of
- * @link is not affected.
- */
-void pm_runtime_active_link(struct device_link *link, struct device *supplier)
-{
-	refcount_add(2, &link->rpm_active);
-	pm_runtime_get_noresume(supplier);
-}
-
 void pm_runtime_drop_link(struct device *dev)
 {
 	spin_lock_irq(&dev->power.lock);
Index: linux-pm/include/linux/device.h
===================================================================
--- linux-pm.orig/include/linux/device.h
+++ linux-pm/include/linux/device.h
@@ -861,6 +861,7 @@ struct device_link {
 #ifdef CONFIG_SRCU
 	struct rcu_head rcu_head;
 #endif
+	bool supplier_preactivated; /* Owned by consumer probe. */
 };
 
 /**
Index: linux-pm/include/linux/pm_runtime.h
===================================================================
--- linux-pm.orig/include/linux/pm_runtime.h
+++ linux-pm/include/linux/pm_runtime.h
@@ -59,8 +59,6 @@ extern void pm_runtime_clean_up_links(st
 extern void pm_runtime_get_suppliers(struct device *dev);
 extern void pm_runtime_put_suppliers(struct device *dev);
 extern void pm_runtime_new_link(struct device *dev);
-extern void pm_runtime_active_link(struct device_link *link,
-				   struct device *supplier);
 extern void pm_runtime_drop_link(struct device *dev);
 
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
@@ -180,8 +178,6 @@ static inline void pm_runtime_clean_up_l
 static inline void pm_runtime_get_suppliers(struct device *dev) {}
 static inline void pm_runtime_put_suppliers(struct device *dev) {}
 static inline void pm_runtime_new_link(struct device *dev) {}
-static inline void pm_runtime_active_link(struct device_link *link,
-					  struct device *supplier) {}
 static inline void pm_runtime_drop_link(struct device *dev) {}
 
 #endif /* !CONFIG_PM */

