Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085FCC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FF92087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FF92087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJMBfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:35:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:48818 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeJMBfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:35:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 11:01:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,373,1534834800"; 
   d="scan'208";a="82143394"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006.jf.intel.com with ESMTP; 12 Oct 2018 11:01:19 -0700
Subject: [PATCH v7 0/7] mm: Merge hmm into devm_memremap_pages, mark GPL-only
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     stable@vger.kernel.org, Balbir Singh <bsingharora@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Oct 2018 10:49:31 -0700
Message-ID: <153936657159.1198040.4489957977352276272.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ apologies for the resend, script error ]

Changes since v6 [1]:
* Rebase on next-20181008 and fixup conflicts with the xarray conversion
  and hotplug optimizations
* It has soaked on a 0day visible branch for a few days without any
  reports.

[1]: https://lkml.org/lkml/2018/9/13/104

---

Hi Andrew,

Jérôme has reviewed the cleanups, thanks Jérôme. We still disagree on
the EXPORT_SYMBOL_GPL status of the core HMM implementation, but Logan,
Christoph and I continue to support marking all devm_memremap_pages()
derivatives EXPORT_SYMBOL_GPL.

HMM has been upstream for over a year, with no in-tree users it is clear
it was designed first and foremost for out of tree drivers. It takes
advantage of a facility Christoph and I spearheaded to support
persistent memory. It continues to see expanding use cases with no clear
end date when it will stop attracting features / revisions. It is not
suitable to export devm_memremap_pages() as a stable 3rd party driver
api.

devm_memremap_pages() is a facility that can create struct page entries
for any arbitrary range and give out-of-tree drivers the ability to
subvert core aspects of page management. It, and anything derived from
it (e.g. hmm, pcip2p, etc...), is a deep integration point into the core
kernel, and an EXPORT_SYMBOL_GPL() interface. 

Commit 31c5bda3a656 "mm: fix exports that inadvertently make put_page()
EXPORT_SYMBOL_GPL" was merged ahead of this series to relieve some of
the pressure from innocent consumers of put_page(), but now we need this
series to address *producers* of device pages.

More details and justification in the changelogs. The 0day
infrastructure has reported success across 152 configs and this survives
the libnvdimm unit test suite. Aside from the controversial bits the
diffstat is compelling at:

	7 files changed, 126 insertions(+), 323 deletions(-)

Note that the series has some minor collisions with Alex's recent series
to improve devm_memremap_pages() scalability [2]. So, whichever you take
first the other will need a minor rebase.

[2]: https://www.lkml.org/lkml/2018/9/11/10

Dan Williams (7):
      mm, devm_memremap_pages: Mark devm_memremap_pages() EXPORT_SYMBOL_GPL
      mm, devm_memremap_pages: Kill mapping "System RAM" support
      mm, devm_memremap_pages: Fix shutdown handling
      mm, devm_memremap_pages: Add MEMORY_DEVICE_PRIVATE support
      mm, hmm: Use devm semantics for hmm_devmem_{add,remove}
      mm, hmm: Replace hmm_devmem_pages_create() with devm_memremap_pages()
      mm, hmm: Mark hmm_devmem_{add,add_resource} EXPORT_SYMBOL_GPL


 drivers/dax/pmem.c                |   14 --
 drivers/nvdimm/pmem.c             |   13 +-
 include/linux/hmm.h               |    4 
 include/linux/memremap.h          |    2 
 kernel/memremap.c                 |   94 +++++++----
 mm/hmm.c                          |  305 +++++--------------------------------
 tools/testing/nvdimm/test/iomap.c |   17 ++
 7 files changed, 126 insertions(+), 323 deletions(-)
