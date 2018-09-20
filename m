Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55BFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E1521533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E1521533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbeIUEKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:10:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:14406 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbeIUEKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:10:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 15:24:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,282,1534834800"; 
   d="scan'208";a="85285084"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.152])
  by orsmga003.jf.intel.com with ESMTP; 20 Sep 2018 15:24:10 -0700
Subject: [PATCH v4 0/5] Address issues slowing persistent memory
 initialization
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, mingo@kernel.org, dave.hansen@intel.com,
        jglisse@redhat.com, akpm@linux-foundation.org, logang@deltatee.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com
Date:   Thu, 20 Sep 2018 15:24:09 -0700
Message-ID: <20180920215824.19464.8884.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is meant to be a v4 to my earlier patch set "Address issues
slowing memory init"[1], and a follow-up to my earlier patch set "Address
issues slowing persistent memory initialization"[2].

Excluding any gains seen from using the vm_debug option to disable page
init poisoning I see a total reduction in file-system init time of about
two and a half minutes, or 65%, for a system initializing btrfs on a 12TB
block of persistent memory split evenly over 4 NUMA nodes.

Since the last patch set I have reworked the first patch to provide a more
generic disable implementation that can be extended in the future.

I tweaked the commit message for the second patch slightly to reflect why
we might want to use a non-atomic __set_bit versus the atomic set_bit.

I have modified the third patch to make it so that it can merge onto either
the linux git tree or the linux-next git tree. The patch set that Dan
Williams has outstanding may end up conflicting with this patch depending
on the merge order. If his are merged first I believe the code I changed
in mm/hmm.c could be dropped entirely.

The fourth patch has been split into two and focused more on the async
scheduling portion of the nvdimm code. The result is much cleaner than the
original approach in that instead of having two threads running we are now
getting the thread running where we wanted it to be.

The last change for all patches is that I have updated my email address to
alexander.h.duyck@linux.intel.com to reflect the fact that I have changed
teams within Intel. I will be trying to use that for correspondence going
forward instead of my gmail account.

[1]: https://lkml.org/lkml/2018/9/5/924
[2]: https://lkml.org/lkml/2018/9/11/10
[3]: https://lkml.org/lkml/2018/9/13/104

---

Alexander Duyck (5):
      mm: Provide kernel parameter to allow disabling page init poisoning
      mm: Create non-atomic version of SetPageReserved for init use
      mm: Defer ZONE_DEVICE page initialization to the point where we init pgmap
      async: Add support for queueing on specific node
      nvdimm: Schedule device registration on node local to the device


 Documentation/admin-guide/kernel-parameters.txt |   12 +++
 drivers/nvdimm/bus.c                            |   19 ++++
 include/linux/async.h                           |   20 ++++-
 include/linux/mm.h                              |    2 
 include/linux/page-flags.h                      |    9 ++
 kernel/async.c                                  |   36 ++++++--
 kernel/memremap.c                               |   24 ++---
 mm/debug.c                                      |   46 ++++++++++
 mm/hmm.c                                        |   12 ++-
 mm/memblock.c                                   |    5 -
 mm/page_alloc.c                                 |  101 ++++++++++++++++++++++-
 mm/sparse.c                                     |    4 -
 12 files changed, 243 insertions(+), 47 deletions(-)

--
