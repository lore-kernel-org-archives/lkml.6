Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753859AbeAaAa2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 19:30:28 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:38424 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbeAaAa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 19:30:26 -0500
X-Google-Smtp-Source: AH8x224p1nBYIOR7XN1eCywNe9TblpOxvCSIyZpdYlu6T9H6VoAl1lmo5NtAZWScnCX4CIJ3Nsk+/w==
Date: Tue, 30 Jan 2018 16:30:22 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+eceb3204562c41a438fa1f2335e0fe4f6886d669@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: WARNING: bad unlock balance in ipmr_mfc_seq_stop
Message-ID: <20180131003022.o7qo3eftbjj4qcbk@gmail.com>
References: <001a1144a1ee7405cb0560706451@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a1144a1ee7405cb0560706451@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2017 at 11:52:01PM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> a638349bf6c29433b938141f99225b160551ff48
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> 
> =====================================
> WARNING: bad unlock balance detected!
> 4.15.0-rc3+ #128 Not tainted
> -------------------------------------
> syzkaller971460/3195 is trying to release lock (mrt_lock) at:
> [<000000006898068d>] ipmr_mfc_seq_stop+0xe1/0x130 net/ipv6/ip6mr.c:553
> but there are no more locks to release!
> 
> other info that might help us debug this:
> 1 lock held by syzkaller971460/3195:
>  #0:  (&p->lock){+.+.}, at: [<00000000744a6565>] seq_read+0xd5/0x13d0
> fs/seq_file.c:165
> 
> stack backtrace:
> CPU: 1 PID: 3195 Comm: syzkaller971460 Not tainted 4.15.0-rc3+ #128
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_unlock_imbalance_bug+0x12f/0x140 kernel/locking/lockdep.c:3561
>  __lock_release kernel/locking/lockdep.c:3775 [inline]
>  lock_release+0x5f9/0xda0 kernel/locking/lockdep.c:4023
>  __raw_read_unlock include/linux/rwlock_api_smp.h:225 [inline]
>  _raw_read_unlock+0x1a/0x30 kernel/locking/spinlock.c:255
>  ipmr_mfc_seq_stop+0xe1/0x130 net/ipv6/ip6mr.c:553
>  traverse+0x3bc/0xa00 fs/seq_file.c:135
>  seq_read+0x96a/0x13d0 fs/seq_file.c:189
>  proc_reg_read+0xef/0x170 fs/proc/inode.c:217
>  do_loop_readv_writev fs/read_write.c:673 [inline]
>  do_iter_read+0x3db/0x5b0 fs/read_write.c:897
>  compat_readv+0x1bf/0x270 fs/read_write.c:1140
>  do_compat_preadv64+0xdc/0x100 fs/read_write.c:1189
>  C_SYSC_preadv fs/read_write.c:1209 [inline]
>  compat_SyS_preadv+0x3b/0x50 fs/read_write.c:1203
>  do_syscall_32_irqs_on arch/x86/entry/common.c:327 [inline]
>  do_fast_syscall_32+0x3ee/0xf9d arch/x86/entry/common.c:389
>  entry_SYSENTER_compat+0x51/0x60 arch/x86/entry/entry_64_compat.S:125
> RIP: 0023:0xf7f73c79
> RSP: 002b:00000000e574a15c EFLAGS: 00000292 ORIG_RAX: 000000000000014d
> RAX: ffffffffffffffda RBX: 000000000000000f RCX: 0000000020a3afb0
> RDX: 0000000000000001 RSI: 0000000000000067 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> BUG: sleeping function called from invalid context at lib/usercopy.c:25
> in_atomic(): 1, irqs_disabled(): 0, pid: 3195, name: syzkaller971460
> INFO: lockdep is turned off.
> CPU: 1 PID: 3195 Comm: syzkaller971460 Not tainted 4.15.0-rc3+ #128
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  ___might_sleep+0x2b2/0x470 kernel/sched/core.c:6060
>  __might_sleep+0x95/0x190 kernel/sched/core.c:6013
>  __might_fault+0xab/0x1d0 mm/memory.c:4525
>  _copy_to_user+0x2c/0xc0 lib/usercopy.c:25
>  copy_to_user include/linux/uaccess.h:155 [inline]
>  seq_read+0xcb4/0x13d0 fs/seq_file.c:279
>  proc_reg_read+0xef/0x170 fs/proc/inode.c:217
>  do_loop_readv_writev fs/read_write.c:673 [inline]
>  do_iter_read+0x3db/0x5b0 fs/read_write.c:897
>  compat_readv+0x1bf/0x270 fs/read_write.c:1140
>  do_compat_preadv64+0xdc/0x100 fs/read_write.c:1189
>  C_SYSC_preadv fs/read_write.c:1209 [inline]
>  compat_SyS_preadv+0x3b/0x50 fs/read_write.c:1203
>  do_syscall_32_irqs_on arch/x86/entry/common.c:327 [inline]
>  do_fast_syscall_32+0x3ee/0xf9d arch/x86/entry/common.c:389
>  entry_SYSENTER_compat+0x51/0x60 arch/x86/entry/entry_64_compat.S:125
> RIP: 0023:0xf7f73c79
> RSP: 002b:00000000e574a15c EFLAGS: 00000292 ORIG_RAX: 000000000000014d
> RAX: ffffffffffffffda RBX: 000000000000000f RCX: 0000000020a3afb0
> RDX: 0000000000000001 RSI: 0000000000000067 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> WARNING: CPU: 1 PID: 3195 at lib/usercopy.c:26 _copy_to_user+0xb5/0xc0
> lib/usercopy.c:26
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> Please credit me with: Reported-by: syzbot <syzkaller@googlegroups.com>
> 
> syzbot will keep track of this bug report.
> Once a fix for this bug is merged into any tree, reply to this email with:
> #syz fix: exact-commit-title
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch
> and provide the patch inline or as an attachment.
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.

This is still happening.  Here's a simplified reproducer, assuming that
CONFIG_IPV6_MROUTE and CONFIG_PROVE_LOCKING are enabled:

#include <fcntl.h>
#include <linux/mroute6.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <unistd.h>

int main()
{
	struct mf6cctl ctl = { };
	int cachefd = open("/proc/self/net/ip6_mr_cache", O_RDONLY);
	int sockfd = socket(AF_INET6, SOCK_RAW, 0x3aul);
	char buf[2];

	if (fork() == 0) {
		for (;;)
			pread(cachefd, buf, 2, 103);
	} else {
		for (;;) {
			setsockopt(sockfd, SOL_IPV6, MRT6_ADD_MFC,
				   &ctl, sizeof(ctl));
		}
	}
}
