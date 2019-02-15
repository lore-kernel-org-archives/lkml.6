Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE16C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577D2222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbfBOT45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:56:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:36548 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfBOT45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:56:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 11:56:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,373,1544515200"; 
   d="scan'208";a="116562696"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2019 11:56:56 -0800
Subject: [PATCH v2 6/6] nfit/ars: Avoid stale ARS results
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Krzysztof Rusocki <krzysztof.rusocki@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 15 Feb 2019 11:44:18 -0800
Message-ID: <155025985870.1043225.8854289247736261912.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155025982726.1043225.15436410616433285475.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155025982726.1043225.15436410616433285475.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gate ARS result consumption on whether the OS issued start-ARS since the
previous consumption. The BIOS may only clear its result buffers after a
successful start-ARS.

Reported-by: Krzysztof Rusocki <krzysztof.rusocki@intel.com>
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |   17 ++++++++++++++++-
 drivers/acpi/nfit/nfit.h |    1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 629cf91649d2..5c9eb8d700d3 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2652,7 +2652,10 @@ static int ars_start(struct acpi_nfit_desc *acpi_desc,
 
 	if (rc < 0)
 		return rc;
-	return cmd_rc;
+	if (cmd_rc < 0)
+		return cmd_rc;
+	set_bit(ARS_VALID, &acpi_desc->scrub_flags);
+	return 0;
 }
 
 static int ars_continue(struct acpi_nfit_desc *acpi_desc)
@@ -2745,6 +2748,17 @@ static int ars_status_process_records(struct acpi_nfit_desc *acpi_desc)
 	 */
 	if (ars_status->out_length < 44)
 		return 0;
+
+	/*
+	 * Ignore potentially stale results that are only refreshed
+	 * after a start-ARS event.
+	 */
+	if (!test_and_clear_bit(ARS_VALID, &acpi_desc->scrub_flags)) {
+		dev_dbg(acpi_desc->dev, "skip %d stale records\n",
+				ars_status->num_records);
+		return 0;
+	}
+
 	for (i = 0; i < ars_status->num_records; i++) {
 		/* only process full records */
 		if (ars_status->out_length
@@ -3229,6 +3243,7 @@ static int acpi_nfit_register_regions(struct acpi_nfit_desc *acpi_desc)
 	struct nfit_spa *nfit_spa;
 	int rc;
 
+	set_bit(ARS_VALID, &acpi_desc->scrub_flags);
 	list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
 		switch (nfit_spa_type(nfit_spa->spa)) {
 		case NFIT_SPA_VOLATILE:
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index d14bad687fb8..0cbe5009eb2c 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -213,6 +213,7 @@ struct nfit_mem {
 enum scrub_flags {
 	ARS_BUSY,
 	ARS_CANCEL,
+	ARS_VALID,
 	ARS_POLL,
 };
 

