Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0284C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B3C2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078986;
	bh=HcO03V5QyUWVTYIbKw0WNW1Sih7BuIouyLSFX1EdGgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0xY9UZtaOiiAjyJnmewszMciRhz3QMODzqTa+irdUA2m4cGImd2nCnq2gG3XwG8r+
	 OxhZzDUQEdxzD6saKeeZJvXfz0VvJus1i5iLGs3NiMhhTsfIZiGCDDFuOMVJFYEnh0
	 SOtXHJFurTjPrm3R3UPoB5kXWx/qjxkSetYv4358=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbfAUN4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:56:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731874AbfAUN4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:56:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2E1520861;
        Mon, 21 Jan 2019 13:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078979;
        bh=HcO03V5QyUWVTYIbKw0WNW1Sih7BuIouyLSFX1EdGgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQ6i4tbn6eNouI2vJZZlRTP6z2bLwFmr2TA1MeGWavNe9Z7TVdUOtrbmBcvj5FpUK
         8xodbszjyRFX0KPzTYpowpi5aCeWjH77uaV50rN80iWH6tfkE7qzBta2iB2ZTkcQAN
         u8al23sNjlYvR8IlF0Jsio2flks0ze2bQmZrN7pw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 51/51] mm, memcg: fix reclaim deadlock with writeback
Date:   Mon, 21 Jan 2019 14:44:47 +0100
Message-Id: <20190121122458.832467342@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.com>

commit 63f3655f950186752236bb88a22f8252c11ce394 upstream.

Liu Bo has experienced a deadlock between memcg (legacy) reclaim and the
ext4 writeback

  task1:
    wait_on_page_bit+0x82/0xa0
    shrink_page_list+0x907/0x960
    shrink_inactive_list+0x2c7/0x680
    shrink_node_memcg+0x404/0x830
    shrink_node+0xd8/0x300
    do_try_to_free_pages+0x10d/0x330
    try_to_free_mem_cgroup_pages+0xd5/0x1b0
    try_charge+0x14d/0x720
    memcg_kmem_charge_memcg+0x3c/0xa0
    memcg_kmem_charge+0x7e/0xd0
    __alloc_pages_nodemask+0x178/0x260
    alloc_pages_current+0x95/0x140
    pte_alloc_one+0x17/0x40
    __pte_alloc+0x1e/0x110
    alloc_set_pte+0x5fe/0xc20
    do_fault+0x103/0x970
    handle_mm_fault+0x61e/0xd10
    __do_page_fault+0x252/0x4d0
    do_page_fault+0x30/0x80
    page_fault+0x28/0x30

  task2:
    __lock_page+0x86/0xa0
    mpage_prepare_extent_to_map+0x2e7/0x310 [ext4]
    ext4_writepages+0x479/0xd60
    do_writepages+0x1e/0x30
    __writeback_single_inode+0x45/0x320
    writeback_sb_inodes+0x272/0x600
    __writeback_inodes_wb+0x92/0xc0
    wb_writeback+0x268/0x300
    wb_workfn+0xb4/0x390
    process_one_work+0x189/0x420
    worker_thread+0x4e/0x4b0
    kthread+0xe6/0x100
    ret_from_fork+0x41/0x50

He adds
 "task1 is waiting for the PageWriteback bit of the page that task2 has
  collected in mpd->io_submit->io_bio, and tasks2 is waiting for the
  LOCKED bit the page which tasks1 has locked"

More precisely task1 is handling a page fault and it has a page locked
while it charges a new page table to a memcg.  That in turn hits a
memory limit reclaim and the memcg reclaim for legacy controller is
waiting on the writeback but that is never going to finish because the
writeback itself is waiting for the page locked in the #PF path.  So
this is essentially ABBA deadlock:

                                        lock_page(A)
                                        SetPageWriteback(A)
                                        unlock_page(A)
  lock_page(B)
                                        lock_page(B)
  pte_alloc_pne
    shrink_page_list
      wait_on_page_writeback(A)
                                        SetPageWriteback(B)
                                        unlock_page(B)

                                        # flush A, B to clear the writeback

This accumulating of more pages to flush is used by several filesystems
to generate a more optimal IO patterns.

Waiting for the writeback in legacy memcg controller is a workaround for
pre-mature OOM killer invocations because there is no dirty IO
throttling available for the controller.  There is no easy way around
that unfortunately.  Therefore fix this specific issue by pre-allocating
the page table outside of the page lock.  We have that handy
infrastructure for that already so simply reuse the fault-around pattern
which already does this.

There are probably other hidden __GFP_ACCOUNT | GFP_KERNEL allocations
from under a fs page locked but they should be really rare.  I am not
aware of a better solution unfortunately.

[akpm@linux-foundation.org: fix mm/memory.c:__do_fault()]
[akpm@linux-foundation.org: coding-style fixes]
[mhocko@kernel.org: enhance comment, per Johannes]
  Link: http://lkml.kernel.org/r/20181214084948.GA5624@dhcp22.suse.cz
Link: http://lkml.kernel.org/r/20181213092221.27270-1-mhocko@kernel.org
Fixes: c3b94f44fcb0 ("memcg: further prevent OOM with too many dirty pages")
Signed-off-by: Michal Hocko <mhocko@suse.com>
Reported-by: Liu Bo <bo.liu@linux.alibaba.com>
Debugged-by: Liu Bo <bo.liu@linux.alibaba.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memory.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2823,6 +2823,28 @@ static int __do_fault(struct fault_env *
 	struct vm_fault vmf;
 	int ret;
 
+	/*
+	 * Preallocate pte before we take page_lock because this might lead to
+	 * deadlocks for memcg reclaim which waits for pages under writeback:
+	 *				lock_page(A)
+	 *				SetPageWriteback(A)
+	 *				unlock_page(A)
+	 * lock_page(B)
+	 *				lock_page(B)
+	 * pte_alloc_pne
+	 *   shrink_page_list
+	 *     wait_on_page_writeback(A)
+	 *				SetPageWriteback(B)
+	 *				unlock_page(B)
+	 *				# flush A, B to clear the writeback
+	 */
+	if (pmd_none(*fe->pmd) && !fe->prealloc_pte) {
+		fe->prealloc_pte = pte_alloc_one(vma->vm_mm, fe->address);
+		if (!fe->prealloc_pte)
+			return VM_FAULT_OOM;
+		smp_wmb(); /* See comment in __pte_alloc() */
+	}
+
 	vmf.virtual_address = (void __user *)(fe->address & PAGE_MASK);
 	vmf.pgoff = pgoff;
 	vmf.flags = fe->flags;


