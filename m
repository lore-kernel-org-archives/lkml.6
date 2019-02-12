Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFAAC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986E5222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbfBLVhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:37:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:36555 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfBLVhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:37:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 13:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="125954900"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003.jf.intel.com with ESMTP; 12 Feb 2019 13:37:18 -0800
Subject: [PATCH 0/7] libnvdimm/pfn: Fix section-alignment padding
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Oliver O'Halloran <oohall@gmail.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-kernel@vger.kernel.org, vishal.l.verma@intel.com,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 12 Feb 2019 13:24:40 -0800
Message-ID: <155000668075.348031.9371497273408112600.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lately Linux has encountered platforms that collide Persistent Memory
regions between each other, specifically cases where ->start_pad needed
to be non-zero. This lead to commit ae86cbfef381 "libnvdimm, pfn: Pad
pfn namespaces relative to other regions". That commit allowed
namespaces to be mapped with devm_memremap_pages(). However dax
operations on those configurations currently fail if attempted within the
->start_pad range because pmem_device->data_offset was still relative to
raw resource base not relative to the section aligned resource range
mapped by devm_memremap_pages().

Luckily __bdev_dax_supported() caught these failures and simply disabled
dax. However, to fix this situation a non-backwards compatible change
needs to be made to the interpretation of the nd_pfn info-block.
->start_pad needs to be accounted in ->map.map_offset (formerly
->data_offset), and ->map.map_base (formerly ->phys_addr) needs to be
adjusted to the section aligned resource base used to establish
->map.map formerly (formerly ->virt_addr).

See patch 7 "libnvdimm/pfn: Fix 'start_pad' implementation" for more
details, and the ndctl patch series "Improve support + testing for
labels + info-blocks" for the corresponding regression test.

---

Dan Williams (7):
      libnvdimm/pfn: Account for PAGE_SIZE > info-block-size in nd_pfn_init()
      libnvdimm/pmem: Honor force_raw for legacy pmem regions
      dax: Check the end of the block-device capacity with dax_direct_access()
      libnvdimm/pfn: Introduce super-block minimum version requirements
      libnvdimm/pfn: Remove dax_label_reserve
      libnvdimm/pfn: Introduce 'struct pfn_map_info'
      libnvdimm/pfn: Fix 'start_pad' implementation


 drivers/dax/pmem.c              |    9 +-
 drivers/dax/super.c             |   39 ++++++--
 drivers/nvdimm/namespace_devs.c |    4 +
 drivers/nvdimm/nd.h             |   15 +++
 drivers/nvdimm/pfn.h            |    4 +
 drivers/nvdimm/pfn_devs.c       |  181 ++++++++++++++++++++++++++++-----------
 drivers/nvdimm/pmem.c           |  111 +++++++++++-------------
 drivers/nvdimm/pmem.h           |   12 ---
 tools/testing/nvdimm/pmem-dax.c |   15 ++-
 9 files changed, 244 insertions(+), 146 deletions(-)
