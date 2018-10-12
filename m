Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A102C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231422150C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231422150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeJMBdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:33:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:53934 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbeJMBdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:33:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 10:59:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,373,1534834800"; 
   d="scan'208";a="270852970"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005.fm.intel.com with ESMTP; 12 Oct 2018 10:59:30 -0700
Subject: [PATCH v7 1/7] mm,
 devm_memremap_pages: Mark devm_memremap_pages() EXPORT_SYMBOL_GPL
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 12 Oct 2018 10:47:42 -0700
Message-ID: <153936646280.1197954.3829959749267801701.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153936645715.1197954.17511560935912733744.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153936645715.1197954.17511560935912733744.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_memremap_pages() is a facility that can create struct page entries
for any arbitrary range and give drivers the ability to subvert core
aspects of page management.

Specifically the facility is tightly integrated with the kernel's memory
hotplug functionality. It injects an altmap argument deep into the
architecture specific vmemmap implementation to allow allocating from
specific reserved pages, and it has Linux specific assumptions about
page structure reference counting relative to get_user_pages() and
get_user_pages_fast(). It was an oversight and a mistake that this was
not marked EXPORT_SYMBOL_GPL from the outset.

Again, devm_memremap_pagex() exposes and relies upon core kernel
internal assumptions and will continue to evolve along with 'struct
page', memory hotplug, and support for new memory types / topologies.
Only an in-kernel GPL-only driver is expected to keep up with this
ongoing evolution. This interface, and functionality derived from this
interface, is not suitable for kernel-external drivers.

Cc: Michal Hocko <mhocko@suse.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/memremap.c                 |    2 +-
 tools/testing/nvdimm/test/iomap.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index 6ec81e0d7a33..1bbb2e892941 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -232,7 +232,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
  err_array:
 	return ERR_PTR(error);
 }
-EXPORT_SYMBOL(devm_memremap_pages);
+EXPORT_SYMBOL_GPL(devm_memremap_pages);
 
 unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
 {
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index ff9d3a5825e1..ed18a0cbc0c8 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -113,7 +113,7 @@ void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 		return nfit_res->buf + offset - nfit_res->res.start;
 	return devm_memremap_pages(dev, pgmap);
 }
-EXPORT_SYMBOL(__wrap_devm_memremap_pages);
+EXPORT_SYMBOL_GPL(__wrap_devm_memremap_pages);
 
 pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags)
 {

