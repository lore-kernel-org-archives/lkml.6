Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB94ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CB720871
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CB720871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbeGMNIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:08:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:44211 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbeGMNIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:08:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 05:53:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,347,1526367600"; 
   d="scan'208";a="72470397"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 13 Jul 2018 05:53:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8D98E29B; Fri, 13 Jul 2018 15:53:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Tai <thomas.tai@oracle.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] platform/x86: wmi: Switch to use new generic UUID API
Date:   Fri, 13 Jul 2018 15:53:51 +0300
Message-Id: <20180713125351.26048-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are new types and helpers that are supposed to be used in new code.

As a preparation to get rid of legacy types and API functions do
the conversion here.

While here, update Copyright to reflect this change along with previous
one for the topic.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/wmi.c | 54 ++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 04791ea5d97b..da8d863c57ba 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -7,6 +7,8 @@
  *   Copyright (C) 2001,2002 Richard Russon <ldm@flatcap.org>
  *   Copyright (c) 2001-2007 Anton Altaparmakov
  *   Copyright (C) 2001,2002 Jakob Kemi <jakob.kemi@telia.com>
+ *  ...replaced by generic UUID API:
+ *   Copyright (C) 2016,2017 Intel Corporation.
  *
  *  WMI bus infrastructure by Andrew Lutomirski and Darren Hart:
  *    Copyright (C) 2015 Andrew Lutomirski
