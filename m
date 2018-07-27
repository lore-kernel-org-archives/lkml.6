Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70002C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFA9208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFA9208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbeG0So3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:44:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:57632 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730636AbeG0So3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:44:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 10:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,410,1526367600"; 
   d="scan'208";a="61270278"
Received: from theros.lm.intel.com (HELO linux.intel.com) ([10.232.112.164])
  by orsmga006.jf.intel.com with ESMTP; 27 Jul 2018 10:20:35 -0700
Date:   Fri, 27 Jul 2018 11:20:35 -0600
From:   Ross Zwisler <ross.zwisler@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>, zwisler@kernel.org
Cc:     Ross Zwisler <ross.zwisler@linux.intel.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v14 00/74] Convert page cache to XArray
Message-ID: <20180727172035.GA13586@linux.intel.com>
Mail-Followup-To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>, zwisler@kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180617020052.4759-1-willy@infradead.org>
 <20180619031257.GA12527@linux.intel.com>
 <20180619092230.GA1438@bombadil.infradead.org>
 <20180619164037.GA6679@linux.intel.com>
 <20180619171638.GE1438@bombadil.infradead.org>
 <20180627110529.GA19606@bombadil.infradead.org>
 <20180627194438.GA20774@linux.intel.com>
 <20180725210323.GB1366@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725210323.GB1366@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 02:03:23PM -0700, Matthew Wilcox wrote:
> On Wed, Jun 27, 2018 at 01:44:38PM -0600, Ross Zwisler wrote:
> > On Wed, Jun 27, 2018 at 04:05:29AM -0700, Matthew Wilcox wrote:
> > > On Tue, Jun 19, 2018 at 10:16:38AM -0700, Matthew Wilcox wrote:
> > > > I think I see a bug.  No idea if it's the one you're hitting ;-)
> > > > 
> > > > I had been intending to not use the 'entry' to decide whether we were
> > > > waiting on a 2MB or 4kB page, but rather the xas.  I shelved that idea,
> > > > but not before dropping the DAX_PMD flag being passed from the PMD
> > > > pagefault caller.  So if I put that back ...
> > > 
> > > Did you get a chance to test this?
> > 
> > With this patch it doesn't deadlock, but the test dies with a SIGBUS and we
> > hit a WARN_ON in the DAX code:
> > 
> > WARNING: CPU: 5 PID: 1678 at fs/dax.c:226 get_unlocked_entry+0xf7/0x120
> > 
> > I don't have a lot of time this week to debug further.  The quickest path to
> > victory is probably for you to get this reproducing in your test setup.  Does
> > XFS + DAX + generic/340 pass for you?
> 
> I now have generic/340 passing.  I've pushed a new version to
> git://git.infradead.org/users/willy/linux-dax.git xarray

Okay, the next failure I'm hitting is with DAX + XFS + generic/344.  It
doesn't happen every time, but I can usually recreate it within 10 iterations
of the test.  Here's the failure:

