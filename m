Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF880C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73259218E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546439108;
	bh=Gi9/nRJ3kaG2cJZQG9uE5XPLLyVl6b2M739eWjda5PU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=v5UQpCrbadJYtjy9bxN+yJEmg1Ym2wYAalP600bFaRtIGx2IyyrFhJeONryK/gXuZ
	 Blv0rZAp22CzMa1WB4QmWBRpRoDGO5kJi0GAWHKxhKYMhOee6mKs7pv8b4w+uhPnF6
	 K9ShjEZ3oGEKD/GJRaVIzYszcDoM8DHI99uBR21E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfABOYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 09:24:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfABOYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 09:24:32 -0500
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85AD3218E2;
        Wed,  2 Jan 2019 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546439071;
        bh=Gi9/nRJ3kaG2cJZQG9uE5XPLLyVl6b2M739eWjda5PU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RbNGxy6FBZmxd3+zVPZfyPGYCaT3Ezag7cwxcTs0sF78qW9mLYrpBdLOhxPdmKb93
         c1P6EXNazHzWOf196yqO2+mULBly8fnpSjxGf+Ra4/rbaNx6DubgGL1lDGUHFKPQbu
         zzruOpBoc2ZcFWwLW6IYF4i2+hLZjhj3Rf/vsgC0=
Message-ID: <1baebb04848c3f7f429235f1f1608f61c3e2438e.camel@kernel.org>
Subject: Re: KASAN: use-after-free Read in posix_lock_inode
From:   Jeff Layton <jlayton@kernel.org>
To:     syzbot <syzbot+239d99847eb49ecb3899@syzkaller.appspotmail.com>,
        bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Cc:     NeilBrown <neilb@suse.com>
Date:   Wed, 02 Jan 2019 09:24:29 -0500
In-Reply-To: <000000000000a415f5057e772463@google.com>
References: <000000000000a415f5057e772463@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-02 at 02:31 -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    e1ef035d272e Merge tag 'armsoc-defconfig' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16bb4c4b400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9c6a26e22579190b
> dashboard link: https://syzkaller.appspot.com/bug?extid=239d99847eb49ecb3899
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128aa377400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+239d99847eb49ecb3899@syzkaller.appspotmail.com
> 
> IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
> IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
> 8021q: adding VLAN 0 to HW filter on device batadv0
> 8021q: adding VLAN 0 to HW filter on device batadv0
> ==================================================================
> BUG: KASAN: use-after-free in what_owner_is_waiting_for fs/locks.c:1000  
> [inline]
> BUG: KASAN: use-after-free in posix_locks_deadlock fs/locks.c:1023 [inline]
> BUG: KASAN: use-after-free in posix_lock_inode+0x1f9e/0x2750 fs/locks.c:1163
> Read of size 8 at addr ffff88808791b000 by task syz-executor2/10100
> 
> CPU: 1 PID: 10100 Comm: syz-executor2 Not tainted 4.20.0+ #3
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
>   print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
>   kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
>   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
>   what_owner_is_waiting_for fs/locks.c:1000 [inline]
>   posix_locks_deadlock fs/locks.c:1023 [inline]
>   posix_lock_inode+0x1f9e/0x2750 fs/locks.c:1163
>   posix_lock_file fs/locks.c:1346 [inline]
>   vfs_lock_file fs/locks.c:2314 [inline]
>   vfs_lock_file+0xc7/0xf0 fs/locks.c:2309
>   do_lock_file_wait.part.0+0xe5/0x260 fs/locks.c:2328
>   do_lock_file_wait fs/locks.c:2324 [inline]
>   fcntl_setlk+0x2f1/0xfe0 fs/locks.c:2413
>   do_fcntl+0x843/0x12b0 fs/fcntl.c:370
>   __do_sys_fcntl fs/fcntl.c:463 [inline]
>   __se_sys_fcntl fs/fcntl.c:448 [inline]
>   __x64_sys_fcntl+0x16d/0x1e0 fs/fcntl.c:448
>   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457ec9
> Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
> ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f58bbb50c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000048
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
> RDX: 0000000020000140 RSI: 0000000000000007 RDI: 0000000000000003
> RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f58bbb516d4
> R13: 00000000004be5f0 R14: 00000000004ceab0 R15: 00000000ffffffff
> 
> Allocated by task 10100:
>   save_stack+0x45/0xd0 mm/kasan/common.c:73
>   set_track mm/kasan/common.c:85 [inline]
>   kasan_kmalloc mm/kasan/common.c:482 [inline]
>   kasan_kmalloc+0xcf/0xe0 mm/kasan/common.c:455
>   kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:397
>   kmem_cache_alloc+0x12d/0x710 mm/slab.c:3541
>   kmem_cache_zalloc include/linux/slab.h:730 [inline]
>   locks_alloc_lock+0x8e/0x2f0 fs/locks.c:344
>   fcntl_setlk+0xa9/0xfe0 fs/locks.c:2362
>   do_fcntl+0x843/0x12b0 fs/fcntl.c:370
>   __do_sys_fcntl fs/fcntl.c:463 [inline]
>   __se_sys_fcntl fs/fcntl.c:448 [inline]
>   __x64_sys_fcntl+0x16d/0x1e0 fs/fcntl.c:448
>   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Freed by task 10100:
>   save_stack+0x45/0xd0 mm/kasan/common.c:73
>   set_track mm/kasan/common.c:85 [inline]
>   __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
>   kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
>   __cache_free mm/slab.c:3485 [inline]
>   kmem_cache_free+0x86/0x260 mm/slab.c:3747
>   locks_free_lock+0x27a/0x3f0 fs/locks.c:381
>   fcntl_setlk+0x7b5/0xfe0 fs/locks.c:2439
>   do_fcntl+0x843/0x12b0 fs/fcntl.c:370
>   __do_sys_fcntl fs/fcntl.c:463 [inline]
>   __se_sys_fcntl fs/fcntl.c:448 [inline]
>   __x64_sys_fcntl+0x16d/0x1e0 fs/fcntl.c:448
>   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> The buggy address belongs to the object at ffff88808791b000
>   which belongs to the cache file_lock_cache of size 264
> The buggy address is located 0 bytes inside of
>   264-byte region [ffff88808791b000, ffff88808791b108)
> The buggy address belongs to the page:
> page:ffffea00021e46c0 count:1 mapcount:0 mapping:ffff8880aa16a1c0 index:0x0
> flags: 0x1fffc0000000200(slab)
> raw: 01fffc0000000200 ffffea0002333508 ffffea00021d76c8 ffff8880aa16a1c0
> raw: 0000000000000000 ffff88808791b000 000000010000000c 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>   ffff88808791af00: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
>   ffff88808791af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff88808791b000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                     ^
>   ffff88808791b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff88808791b100: fb fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> 

The interesting bit is that the crash, alloc and free all seem to have
occurred in the same kernel task (PID 10100).

Here's the loop in what_owner_is_waiting_for():

----------------8<------------------
        hash_for_each_possible(blocked_hash, fl, fl_link, posix_owner_key(block_fl)) {
                if (posix_same_owner(fl, block_fl)) {                           
                        while (fl->fl_blocker)            <<<<<< CRASH HERE                           
                                fl = fl->fl_blocker;                            
                        return fl;                                              
                }                                                               
        }        
----------------8<------------------

So fl got freed while we were walking down the chain of blocked locks.
At a quick glance, I'm now wondering whether the lockless optimization
to avoid the blocked_lock_lock in locks_delete_block is actually ok.

Neil, any thoughts?
-- 
Jeff Layton <jlayton@kernel.org>

