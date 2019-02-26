Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE053C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E224213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfBZIXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:23:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:21848 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfBZIXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:23:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2019 00:17:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,414,1544515200"; 
   d="scan'208";a="302607380"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.151])
  by orsmga005.jf.intel.com with ESMTP; 26 Feb 2019 00:17:19 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Chen\, Rong A" <rong.a.chen@intel.com>,
        "lkp\@01.org" <lkp@01.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Tim C Chen <tim.c.chen@intel.com>
Subject: Re: [LKP] [page cache] eb797a8ee0: vm-scalability.throughput -16.5% regression
References: <20181114092242.GD18977@shao2-debian>
        <20181114141713.GA25731@bombadil.infradead.org>
Date:   Tue, 26 Feb 2019 16:17:18 +0800
In-Reply-To: <20181114141713.GA25731@bombadil.infradead.org> (Matthew Wilcox's
        message of "Wed, 14 Nov 2018 22:17:13 +0800")
Message-ID: <875zt7t14h.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Nov 14, 2018 at 05:22:42PM +0800, kernel test robot wrote:
>> FYI, we noticed a -16.5% regression of vm-scalability.throughput due to commit:
>> commit: eb797a8ee0ab4cd03df556980ce7bf167cadaa50 ("page cache: Rearrange address_space")
>> 
>> in testcase: vm-scalability
>> on test machine: 80 threads Skylake with 64G memory
>> with following parameters:
>> 
>> 	runtime: 300s
>> 	test: small-allocs
>> 	cpufreq_governor: performance
>
> Thanks for the report.  I am surprised by it, because I can't see what
> could have caused this.  On a 64-bit system (which your test is using),
> here's the effect of that patch:
>
> gfp_mask moves from being with private_lock up into a hole adjacent
> to i_mmap_writable.
> wb_err moves from the end of the array up to be with private_lock.
> address_space shrinks by 8 bytes.
>
> Hmm.  Might the shrinking be the problem?  Something in struct inode is
> now split across two cachelines, or is no longer in the same cacheline
> as something else?

It appears that the shrinking causes the regression.  To verify that, I
write a debug patch as follow.  And it recovers the regression.

"
modified   include/linux/fs.h
@@ -437,6 +437,7 @@ struct address_space {
 	spinlock_t		private_lock;
 	struct list_head	private_list;
 	void			*private_data;
+	int			pad0;
 } __attribute__((aligned(sizeof(long)))) __randomize_layout;
 	/*
 	 * On most architectures that alignment is already the case; but
"

Which recovers the size of struct address_space.  And the following
patch by itself recovers the size of struct inode, and it recovers the
regression too.

"
modified   include/linux/fs.h
@@ -704,6 +703,7 @@ struct inode {
 #endif
 
 	void			*i_private; /* fs or device private pointer */
+	long			i_dbg_pad;
 } __randomize_layout;
 
 static inline unsigned int i_blocksize(const struct inode *node)
"

That is, the regression is related with the size of struct inode.  Take
a look at how struct inode is allocated, I found it is allocated via
slab and without any alignment requirement.  After the first bad commit,
the sizeof(struct inode) is changed from 592 to 584, so the cache line
alignment of some inode are changed, which causes the regression.  To
further dig which causes the regression, I make the struct inode/struct
address_space allocation aligned with the cache line, add some pads to
struct address_space, and check the performance difference.  It is found
that if the last 8 or 16 bytes of address_space->i_mmap_rwsem are put in
a separate cache with other fields of address_space->i_mmap_rwsem, the
regression could be recovered.  The layout of struct rw_semphore is as
follow.

struct rw_semaphore {
	atomic_long_t              count;                /*     0     8 */
	struct list_head           wait_list;            /*     8    16 */
	raw_spinlock_t             wait_lock;            /*    24     4 */
	struct optimistic_spin_queue osq;                /*    28     4 */
	struct task_struct *       owner;                /*    32     8 */

	/* size: 40, cachelines: 1, members: 5 */
	/* last cacheline: 40 bytes */
};

This means, we need to put rw_semphore->owner at a different cache line
of other rw_semphore fields to recover the regression.

Back to the regression report.  Most of CPU time is spent for
rw_semphore spinning during the test,

     89.08            +0.7       89.79        perf-profile.self.cycles-pp.osq_lock
      1.02            -0.1        0.89        perf-profile.self.cycles-pp.rwsem_spin_on_owner

So the cache line layout of struct rw_semphore could have big influence
for the test.  And during spinning, the lock holder will update
address_space->i_mmap and address_space->i_mmap_rwsem.count, while the
spinning CPU will keep reading address_space->i_mmap_rwsem.owner, this
will cause cache ping-pong, then cause the regression.  The parent
commit happens to have the right cache line layout, while the first bad
commit doesn't.

As for fixing.  Should we care about the cache line alignment of struct
inode?  Or its size is considered more important because there may be a
huge number of struct inode in the system?

Best Regards,
Huang, Ying

> I'm at Plumbers this week, so I don't have much time to investigate,
> but this regression is very important to me and I shall dig into this
> when I can.  It's OK to revert this commit in the meantime; nothing
> depends on it yet.
>
>> In addition to that, the commit also has significant impact on the following tests:
>> 
>> | testcase: change | unixbench: unixbench.score 20.9% improvement                         |
>
> Huh.  If we had to choose, would a 20.9% improvement in unixbench be more
> important than a 16.5% penalty to will-it-scale?
