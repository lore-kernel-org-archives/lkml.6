Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeAaH1z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:27:55 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41978 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbeAaH1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:27:54 -0500
X-Google-Smtp-Source: AH8x227FwDcm/3XkLlLrhYUyJ57gJVzRehyh1FuZX61RJFOMvqaJ6jeZBc7CsUE9mfyiBEJUpi80zw==
Date: Tue, 30 Jan 2018 23:27:50 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+944a064dbc165044476317df06ebfb218415e951@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, deepa.kernel@gmail.com,
        gscrivan@redhat.com, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, luc.vanoostenryck@gmail.com,
        mingo@kernel.org, netdev@vger.kernel.org, sfr@canb.auug.org.au,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, xiyou.wangcong@gmail.com
Subject: Re: WARNING in refcount_inc (2)
Message-ID: <20180131072750.GF2736@zzz.localdomain>
References: <001a114292fa7f761c0560ad62e1@google.com>
 <001a113f542aed9c4e0560b66f3b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a113f542aed9c4e0560b66f3b@google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2017 at 11:26:01AM -0800, syzbot wrote:
> syzkaller has found reproducer for the following crash on
> 6084b576dca2e898f5c101baef151f7bfdbb606d
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> audit: type=1400 audit(1513711436.700:7): avc:  denied  { map } for
> pid=3124 comm="syzkaller396275" path="/root/syzkaller396275826" dev="sda1"
> ino=16481 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
> ------------[ cut here ]------------
> refcount_t: increment on 0; use-after-free.
> WARNING: CPU: 1 PID: 3125 at lib/refcount.c:153 refcount_inc+0x47/0x50
> lib/refcount.c:153
> Kernel panic - not syncing: panic_on_warn set ...
> 
> CPU: 1 PID: 3125 Comm: syzkaller396275 Not tainted 4.15.0-rc3-next-20171214+
> #67
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0xe9/0x14b lib/dump_stack.c:53
>  panic+0x10e/0x2f8 kernel/panic.c:183
>  __warn+0x14e/0x150 kernel/panic.c:547
>  report_bug+0x11e/0x1a0 lib/bug.c:184
>  fixup_bug.part.11+0x17/0x30 arch/x86/kernel/traps.c:177
>  fixup_bug arch/x86/kernel/traps.c:246 [inline]
>  do_error_trap+0x14a/0x180 arch/x86/kernel/traps.c:295
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:314
>  invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1079
> RIP: 0010:refcount_inc+0x47/0x50 lib/refcount.c:153
> RSP: 0018:ffffc9000186bb90 EFLAGS: 00010282
> RAX: 000000000000002b RBX: ffff880214e2f800 RCX: ffffffff8123dede
> RDX: 0000000000000000 RSI: ffff880214d5f018 RDI: 0000000000000293
> RBP: ffffc9000186bb98 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffc9000186bb18 R11: 0000000000000000 R12: ffffffff8162ef10
> R13: ffff8802156d2578 R14: ffff8802156d2600 R15: 0000000000000001
>  get_ipc_ns include/linux/ipc_namespace.h:129 [inline]
>  __get_ns_from_inode ipc/mqueue.c:110 [inline]
>  get_ns_from_inode ipc/mqueue.c:118 [inline]
>  mqueue_evict_inode+0x69/0x340 ipc/mqueue.c:402
>  evict+0x102/0x230 fs/inode.c:552
>  iput_final fs/inode.c:1514 [inline]
>  iput+0x32b/0x400 fs/inode.c:1541
>  dentry_unlink_inode+0x1ab/0x1e0 fs/dcache.c:375
>  __dentry_kill+0x12d/0x210 fs/dcache.c:572
>  shrink_dentry_list+0x140/0x660 fs/dcache.c:1019
>  shrink_dcache_parent+0x2f/0x90 fs/dcache.c:1453
>  do_one_tree+0x15/0x50 fs/dcache.c:1484
>  shrink_dcache_for_umount+0x37/0xb0 fs/dcache.c:1501
>  generic_shutdown_super+0x2d/0x170 fs/super.c:424
>  kill_anon_super fs/super.c:987 [inline]
>  kill_litter_super+0x36/0x50 fs/super.c:997
>  deactivate_locked_super+0x4d/0x80 fs/super.c:312
>  deactivate_super+0x61/0x90 fs/super.c:343
>  cleanup_mnt+0x49/0x90 fs/namespace.c:1173
>  __cleanup_mnt+0x16/0x20 fs/namespace.c:1180
>  task_work_run+0xa3/0xe0 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x3e6/0x1050 kernel/exit.c:869
>  do_group_exit+0x60/0x100 kernel/exit.c:972
>  SYSC_exit_group kernel/exit.c:983 [inline]
>  SyS_exit_group+0x18/0x20 kernel/exit.c:981
>  entry_SYSCALL_64_fastpath+0x1f/0x96

I'm not able to reproduce this anymore.  Looks like it was another report of the
bug in the patch "ipc, mqueue: lazy call kern_mount_data in new namespaces"
which was present in linux-next for a while but was replaced by "mqueue: switch
to on-demand creation of internal mount" which no longer has the bug.

This report was also on the linux-next version where KASAN had accidentally
gotten disabled in the syzbot config.

So, I'm invalidating this bug so that syzbot can report similar crashes again:

#syz invalid

Also Dmitry, syzbot seems to be grouping together unrelated bugs under the
refcount_t WARNINGs; maybe those should be on a blacklist?

- Eric
