Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CDCC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E201218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfAYLTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:19:08 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53039 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAYLTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:19:08 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id badf1de1758215dc; Fri, 25 Jan 2019 12:19:04 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 5/6] driver core: Fix handling of runtime PM flags in device_link_add()
Date:   Fri, 25 Jan 2019 12:18:03 +0100
Message-ID: <2208291.Uxpfu9YhsE@aspire.rjw.lan>
In-Reply-To: <1665211.FOmLsISsVf@aspire.rjw.lan>
References: <2493187.oiOpCWJBV7@aspire.rjw.lan> <1665211.FOmLsISsVf@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit ead18c23c263 ("driver core: Introduce device links
reference counting"), if if there is a link between the given supplier
and the given consumer already, device_link_add() will refcount it
and return it unconditionally without updating its flags.  It is
possible, however, that the second (or any subsequent) caller of
device_link_add() for the same consumer-supplier pair will pass
DL_FLAG_PM_RUNTIME, possibly along with DL_FLAG_RPM_ACTIVE, in flags
to it and the existing link may not behave as expected then.

First, if DL_FLAG_PM_RUNTIME is not set in the existing link's flags
at all, it needs to be set like during the original initialization of
the link.

Second, if DL_FLAG_RPM_ACTIVE is passed to device_link_add() in flags
(in addition to DL_FLAG_PM_RUNTIME), the existing link should to be
updated to reflect the "active" runtime PM configuration of the
consumer-supplier pair and extra care must be taken here to avoid
possible destructive races with runtime PM of the consumer.

To that end, redefine the rpm_active field in struct device_link
as a refcount, initialize it to 1 and make rpm_resume() (for the
consumer) and device_link_add() increment it whenever they acquire
a runtime PM reference on the supplier device.  Accordingly, make
rpm_suspend() (for the consumer) and pm_runtime_clean_up_links()
decrement it and drop runtime PM references to the supplier
device in a loop until rpm_active becones 1 again.

Fixes: ead18c23c263 ("driver core: Introduce device links reference counting")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

I have overlooked the fact that rpm_put_suppliers() doesn't even look
at the DL_FLAG_PM_RUNTIME link flag and only checks rpm_active for each
link in the list, so updating rpm_active for existing links from
device_link_add() is unsafe, regardless of whether or not DL_FLAG_PM_RUNTIME
is set in their flags.  Of course, this means that the previous version of
this patch was incorrect.

I also was kind of unhappy with returning NULL to the callers of
device_link_add() who passed DL_FLAG_RPM_ACTIVE in flags, but the link
(with DL_FLAG_PM_RUNTIME set) had been there already.

So, here's a v2 of just this patch (the other patches in the series don't
change).

-> v2:
  * Redefine rpm_active in struct device_link as a refcount.
  * Rework the code to use the refcount instead of the bool properly.
  * Make device_link_add() increment rpm_active for existing links.

Admittedly, turning rpm_active into a refcount theoretically increases the
overhead of using device links in runtime PM, so it is a concession of sorts,
but I didn't see any other way to make this work.

---
 drivers/base/core.c          |   45 ++++++++++++++++++++++++++++---------------
 drivers/base/power/runtime.c |   26 ++++++++++--------------
 include/linux/device.h       |    2 -
 3 files changed, 42 insertions(+), 31 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -165,6 +165,19 @@ void device_pm_move_to_tail(struct devic
 	device_links_read_unlock(idx);
 }
 
