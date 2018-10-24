Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE33C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB792075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB792075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbeJXXeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:34:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:34388 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeJXXeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:34:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 08:05:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,420,1534834800"; 
   d="scan'208";a="102104720"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2018 08:05:34 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/5] usb: typec: Find the ports by also matching against the device node
Date:   Wed, 24 Oct 2018 18:05:24 +0300
Message-Id: <20181024150525.11552-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181024150525.11552-1-heikki.krogerus@linux.intel.com>
References: <20181024150525.11552-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the connections are defined in firmware, struct
device_connection will have the fwnode member pointing to
the device node (struct fwnode_handle) of the requested
device, and the endpoint will not be used at all in that
case.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/class.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 5db0593ca0bd..fe6f3a932a88 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -204,15 +204,28 @@ static void typec_altmode_put_partner(struct altmode *altmode)
 	put_device(&adev->dev);
 }
 
-static int __typec_port_match(struct device *dev, const void *name)
+static int typec_port_fwnode_match(struct device *dev, const void *fwnode)
+{
+	return dev_name(fwnode) == fwnode;
+}
+
+static int typec_port_name_match(struct device *dev, const void *name)
 {
 	return !strcmp((const char *)name, dev_name(dev));
 }
 
 static void *typec_port_match(struct device_connection *con, int ep, void *data)
 {
-	return class_find_device(typec_class, NULL, con->endpoint[ep],
-				 __typec_port_match);
+	struct device *dev;
+
+	if (con->fwnode)
+		dev = class_find_device(typec_class, NULL, con->fwnode,
+					typec_port_fwnode_match);
+	else
+		dev = class_find_device(typec_class, NULL, con->endpoint[ep],
+					typec_port_name_match);
+
+	return dev ? dev : ERR_PTR(-EPROBE_DEFER);
 }
 
 struct typec_altmode *
-- 
2.19.1

