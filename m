Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C17BC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8497222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404034AbfBMLz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:55:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:23378 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388245AbfBMLzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:55:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 03:55:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="146481610"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2019 03:55:49 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] software node: Implement get_named_child_node fwnode callback
Date:   Wed, 13 Feb 2019 14:55:49 +0300
Message-Id: <20190213115549.81917-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it possible to support drivers that use
fwnode_get_named_child_node() and device_get_named_child_node()
functions.

The node name is for now taken from a device property named
"name". That mimics the old style of naming of the nodes in
devicetree (though with modern flattened DT, the name is
matched against the actual node-name, it used to be done
with a property "name"). In Open Firmware DT the "name"
property is also still being used.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 89ad8dee6ad5..1fad9291f6aa 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -499,6 +499,28 @@ software_node_get_next_child(const struct fwnode_handle *fwnode,
 	return &c->fwnode;
 }
 
+static struct fwnode_handle *
+software_node_get_named_child_node(const struct fwnode_handle *fwnode,
+				   const char *childname)
+{
+	struct software_node *swnode = to_software_node(fwnode);
+	const struct property_entry *prop;
+	struct software_node *child;
+
+	if (!swnode || list_empty(&swnode->children))
+		return NULL;
+
+	list_for_each_entry(child, &swnode->children, entry) {
+		prop = property_entry_get(child->properties, "name");
+		if (!prop)
+			continue;
+		if (!strcmp(childname, prop->value.str)) {
+			kobject_get(&child->kobj);
+			return &child->fwnode;
+		}
+	}
+	return NULL;
+}
 
 static const struct fwnode_operations software_node_ops = {
 	.get = software_node_get,
@@ -508,6 +530,7 @@ static const struct fwnode_operations software_node_ops = {
 	.property_read_string_array = software_node_read_string_array,
 	.get_parent = software_node_get_parent,
 	.get_next_child_node = software_node_get_next_child,
+	.get_named_child_node = software_node_get_named_child_node,
 };
 
 /* -------------------------------------------------------------------------- */
-- 
2.20.1

