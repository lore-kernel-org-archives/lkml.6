Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87873C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE192084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfBYIRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:17:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:19944 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfBYIRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:17:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 00:16:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,410,1544515200"; 
   d="scan'208";a="149703390"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2019 00:16:57 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: bus: move hw module get/put to probe/release
Date:   Mon, 25 Feb 2019 11:09:28 +0200
Message-Id: <20190225090928.8715-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Fix unbalanced module reference counting during internal reset, which
prevents the drivers unloading.
Tracking mei_me/txe modules on mei client bus via
mei_cldev_enable/disable is error prone due to possible internal
reset flow, where clients are disconnected underneath.
Moving reference counting to probe and release of mei bus client
driver solves this issue in simplest way, as each client provides only
a single connection to a client bus driver.

Cc: <stable@vger.kernel.org>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index e5456faf00e6..65bec998eb6e 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -540,17 +540,9 @@ int mei_cldev_enable(struct mei_cl_device *cldev)
 		goto out;
 	}
 
-	if (!mei_cl_bus_module_get(cldev)) {
-		dev_err(&cldev->dev, "get hw module failed");
-		ret = -ENODEV;
-		goto out;
-	}
-
 	ret = mei_cl_connect(cl, cldev->me_cl, NULL);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(&cldev->dev, "cannot connect\n");
-		mei_cl_bus_module_put(cldev);
-	}
 
 out:
 	mutex_unlock(&bus->device_lock);
@@ -613,7 +605,6 @@ int mei_cldev_disable(struct mei_cl_device *cldev)
 	if (err < 0)
 		dev_err(bus->dev, "Could not disconnect from the ME client\n");
 
-	mei_cl_bus_module_put(cldev);
 out:
 	/* Flush queues and remove any pending read */
 	mei_cl_flush_queues(cl, NULL);
@@ -724,9 +715,16 @@ static int mei_cl_device_probe(struct device *dev)
 	if (!id)
 		return -ENODEV;
 
+	if (!mei_cl_bus_module_get(cldev)) {
+		dev_err(&cldev->dev, "get hw module failed");
+		return -ENODEV;
+	}
+
 	ret = cldrv->probe(cldev, id);
-	if (ret)
+	if (ret) {
+		mei_cl_bus_module_put(cldev);
 		return ret;
+	}
 
 	__module_get(THIS_MODULE);
 	return 0;
@@ -754,6 +752,7 @@ static int mei_cl_device_remove(struct device *dev)
 
 	mei_cldev_unregister_callbacks(cldev);
 
+	mei_cl_bus_module_put(cldev);
 	module_put(THIS_MODULE);
 	dev->driver = NULL;
 	return ret;
-- 
2.20.1

