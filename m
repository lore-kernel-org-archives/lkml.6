Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3F2C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F242082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544534820;
	bh=jTTKGwNa0+ZZgWD9fJj5IOtRn9R40sml/ApPCJ2JpiU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=L3z76jhHe/Txo8DetAm8caDJcQqT5j5AfCjxaQdJgS/pqV3le9hJ181snc+JvC3Jx
	 uGxFAFv4TLbiTwrqEKJpH988ykt/edTHmgPZgEKy3H7cWfKOoQoeUXn6H3zN5xRft2
	 F8W0B5UeAl2arHlzlbecUajM2/glFjrjDy8QPc9U=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F242082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeLKN07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:26:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39872 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeLKN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:26:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so7136150pfc.6;
        Tue, 11 Dec 2018 05:26:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jxbynfRZF3X6tSvesQ9hBhsSdCVxDV0cRayMv8c1614=;
        b=q3/Mm1FzPnqvdTh1AkN6LUGEzCcL9evRf6JrEWAnkEUSWaOitD7CX6jmTgFnHff08J
         R1uz8Nt2z5/rtgfc2bqWvLRdZFNNZrykaZNqxPEXX7RscTeln9ys6aQOAyXZODEPIMqH
         0BwoeQ3OtgCGO3LvownOHaNdQy6vbw0uQIA2cQAmBp72/65/j7hHFYTHQyJ3+XipioSM
         eixcnxVa29IWay5B1cHR8jc5fmQEuMBMyS/YJ5tpGH4wxZFzJTOeBNUy9d8Wk5PlGLZ4
         ypYxUWn9yWT7GKjf3WBpf1CscAabgZ9Lj1X04X8QqFsS1BWXSmhpPqC8jPg+eUyKkf0K
         4MOg==
X-Gm-Message-State: AA+aEWbV/fpuy4pSGqADrkBelIIRsWGTiF2tcEMRCqppJMp5yKbZh6em
        ykSN9CJrqQsv8lkgqPWVukk=
X-Google-Smtp-Source: AFSGD/W5JvJTtNsYhqZ89uUnjHbTW+iv+BfZ7C5Sp303eExqcx99HohPFxw2cfCr05CMj5yUC/vUww==
X-Received: by 2002:a62:5444:: with SMTP id i65mr16903077pfb.193.1544534817855;
        Tue, 11 Dec 2018 05:26:57 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id v62sm28677411pfd.163.2018.12.11.05.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 05:26:56 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Liu Bo <bo.liu@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm, memcg: fix reclaim deadlock with writeback
Date:   Tue, 11 Dec 2018 14:26:45 +0100
Message-Id: <20181211132645.31053-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Liu Bo has experienced a deadlock between memcg (legacy) reclaim and the
ext4 writeback
task1:
[<ffffffff811aaa52>] wait_on_page_bit+0x82/0xa0
[<ffffffff811c5777>] shrink_page_list+0x907/0x960
[<ffffffff811c6027>] shrink_inactive_list+0x2c7/0x680
[<ffffffff811c6ba4>] shrink_node_memcg+0x404/0x830
[<ffffffff811c70a8>] shrink_node+0xd8/0x300
[<ffffffff811c73dd>] do_try_to_free_pages+0x10d/0x330
[<ffffffff811c7865>] try_to_free_mem_cgroup_pages+0xd5/0x1b0
[<ffffffff8122df2d>] try_charge+0x14d/0x720
[<ffffffff812320cc>] memcg_kmem_charge_memcg+0x3c/0xa0
[<ffffffff812321ae>] memcg_kmem_charge+0x7e/0xd0
[<ffffffff811b68a8>] __alloc_pages_nodemask+0x178/0x260
[<ffffffff8120bff5>] alloc_pages_current+0x95/0x140
[<ffffffff81074247>] pte_alloc_one+0x17/0x40
[<ffffffff811e34de>] __pte_alloc+0x1e/0x110
[<ffffffffa06739de>] alloc_set_pte+0x5fe/0xc20
[<ffffffff811e5d93>] do_fault+0x103/0x970
[<ffffffff811e6e5e>] handle_mm_fault+0x61e/0xd10
[<ffffffff8106ea02>] __do_page_fault+0x252/0x4d0
[<ffffffff8106ecb0>] do_page_fault+0x30/0x80
[<ffffffff8171bce8>] page_fault+0x28/0x30
[<ffffffffffffffff>] 0xffffffffffffffff

