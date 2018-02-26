Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbeBZUow (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:44:52 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:55676 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752879AbeBZUot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:44:49 -0500
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: Re: arc: mm->mmap_sem gets locked in do_page_fault() in case of OOM
 killer invocation
Thread-Topic: arc: mm->mmap_sem gets locked in do_page_fault() in case of
 OOM killer invocation
Thread-Index: AQHTpyNUXMYBH9SAIUyk2T8LadpeMaO3JjiA
Date: Mon, 26 Feb 2018 20:44:44 +0000
Message-ID: <1519677883.2997.21.camel@synopsys.com>
References: <1518784830.3544.33.camel@synopsys.com>
In-Reply-To: <1518784830.3544.33.camel@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AB982F5A0BDC648B8C39D449D7EA544@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1QKiwgN013242

Hi Vineet, all

On Fri, 2018-02-16 at 15:40 +0300, Alexey Brodkin wrote:
> Hi Vineet,
> 
> While playing with OOM killer I bumped in a pure software deadlock on ARC
> which is even observed in simulation (i.e. it has nothing to do with HW peculiarities).
> 
> What's nice kernel even sees that lock-up if "Lock Debugging" is enabled.
> That's what I see:
> -------------------------------------------->8-------------------------------------------
> # /home/oom-test 450 & /home/oom-test 450
> oom-test invoked oom-killer: gfp_mask=0x14200ca(GFP_HIGHUSER_MOVABLE), nodemask=(null),  order=0, oom_score_adj=0
> CPU: 0 PID: 67 Comm: oom-test Not tainted 4.14.19 #2
> 
> Stack Trace:
>   arc_unwind_core.constprop.1+0xd4/0xf8
>   dump_header.isra.6+0x84/0x2f8
>   oom_kill_process+0x258/0x7c8
>   out_of_memory+0xb8/0x5e0
>   __alloc_pages_nodemask+0x922/0xd28
>   handle_mm_fault+0x284/0xd90
>   do_page_fault+0xf6/0x2a0
>   ret_from_exception+0x0/0x8
> Mem-Info:
> active_anon:62276 inactive_anon:341 isolated_anon:0
>  active_file:0 inactive_file:0 isolated_file:0
>  unevictable:0 dirty:0 writeback:0 unstable:0
>  slab_reclaimable:26 slab_unreclaimable:196
>  mapped:105 shmem:578 pagetables:263 bounce:0
>  free:344 free_pcp:39 free_cma:0
> Node 0 active_anon:498208kB inactive_anon:2728kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB
> mapped:840kB
> dirty:
> 0kB writeback:0kB shmem:4624kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
> Normal free:2752kB min:2840kB low:3544kB high:4248kB active_anon:498208kB inactive_anon:2728kB active_file:0kB inactive_file:0kB unevictable:0kB
> writependin
> g:0kB present:524288kB managed:508584kB mlocked:0kB kernel_stack:240kB pagetables:2104kB bounce:0kB free_pcp:312kB local_pcp:312kB free_cma:0kB
> lowmem_reserve[]: 0 0
> Normal: 0*8kB 0*16kB 0*32kB 1*64kB (M) 1*128kB (M) 0*256kB 1*512kB (M) 0*1024kB 1*2048kB (M) 0*4096kB 0*8192kB = 2752kB
> 578 total pagecache pages
> 65536 pages RAM
> 0 pages HighMem/MovableOnly
> 1963 pages reserved
> [ pid ]   uid  tgid total_vm      rss nr_ptes nr_pmds swapents oom_score_adj name
> [   41]     0    41      157      103       3       0        0             0 syslogd
> [   43]     0    43      156      106       3       0        0             0 klogd
> [   63]     0    63      157       99       3       0        0             0 getty
> [   64]     0    64      159      118       3       0        0             0 sh
> [   66]     0    66   115291    31094     124       0        0             0 oom-test
> [   67]     0    67   115291    31004     124       0        0             0 oom-test
> Out of memory: Kill process 66 (oom-test) score 476 or sacrifice child
> Killed process 66 (oom-test) total-vm:922328kB, anon-rss:248328kB, file-rss:0kB, shmem-rss:424kB
> 
> ============================================
> WARNING: possible recursive locking detected
> 4.14.19 #2 Not tainted
> --------------------------------------------
> oom-test/66 is trying to acquire lock:
>  (&mm->mmap_sem){++++}, at: [<80217d50>] do_exit+0x444/0x7f8
> 
> but task is already holding lock:
>  (&mm->mmap_sem){++++}, at: [<8021028a>] do_page_fault+0x9e/0x2a0
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&mm->mmap_sem);
>   lock(&mm->mmap_sem);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 1 lock held by oom-test/66:
>  #0:  (&mm->mmap_sem){++++}, at: [<8021028a>] do_page_fault+0x9e/0x2a0
> 
> stack backtrace:
> CPU: 0 PID: 66 Comm: oom-test Not tainted 4.14.19 #2
> 
> Stack Trace:
>   arc_unwind_core.constprop.1+0xd4/0xf8
>   __lock_acquire+0x582/0x1494
>   lock_acquire+0x3c/0x58
>   down_read+0x1a/0x28
>   do_exit+0x444/0x7f8
>   do_group_exit+0x26/0x8c
>   get_signal+0x1aa/0x7d4
>   do_signal+0x30/0x220
>   resume_user_mode_begin+0x90/0xd8
> -------------------------------------------->8-------------------------------------------
> 
> Looking at our code in "arch/arc/mm/fault.c" I may see why "mm->mmap_sem" is not released:
> 1. fatal_signal_pending(current) returns non-zero value
> 2. ((fault & VM_FAULT_ERROR) && !(fault & VM_FAULT_RETRY)) is false thus up_read(&mm->mmap_sem)
>    is not executed.
> 3. It was a user-space process thus we simply return [with "mm->mmap_sem" still held].
> 
> See the code snippet below:
> -------------------------------------------->8-------------------------------------------
> 	/* If Pagefault was interrupted by SIGKILL, exit page fault "early" */
> 	if (unlikely(fatal_signal_pending(current))) {
> 		if ((fault & VM_FAULT_ERROR) && !(fault & VM_FAULT_RETRY))
> 			up_read(&mm->mmap_sem);
> 		if (user_mode(regs))
> 			return;
> 	}
> -------------------------------------------->8-------------------------------------------

