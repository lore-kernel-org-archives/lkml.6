Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeFCUFd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 16:05:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:21546 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbeFCUFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 16:05:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,473,1520924400";
   d="scan'208";a="44960855"
Subject: [PATCH] acpi, nfit: Remove ecc_unit_size
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 03 Jun 2018 12:55:34 -0700
Message-ID: <152805573421.36904.10280982218277525255.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "Clear Error Unit" may be smaller than the ECC unit size on some
devices. For example, poison may be tracked at 64-byte alignment even
though the ECC unit is larger. Unless / until the ACPI specification
provides a non-ambiguous way to communicate this property do not expose
this to userspace.

Software that had been using this property must already be prepared for
the case where the property is not provided on older kernels, so it is
safe to remove this attribute.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/removed/sysfs-bus-nfit |   17 +++++++++++++++++
 Documentation/ABI/testing/sysfs-bus-nfit |   19 -------------------
 drivers/acpi/nfit/core.c                 |   11 -----------
 3 files changed, 17 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-bus-nfit

diff --git a/Documentation/ABI/removed/sysfs-bus-nfit b/Documentation/ABI/removed/sysfs-bus-nfit
new file mode 100644
index 000000000000..ae8c1ca53828
--- /dev/null
+++ b/Documentation/ABI/removed/sysfs-bus-nfit
@@ -0,0 +1,17 @@
+What:		/sys/bus/nd/devices/regionX/nfit/ecc_unit_size
+Date:		Aug, 2017
+KernelVersion:	v4.14 (Removed v4.18)
+Contact:	linux-nvdimm@lists.01.org
+Description:
+		(RO) Size of a write request to a DIMM that will not incur a
+		read-modify-write cycle at the memory controller.
+
+		When the nfit driver initializes it runs an ARS (Address Range
+		Scrub) operation across every pmem range. Part of that process
+		involves determining the ARS capabilities of a given address
+		range. One of the capabilities that is reported is the 'Clear
+		Uncorrectable Error Range Length Unit Size' (see: ACPI 6.2
+		section 9.20.7.4 Function Index 1 - Query ARS Capabilities).
+		This property indicates the boundary at which the NVDIMM may
+		need to perform read-modify-write cycles to maintain ECC (Error
+		Correcting Code) blocks.
diff --git a/Documentation/ABI/testing/sysfs-bus-nfit b/Documentation/ABI/testing/sysfs-bus-nfit
index 619eb8ca0f99..a1cb44dcb908 100644
--- a/Documentation/ABI/testing/sysfs-bus-nfit
+++ b/Documentation/ABI/testing/sysfs-bus-nfit
@@ -212,22 +212,3 @@ Description:
 		range. Used by NVDIMM Region Mapping Structure to uniquely refer
 		to this structure. Value of 0 is reserved and not used as an
 		index.
-
-
-What:		/sys/bus/nd/devices/regionX/nfit/ecc_unit_size
-Date:		Aug, 2017
-KernelVersion:	v4.14
-Contact:	linux-nvdimm@lists.01.org
-Description:
-		(RO) Size of a write request to a DIMM that will not incur a
-		read-modify-write cycle at the memory controller.
-
-		When the nfit driver initializes it runs an ARS (Address Range
-		Scrub) operation across every pmem range. Part of that process
-		involves determining the ARS capabilities of a given address
-		range. One of the capabilities that is reported is the 'Clear
-		Uncorrectable Error Range Length Unit Size' (see: ACPI 6.2
-		section 9.20.7.4 Function Index 1 - Query ARS Capabilities).
-		This property indicates the boundary at which the NVDIMM may
-		need to perform read-modify-write cycles to maintain ECC (Error
-		Correcting Code) blocks.
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index e2235ed3e4be..b87252bf4571 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1978,19 +1978,8 @@ static ssize_t range_index_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(range_index);
 
-static ssize_t ecc_unit_size_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct nd_region *nd_region = to_nd_region(dev);
-	struct nfit_spa *nfit_spa = nd_region_provider_data(nd_region);
-
-	return sprintf(buf, "%d\n", nfit_spa->clear_err_unit);
-}
-static DEVICE_ATTR_RO(ecc_unit_size);
-
 static struct attribute *acpi_nfit_region_attributes[] = {
 	&dev_attr_range_index.attr,
-	&dev_attr_ecc_unit_size.attr,
 	NULL,
 };
 
