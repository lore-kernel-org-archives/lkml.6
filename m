Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B29C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2EE20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2EE20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756136AbeFSGOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:14:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:29483 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755731AbeFSGOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:14:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 23:14:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="60344830"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003.jf.intel.com with ESMTP; 18 Jun 2018 23:14:36 -0700
Subject: [PATCH v3 0/8] mm: Rework hmm to use devm_memremap_pages and other
 fixes
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     stable@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Joe Gorse <jhgorse@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Jun 2018 23:04:39 -0700
Message-ID: <152938827880.17797.439879736804291936.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2 [1]:
* Rebased on v4.18-rc1
* Collect Logan's reviewed-by for "mm, devm_memremap_pages: Add
  MEMORY_DEVICE_PRIVATE support"
* Convert __put_devmap_managed_page and devmap_managed_key to
  EXPORT_SYMBOL otherwise put_page() becomes limited to GPL-only
  modules.
* Clarify some of the changelogs.

[1]: https://lkml.org/lkml/2018/5/23/24

---

Hi Andrew, here's v3 to replace these 5 currently in mm:

mm-devm_memremap_pages-mark-devm_memremap_pages-export_symbol_gpl.patch
mm-devm_memremap_pages-handle-errors-allocating-final-devres-action.patch
mm-hmm-use-devm-semantics-for-hmm_devmem_add-remove.patch
mm-hmm-replace-hmm_devmem_pages_create-with-devm_memremap_pages.patch
mm-hmm-mark-hmm_devmem_add-add_resource-export_symbol_gpl.patch

For maintainability, as ZONE_DEVICE continues to attract new users,
it is useful to keep all users consolidated on devm_memremap_pages() as
the interface for create "device pages".

The devm_memremap_pages() implementation was recently reworked to make
it more generic for arbitrary users, like the proposed peer-to-peer
PCI-E enabling. HMM pre-dated this rework and opted to duplicate
devm_memremap_pages() as hmm_devmem_pages_create().

Rework HMM to be a consumer of devm_memremap_pages() directly and fix up
the licensing on the exports given the deep dependencies on the mm.

Patches based on v4.18-rc1 where there are no upstream consumers of the
HMM functionality.

---

Dan Williams (8):
      mm, devm_memremap_pages: Mark devm_memremap_pages() EXPORT_SYMBOL_GPL
      mm, devm_memremap_pages: Kill mapping "System RAM" support
      mm, devm_memremap_pages: Fix shutdown handling
      mm, devm_memremap_pages: Add MEMORY_DEVICE_PRIVATE support
      mm, hmm: Use devm semantics for hmm_devmem_{add,remove}
      mm, hmm: Replace hmm_devmem_pages_create() with devm_memremap_pages()
      mm, hmm: Mark hmm_devmem_{add,add_resource} EXPORT_SYMBOL_GPL
      mm: Fix exports that inadvertently make put_page() EXPORT_SYMBOL_GPL


 drivers/dax/pmem.c                |   10 -
 drivers/nvdimm/pmem.c             |   18 +-
 include/linux/hmm.h               |    4 
 include/linux/memremap.h          |    7 +
 kernel/memremap.c                 |   89 +++++++----
 mm/hmm.c                          |  307 +++++--------------------------------
 tools/testing/nvdimm/test/iomap.c |   21 ++-
 7 files changed, 132 insertions(+), 324 deletions(-)