So I decided to give a trivial fix a try:
-------------------------------------------->8-------------------------------------------
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index a0b7bd6d030d..979a0995100d 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -143,8 +143,10 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
        if (unlikely(fatal_signal_pending(current))) {
                if ((fault & VM_FAULT_ERROR) && !(fault & VM_FAULT_RETRY))
                        up_read(&mm->mmap_sem);
-               if (user_mode(regs))
+               if (user_mode(regs)) {
+                       up_read(&mm->mmap_sem);
                        return;
+               }
        }
-------------------------------------------->8-------------------------------------------

And indeed I no longer see that deadlock but instead I'm getting another fatal failure:
-------------------------------------------->8-------------------------------------------
# while true; do /home/oom-test 450 & /home/oom-test 450; done;
Buffer size is 450 MiB
Buffer size is 450 MiB
oom-test invoked oom-killer: gfp_mask=0x14200ca(GFP_HIGHUSER_MOVABLE), nodemask=(null),  order=0, oom_score_adj=0
CPU: 3 PID: 105 Comm: oom-test Not tainted 4.14.22-dirty #13

Stack Trace:
  arc_unwind_core.constprop.1+0xd0/0xf4
  dump_stack+0x68/0x80
  dump_header.isra.6+0x7c/0x190
  oom_kill_process+0x110/0x618
  out_of_memory+0xb4/0x404
  __alloc_pages_nodemask+0x1b92/0x2734
  handle_mm_fault+0x2e2/0x974
  do_page_fault+0xf6/0x2ac
  ret_from_exception+0x0/0x8
