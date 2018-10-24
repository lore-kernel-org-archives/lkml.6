Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8A2C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A622075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A622075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeJXXeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:34:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:34388 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeJXXeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:34:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 08:05:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,420,1534834800"; 
   d="scan'208";a="102104730"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2018 08:05:36 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/5] drivers core: Find device connections also from device graphs
Date:   Wed, 24 Oct 2018 18:05:25 +0300
Message-Id: <20181024150525.11552-6-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181024150525.11552-1-heikki.krogerus@linux.intel.com>
References: <20181024150525.11552-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If connections between devices are described in OF graph or
ACPI device graph, we can find them by using the
fwnode_graph_*() functions.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/devcon.c | 48 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index d427e806cd73..9c446ef84dd1 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -7,10 +7,45 @@
  */
 
 #include <linux/device.h>
+#include <linux/property.h>
 
 static DEFINE_MUTEX(devcon_lock);
 static LIST_HEAD(devcon_list);
 
+static void *
+fwnode_graph_devcon_match(struct fwnode_handle *fwnode,
+			  const char *con_id, void *data,
+			  void *(*match)(struct device_connection *con,
+					 int ep, void *data))
+{
+	struct device_connection con = { .id = con_id };
+	struct fwnode_handle *ep;
+	const char *val;
+	void *ret;
+	int err;
+
+	fwnode_graph_for_each_endpoint(fwnode, ep) {
+		con.fwnode = fwnode_graph_get_remote_port_parent(ep);
+
+		if (con_id) {
+			err = fwnode_property_read_string(con.fwnode, "name",
+							  &val);
+			if (err || strcmp(con_id, val)) {
+				fwnode_handle_put(con.fwnode);
+				continue;
+			}
+		}
+
+		ret = match(&con, -1, data);
+		fwnode_handle_put(con.fwnode);
+		if (ret) {
+			fwnode_handle_put(ep);
+			return ret;
+		}
+	}
+	return NULL;
+}
+
 /**
  * device_connection_find_match - Find physical connection to a device
  * @dev: Device with the connection
@@ -23,10 +58,11 @@ static LIST_HEAD(devcon_list);
  * caller is expecting to be returned.
  */
 void *device_connection_find_match(struct device *dev, const char *con_id,
-			       void *data,
-			       void *(*match)(struct device_connection *con,
-					      int ep, void *data))
+				   void *data,
+				   void *(*match)(struct device_connection *con,
+						  int ep, void *data))
 {
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	const char *devname = dev_name(dev);
 	struct device_connection *con;
 	void *ret = NULL;
@@ -35,6 +71,12 @@ void *device_connection_find_match(struct device *dev, const char *con_id,
 	if (!match)
 		return NULL;
 
+	if (fwnode) {
+		ret = fwnode_graph_devcon_match(fwnode, con_id, data, match);
+		if (ret)
+			return ret;
+	}
+
 	mutex_lock(&devcon_lock);
 
 	list_for_each_entry(con, &devcon_list, list) {
-- 
2.19.1

