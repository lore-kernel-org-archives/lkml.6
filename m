Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBAFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8D3214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391202AbfAOWqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:46:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:2157 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391195AbfAOWqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:46:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2019 14:46:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,483,1539673200"; 
   d="scan'208";a="291833474"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005.jf.intel.com with ESMTP; 15 Jan 2019 14:46:38 -0800
Subject: [PATCH v3 1/2] acpi/nfit: Block function zero DSMs
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     stable@vger.kernel.org, stuart hayes <stuart.w.hayes@gmail.com>,
        Jeff Moyer <jmoyer@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org,
        vishal.l.verma@intel.com
Date:   Tue, 15 Jan 2019 14:34:02 -0800
Message-ID: <154759164209.1953028.13765956293945097723.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154759163682.1953028.16995572958827750312.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154759163682.1953028.16995572958827750312.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 5143e11e3b0f..73281b19d3dd 100644
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

