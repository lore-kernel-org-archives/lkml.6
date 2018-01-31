Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeAaAiu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 19:38:50 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:34970 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751902AbeAaAit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 19:38:49 -0500
X-Google-Smtp-Source: AH8x227oaDUpATt3u/Mn2ptY1m7rEqFkdZd8UfLB8h+OG2s9DqikGzFYzsf6ocfbtja5+Trz2n1rzQ==
Date: Tue, 30 Jan 2018 16:38:46 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+8318ec2d461d10f73b5a54b6b164dc028f9dd9ef@syzkaller.appspotmail.com>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        Stephan Mueller <smueller@chronox.de>
Subject: Re: BUG: sleeping function called from invalid context at
 net/core/sock.c:LINE (2)
Message-ID: <20180131003846.4ry4eh3b32uqhrx5@gmail.com>
References: <94eb2c0308821c7b7d055f458943@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94eb2c0308821c7b7d055f458943@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2017 at 03:19:01AM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> 43f462f1c2e111d2882b48baeeff774ae42e7c56
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> 
> Unfortunately, I don't have any reproducer for this bug yet.
> 
> 
> BUG: sleeping function called from invalid context at net/core/sock.c:2761
> in_atomic(): 1, irqs_disabled(): 0, pid: 23, name: kworker/1:1
> 2 locks held by kworker/1:1/23:
>  #0:  ((wq_completion)"%s"name){+.+.}, at: [<ffffffff8147b244>]
> __write_once_size include/linux/compiler.h:212 [inline]
>  #0:  ((wq_completion)"%s"name){+.+.}, at: [<ffffffff8147b244>] atomic64_set
> arch/x86/include/asm/atomic64_64.h:34 [inline]
>  #0:  ((wq_completion)"%s"name){+.+.}, at: [<ffffffff8147b244>]
> atomic_long_set include/asm-generic/atomic-long.h:57 [inline]
>  #0:  ((wq_completion)"%s"name){+.+.}, at: [<ffffffff8147b244>]
> set_work_data kernel/workqueue.c:618 [inline]
>  #0:  ((wq_completion)"%s"name){+.+.}, at: [<ffffffff8147b244>]
> set_work_pool_and_clear_pending kernel/workqueue.c:645 [inline]
>  #0:  ((wq_completion)"%s"name){+.+.}, at: [<ffffffff8147b244>]
> process_one_work+0xad4/0x1be0 kernel/workqueue.c:2083
>  #1:  ((work_completion)(&squeue->work)){+.+.}, at: [<ffffffff8147b29f>]
> process_one_work+0xb2f/0x1be0 kernel/workqueue.c:2087
> CPU: 1 PID: 23 Comm: kworker/1:1 Not tainted 4.15.0-rc1+ #198
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: pencrypt padata_serial_worker
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  ___might_sleep+0x2b2/0x470 kernel/sched/core.c:6060
>  __might_sleep+0x95/0x190 kernel/sched/core.c:6013
>  lock_sock_nested+0x37/0x110 net/core/sock.c:2761
>  lock_sock include/net/sock.h:1465 [inline]
>  af_alg_async_cb+0x86/0x1a0 crypto/af_alg.c:1039
>  aead_request_complete include/crypto/internal/aead.h:75 [inline]
>  pcrypt_aead_serial+0x75/0xa0 crypto/pcrypt.c:123
>  padata_serial_worker+0x476/0x750 kernel/padata.c:348
>  process_one_work+0xbfd/0x1be0 kernel/workqueue.c:2112
>  worker_thread+0x223/0x1990 kernel/workqueue.c:2246
>  kthread+0x37a/0x440 kernel/kthread.c:238
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:441

This crash stopped occurring around Nov 29.  It seems to have been fixed by the
following commit (merged into mainline by 43570f0383d), so telling syzbot:

#syz fix: crypto: af_alg - remove locking in async callback
