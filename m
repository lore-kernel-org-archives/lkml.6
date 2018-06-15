Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 35C05C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC80208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC80208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965438AbeFOArZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 20:47:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:44122 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965325AbeFOArW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 20:47:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 17:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,225,1526367600"; 
   d="scan'208";a="64699726"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001.jf.intel.com with ESMTP; 14 Jun 2018 17:47:22 -0700
Subject: [PATCH 2/3] acpi,
 nfit: Prefer _DSM over _LSR for namespace label reads
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Jun 2018 17:37:25 -0700
Message-ID: <152902304504.10541.15111766266820956936.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152902303439.10541.13027910074116606464.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152902303439.10541.13027910074116606464.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _LSR method indicates locked status via error-code-3 returned in the
_LSR payload. When any error is returned the payload of _LSR is
truncated to a zero-length buffer.

The _DSM path in comparison allows system software to retrieve the
locked status *and* namespace label area contents.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index e2235ed3e4be..5ce3b0221073 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1694,7 +1694,7 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 {
 	struct acpi_device *adev, *adev_dimm;
 	struct device *dev = acpi_desc->dev;
-	unsigned long dsm_mask;
+	unsigned long dsm_mask, label_mask;
 	const guid_t *guid;
 	int i;
 	int family = -1;
@@ -1766,6 +1766,16 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 					1ULL << i))
 			set_bit(i, &nfit_mem->dsm_mask);
 
+	/*
+	 * Prefer the NVDIMM_FAMILY_INTEL label read commands if present
+	 * due to their better semantics handling locked capacity.
+	 */
+	label_mask = 1 << ND_CMD_GET_CONFIG_SIZE | 1 << ND_CMD_GET_CONFIG_DATA
+		| 1 << ND_CMD_SET_CONFIG_DATA;
+	if (family == NVDIMM_FAMILY_INTEL
+			&& (dsm_mask & label_mask) == label_mask)
+		return 0;
+
 	if (acpi_nvdimm_has_method(adev_dimm, "_LSI")
 			&& acpi_nvdimm_has_method(adev_dimm, "_LSR")) {
 		dev_dbg(dev, "%s: has _LSR\n", dev_name(&adev_dimm->dev));

