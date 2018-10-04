Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BF1C64EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D7320854
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D7320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeJEHEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 03:04:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:63004 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeJEHEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 03:04:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 17:08:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,342,1534834800"; 
   d="scan'208";a="94760662"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004.fm.intel.com with ESMTP; 04 Oct 2018 17:08:25 -0700
Subject: [PATCH] libnvdimm,
 pmem: Fix badblocks population for 'raw' namespaces
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jacek Zloch <jacek.zloch@intel.com>,
        Krzysztof Rusocki <krzysztof.rusocki@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 16:56:37 -0700
Message-ID: <153869739732.2904401.10895695693942634646.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is only initializing bb_res in the devm_memremap_pages()
paths, but the raw namespace case is passing an uninitialized bb_res to
nvdimm_badblocks_populate().

Fixes: e8d513483300 ("memremap: change devm_memremap_pages interface...")
Cc: <stable@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Reported-by: Jacek Zloch <jacek.zloch@intel.com>
Reported-by: Krzysztof Rusocki <krzysztof.rusocki@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/pmem.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 6071e2942053..2082ae01b9c8 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -421,9 +421,11 @@ static int pmem_attach_disk(struct device *dev,
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pmem->pfn_flags |= PFN_MAP;
 		memcpy(&bb_res, &pmem->pgmap.res, sizeof(bb_res));
-	} else
+	} else {
 		addr = devm_memremap(dev, pmem->phys_addr,
 				pmem->size, ARCH_MEMREMAP_PMEM);
+		memcpy(&bb_res, &nsio->res, sizeof(bb_res));
+	}
 
 	/*
 	 * At release time the queue must be frozen before

