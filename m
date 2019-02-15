Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1DFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D16222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbfBOT4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:56:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:33226 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732725AbfBOT4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:56:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 11:56:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,373,1544515200"; 
   d="scan'208";a="118277815"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008.jf.intel.com with ESMTP; 15 Feb 2019 11:56:30 -0800
Subject: [PATCH v2 1/6] nfit/ars: Attempt a short-ARS whenever the ARS state
 is idle at boot
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Krzysztof Rusocki <krzysztof.rusocki@intel.com>,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Date:   Fri, 15 Feb 2019 11:43:52 -0800
Message-ID: <155025983247.1043225.5927153534700111609.stgit@dwillia2-desk3.amr.corp.intel.com>
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

If query-ARS reports that ARS has stopped and requires continuation
attempt to retrieve short-ARS results before continuing the long
operation.

Reported-by: Krzysztof Rusocki <krzysztof.rusocki@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index e18ade5d74e9..3d681a92ff7f 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3012,6 +3012,7 @@ static int ars_register(struct acpi_nfit_desc *acpi_desc,
 
 	switch (acpi_nfit_query_poison(acpi_desc)) {
 	case 0:
+	case -ENOSPC:
 	case -EAGAIN:
 		rc = ars_start(acpi_desc, nfit_spa, ARS_REQ_SHORT);
 		/* shouldn't happen, try again later */
@@ -3036,7 +3037,6 @@ static int ars_register(struct acpi_nfit_desc *acpi_desc,
 		break;
 	case -EBUSY:
 	case -ENOMEM:
-	case -ENOSPC:
 		/*
 		 * BIOS was using ARS, wait for it to complete (or
 		 * resources to become available) and then perform our

