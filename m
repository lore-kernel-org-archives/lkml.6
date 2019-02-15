Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F8EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF36222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733188AbfBOT4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:56:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:56580 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732893AbfBOT4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:56:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 11:56:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,373,1544515200"; 
   d="scan'208";a="115302176"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007.jf.intel.com with ESMTP; 15 Feb 2019 11:56:35 -0800
Subject: [PATCH v2 2/6] nfit/ars: Attempt short-ARS even in the no_init_ars
 case
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Erwin Tsaur <erwin.tsaur@oracle.com>, vishal.l.verma@intel.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 15 Feb 2019 11:43:57 -0800
Message-ID: <155025983758.1043225.7069046151889688538.stgit@dwillia2-desk3.amr.corp.intel.com>
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

