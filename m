Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689E8C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F422148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfA2Fes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:34:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:60485 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfA2Fes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:34:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 21:34:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,536,1539673200"; 
   d="scan'208";a="120282711"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jan 2019 21:34:47 -0800
Subject: [PATCH] nfit: Fix nfit_intel_shutdown_status() command submission
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 28 Jan 2019 21:22:10 -0800
Message-ID: <154873933011.295327.10921465390915828081.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implementation is broken in all the ways the unit test did not touch:

1/ The local definition of in_buf and in_obj violated C99 initializer
   expectations for zeroing. By only initializing 2 out of the three
   struct members the compiler was free to zero-initialize the remaining
   entry even though the aliased location in the union was initialized.

2/ The implementation made assumptions about the state of the 'smart'
   payload after command execution that are satisfied by
   acpi_nfit_ctl(), but not acpi_evaluate_dsm().

3/ populate_shutdown_status() is skipped on Intel NVDIMMs due to the early
   return for skipping the common _LS{I,R,W} enabling.

4/ The input length should be zero.

This breakage was missed due to the unit test implementation only
testing the case where nfit_intel_shutdown_status() returns a valid
payload.

Much of this complexity would be saved if acpi_nfit_ctl() could be used, but
that currently requires a 'struct nvdimm *' argument and one is not created
until later in the init process. The health result is needed before the device
is created because the payload gates whether the nmemX/nfit/dirty_shutdown
property is visible in sysfs.

Cc: <stable@vger.kernel.org>
Fixes: 0ead11181fe0 ("acpi, nfit: Collect shutdown status")
Reported-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |   41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index e18ade5d74e9..0a49c57334cc 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1759,14 +1759,14 @@ static bool acpi_nvdimm_has_method(struct acpi_device *adev, char *method)
 
 __weak void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
 {
+	struct device *dev = &nfit_mem->adev->dev;
 	struct nd_intel_smart smart = { 0 };
 	union acpi_object in_buf = {
-		.type = ACPI_TYPE_BUFFER,
-		.buffer.pointer = (char *) &smart,
-		.buffer.length = sizeof(smart),
+		.buffer.type = ACPI_TYPE_BUFFER,
+		.buffer.length = 0,
 	};
 	union acpi_object in_obj = {
-		.type = ACPI_TYPE_PACKAGE,
+		.package.type = ACPI_TYPE_PACKAGE,
 		.package.count = 1,
 		.package.elements = &in_buf,
 	};
@@ -1781,8 +1781,15 @@ __weak void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
 		return;
 
 	out_obj = acpi_evaluate_dsm(handle, guid, revid, func, &in_obj);
-	if (!out_obj)
+	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER
+			|| out_obj->buffer.length < sizeof(smart)) {
+		dev_dbg(dev->parent, "%s: failed to retrieve initial health\n",
+				dev_name(dev));
+		ACPI_FREE(out_obj);
 		return;
+	}
+	memcpy(&smart, out_obj->buffer.pointer, sizeof(smart));
+	ACPI_FREE(out_obj);
 
 	if (smart.flags & ND_INTEL_SMART_SHUTDOWN_VALID) {
 		if (smart.shutdown_state)
@@ -1793,7 +1800,6 @@ __weak void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
 		set_bit(NFIT_MEM_DIRTY_COUNT, &nfit_mem->flags);
 		nfit_mem->dirty_shutdown = smart.shutdown_count;
 	}
-	ACPI_FREE(out_obj);
 }
 
 static void populate_shutdown_status(struct nfit_mem *nfit_mem)
@@ -1915,18 +1921,19 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 		| 1 << ND_CMD_SET_CONFIG_DATA;
 	if (family == NVDIMM_FAMILY_INTEL
 			&& (dsm_mask & label_mask) == label_mask)
-		return 0;
-
-	if (acpi_nvdimm_has_method(adev_dimm, "_LSI")
-			&& acpi_nvdimm_has_method(adev_dimm, "_LSR")) {
-		dev_dbg(dev, "%s: has _LSR\n", dev_name(&adev_dimm->dev));
-		set_bit(NFIT_MEM_LSR, &nfit_mem->flags);
-	}
+		/* skip _LS{I,R,W} enabling */;
+	else {
+		if (acpi_nvdimm_has_method(adev_dimm, "_LSI")
+				&& acpi_nvdimm_has_method(adev_dimm, "_LSR")) {
+			dev_dbg(dev, "%s: has _LSR\n", dev_name(&adev_dimm->dev));
+			set_bit(NFIT_MEM_LSR, &nfit_mem->flags);
+		}
 
-	if (test_bit(NFIT_MEM_LSR, &nfit_mem->flags)
-			&& acpi_nvdimm_has_method(adev_dimm, "_LSW")) {
-		dev_dbg(dev, "%s: has _LSW\n", dev_name(&adev_dimm->dev));
-		set_bit(NFIT_MEM_LSW, &nfit_mem->flags);
+		if (test_bit(NFIT_MEM_LSR, &nfit_mem->flags)
+				&& acpi_nvdimm_has_method(adev_dimm, "_LSW")) {
+			dev_dbg(dev, "%s: has _LSW\n", dev_name(&adev_dimm->dev));
+			set_bit(NFIT_MEM_LSW, &nfit_mem->flags);
+		}
 	}
 
 	populate_shutdown_status(nfit_mem);

