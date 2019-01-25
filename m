Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC210C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFE0218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfAYNPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:15:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:65210 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728740AbfAYNPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:15:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 05:15:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,521,1539673200"; 
   d="scan'208";a="141284005"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2019 05:15:36 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] device connection: Prepare support for firmware described connections
Date:   Fri, 25 Jan 2019 16:15:18 +0300
Message-Id: <20190125131519.88416-8-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
References: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the connections are defined in firmware, struct
device_connection will have the fwnode member pointing to
the device node (struct fwnode_handle) of the requested
device. The endpoint member for the device names will not be
used at all in that case.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/devcon.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index d427e806cd73..858b8d2f6ef8 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -75,12 +75,36 @@ static struct bus_type *generic_match_buses[] = {
 	NULL,
 };
 
+static int device_fwnode_match(struct device *dev, void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode;
+}
+
+static void *device_connection_fwnode_match(struct device_connection *con)
+{
+	struct bus_type *bus;
+	struct device *dev;
+
+	for (bus = generic_match_buses[0]; bus; bus++) {
+		dev = bus_find_device(bus, NULL, (void *)con->fwnode,
+				      device_fwnode_match);
+		if (dev && !strncmp(dev_name(dev), con->id, strlen(con->id)))
+			return dev;
+
+		put_device(dev);
+	}
+	return NULL;
+}
+
 /* This tries to find the device from the most common bus types by name. */
 static void *generic_match(struct device_connection *con, int ep, void *data)
 {
 	struct bus_type *bus;
 	struct device *dev;
 
+	if (con->fwnode)
+		return device_connection_fwnode_match(con);
+
 	for (bus = generic_match_buses[0]; bus; bus++) {
 		dev = bus_find_device_by_name(bus, NULL, con->endpoint[ep]);
 		if (dev)
-- 
2.20.1