@@ -127,17 +129,17 @@ static struct platform_driver acpi_wmi_driver = {
 
 static bool find_guid(const char *guid_string, struct wmi_block **out)
 {
-	uuid_le guid_input;
+	guid_t guid_input;
 	struct wmi_block *wblock;
 	struct guid_block *block;
 
-	if (uuid_le_to_bin(guid_string, &guid_input))
+	if (guid_parse(guid_string, &guid_input))
 		return false;
 
 	list_for_each_entry(wblock, &wmi_block_list, list) {
 		block = &wblock->gblock;
 
-		if (memcmp(block->guid, &guid_input, 16) == 0) {
+		if (guid_equal((guid_t *)&block->guid, &guid_input)) {
 			if (out)
 				*out = wblock;
 			return true;
@@ -446,7 +448,7 @@ EXPORT_SYMBOL_GPL(wmi_set_block);
 
 static void wmi_dump_wdg(const struct guid_block *g)
 {
-	pr_info("%pUL:\n", g->guid);
+	pr_info("%pUL:\n", &g->guid);
 	if (g->flags & ACPI_WMI_EVENT)
 		pr_info("\tnotify_id: 0x%02X\n", g->notify_id);
 	else
@@ -506,6 +508,7 @@ static void wmi_notify_debug(u32 value, void *context)
 
 /**
  * wmi_install_notify_handler - Register handler for WMI events
+ * @guid: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
  * @handler: Function to handle notifications
  * @data: Data to be returned to handler when event is fired
  *
@@ -516,18 +519,18 @@ wmi_notify_handler handler, void *data)
 {
 	struct wmi_block *block;
 	acpi_status status = AE_NOT_EXIST;
-	uuid_le guid_input;
+	guid_t guid_input;
 
 	if (!guid || !handler)
 		return AE_BAD_PARAMETER;
 
-	if (uuid_le_to_bin(guid, &guid_input))
+	if (guid_parse(guid, &guid_input))
 		return AE_BAD_PARAMETER;
 
 	list_for_each_entry(block, &wmi_block_list, list) {
 		acpi_status wmi_status;
 
-		if (memcmp(block->gblock.guid, &guid_input, 16) == 0) {
+		if (guid_equal((guid_t *)&block->gblock.guid, &guid_input)) {
 			if (block->handler &&
 			    block->handler != wmi_notify_debug)
 				return AE_ALREADY_ACQUIRED;
@@ -548,6 +551,7 @@ EXPORT_SYMBOL_GPL(wmi_install_notify_handler);
 
 /**
  * wmi_uninstall_notify_handler - Unregister handler for WMI events
+ * @guid: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
  *
  * Unregister handler for events sent to the ACPI-WMI mapper device.
  */
@@ -555,18 +559,18 @@ acpi_status wmi_remove_notify_handler(const char *guid)
 {
 	struct wmi_block *block;
 	acpi_status status = AE_NOT_EXIST;
-	uuid_le guid_input;
+	guid_t guid_input;
 
 	if (!guid)
 		return AE_BAD_PARAMETER;
 
-	if (uuid_le_to_bin(guid, &guid_input))
+	if (guid_parse(guid, &guid_input))
 		return AE_BAD_PARAMETER;
 
 	list_for_each_entry(block, &wmi_block_list, list) {
 		acpi_status wmi_status;
 
-		if (memcmp(block->gblock.guid, &guid_input, 16) == 0) {
+		if (guid_equal((guid_t *)&block->gblock.guid, &guid_input)) {
 			if (!block->handler ||
 			    block->handler == wmi_notify_debug)
 				return AE_NULL_ENTRY;
@@ -653,7 +657,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 {
 	struct wmi_block *wblock = dev_to_wblock(dev);
 
-	return sprintf(buf, "wmi:%pUL\n", wblock->gblock.guid);
+	return sprintf(buf, "wmi:%pUL\n", &wblock->gblock.guid);
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -662,7 +666,7 @@ static ssize_t guid_show(struct device *dev, struct device_attribute *attr,
 {
 	struct wmi_block *wblock = dev_to_wblock(dev);
 
-	return sprintf(buf, "%pUL\n", wblock->gblock.guid);
+	return sprintf(buf, "%pUL\n", &wblock->gblock.guid);
 }
 static DEVICE_ATTR_RO(guid);
 
@@ -745,10 +749,10 @@ static int wmi_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct wmi_block *wblock = dev_to_wblock(dev);
 
-	if (add_uevent_var(env, "MODALIAS=wmi:%pUL", wblock->gblock.guid))
+	if (add_uevent_var(env, "MODALIAS=wmi:%pUL", &wblock->gblock.guid))
 		return -ENOMEM;
 
-	if (add_uevent_var(env, "WMI_GUID=%pUL", wblock->gblock.guid))
+	if (add_uevent_var(env, "WMI_GUID=%pUL", &wblock->gblock.guid))
 		return -ENOMEM;
 
 	return 0;
@@ -769,11 +773,11 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
 	const struct wmi_device_id *id = wmi_driver->id_table;
 
 	while (id->guid_string) {
-		uuid_le driver_guid;
+		guid_t driver_guid;
 
-		if (WARN_ON(uuid_le_to_bin(id->guid_string, &driver_guid)))
+		if (WARN_ON(guid_parse(id->guid_string, &driver_guid)))
 			continue;
-		if (!memcmp(&driver_guid, wblock->gblock.guid, 16))
+		if (guid_equal(&driver_guid, (guid_t *)&wblock->gblock.guid))
 			return 1;
 
 		id++;
@@ -1069,7 +1073,7 @@ static int wmi_create_device(struct device *wmi_bus_dev,
 	wblock->dev.dev.bus = &wmi_bus_type;
 	wblock->dev.dev.parent = wmi_bus_dev;
 
-	dev_set_name(&wblock->dev.dev, "%pUL", gblock->guid);
+	dev_set_name(&wblock->dev.dev, "%pUL", &gblock->guid);
 
 	device_initialize(&wblock->dev.dev);
 
@@ -1090,12 +1094,12 @@ static void wmi_free_devices(struct acpi_device *device)
 }
 
 static bool guid_already_parsed(struct acpi_device *device,
-				const u8 *guid)
+				const guid_t *guid)
 {
 	struct wmi_block *wblock;
 
 	list_for_each_entry(wblock, &wmi_block_list, list) {
-		if (memcmp(wblock->gblock.guid, guid, 16) == 0) {
+		if (guid_equal((guid_t *)&wblock->gblock.guid, guid)) {
 			/*
 			 * Because we historically didn't track the relationship
 			 * between GUIDs and ACPI nodes, we don't know whether
@@ -1150,7 +1154,7 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		 * case yet, so for now, we'll just ignore the duplicate
 		 * for device creation.
 		 */
-		if (guid_already_parsed(device, gblock[i].guid))
+		if (guid_already_parsed(device, (guid_t *)&gblock[i].guid))
 			continue;
 
 		wblock = kzalloc(sizeof(struct wmi_block), GFP_KERNEL);
@@ -1187,7 +1191,7 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		retval = device_add(&wblock->dev.dev);
 		if (retval) {
 			dev_err(wmi_bus_dev, "failed to register %pUL\n",
-				wblock->gblock.guid);
+				&wblock->gblock.guid);
 			if (debug_event)
 				wmi_method_enable(wblock, 0);
 			list_del(&wblock->list);
@@ -1300,10 +1304,8 @@ static void acpi_wmi_notify_handler(acpi_handle handle, u32 event,
 		wblock->handler(event, wblock->handler_data);
 	}
 
-	if (debug_event) {
-		pr_info("DEBUG Event GUID: %pUL\n",
-			wblock->gblock.guid);
-	}
+	if (debug_event)
+		pr_info("DEBUG Event GUID: %pUL\n", &wblock->gblock.guid);
 
 	acpi_bus_generate_netlink_event(
 		wblock->acpi_device->pnp.device_class,
-- 
2.18.0

