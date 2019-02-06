Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2748C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C566217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfBFSAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:00:00 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:59900 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfBFSAA (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 6 Feb 2019 13:00:00 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 06 Feb 2019 18:59:58 +0100
Received: from linux-r8p5.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Wed, 06 Feb 2019 17:59:34 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jgg@ziepe.ca, akpm@linux-foundation.org
Cc:     dledford@redhat.com, jgg@mellanox.com, jack@suse.cz,
        willy@infradead.org, ira.weiny@intel.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH v3 0/6] mm: make pinned_vm atomic and simplify users
Date:   Wed,  6 Feb 2019 09:59:14 -0800
Message-Id: <20190206175920.31082-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v2 (https://patchwork.kernel.org/cover/10774255/):
 - Added more reviews for patch 1 and also fixed mm/debug.c to
   use llx insted of lx so gcc doesn't complain.

 - Re did patch 3 (qib rdma) such that we still have to take
   mmap_sem as it now uses gup_longterm(). gup_fast() conversion
   remains for patch 2 which is not infiniband.

 - Rebased for rdma tree.
 
Changes from v1 (https://patchwork.kernel.org/cover/10764923/):
 - Converted pinned_vm to atomic64 instead of atomic_long such that
   infiniband need not worry about overflows.

 - Rebased patch 1 and added Ira's reviews as well as Parvi's review
   for patch 5 (thanks!).
   
--------

Hi,

The following patches aim to provide cleanups to users that pin pages
(mostly infiniband) by converting the counter to atomic -- note that
Daniel Jordan also has patches[1] for the locked_vm counterpart and vfio.

Apart from removing a source of mmap_sem writer, we benefit in that
we can get rid of a lot of code that defers work when the lock cannot
be acquired, as well as drivers avoiding mmap_sem altogether by also
converting gup to gup_fast() and letting the mm handle it. Users
that do the gup_longterm() remain of course under at least reader mmap_sem.

Everything has been compile-tested _only_ so I hope I didn't do anything
too stupid. Please consider for v5.1.

On a similar topic and potential follow up, it would be nice to resurrect
Peter's VM_PINNED idea in that the broken semantics that occurred after
bc3e53f682 ("mm: distinguish between mlocked and pinned pages") are still
present. Also encapsulating internal mm logic via mm[un]pin() instead of
drivers having to know about internals and playing nice with compaction are
all wins.

Applies against rdma's for-next branch.

Thanks!

[1] https://lkml.org/lkml/2018/11/5/854

Davidlohr Bueso (6):
  mm: make mm->pinned_vm an atomic64 counter
  drivers/mic/scif: do not use mmap_sem
  drivers/IB,qib: optimize mmap_sem usage
  drivers/IB,hfi1: do not se mmap_sem
  drivers/IB,usnic: reduce scope of mmap_sem
  drivers/IB,core: reduce scope of mmap_sem

 drivers/infiniband/core/umem.c              | 47 ++----------------
 drivers/infiniband/hw/hfi1/user_pages.c     | 12 ++---
 drivers/infiniband/hw/qib/qib_user_pages.c  | 75 +++++++++++------------------
 drivers/infiniband/hw/usnic/usnic_ib_main.c |  2 -
 drivers/infiniband/hw/usnic/usnic_uiom.c    | 60 +++--------------------
 drivers/infiniband/hw/usnic/usnic_uiom.h    |  1 -
 drivers/misc/mic/scif/scif_rma.c            | 38 +++++----------
 fs/proc/task_mmu.c                          |  2 +-
 include/linux/mm_types.h                    |  2 +-
 kernel/events/core.c                        |  8 +--
 kernel/fork.c                               |  2 +-
 mm/debug.c                                  |  5 +-
 12 files changed, 65 insertions(+), 189 deletions(-)

-- 
2.16.4

