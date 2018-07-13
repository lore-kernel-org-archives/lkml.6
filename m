Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4CAECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C5A2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C5A2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387704AbeGMO3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:29:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731960AbeGMO3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:29:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 57B0887A74;
        Fri, 13 Jul 2018 14:14:14 +0000 (UTC)
Received: from plouf.banquise.eu.com (ovpn-116-134.ams2.redhat.com [10.36.116.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 136FE1C67D;
        Fri, 13 Jul 2018 14:14:12 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mario.Limonciello@dell.com,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 08/12] HID: core: do not upper bound the collection stack
Date:   Fri, 13 Jul 2018 16:13:50 +0200
Message-Id: <20180713141354.7286-9-benjamin.tissoires@redhat.com>
In-Reply-To: <20180713141354.7286-1-benjamin.tissoires@redhat.com>
References: <20180713141354.7286-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 13 Jul 2018 14:14:14 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 13 Jul 2018 14:14:14 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like 4 was sufficient until now. However, the Surface Dial needs
a stack of 5 and simply fails at probing.
Dynamically add HID_COLLECTION_STACK_SIZE to the size of the stack if
we hit the upper bound.

Checkpatch complains about bare unsigned, so converting those to
'unsigned int' in struct hid_parser

Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v4
no changes in v3
no changes in v2
---
 drivers/hid/hid-core.c | 17 ++++++++++++++---
 include/linux/hid.h    |  9 +++++----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3942ee61bd1c..5de6f18c9bf7 100644
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
@@ -840,6 +850,7 @@ static int hid_scan_report(struct hid_device *hid)
 		break;
 	}
 
+	kfree(parser->collection_stack);
 	vfree(parser);
 	return 0;
 }
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 2e4498d52a2f..aee281522c6d 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -644,12 +644,13 @@ static inline void hid_set_drvdata(struct hid_device *hdev, void *data)
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

