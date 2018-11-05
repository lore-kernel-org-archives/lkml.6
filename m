Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60ADC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7174120862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7174120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbeKESgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:36:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:34873 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbeKESgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:36:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 01:17:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="105337708"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Nov 2018 01:17:36 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 4/4] device property: Drop get_named_child_node callback
Date:   Mon,  5 Nov 2018 12:17:27 +0300
Message-Id: <20181105091727.25544-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using fwnode_name() in fwnode_get_named_child_node(),
get_named_child_node implementations become boilerplate.
Removing all of them.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/property.c | 20 +-------------------
 drivers/base/property.c | 10 +++++++++-
 drivers/of/property.c   | 15 ---------------
 include/linux/fwnode.h  |  3 ---
 4 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 75854e07ed64..6c38cd73e4c0 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -587,23 +587,6 @@ static int acpi_data_get_property_array(const struct acpi_device_data *data,
 	return 0;
 }
 
-static struct fwnode_handle *
-acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
-				 const char *childname)
-{
-	struct fwnode_handle *child;
-
-	/*
-	 * Find first matching named child node of this fwnode.
-	 * For ACPI this will be a data only sub-node.
-	 */
-	fwnode_for_each_child_node(fwnode, child)
-		if (acpi_data_node_match(child, childname))
-			return child;
-
-	return NULL;
-}
-
 /**
  * __acpi_node_get_property_reference - returns handle to the referenced object
  * @fwnode: Firmware node to get the property from
@@ -712,7 +695,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 			for (ref_fwnode = acpi_fwnode_handle(device);
 			     element < end && element->type == ACPI_TYPE_STRING;
 			     element++) {
-				ref_fwnode = acpi_fwnode_get_named_child_node(
+				ref_fwnode = fwnode_get_named_child_node(
 					ref_fwnode, element->string.pointer);
 				if (!ref_fwnode)
 					return -EINVAL;
@@ -1325,7 +1308,6 @@ acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 			acpi_fwnode_property_read_string_array,		\
 		.get_parent = acpi_node_get_parent,			\
 		.get_next_child_node = acpi_get_next_subnode,		\
-		.get_named_child_node = acpi_fwnode_get_named_child_node, \
 		.get_reference_args = acpi_fwnode_get_reference_args,	\
 		.graph_get_next_endpoint =				\
 			acpi_graph_get_next_endpoint,			\
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 1e4eb7ab2b84..06ba83d73517 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1111,7 +1111,15 @@ struct fwnode_handle *
 fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 			    const char *childname)
 {
-	return fwnode_call_ptr_op(fwnode, get_named_child_node, childname);
+	struct fwnode_handle *child;
+	const char *name;
+
+	fwnode_for_each_child_node(fwnode, child) {
+		name = fwnode_name(child);
+		if (name && !strcasecmp(name, childname))
+			return child;
+	}
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(fwnode_get_named_child_node);
 
diff --git a/drivers/of/property.c b/drivers/of/property.c
index ac7b0b6c2d4d..60b590fc5b99 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -890,20 +890,6 @@ of_fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 							    to_of_node(child)));
 }
 
-static struct fwnode_handle *
-of_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
-			       const char *childname)
-{
-	const struct device_node *node = to_of_node(fwnode);
-	struct device_node *child;
-
-	for_each_available_child_of_node(node, child)
-		if (!of_node_cmp(child->name, childname))
-			return of_fwnode_handle(child);
-
-	return NULL;
-}
-
 static int
 of_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 			     const char *prop, const char *nargs_prop,
@@ -1000,7 +986,6 @@ const struct fwnode_operations of_fwnode_ops = {
 	.property_read_string_array = of_fwnode_property_read_string_array,
 	.get_parent = of_fwnode_get_parent,
 	.get_next_child_node = of_fwnode_get_next_child_node,
-	.get_named_child_node = of_fwnode_get_named_child_node,
 	.get_reference_args = of_fwnode_get_reference_args,
 	.graph_get_next_endpoint = of_fwnode_graph_get_next_endpoint,
 	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 2e445fed4df4..83f8ec3754d0 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -90,9 +90,6 @@ struct fwnode_operations {
 	struct fwnode_handle *
 	(*get_next_child_node)(const struct fwnode_handle *fwnode,
 			       struct fwnode_handle *child);
-	struct fwnode_handle *
-	(*get_named_child_node)(const struct fwnode_handle *fwnode,
-				const char *name);
 	int (*get_reference_args)(const struct fwnode_handle *fwnode,
 				  const char *prop, const char *nargs_prop,
 				  unsigned int nargs, unsigned int index,
-- 
2.19.1

