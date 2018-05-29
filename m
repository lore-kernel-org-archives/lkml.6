Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932974AbeE2J6b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:58:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932904AbeE2J6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:58:20 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 8/9] HID: core: do not upper bound the collection stack
Date: Tue, 29 May 2018 11:57:59 +0200
Message-Id: <20180529095800.13504-9-benjamin.tissoires@redhat.com>
In-Reply-To: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
References: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like 4 was sufficient until now. However, the Surface Dial needs
a stack of 5 and simply fails at probing.
Dynamically add HID_COLLECTION_STACK_SIZE to the size of the stack if
we hit the upper bound.

Checkpatch complains about bare unsigned, so converting those to
'unsigned int' in struct hid_parser

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c | 17 ++++++++++++++---
 include/linux/hid.h    |  9 +++++----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 355dc7e49562..2f7367b1de00 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -128,9 +128,19 @@ static int open_collection(struct hid_parser *parser, unsigned type)
 
 	usage = parser->local.usage[0];
 
-	if (parser->collection_stack_ptr == HID_COLLECTION_STACK_SIZE) {
-		hid_err(parser->device, "collection stack overflow\n");
-		return -EINVAL;
+	if (parser->collection_stack_ptr == parser->collection_stack_size) {
+		unsigned int *collection_stack;
+		unsigned int new_size = parser->collection_stack_size +
+					HID_COLLECTION_STACK_SIZE;
+
+		collection_stack = krealloc(parser->collection_stack,
+					    new_size * sizeof(unsigned int),
+					    GFP_KERNEL);
+		if (!collection_stack)
+			return -ENOMEM;
+
+		parser->collection_stack = collection_stack;
+		parser->collection_stack_size = new_size;
 	}
 
 	if (parser->device->maxcollection == parser->device->collection_size) {
@@ -837,6 +847,7 @@ static int hid_scan_report(struct hid_device *hid)
 		break;
 	}
 
+	kfree(parser->collection_stack);
 	vfree(parser);
 	return 0;
 }
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 9caa193e0c67..ee2510019033 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -643,12 +643,13 @@ static inline void hid_set_drvdata(struct hid_device *hdev, void *data)
 struct hid_parser {
 	struct hid_global     global;
 	struct hid_global     global_stack[HID_GLOBAL_STACK_SIZE];
-	unsigned              global_stack_ptr;
+	unsigned int          global_stack_ptr;
 	struct hid_local      local;
-	unsigned              collection_stack[HID_COLLECTION_STACK_SIZE];
-	unsigned              collection_stack_ptr;
+	unsigned int         *collection_stack;
+	unsigned int          collection_stack_ptr;
+	unsigned int          collection_stack_size;
 	struct hid_device    *device;
-	unsigned              scan_flags;
+	unsigned int          scan_flags;
 };
 
 struct hid_class_descriptor {
-- 
2.14.3
