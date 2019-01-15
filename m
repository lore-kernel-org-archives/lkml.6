Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF14C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A2B20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389810AbfAOUZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:25:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:26090 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732372AbfAOUZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:25:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2019 12:25:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,483,1539673200"; 
   d="scan'208";a="291801482"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005.jf.intel.com with ESMTP; 15 Jan 2019 12:25:47 -0800
Subject: [PATCH] libnvdimm/label: Clear 'updating' flag after label-set
 update
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     stable@vger.kernel.org, Kelly Couch <kelly.j.couch@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 15 Jan 2019 12:13:11 -0800
Message-ID: <154758319127.1865528.486579211628557163.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UEFI 2.7 specification sets expectations that the 'updating' flag is
eventually cleared. To date, the libnvdimm core has never adhered to
that protocol. The policy of the core matches the policy of other
multi-device info-block formats like MD-Software-RAID that expect
administrator intervention on inconsistent info-blocks, not automatic
invalidation.

However, some pre-boot environments may unfortunately attempt to "clean
up" the labels and invalidate a set when it fails to find at least one
"non-updating" label in the set. Clear the updating flag after set
updates to minimize the window of vulnerability to aggressive pre-boot
environments.

Ideally implementations would not write to the label area outside of
creating namespaces.

Note that this only minimizes the window, it does not close it as the
system can still crash while clearing the flag and the set can be
subsequently deleted / invalidated by the pre-boot environment.

Fixes: f524bf271a5c ("libnvdimm: write pmem label set")
Cc: <stable@vger.kernel.org>
Cc: Kelly Couch <kelly.j.couch@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/label.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index a11bf4e6b451..6d6e9a12150b 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -755,7 +755,7 @@ static const guid_t *to_abstraction_guid(enum nvdimm_claim_class claim_class,
 
 static int __pmem_label_update(struct nd_region *nd_region,
 		struct nd_mapping *nd_mapping, struct nd_namespace_pmem *nspm,
-		int pos)
+		int pos, unsigned long flags)
 {
 	struct nd_namespace_common *ndns = &nspm->nsio.common;
 	struct nd_interleave_set *nd_set = nd_region->nd_set;
@@ -796,7 +796,7 @@ static int __pmem_label_update(struct nd_region *nd_region,
 	memcpy(nd_label->uuid, nspm->uuid, NSLABEL_UUID_LEN);
 	if (nspm->alt_name)
 		memcpy(nd_label->name, nspm->alt_name, NSLABEL_NAME_LEN);
-	nd_label->flags = __cpu_to_le32(NSLABEL_FLAG_UPDATING);
+	nd_label->flags = __cpu_to_le32(flags);
 	nd_label->nlabel = __cpu_to_le16(nd_region->ndr_mappings);
 	nd_label->position = __cpu_to_le16(pos);
 	nd_label->isetcookie = __cpu_to_le64(cookie);
@@ -1249,13 +1249,13 @@ static int del_labels(struct nd_mapping *nd_mapping, u8 *uuid)
 int nd_pmem_namespace_label_update(struct nd_region *nd_region,
 		struct nd_namespace_pmem *nspm, resource_size_t size)
 {
-	int i;
+	int i, rc;
 
 	for (i = 0; i < nd_region->ndr_mappings; i++) {
 		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
 		struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
 		struct resource *res;
-		int rc, count = 0;
+		int count = 0;
 
 		if (size == 0) {
 			rc = del_labels(nd_mapping, nspm->uuid);
@@ -1273,7 +1273,20 @@ int nd_pmem_namespace_label_update(struct nd_region *nd_region,
 		if (rc < 0)
 			return rc;
 
-		rc = __pmem_label_update(nd_region, nd_mapping, nspm, i);
+		rc = __pmem_label_update(nd_region, nd_mapping, nspm, i,
+				NSLABEL_FLAG_UPDATING);
+		if (rc)
+			return rc;
+	}
+
+	if (size == 0)
+		return 0;
+
+	/* Clear the UPDATING flag per UEFI 2.7 expectations */
+	for (i = 0; i < nd_region->ndr_mappings; i++) {
+		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
+
+		rc = __pmem_label_update(nd_region, nd_mapping, nspm, i, 0);
 		if (rc)
 			return rc;
 	}

