Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeFEOhz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:37:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:51865 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752378AbeFEOhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:37:54 -0400
Date: Tue, 5 Jun 2018 16:35:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        torvalds@linux-foundation.org, snitzer@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm: Use kzalloc for all structs with embedded
 biosets/mempools
Message-ID: <20180605143507.2o3qm4r6euvyhe5g@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jens Axboe <axboe@kernel.dk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        torvalds@linux-foundation.org, snitzer@redhat.com,
        linux-kernel@vger.kernel.org
References: <20180605092633.29583-1-kent.overstreet@gmail.com>
 <e78b0f9f-d4f9-d865-0727-5e1ed074928d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e78b0f9f-d4f9-d865-0727-5e1ed074928d@kernel.dk>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 08:22:22AM -0600, Jens Axboe wrote:
> > I fucked up majorly on the bioset/mempool conversion - I forgot to check that
> > everything biosets/mempools were being embedded in was actually being zeroed on
> > allocation. Device mapper currently explodes, you'll probably want to apply this
> > patch post haste.
> > 
> > I have now done that auditing, for every single conversion - this patch fixes
> > everything I found. There do not seem to be any incorrect ones outside of device
> > mapper...
> > 
> > We'll probably want a second patch that either a) changes
> > bioset_init()/mempool_init() to zero the passed in bioset/mempool first, or b)
> > my preference, WARN() or BUG() if they're passed memory that isn't zeroed.
> 
> Odd, haven't seen a crash, but probably requires kasan or poisoning to
> trigger anything? Mike's tree also had the changes, since they were based
> on the block tree.

eg. fstests/generic/081 crashes (trace below), no KASAN, PAGE_POISONING=y,
PAGE_POISONING_NO_SANITY=y.

> I can queue this up and ship it later today. Mike, you want to review
> this one?

Would be great to push that soon. The fstests build on several DM targets, the
crashes lead to many test failures. I'm going to test the kzalloc fix now.

[ 8546.936276] BUG: unable to handle kernel paging request at ffff8a3314cabf98
[ 8546.943407] PGD 1e4915067 P4D 1e4915067 PUD 0 
[ 8546.948006] Oops: 0000 [#1] PREEMPT SMP
[ 8546.951984] CPU: 5 PID: 11452 Comm: lvm Not tainted 4.17.0-1.ge195904-vanilla+ #249
[ 8546.959849] Hardware name: empty empty/S3993, BIOS PAQEX0-3 02/24/2008
[ 8546.966532] RIP: 0010:remove_element.isra.8+0x2e/0x200
[ 8546.991185] RSP: 0018:ffff9af9c1bf3ba8 EFLAGS: 00010206
[ 8546.996553] RAX: 000000006b6b6b6a RBX: ffff8a2fb95d8008 RCX: 0000000000000000
[ 8547.003831] RDX: 000000006b6b6b6b RSI: 0000000000000000 RDI: ffff8a2fb95d8008
[ 8547.011107] RBP: 000000006b6b6b6a R08: 0000000000000000 R09: 0000000000000001
[ 8547.018378] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a2fb96f6448
[ 8547.025668] R13: ffff8a2fb0ee6d58 R14: ffffffffc05d2a00 R15: ffff9af9c1bf3d08
[ 8547.032956] FS:  00007fe863936880(0000) GS:ffff8a2fe7000000(0000) knlGS:0000000000000000
[ 8547.041269] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8547.047167] CR2: ffff8a3314cabf98 CR3: 00000001fee98000 CR4: 00000000000006e0
[ 8547.054457] Call Trace:
[ 8547.057078]  ? dev_wait+0xa0/0xa0 [dm_mod]
[ 8547.061323]  mempool_exit+0x18/0x50
[ 8547.064974]  dm_io_client_destroy+0xe/0x30 [dm_mod]
[ 8547.070028]  dm_kcopyd_client_destroy+0x86/0x130 [dm_mod]
[ 8547.075614]  ? dev_wait+0xa0/0xa0 [dm_mod]
[ 8547.079875]  snapshot_dtr+0xb3/0x170 [dm_snapshot]
[ 8547.084844]  dm_table_destroy+0x62/0x140 [dm_mod]
[ 8547.089720]  ? dev_wait+0xa0/0xa0 [dm_mod]
[ 8547.094000]  dev_suspend+0xe6/0x270 [dm_mod]
[ 8547.098448]  ctl_ioctl+0x220/0x540 [dm_mod]
[ 8547.102845]  dm_ctl_ioctl+0xa/0x10 [dm_mod]
[ 8547.107196]  do_vfs_ioctl+0x91/0x6c0
[ 8547.110923]  ? kfree+0x1e5/0x310
[ 8547.114313]  ? syscall_trace_enter+0x1ce/0x3c0
[ 8547.118915]  ksys_ioctl+0x70/0x80
[ 8547.122388]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[ 8547.127247]  __x64_sys_ioctl+0x16/0x20
[ 8547.131140]  do_syscall_64+0x62/0x1c0
[ 8547.134968]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
