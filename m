Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37E3C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6505623F16
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6505623F16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbeGDVut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:50:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:59734 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752933AbeGDVuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:50:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 14:50:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,309,1526367600"; 
   d="scan'208";a="52057511"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jul 2018 14:50:36 -0700
Subject: [PATCH v5 03/11] device-dax: Set page->index
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Jan Kara <jack@suse.cz>, hch@lst.de, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        ross.zwisler@linux.intel.com
Date:   Wed, 04 Jul 2018 14:40:39 -0700
Message-ID: <153074043918.27838.10612469015732111514.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In support of enabling memory_failure() handling for device-dax
mappings, set ->index to the pgoff of the page. The rmap implementation
requires ->index to bound the search through the vma interval tree.

The ->index value is never cleared. There is no possibility for the
page to become associated with another pgoff while the device is
enabled. When the device is disabled the 'struct page' array for the
device is destroyed and ->index is reinitialized to zero.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/device.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 95cfcfd612df..361a11089591 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -416,6 +416,7 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 
 	if (rc == VM_FAULT_NOPAGE) {
 		unsigned long i;
+		pgoff_t pgoff;
 
 		/*
 		 * In the device-dax case the only possibility for a
@@ -423,6 +424,8 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 		 * mapped. No need to consider the zero page, or racing
 		 * conflicting mappings.
 		 */
+		pgoff = linear_page_index(vmf->vma, vmf->address
+				& ~(fault_size - 1));
 		for (i = 0; i < fault_size / PAGE_SIZE; i++) {
 			struct page *page;
 
@@ -430,6 +433,7 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 			if (page->mapping)
 				continue;
 			page->mapping = filp->f_mapping;
+			page->index = pgoff + i;
 		}
 	}
 	dax_read_unlock(id);

