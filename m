Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38223C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95DE2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544629866;
	bh=HJkkZDLWlKvxRo9Ys2BljbfTCJIP5K92m5QmcBnk6eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PTf3vVfBYey2t++Crmx7SshgK42HEkGLo9BdiqjOIpyezdRLcRGLMOgtTFoIC/mP8
	 XU1VBD2KtYz6BCzpkpvhSbjfWLlGSiHe7v4PXNJgQPsL8UYfZfTURF4JHgonOEpeEz
	 YMtwYLxRpbdadCzcYSEQ3Tv1LsM82o4TRgkcS7e4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95DE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeLLPvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:51:04 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34455 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLLPvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:51:04 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so15978404ede.1;
        Wed, 12 Dec 2018 07:51:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2NB6emeHojHP3Pcyzy+norq0ay8ZtgpPR5m6A6AHM3U=;
        b=DSv1YemFszZRzzqLFJlnLeCnG8v/lPY0TuIkNfspSwLdo46e8V8sU/N2yBIoCqAsfF
         5ilCe9Ag/Fpysc+6zv8jCyxM+8N+w1K7HNKBVp8LML1sYVZhImn2VIBc6+ea5lwdlHfG
         wcmnZUmO2Aex6SfputTo6xezkAk53pLa/JLZ2YCO4JHiUsKBypAzFXVwhMav6zreoX5A
         FY3wWIltVvQJX4kPYs+lAipIi0aSbWwDUeJ4QQ54OYZB/XRkjewJh4K9NhZMb+c9Qic8
         jcPuMw83rRsq1DhDdivq5afI8rJVLvHfWbv38t2YV6oAZcrsiKEOVWJHFzhinbozCYXE
         8+3w==
X-Gm-Message-State: AA+aEWZmGYWJlzG/LerH9QGjEMA1UGH43s3+fPbk7y2LWRHsB0s4/ssV
        o4t6mYjGuxyGkmKC231fi6I=
X-Google-Smtp-Source: AFSGD/XnGfNEzRSWh3XdLWLYLSJZQYSGGcDfYbkNWdPkoISYlb7RYCSLlfuq1Mhdhb0Z4eF2tQvqeA==
X-Received: by 2002:a17:906:5304:: with SMTP id h4-v6mr15820892ejo.39.1544629862211;
        Wed, 12 Dec 2018 07:51:02 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id l17sm4913030edc.56.2018.12.12.07.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 07:51:00 -0800 (PST)
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
Subject: [PATCH v2] mm, memcg: fix reclaim deadlock with writeback
Date:   Wed, 12 Dec 2018 16:50:55 +0100
Message-Id: <20181212155055.1269-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211132645.31053-1-mhocko@kernel.org>
References: <20181211132645.31053-1-mhocko@kernel.org>
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
 mm/memory.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 4ad2d293ddc2..bb78e90a9b70 100644
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
+		vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm_mm, vmf->address);
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

