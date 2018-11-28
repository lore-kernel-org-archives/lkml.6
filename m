Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D165BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A130E20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A130E20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeK1XBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:01:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:3291 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbeK1XBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:01:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 03:59:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,290,1539673200"; 
   d="scan'208";a="116501285"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Nov 2018 03:59:55 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 1/3] device property: Introduce fwnode_get_name()
Date:   Wed, 28 Nov 2018 14:59:50 +0300
Message-Id: <20181128115952.80890-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181128115952.80890-1-heikki.krogerus@linux.intel.com>
References: <20181128115952.80890-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper returns the name of the node. The name is
primarily expected to be returned from a new fwnode
operation meant for this purpose, but when no name is
returned, the helper will also attempt to read a device
property "name".

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/property.c  | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/fwnode.h   |  3 +++
 include/linux/property.h |  2 ++
 3 files changed, 41 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 240ab5230ff6..8bd35b44d9ec 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1156,6 +1156,42 @@ void fwnode_handle_put(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_handle_put);
 
+/**
+ * fwnode_get_name - Copy the name of an fwnode to a buffer
+ * @fwnode: Pointer to the node
+ * @buf: Buffer where the name is copied to
+ * @len: Size of the buffer
+ *
+ * Copies the node name of @fwnode to @buf. The routine attempts to first use
+ * the get_name fwnode op of @fwnode, and if it fails, the routine attempts to
+ * read a property "name".
+ *
+ * NOTE: @buf must be large enough to accommodate the name and trailing '\0'.
+ *
+ * Returns 0 on success or errno in case of an error.
+ */
+int fwnode_get_name(const struct fwnode_handle *fwnode, char *buf, size_t len)
+{
+	const char *name;
+	int ret;
+
+	ret = fwnode_call_int_op(fwnode, get_name, buf, len);
+	if (ret == 0 || ret == -EOVERFLOW)
+		return ret;
+
+	ret = fwnode_call_int_op(fwnode, property_read_string_array,
+				 "name", &name, 1);
+	if (ret)
+		return ret;
+
+	if (len < strlen(name) + 1)
+		return -EOVERFLOW;
+
+	sprintf(buf, "%s", name);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_name);
+
 /**
  * fwnode_device_is_available - check if a device is available for use
  * @fwnode: Pointer to the fwnode of the device.
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index faebf0ca0686..a211b55a5da1 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -52,6 +52,7 @@ struct fwnode_reference_args {
  * struct fwnode_operations - Operations for fwnode interface
  * @get: Get a reference to an fwnode.
  * @put: Put a reference to an fwnode.
+ * @get_name: Get the name of an fwnode
  * @device_get_match_data: Return the device driver match data.
  * @property_present: Return true if a property is present.
  * @property_read_integer_array: Read an array of integer properties. Return
@@ -72,6 +73,8 @@ struct fwnode_reference_args {
 struct fwnode_operations {
 	struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
 	void (*put)(struct fwnode_handle *fwnode);
+	int (*get_name)(const struct fwnode_handle *fwnode, char *buf,
+			size_t len);
 	bool (*device_is_available)(const struct fwnode_handle *fwnode);
 	const void *(*device_get_match_data)(const struct fwnode_handle *fwnode,
 					     const struct device *dev);
diff --git a/include/linux/property.h b/include/linux/property.h
index ac8a1ebc4c1b..e77f08f49c48 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -109,6 +109,8 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
 struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
+int fwnode_get_name(const struct fwnode_handle *fwnode, char *name, size_t len);
+
 int fwnode_irq_get(struct fwnode_handle *fwnode, unsigned int index);
 
 unsigned int device_get_child_node_count(struct device *dev);
-- 
2.19.2

