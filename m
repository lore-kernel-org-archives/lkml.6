Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD67C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A5420651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfAOCJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:09:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:37617 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbfAOCJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 21:09:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 18:09:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,480,1539673200"; 
   d="scan'208";a="126074521"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002.jf.intel.com with ESMTP; 14 Jan 2019 18:09:46 -0800
Subject: [PATCH v2 1/2] acpi/nfit: Block function zero DSMs
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     stable@vger.kernel.org, stuart hayes <stuart.w.hayes@gmail.com>,
        Jeff Moyer <jmoyer@redhat.com>, vishal.l.verma@intel.com,
        linux-kernel@vger.kernel.org, vishal.l.verma@intel.com
Date:   Mon, 14 Jan 2019 17:57:09 -0800
Message-ID: <154751742931.1617064.12104834083206585656.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154751742416.1617064.8252289468130584022.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154751742416.1617064.8252289468130584022.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for using function number 0 as an error value, prevent it
from being considered a valid function value by acpi_nfit_ctl().

Cc: <stable@vger.kernel.org>
Cc: stuart hayes <stuart.w.hayes@gmail.com>
Fixes: e02fb7264d8a ("nfit: add Microsoft NVDIMM DSM command set...")
Reported-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 790691d9a982..67aef1a793d5 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1867,6 +1867,13 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 		return 0;
 	}
 
+	/*
+	 * Function 0 is the command interrogation function, don't
+	 * export it to potential userspace use, and enable it to be
+	 * used as an error value in acpi_nfit_ctl().
+	 */
+	dsm_mask &= ~1UL;
+
 	guid = to_nfit_uuid(nfit_mem->family);
 	for_each_set_bit(i, &dsm_mask, BITS_PER_LONG)
 		if (acpi_check_dsm(adev_dimm->handle, guid,

