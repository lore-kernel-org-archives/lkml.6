Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E3AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7EA20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7EA20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeLLKFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:05:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:36430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726727AbeLLKFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:05:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D557AE88;
        Wed, 12 Dec 2018 10:05:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9E9B61E11DB; Wed, 12 Dec 2018 11:05:42 +0100 (CET)
Date:   Wed, 12 Dec 2018 11:05:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liu Bo <bo.liu@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm, memcg: fix reclaim deadlock with writeback
Message-ID: <20181212100542.GA10902@quack2.suse.cz>
References: <20181211132645.31053-1-mhocko@kernel.org>
 <20181212094249.cw4xjrdchqsp2tkt@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212094249.cw4xjrdchqsp2tkt@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-12-18 12:42:49, Kirill A. Shutemov wrote:
> On Tue, Dec 11, 2018 at 02:26:45PM +0100, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > Liu Bo has experienced a deadlock between memcg (legacy) reclaim and the
> > ext4 writeback
> > task1:
> > [<ffffffff811aaa52>] wait_on_page_bit+0x82/0xa0
> > [<ffffffff811c5777>] shrink_page_list+0x907/0x960
> > [<ffffffff811c6027>] shrink_inactive_list+0x2c7/0x680
> > [<ffffffff811c6ba4>] shrink_node_memcg+0x404/0x830
> > [<ffffffff811c70a8>] shrink_node+0xd8/0x300
> > [<ffffffff811c73dd>] do_try_to_free_pages+0x10d/0x330
> > [<ffffffff811c7865>] try_to_free_mem_cgroup_pages+0xd5/0x1b0
> > [<ffffffff8122df2d>] try_charge+0x14d/0x720
> > [<ffffffff812320cc>] memcg_kmem_charge_memcg+0x3c/0xa0
> > [<ffffffff812321ae>] memcg_kmem_charge+0x7e/0xd0
> > [<ffffffff811b68a8>] __alloc_pages_nodemask+0x178/0x260
> > [<ffffffff8120bff5>] alloc_pages_current+0x95/0x140
> > [<ffffffff81074247>] pte_alloc_one+0x17/0x40
> > [<ffffffff811e34de>] __pte_alloc+0x1e/0x110
> > [<ffffffffa06739de>] alloc_set_pte+0x5fe/0xc20
> > [<ffffffff811e5d93>] do_fault+0x103/0x970
> > [<ffffffff811e6e5e>] handle_mm_fault+0x61e/0xd10
> > [<ffffffff8106ea02>] __do_page_fault+0x252/0x4d0
> > [<ffffffff8106ecb0>] do_page_fault+0x30/0x80
> > [<ffffffff8171bce8>] page_fault+0x28/0x30
> > [<ffffffffffffffff>] 0xffffffffffffffff
> > 
> > task2:
> > [<ffffffff811aadc6>] __lock_page+0x86/0xa0
> > [<ffffffffa02f1e47>] mpage_prepare_extent_to_map+0x2e7/0x310 [ext4]
> > [<ffffffffa08a2689>] ext4_writepages+0x479/0xd60
> > [<ffffffff811bbede>] do_writepages+0x1e/0x30
> > [<ffffffff812725e5>] __writeback_single_inode+0x45/0x320
> > [<ffffffff81272de2>] writeback_sb_inodes+0x272/0x600
> > [<ffffffff81273202>] __writeback_inodes_wb+0x92/0xc0
> > [<ffffffff81273568>] wb_writeback+0x268/0x300
> > [<ffffffff81273d24>] wb_workfn+0xb4/0x390
> > [<ffffffff810a2f19>] process_one_work+0x189/0x420
> > [<ffffffff810a31fe>] worker_thread+0x4e/0x4b0
> > [<ffffffff810a9786>] kthread+0xe6/0x100
> > [<ffffffff8171a9a1>] ret_from_fork+0x41/0x50
> > [<ffffffffffffffff>] 0xffffffffffffffff
> > 
> > He adds
> > : task1 is waiting for the PageWriteback bit of the page that task2 has
> > : collected in mpd->io_submit->io_bio, and tasks2 is waiting for the LOCKED
> > : bit the page which tasks1 has locked.
> > 
> > More precisely task1 is handling a page fault and it has a page locked
> > while it charges a new page table to a memcg. That in turn hits a memory
> > limit reclaim and the memcg reclaim for legacy controller is waiting on
> > the writeback but that is never going to finish because the writeback
> > itself is waiting for the page locked in the #PF path. So this is
> > essentially ABBA deadlock.
> 
> Side node:
> 
> Do we have PG_writeback vs. PG_locked ordering documentated somewhere?
> 
> IIUC, the trace from task2 suggests that we must not wait for writeback
> on the locked page.

Well, waiting on writeback of page A when A is locked has always been fine.
After all that's the only easy way to make sure you really have a page for
which no IO is running as page lock protects you from new writeback attempt
starting.

Waiting on writeback of page B while having page A locked *is* problematic
and prone to deadlocks due to code paths like in task2.

> But that not what I see for many wait_on_page_writeback() users: it usally
> called with the page locked. I see it for truncate, shmem, swapfile,
> splice...
> 
> Maybe the problem is within task2 codepath after all?

So ->writepages() methods in filesystems have the property that to complete
writeback on page with index X, they may need page lock from page X+1. I
agree that this is a bit hairy but from fs point of view it makes a lot of
sense and AFAIK nothing besides that memcg IO throttling can create
deadlocks with such a locking scheme.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
