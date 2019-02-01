Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4262C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAE720869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfBABEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 20:04:22 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63459 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfBABEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 20:04:04 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 412d02e03a8f3558; Fri, 1 Feb 2019 02:03:58 +0100
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v2 8/9] driver core: Make driver core own stateful device links
Date:   Fri, 01 Feb 2019 01:58:33 +0100
Message-ID: <4479347.0dQE3kCcGh@aspire.rjw.lan>
In-Reply-To: <1952449.TVsm6CJCTy@aspire.rjw.lan>
References: <1952449.TVsm6CJCTy@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Even though stateful device links are managed by the driver core in
principle, their creators are allowed and sometimes even expected
to drop references to them via device_link_del() or
device_link_remove(), but that doesn't really play well with the
"persistent" link concept.

If "persistent" managed device links are created from driver
probe callbacks, device_link_add() called to do that will take a
new reference on the link each time the callback runs and those
references will never be dropped, which kind of isn't nice.

This issues arises because of the link reference counting carried
out by device_link_add() for existing links, but that is only done to
avoid deleting device links that may still be necessary, which
shouldn't be a concern for managed (stateful) links.  These device
links are managed by the driver core and whoever creates one of them
will need it at least as long as until the consumer driver is detached
from its device and deleting it may be left to the driver core just
fine.

For this reason, rework device_link_add() to apply the reference
counting to stateless links only and make device_link_del() and
device_link_remove() drop references to stateless links only too.
After this change, if called to add a stateful device link for
a consumer-supplier pair for which a stateful device link is
present already, device_link_add() will return the existing link
without incrementing its reference counter.  Accordingly,
device_link_del() and device_link_remove() will WARN() and do
nothing when called to drop a reference to a stateful link.  Thus,
effectively, all stateful device links will be owned by the driver
core.

In addition, clean up the handling of the link management flags,
DL_FLAG_AUTOREMOVE_CONSUMER and DL_FLAG_AUTOREMOVE_SUPPLIER, so that
(a) they are never set at the same time and (b) if device_link_add()
is called for a consumer-supplier pair with an existing stateful link
between them, the flags of that link will be combined with the flags
passed to device_link_add() to ensure that the life time of the link
is sufficient for all of the callers of device_link_add() for the
same consumer-supplier pair.

