Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967271AbeBPMkh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:40:37 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:60938 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967151AbeBPMkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:40:35 -0500
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: arc: mm->mmap_sem gets locked in do_page_fault() in case of OOM
 killer invocation
Thread-Topic: mm->mmap_sem gets locked in do_page_fault() in case of OOM
 killer invocation
Thread-Index: AQHTpyNUXMYBH9SAIUyk2T8LadpeMQ==
Date: Fri, 16 Feb 2018 12:40:30 +0000
Message-ID: <1518784830.3544.33.camel@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.86]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A9131B80B16FB4EAC4FB40E2B39EC19@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1GCehvP005514

Hi Vineet,

While playing with OOM killer I bumped in a pure software deadlock on ARC
which is even observed in simulation (i.e. it has nothing to do with HW peculiarities).

What's nice kernel even sees that lock-up if "Lock Debugging" is enabled.
That's what I see:
-------------------------------------------->8-------------------------------------------
# /home/oom-test 450 & /home/oom-test 450
oom-test invoked oom-killer: gfp_mask=0x14200ca(GFP_HIGHUSER_MOVABLE), nodemask=(null),  order=0, oom_score_adj=0
CPU: 0 PID: 67 Comm: oom-test Not tainted 4.14.19 #2

Stack Trace:
  arc_unwind_core.constprop.1+0xd4/0xf8
  dump_header.isra.6+0x84/0x2f8
  oom_kill_process+0x258/0x7c8
  out_of_memory+0xb8/0x5e0
  __alloc_pages_nodemask+0x922/0xd28
  handle_mm_fault+0x284/0xd90
  do_page_fault+0xf6/0x2a0
  ret_from_exception+0x0/0x8
Mem-Info:
active_anon:62276 inactive_anon:341 isolated_anon:0
 active_file:0 inactive_file:0 isolated_file:0
 unevictable:0 dirty:0 writeback:0 unstable:0
 slab_reclaimable:26 slab_unreclaimable:196
 mapped:105 shmem:578 pagetables:263 bounce:0
 free:344 free_pcp:39 free_cma:0
Node 0 active_anon:498208kB inactive_anon:2728kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:840kB
dirty:
0kB writeback:0kB shmem:4624kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
Normal free:2752kB min:2840kB low:3544kB high:4248kB active_anon:498208kB inactive_anon:2728kB active_file:0kB inactive_file:0kB unevictable:0kB
writependin
g:0kB present:524288kB managed:508584kB mlocked:0kB kernel_stack:240kB pagetables:2104kB bounce:0kB free_pcp:312kB local_pcp:312kB free_cma:0kB
lowmem_reserve[]: 0 0
Normal: 0*8kB 0*16kB 0*32kB 1*64kB (M) 1*128kB (M) 0*256kB 1*512kB (M) 0*1024kB 1*2048kB (M) 0*4096kB 0*8192kB = 2752kB
578 total pagecache pages
65536 pages RAM
0 pages HighMem/MovableOnly
1963 pages reserved
[ pid ]   uid  tgid total_vm      rss nr_ptes nr_pmds swapents oom_score_adj name
[   41]     0    41      157      103       3       0        0             0 syslogd
[   43]     0    43      156      106       3       0        0             0 klogd
[   63]     0    63      157       99       3       0        0             0 getty
[   64]     0    64      159      118       3       0        0             0 sh
[   66]     0    66   115291    31094     124       0        0             0 oom-test
[   67]     0    67   115291    31004     124       0        0             0 oom-test
Out of memory: Kill process 66 (oom-test) score 476 or sacrifice child
Killed process 66 (oom-test) total-vm:922328kB, anon-rss:248328kB, file-rss:0kB, shmem-rss:424kB

============================================
WARNING: possible recursive locking detected
4.14.19 #2 Not tainted
--------------------------------------------
oom-test/66 is trying to acquire lock:
 (&mm->mmap_sem){++++}, at: [<80217d50>] do_exit+0x444/0x7f8

but task is already holding lock:
 (&mm->mmap_sem){++++}, at: [<8021028a>] do_page_fault+0x9e/0x2a0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&mm->mmap_sem);
  lock(&mm->mmap_sem);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by oom-test/66:
 #0:  (&mm->mmap_sem){++++}, at: [<8021028a>] do_page_fault+0x9e/0x2a0

stack backtrace:
CPU: 0 PID: 66 Comm: oom-test Not tainted 4.14.19 #2

Stack Trace:
  arc_unwind_core.constprop.1+0xd4/0xf8
  __lock_acquire+0x582/0x1494
  lock_acquire+0x3c/0x58
  down_read+0x1a/0x28
  do_exit+0x444/0x7f8
  do_group_exit+0x26/0x8c
  get_signal+0x1aa/0x7d4
  do_signal+0x30/0x220
  resume_user_mode_begin+0x90/0xd8
-------------------------------------------->8-------------------------------------------

Looking at our code in "arch/arc/mm/fault.c" I may see why "mm->mmap_sem" is not released:
1. fatal_signal_pending(current) returns non-zero value
2. ((fault & VM_FAULT_ERROR) && !(fault & VM_FAULT_RETRY)) is false thus up_read(&mm->mmap_sem)
   is not executed.
3. It was a user-space process thus we simply return [with "mm->mmap_sem" still held].

See the code snippet below:
-------------------------------------------->8-------------------------------------------
	/* If Pagefault was interrupted by SIGKILL, exit page fault "early" */
	if (unlikely(fatal_signal_pending(current))) {
		if ((fault & VM_FAULT_ERROR) && !(fault & VM_FAULT_RETRY))
			up_read(&mm->mmap_sem);
		if (user_mode(regs))
			return;
	}
-------------------------------------------->8-------------------------------------------

Then we leave page fault handler and before returning to user-space we
process pending signal which happen to be a death signal and so we end-up executing the
following code-path (see stack trace above):
    do_exit() -> exit_mm() -> down_read(&mm->mmap_sem) <-- And here we go locking ourselves for good.

What's interesting most if not all architectures return from page fault handler with
"mm->mmap_sem" held in case of fatal_signal_pending(). So I would expect the same failure as I see on ARC
to happen on other arches too... though I was not able to trigger that on ARM (WandBoard Quad).

I think because on ARM and many others the check is a bit different:
-------------------------------------------->8-------------------------------------------
	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
		if (!user_mode(regs))
			goto no_context;
		return 0;
	}
-------------------------------------------->8-------------------------------------------

So to get into problematic code-path (i.e. exit with "mm->mmap_sem" still held) we need
__do_page_fault() to return VM_FAULT_RETRY. Which makes reproduction even more complicated but
I think it's still doable :)

The simplest solution here seems to be unconditional up_read(&mm->mmap_sem) before return but
that's so strange it was not done by that time. Anyways any thought are very welcome!

-Alexey
