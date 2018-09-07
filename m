Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21F2C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83559206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83559206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeIGOSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:18:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:54694 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726122AbeIGOSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:18:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61AB2AFE4;
        Fri,  7 Sep 2018 09:38:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3014D1E3613; Fri,  7 Sep 2018 11:38:12 +0200 (CEST)
Date:   Fri, 7 Sep 2018 11:38:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+fe49aec75e221f9b093e@syzkaller.appspotmail.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, mhocko@suse.cz,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Subject: Re: possible deadlock in start_this_handle
Message-ID: <20180907093812.GA18674@quack2.suse.cz>
References: <000000000000005a89057543edbb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000005a89057543edbb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-09-18 01:38:03, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    ca16eb342ebe Merge tag 'for-linus-20180906' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=129e80ae400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6c9564cd177daf0c
> dashboard link: https://syzkaller.appspot.com/bug?extid=fe49aec75e221f9b093e
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+fe49aec75e221f9b093e@syzkaller.appspotmail.com
> 

So this looks like a false positive due to Michal's memalloc_nofs_save()
work and lockdep not being clever enough. And it actually nicely shows how
Michal's work prevents real deadlock possibilities.

> ======================================================
> WARNING: possible circular locking dependency detected
> 4.19.0-rc2+ #2 Not tainted
> ------------------------------------------------------
> kswapd0/1430 is trying to acquire lock:
> 0000000085a9412e (jbd2_handle){++++}, at: start_this_handle+0x589/0x1260
> fs/jbd2/transaction.c:383
> 
> but task is already holding lock:
> 00000000af99a839 (fs_reclaim){+.+.}, at: __page_frag_cache_refill
> mm/page_alloc.c:4476 [inline]
> 00000000af99a839 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x30
> mm/page_alloc.c:4505

So lockdep is complaining about kswapd starting a transaction during fs
reclaim. It should be OK to do so so let's see why lockdep thinks starting
a transaction in fs reclaim is not good.

> the existing dependency chain (in reverse order) is:
> 
> -> #2 (fs_reclaim){+.+.}:
>        __fs_reclaim_acquire mm/page_alloc.c:3728 [inline]
>        fs_reclaim_acquire.part.98+0x24/0x30 mm/page_alloc.c:3739
>        fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3740
>        slab_pre_alloc_hook mm/slab.h:418 [inline]
>        slab_alloc mm/slab.c:3378 [inline]
>        kmem_cache_alloc_trace+0x2d/0x730 mm/slab.c:3618

Here smack is doing GFP_KERNEL allocation. In this case it gets called from
shmfs which is OK with doing fs reclaim... <see below>

>        kmalloc include/linux/slab.h:513 [inline]
>        kzalloc include/linux/slab.h:707 [inline]
>        smk_fetch.part.24+0x5a/0xf0 security/smack/smack_lsm.c:273
>        smk_fetch security/smack/smack_lsm.c:3548 [inline]
>        smack_d_instantiate+0x946/0xea0 security/smack/smack_lsm.c:3502
>        security_d_instantiate+0x5c/0xf0 security/security.c:1287
>        d_instantiate+0x5e/0xa0 fs/dcache.c:1870
>        shmem_mknod+0x189/0x1f0 mm/shmem.c:2812
>        vfs_mknod+0x447/0x800 fs/namei.c:3719
>        handle_create+0x1ff/0x7c0 drivers/base/devtmpfs.c:211
>        handle drivers/base/devtmpfs.c:374 [inline]
>        devtmpfsd+0x27f/0x4c0 drivers/base/devtmpfs.c:400
>        kthread+0x35a/0x420 kernel/kthread.c:246
>        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
> 
> -> #1 (&isp->smk_lock){+.+.}:
>        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
>        __mutex_lock+0x171/0x1700 kernel/locking/mutex.c:1073
>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
>        smack_d_instantiate+0x130/0xea0 security/smack/smack_lsm.c:3369
>        security_d_instantiate+0x5c/0xf0 security/security.c:1287

... while here the same function gets called from ext4 which will have
PF_MEMALLOC_NOFS set so fs reclaim won't happen. Lockdep transfers the
locking dependency through isp->smk_lock as it is not clever enough to know
that this lock in shmfs case is different from this lock in ext4 case -
they are in the same locking class.

So what Smack needs to do to prevent these false positives is to set
locking class of its smk_lock to be different for different filesystem
types. We do the same for other inode-related locks in fs/inode.c:
inode_init_always() - see the lockdep_set_class calls there - so Smack
needs to do something similar.

>        d_instantiate_new+0x7e/0x160 fs/dcache.c:1889
>        ext4_add_nondir+0x81/0x90 fs/ext4/namei.c:2415
>        ext4_symlink+0x761/0x1170 fs/ext4/namei.c:3162
>        vfs_symlink+0x37a/0x5d0 fs/namei.c:4127
>        do_symlinkat+0x242/0x2d0 fs/namei.c:4154
>        __do_sys_symlink fs/namei.c:4173 [inline]
>        __se_sys_symlink fs/namei.c:4171 [inline]
>        __x64_sys_symlink+0x59/0x80 fs/namei.c:4171
>        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
