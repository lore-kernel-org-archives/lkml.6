Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEFFC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EF6222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbfBMBYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 20:24:20 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:52413 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfBMBYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 20:24:20 -0500
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1D1OGUD070051;
        Wed, 13 Feb 2019 10:24:16 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Wed, 13 Feb 2019 10:24:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1D1OGIC070047;
        Wed, 13 Feb 2019 10:24:16 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x1D1OGg3070046;
        Wed, 13 Feb 2019 10:24:16 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201902130124.x1D1OGg3070046@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH] proc, oom: do not report alien mms when setting
 =?ISO-2022-JP?B?b29tX3Njb3JlX2Fkag==?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yong-Taek Lee <ytk.lee@samsung.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
MIME-Version: 1.0
Date:   Wed, 13 Feb 2019 10:24:16 +0900
References: <20190212102129.26288-1-mhocko@kernel.org> <20190212125635.27742b5741e92a0d47690c53@linux-foundation.org>
In-Reply-To: <20190212125635.27742b5741e92a0d47690c53@linux-foundation.org>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 12 Feb 2019 11:21:29 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > Tetsuo has reported that creating a thousands of processes sharing MM
> > without SIGHAND (aka alien threads) and setting
> > /proc/<pid>/oom_score_adj will swamp the kernel log and takes ages [1]
> > to finish. This is especially worrisome that all that printing is done
> > under RCU lock and this can potentially trigger RCU stall or softlockup
> > detector.
> > 
> > The primary reason for the printk was to catch potential users who might
> > depend on the behavior prior to 44a70adec910 ("mm, oom_adj: make sure
> > processes sharing mm have same view of oom_score_adj") but after more
> > than 2 years without a single report I guess it is safe to simply remove
> > the printk altogether.
> > 
> > The next step should be moving oom_score_adj over to the mm struct and
> > remove all the tasks crawling as suggested by [2]
> > 
> > [1] http://lkml.kernel.org/r/97fce864-6f75-bca5-14bc-12c9f890e740@i-love.sakura.ne.jp
> > [2] http://lkml.kernel.org/r/20190117155159.GA4087@dhcp22.suse.cz
> 
> I think I'll put a cc:stable on this.  Deleting a might-trigger debug
> printk is safe and welcome.
> 

I don't like this patch, for I can confirm that removing only printk() is not
sufficient for avoiding hungtask warning. If the reason of removing printk() is
that we have never heard that someone hit this printk() for more than 2 years,
the whole iteration is nothing but a garbage. I insist that this iteration
should be removed.

Nacked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Reproducer:
----------------------------------------
#define _GNU_SOURCE
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sched.h>
#include <stdlib.h>
#include <signal.h>

#define STACKSIZE 8192
static int child(void *unused)
{
	int fd = open("/proc/self/oom_score_adj", O_WRONLY);
	write(fd, "0\n", 2);
	close(fd);
	pause();
	return 0;
}
int main(int argc, char *argv[])
{
	int i;
	for (i = 0; i < 8192 * 4; i++)
		if (clone(child, malloc(STACKSIZE) + STACKSIZE, CLONE_VM, NULL) == -1)
			break;
	kill(0, SIGSEGV);
	return 0;
}
----------------------------------------

Removing only printk() from the iteration:
----------------------------------------
[root@localhost tmp]# time ./a.out
Segmentation fault

real    2m16.565s
user    0m0.029s
sys     0m2.631s
[root@localhost tmp]# time ./a.out
Segmentation fault

real    2m20.900s
user    0m0.023s
sys     0m2.380s
[root@localhost tmp]# time ./a.out
Segmentation fault

real    2m19.322s
user    0m0.017s
sys     0m2.433s
[root@localhost tmp]# time ./a.out
Segmentation fault

real    2m22.571s
user    0m0.010s
sys     0m2.447s
[root@localhost tmp]# time ./a.out
Segmentation fault

real    2m17.661s
user    0m0.020s
sys     0m2.390s
----------------------------------------

----------------------------------------
[  189.025075] INFO: task a.out:20327 blocked for more than 120 seconds.
[  189.027580]       Not tainted 5.0.0-rc6+ #828
[  189.029142] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  189.031503] a.out           D28432 20327   9408 0x00000084
[  189.033163] Call Trace:
[  189.034005]  __schedule+0x69a/0x1890
[  189.035363]  ? pci_mmcfg_check_reserved+0x120/0x120
[  189.036863]  schedule+0x7f/0x180
[  189.037910]  schedule_preempt_disabled+0x13/0x20
[  189.039470]  __mutex_lock+0x4c0/0x11a0
[  189.040664]  ? __set_oom_adj+0x84/0xd00
[  189.041870]  ? ww_mutex_lock+0xb0/0xb0
[  189.043111]  ? sched_clock_cpu+0x1b/0x1b0
[  189.044318]  ? find_held_lock+0x40/0x1e0
[  189.045550]  ? kasan_check_read+0x11/0x20
[  189.047060]  mutex_lock_nested+0x16/0x20
[  189.048334]  ? mutex_lock_nested+0x16/0x20
[  189.049562]  __set_oom_adj+0x84/0xd00
[  189.050701]  ? kasan_check_write+0x14/0x20
[  189.051943]  oom_score_adj_write+0x136/0x150
[  189.053217]  ? __set_oom_adj+0xd00/0xd00
[  189.054502]  ? check_prev_add.constprop.42+0x14c0/0x14c0
[  189.055959]  ? sched_clock+0x9/0x10
[  189.057756]  ? check_prev_add.constprop.42+0x14c0/0x14c0
[  189.059323]  __vfs_write+0xe3/0x970
[  189.060406]  ? kernel_read+0x130/0x130
[  189.061578]  ? __lock_acquire+0x7f3/0x1210
[  189.062965]  ? __lock_is_held+0xbc/0x140
[  189.064208]  ? rcu_read_lock_sched_held+0x114/0x130
[  189.065672]  ? rcu_sync_lockdep_assert+0x6d/0xb0
[  189.067042]  ? __sb_start_write+0x1ff/0x2b0
[  189.068297]  vfs_write+0x15b/0x480
[  189.069352]  ksys_write+0xcd/0x1b0
[  189.070581]  ? __ia32_sys_read+0xa0/0xa0
[  189.071710]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  189.073245]  ? __this_cpu_preempt_check+0x13/0x20
[  189.074686]  __x64_sys_write+0x6e/0xb0
[  189.075834]  do_syscall_64+0x8f/0x3e0
[  189.077001]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  189.078696] RIP: 0033:0x7f01546c7fd0
[  189.079836] Code: Bad RIP value.
[  189.081075] RSP: 002b:0000000007aeda58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  189.083315] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f01546c7fd0
[  189.085446] RDX: 0000000000000002 RSI: 0000000000400809 RDI: 0000000000000003
[  189.088254] RBP: 0000000000000000 R08: 0000000000002000 R09: 0000000000002000
[  189.092279] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000040062e
[  189.095213] R13: 00007ffde843a8e0 R14: 0000000000000000 R15: 0000000000000000

