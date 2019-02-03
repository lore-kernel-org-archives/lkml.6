Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E996BC282D7
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 01:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0182084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 01:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfBCB0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 20:26:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:56672 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbfBCB0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 20:26:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Feb 2019 17:26:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,554,1539673200"; 
   d="scan'208";a="296831031"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005.jf.intel.com with ESMTP; 02 Feb 2019 17:26:02 -0800
Subject: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM family
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org
Date:   Sat, 02 Feb 2019 17:13:24 -0800
Message-ID: <154915640488.3541628.4947340559510114602.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Dexuan reports the NVDIMM_FAMILY_HYPERV platform is incompatible with
the existing Linux namespace implementation because it uses
NSLABEL_FLAG_LOCAL for x1-width PMEM interleave sets. Quirk it as an
platform / DIMM that does not provide BLK-aperture access. Allow the
libnvdimm core to assume no potential for aliasing. In case other
implementations make the same mistake, provide a "noblk" module
parameter to force-enable the quirk.

Link: https://lkml.kernel.org/r/PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
Reported-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c        |    4 ++++
 drivers/nvdimm/dimm_devs.c      |    7 ++++++-
 drivers/nvdimm/label.c          |    3 +++
 drivers/nvdimm/namespace_devs.c |    6 ++++++
 drivers/nvdimm/region_devs.c    |    7 +++++++
 include/linux/libnvdimm.h       |    2 ++
 6 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 4a7e8b1fa43b..811c399a3a76 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2016,6 +2016,10 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
 			cmd_mask |= nfit_mem->dsm_mask & NVDIMM_STANDARD_CMDMASK;
 		}
 
+		/* Quirk to ignore LOCAL for labels on HYPERV DIMMs */
+		if (nfit_mem->family == NVDIMM_FAMILY_HYPERV)
+			set_bit(NDD_NOBLK, &flags);
+
 		if (test_bit(NFIT_MEM_LSR, &nfit_mem->flags)) {
 			set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
 			set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 4890310df874..186d63f16434 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -11,6 +11,7 @@
  * General Public License for more details.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
 #include <linux/device.h>
 #include <linux/ndctl.h>
@@ -25,6 +26,10 @@
 
 static DEFINE_IDA(dimm_ida);
 
+static bool noblk;
+module_param(noblk, bool, 0444);
+MODULE_PARM_DESC(noblk, "force disable BLK / local alias support");
+
 /*
  * Retrieve bus and dimm handle and return if this bus supports
  * get_config_data commands
@@ -551,7 +556,7 @@ struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
 
 	nvdimm->dimm_id = dimm_id;
 	nvdimm->provider_data = provider_data;
-	nvdimm->flags = flags;
+	nvdimm->flags = flags | noblk ? (1 << NDD_NOBLK) : 0;
 	nvdimm->cmd_mask = cmd_mask;
 	nvdimm->num_flush = num_flush;
 	nvdimm->flush_wpq = flush_wpq;
diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index 6d6e9a12150b..f3d753d3169c 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -392,6 +392,7 @@ int nd_label_reserve_dpa(struct nvdimm_drvdata *ndd)
 		return 0; /* no label, nothing to reserve */
 
 	for_each_clear_bit_le(slot, free, nslot) {
+		struct nvdimm *nvdimm = to_nvdimm(ndd->dev);
 		struct nd_namespace_label *nd_label;
 		struct nd_region *nd_region = NULL;
 		u8 label_uuid[NSLABEL_UUID_LEN];
@@ -406,6 +407,8 @@ int nd_label_reserve_dpa(struct nvdimm_drvdata *ndd)
 
 		memcpy(label_uuid, nd_label->uuid, NSLABEL_UUID_LEN);
 		flags = __le32_to_cpu(nd_label->flags);
+		if (test_bit(NDD_NOBLK, &nvdimm->flags))
+			flags &= ~NSLABEL_FLAG_LOCAL;
 		nd_label_gen_id(&label_id, label_uuid, flags);
 		res = nvdimm_allocate_dpa(ndd, &label_id,
 				__le64_to_cpu(nd_label->dpa),
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 4b077555ac70..3677b0c4a33d 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -2492,6 +2492,12 @@ static int init_active_labels(struct nd_region *nd_region)
 			if (!label_ent)
 				break;
 			label = nd_label_active(ndd, j);
+			if (test_bit(NDD_NOBLK, &nvdimm->flags)) {
+				u32 flags = __le32_to_cpu(label->flags);
+
+				flags &= ~NSLABEL_FLAG_LOCAL;
+				label->flags = __cpu_to_le32(flags);
+			}
 			label_ent->label = label;
 
 			mutex_lock(&nd_mapping->lock);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index e2818f94f292..3b58baa44b5c 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1003,6 +1003,13 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 
 		if (test_bit(NDD_UNARMED, &nvdimm->flags))
 			ro = 1;
+
+		if (test_bit(NDD_NOBLK, &nvdimm->flags)
+				&& dev_type == &nd_blk_device_type) {
+			dev_err(&nvdimm_bus->dev, "%s: %s mapping%d is not BLK capable\n",
+					caller, dev_name(&nvdimm->dev), i);
+			return NULL;
+		}
 	}
 
 	if (dev_type == &nd_blk_device_type) {
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 5440f11b0907..7da406ae3a2b 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -42,6 +42,8 @@ enum {
 	NDD_SECURITY_OVERWRITE = 3,
 	/*  tracking whether or not there is a pending device reference */
 	NDD_WORK_PENDING = 4,
+	/* ignore / filter NSLABEL_FLAG_LOCAL for this DIMM, i.e. no aliasing */
+	NDD_NOBLK = 5,
 
 	/* need to set a limit somewhere, but yes, this is likely overkill */
 	ND_IOCTL_MAX_BUFLEN = SZ_4M,

