Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34F9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87185206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87185206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbeGPRjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:39:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:43956 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728129AbeGPRjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:39:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 10:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,362,1526367600"; 
   d="scan'208";a="246149807"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jul 2018 10:11:01 -0700
Subject: [PATCH v2 08/14] tools/testing/nvdimm: Allow a NULL-pfn to
 ->direct_access()
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Huaisheng Ye <yehs1@lenovo.com>, Jan Kara <jack@suse.cz>,
        vishal.l.verma@intel.com, hch@lst.de, linux-mm@kvack.org,
        jack@suse.cz, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jul 2018 10:01:03 -0700
Message-ID: <153176046336.12695.10183072594003102353.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153176041838.12695.3365448145295112857.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153176041838.12695.3365448145295112857.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

The mock / test version of pmem_direct_access() needs to check the
validity of pointer pfn for NULL assignment. If pfn equals to NULL, it
doesn't need to calculate the value. This is in support of asynchronous
memmap init and avoid page lookups when possible.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/nvdimm/pmem-dax.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/nvdimm/pmem-dax.c b/tools/testing/nvdimm/pmem-dax.c
index b53596ad601b..d4cb5281b30e 100644
--- a/tools/testing/nvdimm/pmem-dax.c
+++ b/tools/testing/nvdimm/pmem-dax.c
@@ -33,7 +33,8 @@ long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 
 		*kaddr = pmem->virt_addr + offset;
 		page = vmalloc_to_page(pmem->virt_addr + offset);
-		*pfn = page_to_pfn_t(page);
+		if (pfn)
+			*pfn = page_to_pfn_t(page);
 		pr_debug_ratelimited("%s: pmem: %p pgoff: %#lx pfn: %#lx\n",
 				__func__, pmem, pgoff, page_to_pfn(page));
 
@@ -41,7 +42,8 @@ long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 	}
 
 	*kaddr = pmem->virt_addr + offset;
-	*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
+	if (pfn)
+		*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
 
 	/*
 	 * If badblocks are present, limit known good range to the

