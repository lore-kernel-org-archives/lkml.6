Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6030C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F34A20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F34A20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeIMHlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:41:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:54799 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbeIMHlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:41:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 19:33:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,367,1531810800"; 
   d="scan'208";a="85535756"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002.fm.intel.com with ESMTP; 12 Sep 2018 19:33:42 -0700
Subject: [PATCH v5 0/7] mm: Merge hmm into devm_memremap_pages, mark GPL-only
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     stable@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>, alexander.h.duyck@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 12 Sep 2018 19:22:00 -0700
Message-ID: <153680531988.453305.8080706591516037706.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4 [1]:
* Rebase on v4.19-rc3
* Update changelogs and cover letter

[1]: https://lkml.org/lkml/2018/7/11/14

---

Hi Andrew,

Back from vacation and this series is still top of mind.
devm_memremap_pages() is a facility that can create struct page entries
for any arbitrary range and give drivers the ability to subvert core
aspects of page management. It, and anything derived from it (e.g. hmm,
pcip2p, etc...), is an EXPORT_SYMBOL_GPL() interface.

I see that commit 31c5bda3a656 "mm: fix exports that inadvertently make
put_page() EXPORT_SYMBOL_GPL" was merged ahead of this series to relieve
some of the pressure from innocent consumers of put_page(), but now we
need this series to address *producers* of device pages.

More details and justification in the changelogs. The 0day
infrastructure has reported success across 182 configs and this survives
the libnvdimm unit test suite. Aside from the controversial bits the
diffstat is compelling at:

    7 files changed, 138 insertions(+), 328 deletions(-).

Note that the series has some minor collisions with Alex's recent series
to improve devm_memremap_pages() scalability [2]. So, whichever you take
first the other will need a minor rebase.

[2]: https://www.lkml.org/lkml/2018/9/11/10

---

Dan Williams (7):
      mm, devm_memremap_pages: Mark devm_memremap_pages() EXPORT_SYMBOL_GPL
      mm, devm_memremap_pages: Kill mapping "System RAM" support
      mm, devm_memremap_pages: Fix shutdown handling
      mm, devm_memremap_pages: Add MEMORY_DEVICE_PRIVATE support
      mm, hmm: Use devm semantics for hmm_devmem_{add,remove}
      mm, hmm: Replace hmm_devmem_pages_create() with devm_memremap_pages()
      mm, hmm: Mark hmm_devmem_{add,add_resource} EXPORT_SYMBOL_GPL


 drivers/dax/pmem.c                |   15 --
 drivers/nvdimm/pmem.c             |   18 +-
 include/linux/hmm.h               |    4 
 include/linux/memremap.h          |    7 +
 kernel/memremap.c                 |   98 ++++++++----
 mm/hmm.c                          |  303 +++++--------------------------------
 tools/testing/nvdimm/test/iomap.c |   21 ++-
 7 files changed, 138 insertions(+), 328 deletions(-)
