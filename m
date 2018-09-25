Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F521C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3FC20880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3FC20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeIZC10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:27:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:8353 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeIZC1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:27:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 13:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="77229927"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.152])
  by orsmga006.jf.intel.com with ESMTP; 25 Sep 2018 13:18:09 -0700
Subject: [PATCH v5 0/4] Address issues slowing persistent memory
 initialization
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, dave.hansen@intel.com, jglisse@redhat.com,
        rppt@linux.vnet.ibm.com, dan.j.williams@intel.com,
        logang@deltatee.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Date:   Tue, 25 Sep 2018 13:18:08 -0700
Message-ID: <20180925200551.3576.18755.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is meant to be a v5 of my earlier submission with the same
title[1].

The main changes from the previous version are that I have added a new
patch to address an issue that had disabled deferred memory init on my
system due to recent config changes related to CONFIG_NO_BOOTMEM. In
addition I dropped the original patches 4 and 5 from the previous set as
that is going to need to be a separate set of patches.

The main thing this patch set achieves is that it allows us to initialize
each node worth of persistent memory independently. As a result we reduce
page init time by about 2 minutes because instead of taking 30 to 40 seconds
per node and going through each node one at a time, we process all 4 nodes
in parallel in the case of a 12TB persistent memory setup spread evenly over
4 nodes.

[1]: https://lkml.org/lkml/2018/9/21/4
---

Alexander Duyck (4):
      mm: Remove now defunct NO_BOOTMEM from depends list for deferred init
      mm: Provide kernel parameter to allow disabling page init poisoning
      mm: Create non-atomic version of SetPageReserved for init use
      mm: Defer ZONE_DEVICE page initialization to the point where we init pgmap


 Documentation/admin-guide/kernel-parameters.txt |   12 +++
 arch/csky/Kconfig                               |    1 
 include/linux/mm.h                              |    2 
 include/linux/page-flags.h                      |    9 ++
 kernel/memremap.c                               |   24 ++---
 mm/Kconfig                                      |    1 
 mm/debug.c                                      |   46 ++++++++++
 mm/hmm.c                                        |   12 ++-
 mm/memblock.c                                   |    5 -
 mm/page_alloc.c                                 |  101 ++++++++++++++++++++++-
 mm/sparse.c                                     |    4 -
 11 files changed, 184 insertions(+), 33 deletions(-)

--
