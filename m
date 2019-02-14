Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CE4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC47721B24
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503052AbfBNUWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:22:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:8476 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387849AbfBNUWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:22:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 12:22:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,369,1544515200"; 
   d="scan'208";a="133661265"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Feb 2019 12:22:54 -0800
Subject: [PATCH 2/6] nfit/ars: Attempt short-ARS even in the no_init_ars case
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Erwin Tsaur <erwin.tsaur@oracle.com>, vishal.l.verma@intel.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Feb 2019 12:10:16 -0800
Message-ID: <155017501600.944049.16981138728362610371.stgit@dwillia2-desk3.amr.corp.intel.com>
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

The no_init_ars option is meant to prevent long-ARS, but short-ARS
should be allowed to grab any immediate results.

Reported-by: Erwin Tsaur <erwin.tsaur@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 3d681a92ff7f..934be96dc149 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3004,11 +3004,12 @@ static int ars_register(struct acpi_nfit_desc *acpi_desc,
 {
 	int rc;
 
-	if (no_init_ars || test_bit(ARS_FAILED, &nfit_spa->ars_state))
+	if (test_bit(ARS_FAILED, &nfit_spa->ars_state))
 		return acpi_nfit_register_region(acpi_desc, nfit_spa);
 
 	set_bit(ARS_REQ_SHORT, &nfit_spa->ars_state);
-	set_bit(ARS_REQ_LONG, &nfit_spa->ars_state);
+	if (!no_init_ars)
+		set_bit(ARS_REQ_LONG, &nfit_spa->ars_state);
 
 	switch (acpi_nfit_query_poison(acpi_desc)) {
 	case 0:

