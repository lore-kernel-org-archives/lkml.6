Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D7EC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8493C20821
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfBCTl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 14:41:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:28844 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726577AbfBCTl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 14:41:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2019 11:41:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,557,1539673200"; 
   d="scan'208";a="112106341"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007.jf.intel.com with ESMTP; 03 Feb 2019 11:41:27 -0800
Subject: [PATCH] acpi/nfit: Require opt-in for read-only label configurations
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org
Date:   Sun, 03 Feb 2019 11:28:50 -0800
Message-ID: <154922213038.3561630.15221922065373676874.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <CAPcyv4iMau=fvOfubDvK=cg5v5287TvXqBCm=p8nqbz2es6YEg@mail.gmail.com>
References: <CAPcyv4iMau=fvOfubDvK=cg5v5287TvXqBCm=p8nqbz2es6YEg@mail.gmail.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent fixes to command handling enabled Linux to read label
configurations that it could not before. Unfortunately that means that
configurations that were operating in label-less mode will be broken as
the kernel ignores the existing namespace configuration and tries to
honor the new found labels.

Fortunately this seems limited to a case where Linux can quirk the
behavior and maintain the existing label-less semantics by default.
When the platform does not emit an _LSW method, disable all label access
methods. Provide a 'force_labels' module parameter to allow read-only
label operation.

Fixes: 11189c1089da ("acpi/nfit: Fix command-supported detection")
Reported-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 811c399a3a76..5b5e802de7b8 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -56,6 +56,10 @@ static bool no_init_ars;
 module_param(no_init_ars, bool, 0644);
 MODULE_PARM_DESC(no_init_ars, "Skip ARS run at nfit init time");
 
+static bool force_labels;
+module_param(force_labels, bool, 0444);
+MODULE_PARM_DESC(force_labels, "Opt-in to labels despite missing methods");
+
 LIST_HEAD(acpi_descs);
 DEFINE_MUTEX(acpi_desc_lock);
 
@@ -1916,6 +1920,19 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 			dev_dbg(dev, "%s: has _LSW\n", dev_name(&adev_dimm->dev));
 			set_bit(NFIT_MEM_LSW, &nfit_mem->flags);
 		}
+
+		/*
+		 * Quirk read-only label configurations to preserve
+		 * access to label-less namespaces by default.
+		 */
+		if (!test_bit(NFIT_MEM_LSW, &nfit_mem->flags)
+				&& !force_labels) {
+			dev_dbg(dev, "%s: No _LSW, disable labels\n",
+					dev_name(&adev_dimm->dev));
+			clear_bit(NFIT_MEM_LSR, &nfit_mem->flags);
+		} else
+			dev_dbg(dev, "%s: Force enable labels\n",
+					dev_name(&adev_dimm->dev));
 	}
 
 	populate_shutdown_status(nfit_mem);