Mem-Info:
active_anon:94872 inactive_anon:344 isolated_anon:0
 active_file:0 inactive_file:0 isolated_file:0
 unevictable:0 dirty:0 writeback:0 unstable:0
 slab_reclaimable:38 slab_unreclaimable:285
 mapped:105 shmem:579 pagetables:392 bounce:0
 free:428 free_pcp:160 free_cma:0
Node 0 active_anon:758976kB inactive_anon:2752kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:840kB
dirty:0s
Normal free:3424kB min:3512kB low:4384kB high:5256kB active_anon:759024kB inactive_anon:2752kB active_file:0kB inactive_file:0kB unevictable:0kB
writependingB
lowmem_reserve[]: 0 0
Normal: 0*8kB 0*16kB 1*32kB (M) 1*64kB (M) 2*128kB (UM) 2*256kB (UM) 1*512kB (M) 2*1024kB (UM) 0*2048kB 0*4096kB 0*8192kB = 3424kB
579 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
131072 pages RAM
0 pages HighMem/MovableOnly
34397 pages reserved
[ pid ]   uid  tgid total_vm      rss nr_ptes nr_pmds swapents oom_score_adj name
[   80]     0    80      157       28       3       0        0             0 syslogd
[   83]     0    83      156       25       3       0        0             0 klogd
[  102]     0   102      157       28       3       0        0             0 getty
[  103]     0   103      159       28       3       0        0             0 sh
[  105]     0   105   115291    47442     188       0        0             0 oom-test
[  106]     0   106   115291    47178     188       0        0             0 oom-test
Out of memory: Kill process 105 (oom-test) score 477 or sacrifice child
Killed process 105 (oom-test) total-vm:922328kB, anon-rss:379112kB, file-rss:0kB, shmem-rss:424kB

Oops
Path: (null)
CPU: 3 PID: 35 Comm: oom_reaper Not tainted 4.14.22-dirty #13
task: bf0e3540 task.stack: bf0e8000

[ECR   ]: 0x00050100 => Invalid Read @ 0x00000360 by insn @ 0x902ec7ae
[EFA   ]: 0x00000360
[BLINK ]: zap_pte_range+0x7e/0x4f8
[ERET  ]: zap_pte_range+0x86/0x4f8
[STAT32]: 0x80080a42 : IE K DE
BTA: 0x902ec7ee  SP: 0xbf0e9e30  FP: 0x00000000
LPS: 0x906d63fc LPE: 0x906d6400 LPC: 0x00000000
r00: 0xbf28001c r01: 0x00000000 r02: 0x00000001
r03: 0x00000000 r04: 0x000000d8 r05: 0x00000000
r06: 0x2f93e000 r07: 0x90818980 r08: 0xbfdc91c4
r09: 0x00000048 r10: 0x00000000 r11: 0xffffffff
r12: 0x902ec7a6

Stack Trace:
  zap_pte_range+0x86/0x4f8
  zap_pmd_range+0x4a/0x64
  zap_pud_range+0x28/0x40
  zap_p4d_range+0x28/0x40
  unmap_page_range+0x54/0xd0
  oom_reaper+0x1c8/0x214
  kthread+0x124/0x140
  ret_from_fork+0x18/0x1c
-------------------------------------------->8-------------------------------------------

Again that failure happens not very reliably - in fact I have to trigger OOM killer
in a loop to face this problem randomly at some point. Though I don't see any logical
connection to initially discussed issue there seems to be some other corner-case we're
not handling properly as I was not able to trigger something like that on ARM's WandBoard.

Still with that new problem in place I cannot conclude my proposed above fix is a good one
so I'll try to get to the bottom of that new issue and then we'll see what to do.

-Alexey
