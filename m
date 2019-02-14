Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9927CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED1D2192B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503085AbfBNUXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:23:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:21968 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503068AbfBNUXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:23:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 12:23:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,369,1544515200"; 
   d="scan'208";a="134391702"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002.jf.intel.com with ESMTP; 14 Feb 2019 12:23:04 -0800
Subject: [PATCH 4/6] nfit/ars: Remove ars_start_flags
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Toshi Kani <toshi.kani@hpe.com>, vishal.l.verma@intel.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Feb 2019 12:10:27 -0800
Message-ID: <155017502692.944049.7590481780095660318.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155017500427.944049.2254497897075714747.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155017500427.944049.2254497897075714747.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ars_start_flags property of 'struct acpi_nfit_desc' is no longer
used since ARS_REQ_SHORT and ARS_REQ_LONG were added.

Cc: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |   10 +++++-----
 drivers/acpi/nfit/nfit.h |    1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 5ec0e19760ea..7086c193aa81 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2657,11 +2657,11 @@ static int ars_continue(struct acpi_nfit_desc *acpi_desc)
 	struct nvdimm_bus_descriptor *nd_desc = &acpi_desc->nd_desc;
 	struct nd_cmd_ars_status *ars_status = acpi_desc->ars_status;
 
-	memset(&ars_start, 0, sizeof(ars_start));
-	ars_start.address = ars_status->restart_address;
-	ars_start.length = ars_status->restart_length;
-	ars_start.type = ars_status->type;
-	ars_start.flags = acpi_desc->ars_start_flags;
+	ars_start = (struct nd_cmd_ars_start) {
+		.address = ars_status->restart_address,
+		.length = ars_status->restart_length,
+		.type = ars_status->type,
+	};
 	rc = nd_desc->ndctl(nd_desc, NULL, ND_CMD_ARS_START, &ars_start,
 			sizeof(ars_start), &cmd_rc);
 	if (rc < 0)
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 33691aecfcee..871fb3de3b30 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -223,7 +223,6 @@ struct acpi_nfit_desc {
 	struct list_head idts;
 	struct nvdimm_bus *nvdimm_bus;
 	struct device *dev;
-	u8 ars_start_flags;
 	struct nd_cmd_ars_status *ars_status;
 	struct nfit_spa *scrub_spa;
 	struct delayed_work dwork;

