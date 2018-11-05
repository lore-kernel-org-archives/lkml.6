Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE409C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC53520862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC53520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbeKESgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:36:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:34873 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbeKESgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:36:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 01:17:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="105337698"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Nov 2018 01:17:30 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 1/4] device property: Introduce fwnode_name()
Date:   Mon,  5 Nov 2018 12:17:24 +0300
Message-Id: <20181105091727.25544-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
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

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/property.c  | 18 ++++++++++++++++++
 include/linux/fwnode.h   |  1 +
 include/linux/property.h |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 240ab5230ff6..1e4eb7ab2b84 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1156,6 +1156,24 @@ void fwnode_handle_put(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_handle_put);
 
+/**
+ * fwnode_name - Get the name of a device node
+ * @fwnode: Pointer to the device node.
+ *
+ * Returns the node name of @fwnode. If @fwnode does not have a "unit name",
+ * this code will also attempt to read a string property named "name".
+ */
+const char *fwnode_name(const struct fwnode_handle *fwnode)
+{
+	const char *name = fwnode_call_ptr_op(fwnode, name);
+
+	if (!name)
+		fwnode_call_int_op(fwnode, property_read_string_array,
+				   "name", &name, 1);
+	return name;
+}
+EXPORT_SYMBOL_GPL(fwnode_name);
+
 /**
  * fwnode_device_is_available - check if a device is available for use
  * @fwnode: Pointer to the fwnode of the device.
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index faebf0ca0686..2e445fed4df4 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -72,6 +72,7 @@ struct fwnode_reference_args {
 struct fwnode_operations {
 	struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
 	void (*put)(struct fwnode_handle *fwnode);
+	const char *(*name)(const struct fwnode_handle *fwnode);
 	bool (*device_is_available)(const struct fwnode_handle *fwnode);
 	const void *(*device_get_match_data)(const struct fwnode_handle *fwnode,
 					     const struct device *dev);
diff --git a/include/linux/property.h b/include/linux/property.h
index ac8a1ebc4c1b..44781d37dd96 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -109,6 +109,8 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
 struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
+const char *fwnode_name(const struct fwnode_handle *fwnode);
+
 int fwnode_irq_get(struct fwnode_handle *fwnode, unsigned int index);
 
 unsigned int device_get_child_node_count(struct device *dev);
-- 
2.19.1

