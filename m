Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeBWVOV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:14:21 -0500
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:42048 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeBWVOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:14:18 -0500
From: Toshi Kani <toshi.kani@hpe.com>
To: dan.j.williams@intel.com
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH 2/2] libnvdimm, label: change nvdimm_num_label_slots per UEFI 2.7
Date: Fri, 23 Feb 2018 14:59:22 -0700
Message-Id: <20180223215922.25415-3-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180223215922.25415-1-toshi.kani@hpe.com>
References: <20180223215922.25415-1-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sizeof_namespace_index() fails when NVDIMM devices have the minimum
1024 bytes label storage area.  nvdimm_num_label_slots() returns 3
slots while the area is only big enough for 2 slots.

Change nvdimm_num_label_slots() to calculate a number of label slots
according to UEFI 2.7 spec.

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/label.c |   34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index de66c02f6140..be3ccf7c5413 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -45,9 +45,27 @@ unsigned sizeof_namespace_label(struct nvdimm_drvdata *ndd)
 	return ndd->nslabel_size;
 }
 
+static size_t __sizeof_namespace_index(u32 nslot)
+{
+	return ALIGN(sizeof(struct nd_namespace_index) + DIV_ROUND_UP(nslot, 8),
+			NSINDEX_ALIGN);
+}
+
+static int __nvdimm_num_label_slots(struct nvdimm_drvdata *ndd,
+		size_t index_size)
+{
+	return (ndd->nsarea.config_size - index_size * 2) /
+			sizeof_namespace_label(ndd);
+}
+
 int nvdimm_num_label_slots(struct nvdimm_drvdata *ndd)
 {
-	return ndd->nsarea.config_size / (sizeof_namespace_label(ndd) + 1);
+	u32 tmp_nslot, n;
+
+	tmp_nslot = ndd->nsarea.config_size / sizeof_namespace_label(ndd);
+	n = __sizeof_namespace_index(tmp_nslot) / NSINDEX_ALIGN;
+
+	return __nvdimm_num_label_slots(ndd, NSINDEX_ALIGN * n);
 }
 
 size_t sizeof_namespace_index(struct nvdimm_drvdata *ndd)
@@ -55,18 +73,14 @@ size_t sizeof_namespace_index(struct nvdimm_drvdata *ndd)
 	u32 nslot, space, size;
 
 	/*
-	 * The minimum index space is 512 bytes, with that amount of
-	 * index we can describe ~1400 labels which is less than a byte
-	 * of overhead per label.  Round up to a byte of overhead per
-	 * label and determine the size of the index region.  Yes, this
-	 * starts to waste space at larger config_sizes, but it's
-	 * unlikely we'll ever see anything but 128K.
+	 * Per UEFI 2.7, the minimum size of the Label Storage Area is large
+	 * enough to hold 2 index blocks and 2 labels.  The minimum index
+	 * block size is 256 bytes, and the minimum label size is 256 bytes.
 	 */
 	nslot = nvdimm_num_label_slots(ndd);
 	space = ndd->nsarea.config_size - nslot * sizeof_namespace_label(ndd);
-	size = ALIGN(sizeof(struct nd_namespace_index) + DIV_ROUND_UP(nslot, 8),
-			NSINDEX_ALIGN) * 2;
-	if (size <= space)
+	size = __sizeof_namespace_index(nslot) * 2;
+	if (size <= space && nslot >= 2)
 		return size / 2;
 
 	dev_err(ndd->dev, "label area (%d) too small to host (%d byte) labels\n",
