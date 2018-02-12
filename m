Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932574AbeBLVqQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 16:46:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:57543 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932204AbeBLVqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 16:46:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,504,1511856000";
   d="scan'208";a="174311121"
Subject: [PATCH v2] libnvdimm: re-enable deep flush for pmem devices
From: Dave Jiang <dave.jiang@intel.com>
To: dan.j.williams@intel.com
Cc: ross.zwisler@intel.com, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Date: Mon, 12 Feb 2018 14:46:13 -0700
Message-ID: <151847194459.58291.11339638808076622981.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-enable deep flush so that users always have a way to be sure that a write
does make it all the way out to the NVDIMM. The PMEM driver writes always
make it "all the way to the NVDIMM", and it relies on the ADR mechanism to
flush the write buffers on power failure. Deep flush is there to explicitly
flush those write buffers to protect against (rare) ADR failure.
This change prevents a regression in deep flush behavior so that applications
can continue to depend on fsync() as a mechanism to trigger deep flush in the
filesystem-dax case.

Fixes: 06e8ccdab15f4 ("acpi: nfit: Add support for detect platform CPU cache flush on power loss")

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v2: Updated commit patch header from Dan's comments.

 drivers/nvdimm/pmem.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 10041ac4032c..06f8dcc52ca6 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -335,8 +335,7 @@ static int pmem_attach_disk(struct device *dev,
 		dev_warn(dev, "unable to guarantee persistence of writes\n");
 		fua = 0;
 	}
-	wbc = nvdimm_has_cache(nd_region) &&
-		!test_bit(ND_REGION_PERSIST_CACHE, &nd_region->flags);
+	wbc = nvdimm_has_cache(nd_region);
 
 	if (!devm_request_mem_region(dev, res->start, resource_size(res),
 				dev_name(&ndns->dev))) {
