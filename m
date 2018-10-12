Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ACDC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC6420868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC6420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeJLTLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:11:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:42739 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbeJLTLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:11:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 04:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,371,1534834800"; 
   d="scan'208";a="98616689"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2018 04:39:43 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [RFC PATCH 4/5] device property: Move device_add_properties() to swnode.c
Date:   Fri, 12 Oct 2018 14:39:33 +0300
Message-Id: <20181012113934.29942-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Concentrating struct property_entry processing to
drivers/base/swnode.c

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/property.c | 179 --------------------------------------
 drivers/base/swnode.c   | 184 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 184 insertions(+), 179 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 240ab5230ff6..e20642759c67 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -84,44 +84,6 @@ static const void *property_get_pointer(const struct property_entry *prop)
 	}
 }
 
-static void property_set_pointer(struct property_entry *prop, const void *pointer)
-{
-	switch (prop->type) {
-	case DEV_PROP_U8:
-		if (prop->is_array)
-			prop->pointer.u8_data = pointer;
-		else
-			prop->value.u8_data = *((u8 *)pointer);
-		break;
-	case DEV_PROP_U16:
-		if (prop->is_array)
-			prop->pointer.u16_data = pointer;
-		else
-			prop->value.u16_data = *((u16 *)pointer);
-		break;
-	case DEV_PROP_U32:
-		if (prop->is_array)
-			prop->pointer.u32_data = pointer;
-		else
-			prop->value.u32_data = *((u32 *)pointer);
-		break;
-	case DEV_PROP_U64:
-		if (prop->is_array)
-			prop->pointer.u64_data = pointer;
-		else
-			prop->value.u64_data = *((u64 *)pointer);
-		break;
-	case DEV_PROP_STRING:
-		if (prop->is_array)
-			prop->pointer.str = pointer;
-		else
-			prop->value.str = pointer;
-		break;
-	default:
-		break;
-	}
-}
-
 static const void *pset_prop_find(const struct property_set *pset,
 				  const char *propname, size_t length)
 {
@@ -759,147 +721,6 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
 
-static void property_entry_free_data(const struct property_entry *p)
-{
-	const void *pointer = property_get_pointer(p);
-	size_t i, nval;
-
-	if (p->is_array) {
-		if (p->type == DEV_PROP_STRING && p->pointer.str) {
-			nval = p->length / sizeof(const char *);
-			for (i = 0; i < nval; i++)
-				kfree(p->pointer.str[i]);
-		}
-		kfree(pointer);
-	} else if (p->type == DEV_PROP_STRING) {
-		kfree(p->value.str);
-	}
-	kfree(p->name);
-}
-
-static int property_copy_string_array(struct property_entry *dst,
-				      const struct property_entry *src)
-{
-	const char **d;
-	size_t nval = src->length / sizeof(*d);
-	int i;
-
-	d = kcalloc(nval, sizeof(*d), GFP_KERNEL);
-	if (!d)
-		return -ENOMEM;
-
-	for (i = 0; i < nval; i++) {
-		d[i] = kstrdup(src->pointer.str[i], GFP_KERNEL);
-		if (!d[i] && src->pointer.str[i]) {
-			while (--i >= 0)
-				kfree(d[i]);
-			kfree(d);
-			return -ENOMEM;
-		}
-	}
-
-	dst->pointer.str = d;
-	return 0;
-}
-
-static int property_entry_copy_data(struct property_entry *dst,
-				    const struct property_entry *src)
-{
-	const void *pointer = property_get_pointer(src);
-	const void *new;
-	int error;
-
-	if (src->is_array) {
-		if (!src->length)
-			return -ENODATA;
-
-		if (src->type == DEV_PROP_STRING) {
-			error = property_copy_string_array(dst, src);
-			if (error)
-				return error;
-			new = dst->pointer.str;
-		} else {
-			new = kmemdup(pointer, src->length, GFP_KERNEL);
-			if (!new)
-				return -ENOMEM;
-		}
-	} else if (src->type == DEV_PROP_STRING) {
-		new = kstrdup(src->value.str, GFP_KERNEL);
-		if (!new && src->value.str)
-			return -ENOMEM;
-	} else {
-		new = pointer;
-	}
-
-	dst->length = src->length;
-	dst->is_array = src->is_array;
-	dst->type = src->type;
-
-	property_set_pointer(dst, new);
-
-	dst->name = kstrdup(src->name, GFP_KERNEL);
-	if (!dst->name)
-		goto out_free_data;
-
-	return 0;
-
-out_free_data:
-	property_entry_free_data(dst);
-	return -ENOMEM;
-}
-
-/**
- * property_entries_dup - duplicate array of properties
- * @properties: array of properties to copy
- *
- * This function creates a deep copy of the given NULL-terminated array
- * of property entries.
- */
-struct property_entry *
-property_entries_dup(const struct property_entry *properties)
-{
-	struct property_entry *p;
-	int i, n = 0;
-
-	while (properties[n].name)
-		n++;
-
-	p = kcalloc(n + 1, sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return ERR_PTR(-ENOMEM);
-
-	for (i = 0; i < n; i++) {
-		int ret = property_entry_copy_data(&p[i], &properties[i]);
-		if (ret) {
-			while (--i >= 0)
-				property_entry_free_data(&p[i]);
-			kfree(p);
-			return ERR_PTR(ret);
-		}
-	}
-
-	return p;
-}
-EXPORT_SYMBOL_GPL(property_entries_dup);
-
-/**
- * property_entries_free - free previously allocated array of properties
- * @properties: array of properties to destroy
- *
- * This function frees given NULL-terminated array of property entries,
- * along with their data.
- */
-void property_entries_free(const struct property_entry *properties)
-{
-	const struct property_entry *p;
-
-	for (p = properties; p->name; p++)
-		property_entry_free_data(p);
-
-	kfree(properties);
-}
-EXPORT_SYMBOL_GPL(property_entries_free);
-
 /**
  * pset_free_set - releases memory allocated for copied property set
  * @pset: Property set to release
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 77d5645d2fcf..ea120e216a31 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -66,6 +66,45 @@ property_entry_get(const struct property_entry *prop, const char *name)
 	return NULL;
 }
 
+static void
+property_set_pointer(struct property_entry *prop, const void *pointer)
+{
+	switch (prop->type) {
+	case DEV_PROP_U8:
+		if (prop->is_array)
+			prop->pointer.u8_data = pointer;
+		else
+			prop->value.u8_data = *((u8 *)pointer);
+		break;
+	case DEV_PROP_U16:
+		if (prop->is_array)
+			prop->pointer.u16_data = pointer;
+		else
+			prop->value.u16_data = *((u16 *)pointer);
+		break;
+	case DEV_PROP_U32:
+		if (prop->is_array)
+			prop->pointer.u32_data = pointer;
+		else
+			prop->value.u32_data = *((u32 *)pointer);
+		break;
+	case DEV_PROP_U64:
+		if (prop->is_array)
+			prop->pointer.u64_data = pointer;
+		else
+			prop->value.u64_data = *((u64 *)pointer);
+		break;
+	case DEV_PROP_STRING:
+		if (prop->is_array)
+			prop->pointer.str = pointer;
+		else
+			prop->value.str = pointer;
+		break;
+	default:
+		break;
+	}
+}
+
 static const void *property_get_pointer(const struct property_entry *prop)
 {
 	switch (prop->type) {
@@ -243,6 +282,151 @@ static int property_entry_read_string_array(const struct property_entry *props,
 	return array_len;
 }
 
+static void property_entry_free_data(const struct property_entry *p)
+{
+	const void *pointer = property_get_pointer(p);
+	size_t i, nval;
+
+	if (p->is_array) {
+		if (p->type == DEV_PROP_STRING && p->pointer.str) {
+			nval = p->length / sizeof(const char *);
+			for (i = 0; i < nval; i++)
+				kfree(p->pointer.str[i]);
+		}
+		kfree(pointer);
+	} else if (p->type == DEV_PROP_STRING) {
+		kfree(p->value.str);
+	}
+	kfree(p->name);
+}
+
+static int property_copy_string_array(struct property_entry *dst,
+				      const struct property_entry *src)
+{
+	const char **d;
+	size_t nval = src->length / sizeof(*d);
+	int i;
+
+	d = kcalloc(nval, sizeof(*d), GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
+
+	for (i = 0; i < nval; i++) {
+		d[i] = kstrdup(src->pointer.str[i], GFP_KERNEL);
+		if (!d[i] && src->pointer.str[i]) {
+			while (--i >= 0)
+				kfree(d[i]);
+			kfree(d);
+			return -ENOMEM;
+		}
+	}
+
+	dst->pointer.str = d;
+	return 0;
+}
+
+static int property_entry_copy_data(struct property_entry *dst,
+				    const struct property_entry *src)
+{
+	const void *pointer = property_get_pointer(src);
+	const void *new;
+	int error;
+
+	if (src->is_array) {
+		if (!src->length)
+			return -ENODATA;
+
+		if (src->type == DEV_PROP_STRING) {
+			error = property_copy_string_array(dst, src);
+			if (error)
+				return error;
+			new = dst->pointer.str;
+		} else {
+			new = kmemdup(pointer, src->length, GFP_KERNEL);
+			if (!new)
+				return -ENOMEM;
+		}
+	} else if (src->type == DEV_PROP_STRING) {
+		new = kstrdup(src->value.str, GFP_KERNEL);
+		if (!new && src->value.str)
+			return -ENOMEM;
+	} else {
+		new = pointer;
+	}
+
+	dst->length = src->length;
+	dst->is_array = src->is_array;
+	dst->type = src->type;
+
+	property_set_pointer(dst, new);
+
+	dst->name = kstrdup(src->name, GFP_KERNEL);
+	if (!dst->name)
+		goto out_free_data;
+
+	return 0;
+
+out_free_data:
+	property_entry_free_data(dst);
+	return -ENOMEM;
+}
+
+/**
+ * property_entries_dup - duplicate array of properties
+ * @properties: array of properties to copy
+ *
+ * This function creates a deep copy of the given NULL-terminated array
+ * of property entries.
+ */
+struct property_entry *
+property_entries_dup(const struct property_entry *properties)
+{
+	struct property_entry *p;
+	int i, n = 0;
+	int ret;
+
+	while (properties[n].name)
+		n++;
+
+	p = kcalloc(n + 1, sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < n; i++) {
+		ret = property_entry_copy_data(&p[i], &properties[i]);
+		if (ret) {
+			while (--i >= 0)
+				property_entry_free_data(&p[i]);
+			kfree(p);
+			return ERR_PTR(ret);
+		}
+	}
+
+	return p;
+}
+EXPORT_SYMBOL_GPL(property_entries_dup);
+
+/**
+ * property_entries_free - free previously allocated array of properties
+ * @properties: array of properties to destroy
+ *
+ * This function frees given NULL-terminated array of property entries,
+ * along with their data.
+ */
+void property_entries_free(const struct property_entry *properties)
+{
+	const struct property_entry *p;
+
+	if (!properties)
+		return;
+
+	for (p = properties; p->name; p++)
+		property_entry_free_data(p);
+
+	kfree(properties);
+}
+EXPORT_SYMBOL_GPL(property_entries_free);
+
 /* -------------------------------------------------------------------------- */
 /* fwnode operations */
 
-- 
2.19.1