Update the device_link_add() kerneldoc comment to reflect the
above changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/device_link.rst |   42 +++++++++++-------
 drivers/base/core.c                      |   69 ++++++++++++++++++++++++-------
 2 files changed, 79 insertions(+), 32 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -192,10 +192,21 @@ static void device_link_rpm_prepare(stru
  * of the link.  If DL_FLAG_PM_RUNTIME is not set, DL_FLAG_RPM_ACTIVE will be
  * ignored.
  *
- * If the DL_FLAG_AUTOREMOVE_CONSUMER flag is set, the link will be removed
- * automatically when the consumer device driver unbinds from it.  Analogously,
- * if DL_FLAG_AUTOREMOVE_SUPPLIER is set in @flags, the link will be removed
- * automatically when the supplier device driver unbinds from it.
+ * If DL_FLAG_STATELESS is set in @flags, the link is not going to be managed by
+ * the driver core and, in particular, the caller of this function is expected
+ * to drop the reference to the link acquired by it directly.
+ *
+ * If that flag is not set, however, the caller of this function is handing the
+ * management of the link over to the driver core entirely and its return value
+ * can only be used to check whether or not the link is present.  In that case,
+ * the DL_FLAG_AUTOREMOVE_CONSUMER and DL_FLAG_AUTOREMOVE_SUPPLIER device link
+ * flags can be used to indicate to the driver core when the link can be safely
+ * deleted.  Namely, setting one of them in @flags indicates to the driver core
+ * that the link is not going to be used (by the given caller of this function)
+ * after unbinding the consumer or supplier driver, respectively, from its
+ * device, so the link can be deleted at that point.  If none of them is set,
+ * the link will be maintained until one of the devices pointed to by it (either
+ * the consumer or the supplier) is unregistered.
  *
  * The combination of DL_FLAG_STATELESS and either DL_FLAG_AUTOREMOVE_CONSUMER
  * or DL_FLAG_AUTOREMOVE_SUPPLIER set in @flags at the same time is invalid and
@@ -241,6 +252,14 @@ struct device_link *device_link_add(stru
 		goto out;
 	}
 
+	/*
+	 * DL_FLAG_AUTOREMOVE_SUPPLIER indicates that the link will be needed
+	 * longer than for DL_FLAG_AUTOREMOVE_CONSUMER and setting them both
+	 * together doesn't make sense, so prefer DL_FLAG_AUTOREMOVE_SUPPLIER.
+	 */
+	if (flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
+		flags &= ~DL_FLAG_AUTOREMOVE_CONSUMER;
+
 	list_for_each_entry(link, &supplier->links.consumers, s_node) {
 		if (link->consumer != consumer)
 			continue;
@@ -254,12 +273,6 @@ struct device_link *device_link_add(stru
 			goto out;
 		}
 
-		if (flags & DL_FLAG_AUTOREMOVE_CONSUMER)
-			link->flags |= DL_FLAG_AUTOREMOVE_CONSUMER;
-
-		if (flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
-			link->flags |= DL_FLAG_AUTOREMOVE_SUPPLIER;
-
 		if (flags & DL_FLAG_PM_RUNTIME) {
 			if (!(link->flags & DL_FLAG_PM_RUNTIME)) {
 				device_link_rpm_prepare(consumer, supplier);
@@ -269,7 +282,25 @@ struct device_link *device_link_add(stru
 				refcount_inc(&link->rpm_active);
 		}
 
-		kref_get(&link->kref);
+		if (flags & DL_FLAG_STATELESS) {
+			kref_get(&link->kref);
+			goto out;
+		}
+
+		/*
+		 * If the life time of the link following from the new flags is
+		 * longer than indicated by the flags of the existing link,
+		 * update the existing link to stay around longer.
+		 */
+		if (flags & DL_FLAG_AUTOREMOVE_SUPPLIER) {
+			if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER) {
+				link->flags &= ~DL_FLAG_AUTOREMOVE_CONSUMER;
+				link->flags |= DL_FLAG_AUTOREMOVE_SUPPLIER;
+			}
+		} else if (!(flags & DL_FLAG_AUTOREMOVE_CONSUMER)) {
+			link->flags &= ~(DL_FLAG_AUTOREMOVE_CONSUMER |
+					 DL_FLAG_AUTOREMOVE_SUPPLIER);
+		}
 		goto out;
 	}
 
@@ -419,8 +450,16 @@ static void __device_link_del(struct kre
 }
 #endif /* !CONFIG_SRCU */
 
+static void device_link_put_kref(struct device_link *link)
+{
+	if (link->flags & DL_FLAG_STATELESS)
+		kref_put(&link->kref, __device_link_del);
+	else
+		WARN(1, "Unable to drop a managed device link reference\n");
+}
+
 /**
- * device_link_del - Delete a link between two devices.
+ * device_link_del - Delete a stateless link between two devices.
  * @link: Device link to delete.
  *
  * The caller must ensure proper synchronization of this function with runtime
@@ -432,14 +471,14 @@ void device_link_del(struct device_link
 {
 	device_links_write_lock();
 	device_pm_lock();
-	kref_put(&link->kref, __device_link_del);
+	device_link_put_kref(link);
 	device_pm_unlock();
 	device_links_write_unlock();
 }
 EXPORT_SYMBOL_GPL(device_link_del);
 
 /**
- * device_link_remove - remove a link between two devices.
+ * device_link_remove - Delete a stateless link between two devices.
  * @consumer: Consumer end of the link.
  * @supplier: Supplier end of the link.
  *
@@ -458,7 +497,7 @@ void device_link_remove(void *consumer,
 
 	list_for_each_entry(link, &supplier->links.consumers, s_node) {
 		if (link->consumer == consumer) {
-			kref_put(&link->kref, __device_link_del);
+			device_link_put_kref(link);
 			break;
 		}
 	}
Index: linux-pm/Documentation/driver-api/device_link.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/device_link.rst
+++ linux-pm/Documentation/driver-api/device_link.rst
@@ -25,8 +25,8 @@ suspend/resume and shutdown ordering.
 
 Device links allow representation of such dependencies in the driver core.
 
-In its standard form, a device link combines *both* dependency types:
-It guarantees correct suspend/resume and shutdown ordering between a
+In its standard or *managed* form, a device link combines *both* dependency
+types:  It guarantees correct suspend/resume and shutdown ordering between a
 "supplier" device and its "consumer" devices, and it guarantees driver
 presence on the supplier.  The consumer devices are not probed before the
 supplier is bound to a driver, and they're unbound before the supplier
@@ -69,12 +69,14 @@ know that the supplier is functional alr
 the case, for instance, if the consumer has just acquired some resources that
 would not have been available had the supplier not been functional then).]
 
-If a device link is added in the ``->probe`` callback of the supplier or
-consumer driver, it is typically deleted in its ``->remove`` callback for
-symmetry.  That way, if the driver is compiled as a module, the device
-link is added on module load and orderly deleted on unload.  The same
-restrictions that apply to device link addition (e.g. exclusion of a
-parallel suspend/resume transition) apply equally to deletion.
+If a device link with ``DL_FLAG_STATELESS`` set (i.e. a stateless device link)
+is added in the ``->probe`` callback of the supplier or consumer driver, it is
+typically deleted in its ``->remove`` callback for symmetry.  That way, if the
+driver is compiled as a module, the device link is added on module load and
+orderly deleted on unload.  The same restrictions that apply to device link
+addition (e.g. exclusion of a parallel suspend/resume transition) apply equally
+to deletion.  Device links with ``DL_FLAG_STATELESS`` unset (i.e. managed
+device links) are deleted automatically by the driver core.
 
 Several flags may be specified on device link addition, two of which
 have already been mentioned above:  ``DL_FLAG_STATELESS`` to express that no
@@ -87,8 +89,6 @@ link is added from the consumer's ``->pr
 can be specified to runtime resume the supplier upon addition of the
 device link.  ``DL_FLAG_AUTOREMOVE_CONSUMER`` causes the device link to be
 automatically purged when the consumer fails to probe or later unbinds.
-This obviates the need to explicitly delete the link in the ``->remove``
-callback or in the error path of the ``->probe`` callback.
 
 Similarly, when the device link is added from supplier's ``->probe`` callback,
 ``DL_FLAG_AUTOREMOVE_SUPPLIER`` causes the device link to be automatically
@@ -97,12 +97,20 @@ purged when the supplier fails to probe
 Limitations
 ===========
 
-Driver authors should be aware that a driver presence dependency (i.e. when
-``DL_FLAG_STATELESS`` is not specified on link addition) may cause probing of
-the consumer to be deferred indefinitely.  This can become a problem if the
-consumer is required to probe before a certain initcall level is reached.
-Worse, if the supplier driver is blacklisted or missing, the consumer will
-never be probed.
+Driver authors should be aware that a driver presence dependency for managed
+device links (i.e. when ``DL_FLAG_STATELESS`` is not specified on link addition)
+may cause probing of the consumer to be deferred indefinitely.  This can become
+a problem if the consumer is required to probe before a certain initcall level
+is reached.  Worse, if the supplier driver is blacklisted or missing, the
+consumer will never be probed.
+
+Moreover, managed device links cannot be deleted directly.  They are deleted
+by the driver core when they are not necessary any more in accordance with the
+``DL_FLAG_AUTOREMOVE_CONSUMER`` and ``DL_FLAG_AUTOREMOVE_SUPPLIER`` flags.
+However, stateless device links (i.e. device links with ``DL_FLAG_STATELESS``
+set) are expected to be removed by whoever called :c:func:`device_link_add()`
+to add them with the help of either :c:func:`device_link_del()` or
+:c:func:`device_link_remove()`.
 
 Sometimes drivers depend on optional resources.  They are able to operate
 in a degraded mode (reduced feature set or performance) when those resources
@@ -286,4 +294,4 @@ API
 ===
 
 .. kernel-doc:: drivers/base/core.c
-   :functions: device_link_add device_link_del
+   :functions: device_link_add device_link_del device_link_remove