[  916.244660] INFO: task a.out:2027 blocked for more than 120 seconds.
[  916.247443]       Not tainted 5.0.0-rc6+ #828
[  916.249667] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  916.252876] a.out           D28432  2027  55700 0x00000084
[  916.255374] Call Trace:
[  916.257012]  ? check_prev_add.constprop.42+0x14c0/0x14c0
[  916.259527]  ? sched_clock_cpu+0x1b/0x1b0
[  916.261620]  ? sched_clock+0x9/0x10
[  916.263620]  ? sched_clock_cpu+0x1b/0x1b0
[  916.265803]  ? find_held_lock+0x40/0x1e0
[  916.267956]  ? lock_release+0x746/0x1050
[  916.270014]  ? schedule+0x7f/0x180
[  916.271887]  ? do_exit+0x54b/0x2ff0
[  916.273879]  ? check_prev_add.constprop.42+0x14c0/0x14c0
[  916.276294]  ? mm_update_next_owner+0x680/0x680
[  916.278454]  ? sched_clock_cpu+0x1b/0x1b0
[  916.280556]  ? find_held_lock+0x40/0x1e0
[  916.282713]  ? get_signal+0x270/0x1850
[  916.284695]  ? __this_cpu_preempt_check+0x13/0x20
[  916.286788]  ? do_group_exit+0xf4/0x2f0
[  916.288738]  ? get_signal+0x2be/0x1850
[  916.290869]  ? __vfs_write+0xe3/0x970
[  916.292751]  ? sched_clock+0x9/0x10
[  916.294608]  ? do_signal+0x99/0x1b90
[  916.296831]  ? check_flags.part.40+0x420/0x420
[  916.299131]  ? setup_sigcontext+0x7d0/0x7d0
[  916.301134]  ? __audit_syscall_exit+0x71f/0x9a0
[  916.303319]  ? rcu_read_lock_sched_held+0x114/0x130
[  916.305503]  ? do_syscall_64+0x2df/0x3e0
[  916.307565]  ? __this_cpu_preempt_check+0x13/0x20
[  916.309703]  ? lockdep_hardirqs_on+0x347/0x5a0
[  916.311748]  ? exit_to_usermode_loop+0x5a/0x120
[  916.314011]  ? trace_hardirqs_on+0x28/0x170
[  916.316218]  ? exit_to_usermode_loop+0x72/0x120
[  916.318416]  ? do_syscall_64+0x2df/0x3e0
[  916.320471]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
----------------------------------------

Removing the whole iteration:
----------------------------------------
[root@localhost tmp]# time ./a.out
Segmentation fault

real    0m0.309s
user    0m0.001s
sys     0m0.197s
[root@localhost tmp]# time ./a.out
Segmentation fault

real    0m0.722s
user    0m0.007s
sys     0m0.543s
[root@localhost tmp]# time ./a.out
Segmentation fault

real    0m0.415s
user    0m0.002s
sys     0m0.250s
[root@localhost tmp]# time ./a.out
Segmentation fault

real    0m0.473s
user    0m0.001s
sys     0m0.233s
[root@localhost tmp]# time ./a.out
Segmentation fault

real    0m0.327s
user    0m0.001s
sys     0m0.204s
[root@localhost tmp]# time ./a.out
Segmentation fault

real    0m0.325s
user    0m0.001s
sys     0m0.190s
[root@localhost tmp]# time ./a.out
Segmentation fault

real    0m0.370s
user    0m0.002s
sys     0m0.217s
[root@localhost tmp]# time ./a.out
Segmentation fault

real    0m0.320s
user    0m0.002s
sys     0m0.184s
[root@localhost tmp]# time ./a.out
Segmentation fault

real    0m0.361s
user    0m0.002s
sys     0m0.248s
[root@localhost tmp]# time ./a.out
Segmentation fault

real    0m0.358s
user    0m0.000s
sys     0m0.231s
----------------------------------------
