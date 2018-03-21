Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeCUEc3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 00:32:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:24549 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751791AbeCUEc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 00:32:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,338,1517904000";
   d="scan'208";a="210012663"
Subject: [PATCH] libnvdimm, region: hide persistence_domain when unknown
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org
Date: Tue, 20 Mar 2018 21:23:21 -0700
Message-ID: <152160620119.29833.14356675736401790361.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to other region attributes, do not emit the persistence_domain
attribute if its contents are empty.

Fixes: 96c3a239054a ("libnvdimm: expose platform persistence attr...")
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/region_devs.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index e6d01911e092..a8e9d428c0a5 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -593,6 +593,13 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 			return 0;
 	}
 
+	if (a == &dev_attr_persistence_domain.attr) {
+		if ((nd_region->flags & (BIT(ND_REGION_PERSIST_CACHE)
+					| BIT(ND_REGION_PERSIST_MEMCTRL))) == 0)
+			return 0;
+		return a->mode;
+	}
+
 	if (a != &dev_attr_set_cookie.attr
 			&& a != &dev_attr_available_size.attr)
 		return a->mode;