+static void device_link_rpm_prepare(struct device *consumer,
+				    struct device *supplier)
+{
+	pm_runtime_new_link(consumer);
+	/*
+	 * If the link is being added by the consumer driver at probe time,
+	 * balance the decrementation of the supplier's runtime PM usage counter
+	 * after consumer probe in driver_probe_device().
+	 */
+	if (consumer->links.status == DL_DEV_PROBING)
+		pm_runtime_get_noresume(supplier);
+}
+
 /**
  * device_link_add - Create a link between two devices.
  * @consumer: Consumer end of the link.
@@ -202,7 +215,6 @@ struct device_link *device_link_add(stru
 				    struct device *supplier, u32 flags)
 {
 	struct device_link *link;
-	bool rpm_put_supplier = false;
 
 	if (!consumer || !supplier ||
 	    (flags & DL_FLAG_STATELESS &&
@@ -214,7 +226,6 @@ struct device_link *device_link_add(stru
 			pm_runtime_put_noidle(supplier);
 			return NULL;
 		}
-		rpm_put_supplier = true;
 	}
 
 	device_links_write_lock();
@@ -250,6 +261,15 @@ struct device_link *device_link_add(stru
 		if (flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
 			link->flags |= DL_FLAG_AUTOREMOVE_SUPPLIER;
 
+		if (flags & DL_FLAG_PM_RUNTIME) {
+			if (!(link->flags & DL_FLAG_PM_RUNTIME)) {
+				device_link_rpm_prepare(consumer, supplier);
+				link->flags |= DL_FLAG_PM_RUNTIME;
+			}
+			if (flags & DL_FLAG_RPM_ACTIVE)
+				refcount_inc(&link->rpm_active);
+		}
+
 		kref_get(&link->kref);
 		goto out;
 	}
@@ -258,20 +278,15 @@ struct device_link *device_link_add(stru
 	if (!link)
 		goto out;
 
+	refcount_set(&link->rpm_active, 1);
+
 	if (flags & DL_FLAG_PM_RUNTIME) {
-		if (flags & DL_FLAG_RPM_ACTIVE) {
-			link->rpm_active = true;
-			rpm_put_supplier = false;
-		}
-		pm_runtime_new_link(consumer);
-		/*
-		 * If the link is being added by the consumer driver at probe
-		 * time, balance the decrementation of the supplier's runtime PM
-		 * usage counter after consumer probe in driver_probe_device().
-		 */
-		if (consumer->links.status == DL_DEV_PROBING)
-			pm_runtime_get_noresume(supplier);
+		if (flags & DL_FLAG_RPM_ACTIVE)
+			refcount_inc(&link->rpm_active);
+
+		device_link_rpm_prepare(consumer, supplier);
 	}
+
 	get_device(supplier);
 	link->supplier = supplier;
 	INIT_LIST_HEAD(&link->s_node);
@@ -334,7 +349,7 @@ struct device_link *device_link_add(stru
 	device_pm_unlock();
 	device_links_write_unlock();
 
-	if (rpm_put_supplier)
+	if ((flags & DL_FLAG_PM_RUNTIME && flags & DL_FLAG_RPM_ACTIVE) && !link)
 		pm_runtime_put(supplier);
 
 	return link;
Index: linux-pm/include/linux/device.h
===================================================================
--- linux-pm.orig/include/linux/device.h
+++ linux-pm/include/linux/device.h
@@ -853,7 +853,7 @@ struct device_link {
 	struct list_head c_node;
 	enum device_link_state status;
 	u32 flags;
-	bool rpm_active;
+	refcount_t rpm_active;
 	struct kref kref;
 #ifdef CONFIG_SRCU
 	struct rcu_head rcu_head;
Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -271,11 +271,8 @@ static int rpm_get_suppliers(struct devi
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
 		int retval;
 
-		if (!(link->flags & DL_FLAG_PM_RUNTIME))
-			continue;
-
-		if (READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND ||
-		    link->rpm_active)
+		if (!(link->flags & DL_FLAG_PM_RUNTIME) ||
+		    READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
 			continue;
 
 		retval = pm_runtime_get_sync(link->supplier);
@@ -284,7 +281,7 @@ static int rpm_get_suppliers(struct devi
 			pm_runtime_put_noidle(link->supplier);
 			return retval;
 		}
-		link->rpm_active = true;
+		refcount_inc(&link->rpm_active);
 	}
 	return 0;
 }
@@ -293,12 +290,13 @@ static void rpm_put_suppliers(struct dev
 {
 	struct device_link *link;
 
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
-		if (link->rpm_active &&
-		    READ_ONCE(link->status) != DL_STATE_SUPPLIER_UNBIND) {
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node) {
+		if (READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
+			continue;
+
+		while (refcount_dec_not_one(&link->rpm_active))
 			pm_runtime_put(link->supplier);
-			link->rpm_active = false;
-		}
+	}
 }
 
 /**
@@ -1551,7 +1549,7 @@ void pm_runtime_remove(struct device *de
  *
  * Check links from this device to any consumers and if any of them have active
  * runtime PM references to the device, drop the usage counter of the device
- * (once per link).
+ * (as many times as needed).
  *
  * Links with the DL_FLAG_STATELESS flag set are ignored.
  *
@@ -1573,10 +1571,8 @@ void pm_runtime_clean_up_links(struct de
 		if (link->flags & DL_FLAG_STATELESS)
 			continue;
 
-		if (link->rpm_active) {
+		while (refcount_dec_not_one(&link->rpm_active))
 			pm_runtime_put_noidle(dev);
-			link->rpm_active = false;
-		}
 	}
 
 	device_links_read_unlock(idx);

