Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DCAC282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF80214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfA1XOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:14:18 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41848 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfA1XOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:14:05 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id d14eba6300845448; Tue, 29 Jan 2019 00:14:01 +0100
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
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 3/4] driver core: Add device link flag DL_FLAG_AUTOPROBE_CONSUMER
Date:   Tue, 29 Jan 2019 00:07:47 +0100
Message-ID: <9114627.nRTh6DrMlu@aspire.rjw.lan>
In-Reply-To: <2405639.4es7pRLqn0@aspire.rjw.lan>
References: <2405639.4es7pRLqn0@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a new device link flag, DL_FLAG_AUTOPROBE_CONSUMER, to request the
driver core to probe for a consumer driver automatically after binding
a driver to the supplier device on a persistent managed device link.

As unbinding the supplier driver on a managed device link causes the
consumer driver to be detached from its device automatically, this
flag provides a complementary mechanism which is needed to address
some "composite device" use cases.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/device_link.rst |    9 +++++++++
 drivers/base/core.c                      |   16 +++++++++++++++-
 drivers/base/dd.c                        |    2 +-
 include/linux/device.h                   |    3 +++
 4 files changed, 28 insertions(+), 2 deletions(-)

Index: linux-pm/include/linux/device.h
===================================================================
--- linux-pm.orig/include/linux/device.h
+++ linux-pm/include/linux/device.h
@@ -341,6 +341,7 @@ struct device *driver_find_device(struct
 				  struct device *start, void *data,
 				  int (*match)(struct device *dev, void *data));
 
+void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
 
 /**
@@ -827,12 +828,14 @@ enum device_link_state {
  * PM_RUNTIME: If set, the runtime PM framework will use this link.
  * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link creation.
  * AUTOREMOVE_SUPPLIER: Remove the link automatically on supplier driver unbind.
+ * AUTOPROBE_CONSUMER: Probe consumer driver automatically after supplier binds.
  */
 #define DL_FLAG_STATELESS		BIT(0)
 #define DL_FLAG_AUTOREMOVE_CONSUMER	BIT(1)
 #define DL_FLAG_PM_RUNTIME		BIT(2)
 #define DL_FLAG_RPM_ACTIVE		BIT(3)
 #define DL_FLAG_AUTOREMOVE_SUPPLIER	BIT(4)
+#define DL_FLAG_AUTOPROBE_CONSUMER	BIT(5)
 
 /**
  * struct device_link - Device link representation.
Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -208,6 +208,12 @@ static void device_link_rpm_prepare(stru
  * the link will be maintained until one of the devices pointed to by it (either
  * the consumer or the supplier) is unregistered.
  *
+ * Also, if DL_FLAG_STATELESS, DL_FLAG_AUTOREMOVE_CONSUMER and
+ * DL_FLAG_AUTOREMOVE_SUPPLIER are not set in @flags (that is, a persistent
+ * managed device link is being added), the DL_FLAG_AUTOPROBE_CONSUMER flag can
+ * be used to request the driver core to automaticall probe for a consmer
+ * driver after successfully binding a driver to the supplier device.
+ *
  * The combination of DL_FLAG_STATELESS and either DL_FLAG_AUTOREMOVE_CONSUMER
  * or DL_FLAG_AUTOREMOVE_SUPPLIER set in @flags at the same time is invalid and
  * will cause NULL to be returned upfront.
@@ -228,7 +234,12 @@ struct device_link *device_link_add(stru
 
 	if (!consumer || !supplier ||
 	    (flags & DL_FLAG_STATELESS &&
-	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER | DL_FLAG_AUTOREMOVE_SUPPLIER)))
+	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER |
+		      DL_FLAG_AUTOREMOVE_SUPPLIER |
+		      DL_FLAG_AUTOPROBE_CONSUMER)) ||
+	    (flags & DL_FLAG_AUTOPROBE_CONSUMER &&
+	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER |
+		      DL_FLAG_AUTOREMOVE_SUPPLIER)))
 		return NULL;
 
 	if (flags & DL_FLAG_PM_RUNTIME && flags & DL_FLAG_RPM_ACTIVE) {
@@ -589,6 +600,9 @@ void device_links_driver_bound(struct de
 
 		WARN_ON(link->status != DL_STATE_DORMANT);
 		WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
+
+		if (link->flags & DL_FLAG_AUTOPROBE_CONSUMER)
+			driver_deferred_probe_add(link->consumer);
 	}
 
 	list_for_each_entry(link, &dev->links.suppliers, c_node) {
Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -116,7 +116,7 @@ static void deferred_probe_work_func(str
 }
 static DECLARE_WORK(deferred_probe_work, deferred_probe_work_func);
 
-static void driver_deferred_probe_add(struct device *dev)
+void driver_deferred_probe_add(struct device *dev)
 {
 	mutex_lock(&deferred_probe_mutex);
 	if (list_empty(&dev->p->deferred_probe)) {
Index: linux-pm/Documentation/driver-api/device_link.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/device_link.rst
+++ linux-pm/Documentation/driver-api/device_link.rst
@@ -94,6 +94,15 @@ Similarly, when the device link is added
 ``DL_FLAG_AUTOREMOVE_SUPPLIER`` causes the device link to be automatically
 purged when the supplier fails to probe or later unbinds.
 
+If neither ``DL_FLAG_AUTOREMOVE_CONSUMER`` nor ``DL_FLAG_AUTOREMOVE_SUPPLIER``
+is set, ``DL_FLAG_AUTOPROBE_CONSUMER`` can be used to request the driver core
+to probe for a driver for the consumer driver on the link automatically after
+a driver has been bound to the supplier device.
+
+Note, however, that any combinations of ``DL_FLAG_AUTOREMOVE_CONSUMER``,
+``DL_FLAG_AUTOREMOVE_SUPPLIER`` or ``DL_FLAG_AUTOPROBE_CONSUMER`` with
+``DL_FLAG_STATELESS`` are invalid and cannot be used.
+
 Limitations
 ===========
 

