Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C65C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75348222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbfBMCDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:03:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:41541 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfBMCDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:03:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 18:03:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,364,1544515200"; 
   d="scan'208";a="146364507"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2019 18:03:33 -0800
Subject: [PATCH v2] device-dax: Auto-bind device after successful new_id
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Feb 2019 17:50:55 -0800
Message-ID: <155002261877.645460.9109209504128012410.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The typical 'new_id' attribute behavior is to immediately attach a
device to its driver after a new device-id is added. Implement this
behavior for the dax bus.

Reported-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v1:
* Fix the remove_id path since do_id_store() is shared with the new_id
  path (Brice)

Brice, this works for me. I'll push it out on libnvdimm-pending, or in
the meantime you can apply this patch after reverting commit
a9f1ffdb6a20 on the current state of the branch.

 drivers/dax/bus.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index c620ad52d7e5..a410154d75fb 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -57,8 +57,13 @@ static int dax_match_id(struct dax_device_driver *dax_drv, struct device *dev)
 	return match;
 }
 
+enum id_action {
+	ID_REMOVE,
+	ID_ADD,
+};
+
 static ssize_t do_id_store(struct device_driver *drv, const char *buf,
-		size_t count, bool add)
+		size_t count, enum id_action action)
 {
 	struct dax_device_driver *dax_drv = to_dax_drv(drv);
 	unsigned int region_id, id;
@@ -77,7 +82,7 @@ static ssize_t do_id_store(struct device_driver *drv, const char *buf,
 	mutex_lock(&dax_bus_lock);
 	dax_id = __dax_match_id(dax_drv, buf);
 	if (!dax_id) {
-		if (add) {
+		if (action == ID_ADD) {
 			dax_id = kzalloc(sizeof(*dax_id), GFP_KERNEL);
 			if (dax_id) {
 				strncpy(dax_id->dev_name, buf, DAX_NAME_LEN);
@@ -86,26 +91,33 @@ static ssize_t do_id_store(struct device_driver *drv, const char *buf,
 				rc = -ENOMEM;
 		} else
 			/* nothing to remove */;
-	} else if (!add) {
+	} else if (action == ID_REMOVE) {
 		list_del(&dax_id->list);
 		kfree(dax_id);
 	} else
 		/* dax_id already added */;
 	mutex_unlock(&dax_bus_lock);
-	return rc;
+
+	if (rc < 0)
+		return rc;
+	if (action == ID_ADD)
+		rc = driver_attach(drv);
+	if (rc)
+		return rc;
+	return count;
 }
 
 static ssize_t new_id_store(struct device_driver *drv, const char *buf,
 		size_t count)
 {
-	return do_id_store(drv, buf, count, true);
+	return do_id_store(drv, buf, count, ID_ADD);
 }
 static DRIVER_ATTR_WO(new_id);
 
 static ssize_t remove_id_store(struct device_driver *drv, const char *buf,
 		size_t count)
 {
-	return do_id_store(drv, buf, count, false);
+	return do_id_store(drv, buf, count, ID_REMOVE);
 }
 static DRIVER_ATTR_WO(remove_id);
 

