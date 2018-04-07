Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeDGP4N (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 11:56:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:57650 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752012AbeDGP4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 11:56:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,419,1517904000";
   d="scan'208";a="31800113"
Subject: [PATCH v3 3/3] nfit,
 address-range-scrub: add module option to skip initial ars
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Sat, 07 Apr 2018 08:46:07 -0700
Message-ID: <152311596756.35426.7076649397069507532.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152311595210.35426.13667585208560808244.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152311595210.35426.13667585208560808244.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After attempting to quickly retrieve known errors the kernel proceeds to
kick off a long running ARS. Add a module option to disable this
behavior at initialization time, or at new region discovery time.
Otherwise, ARS can be started manually regardless of the state of this
setting.

Co-developed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 2532294bbd68..7f3c70fde9a8 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -49,6 +49,10 @@ module_param(default_dsm_family, int, S_IRUGO);
 MODULE_PARM_DESC(default_dsm_family,
 		"Try this DSM type first when identifying NVDIMM family");
 
+static bool no_init_ars;
+module_param(no_init_ars, bool, 0644);
+MODULE_PARM_DESC(no_init_ars, "Skip ARS run at nfit init time");
+
 LIST_HEAD(acpi_descs);
 DEFINE_MUTEX(acpi_desc_lock);
 
@@ -2816,6 +2820,9 @@ static int ars_register(struct acpi_nfit_desc *acpi_desc, struct nfit_spa *nfit_
 {
 	int rc = *query_rc;
 
+	if (no_init_ars)
+		return acpi_nfit_register_region(acpi_desc, nfit_spa);
+
 	set_bit(ARS_REQ, &nfit_spa->ars_state);
 	set_bit(ARS_SHORT, &nfit_spa->ars_state);
 
