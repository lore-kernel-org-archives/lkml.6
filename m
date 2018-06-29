Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846ACC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E76627B48
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E76627B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752977AbeF2HCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:02:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:10384 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752328AbeF2HCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:02:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 00:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="67310789"
Received: from ning-debian.sh.intel.com ([10.239.16.9])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2018 00:02:28 -0700
From:   ning.a.zhang@intel.com
To:     gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
Cc:     mark.gross@intel.com, Zhang Ning <ning.a.zhang@intel.com>
Subject: [PATCH] driver core: support bus manage deferred probe
Date:   Fri, 29 Jun 2018 15:02:26 +0800
Message-Id: <20180629070226.24506-1-ning.a.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Ning <ning.a.zhang@intel.com>

deferred probe will be hanlded by deferred_probe_initcall,
starts at late_initcall.

this is too late to handle deferred probe, this will block kernel exec
to userspace, make kernel initial time longer.

if we know when required resources are ready for a list of devices,
related deferred drivers can be probe earlier.

add these kinds of drivers into logical list,
eg, bus_type->deferred_probe_pending_list,
then it can be easily handled by bus driver.

with analysis above:
add manage_deferred to struct bus_type
add deferred_probe_pending_list to struct bus_type

when manage_deferred is true, deferred probe will be
manage by bus.

Signed-off-by: Zhang Ning <ning.a.zhang@intel.com>
---
 drivers/base/bus.c     |  3 ++-
 drivers/base/dd.c      | 24 +++++++++++++++++-------
 include/linux/device.h |  5 +++++
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 8bfd27ec73d6..ca8eaf7565db 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -898,7 +898,8 @@ int bus_register(struct bus_type *bus)
 	retval = bus_add_groups(bus, bus->bus_groups);
 	if (retval)
 		goto bus_groups_fail;
-
+	if (bus->manage_deferred)
+		INIT_LIST_HEAD(&bus->deferred_probe_pending_list);
 	pr_debug("bus: '%s': registered\n", bus->name);
 	return 0;
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1435d7281c66..926e57f8dd2f 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -82,10 +82,8 @@ static void deferred_probe_debug(struct device *dev)
 	       dev_name(dev), duration);
 }
 
-/*
- * deferred_probe_work_func() - Retry probing devices in the active list.
- */
-static void deferred_probe_work_func(struct work_struct *work)
+
+void process_deferred_probe(struct list_head *list)
 {
 	struct device *dev;
 	struct device_private *private;
@@ -102,8 +100,8 @@ static void deferred_probe_work_func(struct work_struct *work)
 	 * from under our feet.
 	 */
 	mutex_lock(&deferred_probe_mutex);
-	while (!list_empty(&deferred_probe_active_list)) {
-		private = list_first_entry(&deferred_probe_active_list,
+	while (!list_empty(list)) {
+		private = list_first_entry(list,
 					typeof(*dev->p), deferred_probe);
 		dev = private->device;
 		list_del_init(&private->deferred_probe);
@@ -136,6 +134,15 @@ static void deferred_probe_work_func(struct work_struct *work)
 	}
 	mutex_unlock(&deferred_probe_mutex);
 }
+
+/*
+ * deferred_probe_work_func() - Retry probing devices in the active list.
+ */
+static void deferred_probe_work_func(struct work_struct *work)
+{
+	process_deferred_probe(&deferred_probe_active_list);
+}
+
 static DECLARE_WORK(deferred_probe_work, deferred_probe_work_func);
 
 static void driver_deferred_probe_add(struct device *dev)
@@ -143,7 +150,10 @@ static void driver_deferred_probe_add(struct device *dev)
 	mutex_lock(&deferred_probe_mutex);
 	if (list_empty(&dev->p->deferred_probe)) {
 		dev_dbg(dev, "Added to deferred list\n");
-		list_add_tail(&dev->p->deferred_probe, &deferred_probe_pending_list);
+		if (dev->bus->manage_deferred)
+			list_add_tail(&dev->p->deferred_probe, &dev->bus->deferred_probe_pending_list);
+		else
+			list_add_tail(&dev->p->deferred_probe, &deferred_probe_pending_list);
 	}
 	mutex_unlock(&deferred_probe_mutex);
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 055a69dbcd18..2f70f3124d18 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -143,6 +143,9 @@ struct bus_type {
 	struct lock_class_key lock_key;
 
 	bool need_parent_lock;
+
+	bool manage_deferred;
+	struct list_head deferred_probe_pending_list;
 };
 
 extern int __must_check bus_register(struct bus_type *bus);
@@ -151,6 +154,8 @@ extern void bus_unregister(struct bus_type *bus);
 
 extern int __must_check bus_rescan_devices(struct bus_type *bus);
 
+extern void process_deferred_probe(struct list_head *list);
+
 /* iterator helpers for buses */
 struct subsys_dev_iter {
 	struct klist_iter		ki;
-- 
2.17.1

