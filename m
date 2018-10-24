Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB50C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8F62075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8F62075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeJXXeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:34:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:34388 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeJXXd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:33:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 08:05:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,420,1534834800"; 
   d="scan'208";a="102104679"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2018 08:05:30 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/5] usb: typec: mux: Find the muxes by also matching against the device node
Date:   Wed, 24 Oct 2018 18:05:22 +0300
Message-Id: <20181024150525.11552-3-heikki.krogerus@linux.intel.com>
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
 drivers/usb/typec/mux.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index d990aa510fab..161a96280296 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/property.h>
 #include <linux/usb/typec_mux.h>
 
 static DEFINE_MUTEX(switch_lock);
@@ -23,9 +24,14 @@ static void *typec_switch_match(struct device_connection *con, int ep,
 {
 	struct typec_switch *sw;
 
-	list_for_each_entry(sw, &switch_list, entry)
-		if (!strcmp(con->endpoint[ep], dev_name(sw->dev)))
+	list_for_each_entry(sw, &switch_list, entry) {
+		if (con->fwnode) {
+			if (dev_fwnode(sw->dev) == con->fwnode)
+				return sw;
+		} else if (!strcmp(con->endpoint[ep], dev_name(sw->dev))) {
 			return sw;
+		}
+	}
 
 	/*
 	 * We only get called if a connection was found, tell the caller to
@@ -114,9 +120,14 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 {
 	struct typec_mux *mux;
 
-	list_for_each_entry(mux, &mux_list, entry)
-		if (!strcmp(con->endpoint[ep], dev_name(mux->dev)))
+	list_for_each_entry(mux, &mux_list, entry) {
+		if (con->fwnode) {
+			if (dev_fwnode(mux->dev) == con->fwnode)
+				return mux;
+		} else if (!strcmp(con->endpoint[ep], dev_name(mux->dev))) {
 			return mux;
+		}
+	}
 
 	/*
 	 * We only get called if a connection was found, tell the caller to
-- 
2.19.1