task2:
[<ffffffff811aadc6>] __lock_page+0x86/0xa0
[<ffffffffa02f1e47>] mpage_prepare_extent_to_map+0x2e7/0x310 [ext4]
[<ffffffffa08a2689>] ext4_writepages+0x479/0xd60
[<ffffffff811bbede>] do_writepages+0x1e/0x30
[<ffffffff812725e5>] __writeback_single_inode+0x45/0x320
[<ffffffff81272de2>] writeback_sb_inodes+0x272/0x600
[<ffffffff81273202>] __writeback_inodes_wb+0x92/0xc0
[<ffffffff81273568>] wb_writeback+0x268/0x300
[<ffffffff81273d24>] wb_workfn+0xb4/0x390
[<ffffffff810a2f19>] process_one_work+0x189/0x420
[<ffffffff810a31fe>] worker_thread+0x4e/0x4b0
[<ffffffff810a9786>] kthread+0xe6/0x100
[<ffffffff8171a9a1>] ret_from_fork+0x41/0x50
[<ffffffffffffffff>] 0xffffffffffffffff

He adds
: task1 is waiting for the PageWriteback bit of the page that task2 has
: collected in mpd->io_submit->io_bio, and tasks2 is waiting for the LOCKED
: bit the page which tasks1 has locked.

More precisely task1 is handling a page fault and it has a page locked
while it charges a new page table to a memcg. That in turn hits a memory
limit reclaim and the memcg reclaim for legacy controller is waiting on
the writeback but that is never going to finish because the writeback
itself is waiting for the page locked in the #PF path. So this is
essentially ABBA deadlock.

Waiting for the writeback in legacy memcg controller is a workaround
for pre-mature OOM killer invocations because there is no dirty IO
throttling available for the controller. There is no easy way around
that unfortunately. Therefore fix this specific issue by pre-allocating
the page table outside of the page lock. We have that handy
infrastructure for that already so simply reuse the fault-around pattern
which already does this.

Reported-and-Debugged-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
Hi,
this has been originally reported here [1]. While it could get worked
around in the fs, catching the allocation early sounds like a preferable
approach. Liu Bo has noted that he is not able to reproduce this anymore
because kmem accounting has been disabled in their workload but this
should be quite straightforward to review.

There are probably other hidden __GFP_ACCOUNT | GFP_KERNEL allocations
from under a fs page locked but they should be really rare. I am not
aware of a better solution unfortunately.

I would appreciate if Kirril could have a look and double check I am not
doing something stupid here.

Debugging lock_page deadlocks is an absolute PITA considering a lack of
lockdep support so I would mark it for stable.

[1] http://lkml.kernel.org/r/1540858969-75803-1-git-send-email-bo.liu@linux.alibaba.com
 mm/memory.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 4ad2d293ddc2..1a73d2d4659e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2993,6 +2993,17 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret;
 
+	/*
+	 * Preallocate pte before we take page_lock because this might lead to
+	 * deadlocks for memcg reclaim which waits for pages under writeback.
+	 */
+	if (pmd_none(*vmf->pmd) && !vmf->prealloc_pte) {
+		vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm>mm, vmf->address);
+		if (!vmf->prealloc_pte)
+			return VM_FAULT_OOM;
+		smp_wmb(); /* See comment in __pte_alloc() */
+	}
+
 	ret = vma->vm_ops->fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
 			    VM_FAULT_DONE_COW)))
-- 
2.19.2

