Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeBSPCh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:02:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:33938 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752403AbeBSPCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:02:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,535,1511856000";
   d="scan'208";a="31940577"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] platform/x86: wmi: Replace list_for_each() by list_for_each_entry()
Date: Mon, 19 Feb 2018 17:02:28 +0200
Message-Id: <20180219150228.5823-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In all cases list_for_each() followed by list_entry(),
so, replace them by list_for_each_entry() macro.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/wmi.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 4e76ffcb5394..f90ba83359f5 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -130,13 +130,11 @@ static bool find_guid(const char *guid_string, struct wmi_block **out)
 	uuid_le guid_input;
 	struct wmi_block *wblock;
 	struct guid_block *block;
-	struct list_head *p;
 
 	if (uuid_le_to_bin(guid_string, &guid_input))
 		return false;
 
-	list_for_each(p, &wmi_block_list) {
-		wblock = list_entry(p, struct wmi_block, list);
+	list_for_each_entry(wblock, &wmi_block_list, list) {
 		block = &wblock->gblock;
 
 		if (memcmp(block->guid, &guid_input, 16) == 0) {
@@ -519,7 +517,6 @@ wmi_notify_handler handler, void *data)
 	struct wmi_block *block;
 	acpi_status status = AE_NOT_EXIST;
 	uuid_le guid_input;
-	struct list_head *p;
 
 	if (!guid || !handler)
 		return AE_BAD_PARAMETER;
@@ -527,9 +524,8 @@ wmi_notify_handler handler, void *data)
 	if (uuid_le_to_bin(guid, &guid_input))
 		return AE_BAD_PARAMETER;
 
-	list_for_each(p, &wmi_block_list) {
+	list_for_each_entry(block, &wmi_block_list, list) {
 		acpi_status wmi_status;
-		block = list_entry(p, struct wmi_block, list);
 
 		if (memcmp(block->gblock.guid, &guid_input, 16) == 0) {
 			if (block->handler &&
@@ -560,7 +556,6 @@ acpi_status wmi_remove_notify_handler(const char *guid)
 	struct wmi_block *block;
 	acpi_status status = AE_NOT_EXIST;
 	uuid_le guid_input;
-	struct list_head *p;
 
 	if (!guid)
 		return AE_BAD_PARAMETER;
@@ -568,9 +563,8 @@ acpi_status wmi_remove_notify_handler(const char *guid)
 	if (uuid_le_to_bin(guid, &guid_input))
 		return AE_BAD_PARAMETER;
 
-	list_for_each(p, &wmi_block_list) {
+	list_for_each_entry(block, &wmi_block_list, list) {
 		acpi_status wmi_status;
-		block = list_entry(p, struct wmi_block, list);
 
 		if (memcmp(block->gblock.guid, &guid_input, 16) == 0) {
 			if (!block->handler ||
@@ -610,15 +604,13 @@ acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out)
 	union acpi_object params[1];
 	struct guid_block *gblock;
 	struct wmi_block *wblock;
-	struct list_head *p;
 
 	input.count = 1;
 	input.pointer = params;
 	params[0].type = ACPI_TYPE_INTEGER;
 	params[0].integer.value = event;
 
-	list_for_each(p, &wmi_block_list) {
-		wblock = list_entry(p, struct wmi_block, list);
+	list_for_each_entry(wblock, &wmi_block_list, list) {
 		gblock = &wblock->gblock;
 
 		if ((gblock->flags & ACPI_WMI_EVENT) &&
@@ -1260,11 +1252,9 @@ static void acpi_wmi_notify_handler(acpi_handle handle, u32 event,
 {
 	struct guid_block *block;
 	struct wmi_block *wblock;
-	struct list_head *p;
 	bool found_it = false;
 
-	list_for_each(p, &wmi_block_list) {
-		wblock = list_entry(p, struct wmi_block, list);
+	list_for_each_entry(wblock, &wmi_block_list, list) {
 		block = &wblock->gblock;
 
 		if (wblock->acpi_device->handle == handle &&
-- 
2.16.1
