Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeCVEvc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 00:51:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:32738 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751291AbeCVEva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 00:51:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,342,1517904000";
   d="scan'208";a="210324753"
Subject: [PATCH] nfit: skip region registration for incomplete control
 regions
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, ross.zwisler@linux.intel.com,
        linux-kernel@vger.kernel.org
Date: Wed, 21 Mar 2018 21:42:24 -0700
Message-ID: <152169374458.19742.14326187212131249042.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per the ACPI specification the only functional purpose for a DIMM
Control Region to be mapped into the system physical address space, from
an OSPM perspective, is to support block-apertures. However, there are
some BIOSen that publish DIMM Control Region SPA entries for pre-boot
environment consumption.  Undo the kernel policy of generating disabled
'ndblk' regions when this configuration is detected.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 39ad06143e78..4530d89044db 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2578,7 +2578,7 @@ static int acpi_nfit_init_mapping(struct acpi_nfit_desc *acpi_desc,
 	struct acpi_nfit_system_address *spa = nfit_spa->spa;
 	struct nd_blk_region_desc *ndbr_desc;
 	struct nfit_mem *nfit_mem;
-	int blk_valid = 0, rc;
+	int rc;
 
 	if (!nvdimm) {
 		dev_err(acpi_desc->dev, "spa%d dimm: %#x not found\n",
@@ -2598,15 +2598,14 @@ static int acpi_nfit_init_mapping(struct acpi_nfit_desc *acpi_desc,
 		if (!nfit_mem || !nfit_mem->bdw) {
 			dev_dbg(acpi_desc->dev, "spa%d %s missing bdw\n",
 					spa->range_index, nvdimm_name(nvdimm));
-		} else {
-			mapping->size = nfit_mem->bdw->capacity;
-			mapping->start = nfit_mem->bdw->start_address;
-			ndr_desc->num_lanes = nfit_mem->bdw->windows;
-			blk_valid = 1;
+			break;
 		}
 
+		mapping->size = nfit_mem->bdw->capacity;
+		mapping->start = nfit_mem->bdw->start_address;
+		ndr_desc->num_lanes = nfit_mem->bdw->windows;
 		ndr_desc->mapping = mapping;
-		ndr_desc->num_mappings = blk_valid;
+		ndr_desc->num_mappings = 1;
 		ndbr_desc = to_blk_region_desc(ndr_desc);
 		ndbr_desc->enable = acpi_nfit_blk_region_enable;
 		ndbr_desc->do_io = acpi_desc->blk_do_io;