generic/344 21s ...[ 1852.564559] run fstests generic/344 at 2018-07-27 11:19:05
[ 1853.033177] XFS (pmem0p2): Unmounting Filesystem
[ 1853.134497] XFS (pmem0p2): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
[ 1853.135335] XFS (pmem0p2): Mounting V5 Filesystem
[ 1853.138119] XFS (pmem0p2): Ending clean mount
[ 1862.251185] WARNING: CPU: 10 PID: 15695 at mm/memory.c:1801 insert_pfn+0x229/0x240
[ 1862.252023] Modules linked in: dax_pmem device_dax nd_pmem nd_btt nfit libnvdimm
[ 1862.252853] CPU: 10 PID: 15695 Comm: holetest Tainted: G        W         4.18.0-rc6-00077-gc79b37ebab6d-dirty #1
[ 1862.253979] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/2014
[ 1862.255232] RIP: 0010:insert_pfn+0x229/0x240
[ 1862.255734] Code: 21 fa 4c 89 4d b0 48 89 45 c0 c6 05 3c 47 74 01 01 e8 db c2 e2 ff 0f 0b 44 8b 45 ac 4c 8b 4d b0 4c 8b 55 b8 48 8b 45 c0 eb 92 <0f> 0b e9 45 fe ff ff 41 bf f4 ff ff ff e9 43 fe ff ff e8 50 c5 e2
[ 1862.257526] RSP: 0000:ffffc9000e197af8 EFLAGS: 00010216
[ 1862.257994] RAX: 0000000000002df7 RBX: ffff8800368ffe00 RCX: 0000000000000002
[ 1862.258673] RDX: 000fffffffffffff RSI: 000000000000000a RDI: 8000000002df7225
[ 1862.259319] RBP: ffffc9000e197b50 R08: 0000000000000001 R09: ffff8800b8fecd48
[ 1862.260097] R10: ffffc9000e197a30 R11: ffff88010d649a80 R12: ffff8800bb616e80
[ 1862.260843] R13: 00007fc2137c0000 R14: 00000000004521d4 R15: 00000000fffffff0
[ 1862.261563] FS:  00007fc2157ff700(0000) GS:ffff880115800000(0000) knlGS:0000000000000000
[ 1862.262420] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1862.263003] CR2: 00007fc2137c0c00 CR3: 00000000b866e000 CR4: 00000000000006e0
[ 1862.263631] Call Trace:
[ 1862.263862]  ? trace_hardirqs_on_caller+0xf4/0x190
[ 1862.264300]  __vm_insert_mixed+0x83/0xd0
[ 1862.264657]  vmf_insert_mixed_mkwrite+0x13/0x40
[ 1862.265066]  dax_iomap_pte_fault+0x760/0x1140
[ 1862.265478]  dax_iomap_fault+0x37/0x40
[ 1862.265816]  __xfs_filemap_fault+0x2de/0x310
[ 1862.266207]  xfs_filemap_page_mkwrite+0x15/0x20
[ 1862.266610]  xfs_filemap_pfn_mkwrite+0xe/0x10
[ 1862.267044]  do_wp_page+0x1bb/0x660
[ 1862.267435]  __handle_mm_fault+0xc78/0x1320
[ 1862.267912]  handle_mm_fault+0x1ba/0x3c0
[ 1862.268359]  __do_page_fault+0x2b4/0x590
[ 1862.268799]  do_page_fault+0x38/0x2c0
[ 1862.269218]  do_async_page_fault+0x2c/0xb0
[ 1862.269674]  ? async_page_fault+0x8/0x30
[ 1862.270081]  async_page_fault+0x1e/0x30
[ 1862.270431] RIP: 0033:0x401442
[ 1862.270709] Code: 1d 20 00 85 f6 0f 85 7d 00 00 00 48 85 db 7e 20 4b 8d 04 34 31 d2 66 90 48 8b 0d 21 1d 20 00 48 0f af ca 48 83 c2 01 48 39 d3 <48> 89 2c 08 75 e8 8b 0d de 1c 20 00 31 c0 85 c9 74 0a 8b 15 d6 1c
[ 1862.272811] RSP: 002b:00007fc2157feec0 EFLAGS: 00010216
[ 1862.273392] RAX: 00007fc213600c00 RBX: 0000000000001000 RCX: 00000000001c0000
[ 1862.274182] RDX: 00000000000001c1 RSI: 0000000000000000 RDI: 0000000000000001
[ 1862.274961] RBP: 00007fc2157ff700 R08: 00007fc2157ff700 R09: 00007fc2157ff700
[ 1862.275740] R10: 00007fc2157ff9d0 R11: 0000000000000202 R12: 00007fc213600000
[ 1862.276519] R13: 00007ffe07faa240 R14: 0000000000000c00 R15: 00007ffe07faa170
[ 1862.277296] irq event stamp: 13256
[ 1862.277666] hardirqs last  enabled at (13255): [<ffffffff81c8c24c>] _raw_spin_unlock_irq+0x2c/0x60
[ 1862.278630] hardirqs last disabled at (13256): [<ffffffff81e011d3>] error_entry+0x93/0x110
[ 1862.279510] softirqs last  enabled at (13250): [<ffffffff820003bf>] __do_softirq+0x3bf/0x520
[ 1862.280410] softirqs last disabled at (13229): [<ffffffff810ac388>] irq_exit+0xe8/0xf0
[ 1862.281251] ---[ end trace 4b8bc73df4e9e7ba ]---
 22s
[ 1874.258598] XFS (pmem0p2): Unmounting Filesystem
[ 1874.347182] XFS (pmem0p2): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
[ 1874.348721] XFS (pmem0p2): Mounting V5 Filesystem
[ 1874.353946] XFS (pmem0p2): Ending clean mount
_check_dmesg: something found in dmesg (see /root/xfstests/results//generic/344.dmesg)
Ran: generic/344
Failures: generic/344
Failed 1 of 1 tests

- Ross
