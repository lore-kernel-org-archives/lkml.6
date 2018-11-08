Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D16ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673CF20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673CF20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeKIC2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:28:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:6164 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbeKIC2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:28:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 08:52:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="scan'208";a="106431402"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Nov 2018 08:52:09 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 4/4] device property: Drop get_named_child_node callback
Date:   Thu,  8 Nov 2018 19:51:56 +0300
Message-Id: <20181108165156.60073-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
References: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using fwnode_get_name() in fwnode_get_named_child_node(),
get_named_child_node implementations become boilerplate.
Removing all of them.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/property.c | 20 +-------------------
 drivers/base/property.c |  9 ++++++++-
 drivers/of/property.c   | 15 ---------------
 include/linux/fwnode.h  |  3 ---
 4 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 5b4c659c95d4..03cb46018920 100644
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
@@ -1342,7 +1325,6 @@ acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 			acpi_fwnode_property_read_string_array,		\
 		.get_parent = acpi_node_get_parent,			\
 		.get_next_child_node = acpi_get_next_subnode,		\
-		.get_named_child_node = acpi_fwnode_get_named_child_node, \
 		.get_reference_args = acpi_fwnode_get_reference_args,	\
 		.graph_get_next_endpoint =				\
 			acpi_graph_get_next_endpoint,			\
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 4db710e2ce34..802f55f9fab9 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1111,7 +1111,14 @@ struct fwnode_handle *
 fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 			    const char *childname)
 {
-	return fwnode_call_ptr_op(fwnode, get_named_child_node, childname);
+	char name[FWNODE_NAME_MAX_SIZE];
+	struct fwnode_handle *child;
+
+	fwnode_for_each_child_node(fwnode, child)
+		if (!fwnode_get_name(child, name) &&
+		    !strcmp(name, childname))
+			return child;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(fwnode_get_named_child_node);
 
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 9bc8fe136fa3..34b157921568 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -895,20 +895,6 @@ of_fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
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
@@ -1005,7 +991,6 @@ const struct fwnode_operations of_fwnode_ops = {
 	.property_read_string_array = of_fwnode_property_read_string_array,
 	.get_parent = of_fwnode_get_parent,
 	.get_next_child_node = of_fwnode_get_next_child_node,
-	.get_named_child_node = of_fwnode_get_named_child_node,
 	.get_reference_args = of_fwnode_get_reference_args,
 	.graph_get_next_endpoint = of_fwnode_graph_get_next_endpoint,
 	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index cc234f5d2b40..45df74f91603 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -92,9 +92,6 @@ struct fwnode_operations {
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

