Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B707FC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91967218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfAYNPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:15:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:65210 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbfAYNPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:15:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 05:15:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,521,1539673200"; 
   d="scan'208";a="141284015"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2019 05:15:38 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] device connection: Find device connections also from device graphs
Date:   Fri, 25 Jan 2019 16:15:19 +0300
Message-Id: <20190125131519.88416-9-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
References: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
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
 drivers/base/devcon.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index 858b8d2f6ef8..1c20eceff2b0 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -7,10 +7,38 @@
  */
 
 #include <linux/device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
 
 static DEFINE_MUTEX(devcon_lock);
 static LIST_HEAD(devcon_list);
 
+typedef void *(*devcon_match_t)(struct device_connection *con, int ep,
+				void *data);
+
+static void *
+fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
+			  void *data, devcon_match_t match)
+{
+	struct device_connection con = { .id = con_id };
+	struct fwnode_handle *ep;
+	void *ret;
+
+	fwnode_graph_for_each_endpoint(fwnode, ep) {
+		con.fwnode = fwnode_graph_get_remote_port_parent(ep);
+		if (!fwnode_device_is_available(con.fwnode))
+			continue;
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
@@ -23,10 +51,9 @@ static LIST_HEAD(devcon_list);
  * caller is expecting to be returned.
  */
 void *device_connection_find_match(struct device *dev, const char *con_id,
-			       void *data,
-			       void *(*match)(struct device_connection *con,
-					      int ep, void *data))
+				   void *data, devcon_match_t match)
 {
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	const char *devname = dev_name(dev);
 	struct device_connection *con;
 	void *ret = NULL;
@@ -35,6 +62,12 @@ void *device_connection_find_match(struct device *dev, const char *con_id,
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
2.20.1

