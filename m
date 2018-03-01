Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031199AbeCAOKB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:10:01 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46543 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030989AbeCAOJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:09:58 -0500
X-Google-Smtp-Source: AG47ELsx6lr4oxHzjWaIQn2AW4iL1Cx3zJKNjCNymWHE+C60BYPxBzzMYk41PbX2DRLDZEbu3bTj7hzkYMWhYe9wfTA=
MIME-Version: 1.0
In-Reply-To: <201803011906.JCI39072.NGYSNtPVOJMNt@I-love.SAKURA.ne.jp>
References: <20180224053405.ksymb5yurtpwmfs6@shao2-debian> <20180228102334.65iqne6lu5faan52@pathway.suse.cz>
 <20180228155941.34z45rjz3bjqde7w@pathway.suse.cz> <20180301013722.GA6763@tigerII.localdomain>
 <CACT4Y+ZuCq+yN3YwusmHuv1CN86CfEYEhaJGoaD7xLG9irgyYw@mail.gmail.com> <201803011906.JCI39072.NGYSNtPVOJMNt@I-love.SAKURA.ne.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 1 Mar 2018 15:09:36 +0100
Message-ID: <CACT4Y+ZkbkjJw=diHQbqHOBdbcs9zDUS0ggqwrLU02U_tEP73g@mail.gmail.com>
Subject: Re: [lkp-robot] [printk] c162d5b433: BUG:KASAN:use-after-scope_in_c
To: Tetsuo Handa <from-linux-mm@i-love.sakura.ne.jp>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, kernel test robot <shun.hao@intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Byungchul Park <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w21EA9Bl002199

On Thu, Mar 1, 2018 at 11:06 AM, Tetsuo Handa
<from-linux-mm@i-love.sakura.ne.jp> wrote:
> Dmitry Vyukov wrote:
>> Hi Shun,
>>
>> The report says "job-script is attached in this email", but I don't
>> see it attached. Did you forget to attach it? How can I reproduce this
>> exact build?
>> Could you post a symbolized report with inlines frames?
>>
>
> Forwarded by penguin-kernel@i-love.sakura.ne.jp
> ----------------------- Original Message -----------------------
>  From:    Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
>  To:      Petr Mladek <pmladek@suse.com>
>  Cc:      kernel test robot <shun.hao@intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Dave Hansen <dave.hansen@intel.com>, Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Byungchul Park <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, LKML <linux-kernel@vger.kernel.org>, lkp@01.org
>  Date:    Thu, 01 Mar 2018 10:08:19 +0900
>  Subject: Re: [lkp-robot] [printk]  c162d5b433: BUG:KASAN:use-after-scope_in_c
> ----
>
> Petr Mladek wrote:
>> I am really curious what code is proceed on the line
>> console_unlock+0x185/0x960.
>
> I can reproduce this warning with VMware environment.
> Something is happening inside __asan_store1() before calling raw_spin_lock(&console_owner_lock) ?
>
>
>
> [    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.14.0-12953-gc162d5b root=UUID=98df1583-260a-423a-a193-182dade5d085 ro crashkernel=256M security=none sysrq_always_enabled console=ttyS0,115200n8 console=tty0 LANG=en_US.UTF-8
> [    0.000000] sysrq: sysrq always enabled.
> [    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
> [    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
> [    0.000000] Memory: 3045216K/4193716K available (15633K kernel code, 6278K rwdata, 6948K rodata, 3592K init, 24228K bss, 1148500K reserved, 0K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=64, Nodes=1
> [    0.000000] ftrace: allocating 34522 entries in 135 pages
> [    0.003333] Running RCU self tests
> [    0.003333] Hierarchical RCU implementation.
> [    0.003333]  RCU event tracing is enabled.
> [    0.003333]  RCU dyntick-idle grace-period acceleration is enabled.
> [    0.003333]  RCU lockdep checking is enabled.
> [    0.003333]  Tasks RCU enabled.
> [    0.003333] NR_IRQS: 4352, nr_irqs: 936, preallocated irqs: 16
> [    0.003333]  Offload RCU callbacks from CPUs: .
> [    0.003333] ==================================================================
> [    0.003333] BUG: KASAN: use-after-scope in console_unlock+0x185/0x960
> [    0.003333] Write of size 1 at addr ffffffff828079b8 by task swapper/0
> [    0.003333]
> [    0.003333] CPU: 0 PID: 0 Comm: swapper Not tainted 4.14.0-12953-gc162d5b #414
> [    0.003333] Call Trace:
> [    0.003333]  ? dump_stack+0x11d/0x1c5
> [    0.003333]  ? printk+0xb5/0xd1
> [    0.003333]  ? arch_local_irq_restore+0x17/0x17
> [    0.003333]  ? do_raw_spin_unlock+0x137/0x169
> [    0.003333]  ? irq_trace+0x2e/0x32
> [    0.003333]  ? console_unlock+0x185/0x960
> [    0.003333]  ? print_address_description+0x6e/0x23b
> [    0.003333]  ? console_unlock+0x185/0x960
> [    0.003333]  ? kasan_report+0x223/0x249
> [    0.003333]  ? console_unlock+0x185/0x960
> [    0.003333]  ? wake_up_klogd+0xdf/0xdf
> [    0.003333]  ? do_raw_spin_unlock+0x145/0x169
> [    0.003333]  ? do_raw_spin_trylock+0xed/0xed
> [    0.003333]  ? irq_trace+0x2e/0x32
> [    0.003333]  ? _raw_spin_unlock_irqrestore+0x3b/0x54
> [    0.003333]  ? time_hardirqs_off+0x12/0x2d
> [    0.003333]  ? arch_local_save_flags+0x7/0x8
> [    0.003333]  ? trace_hardirqs_off_caller+0x127/0x139
> [    0.003333]  ? irq_trace+0x2e/0x32
> [    0.003333]  ? vprintk_emit+0x579/0x823
> [    0.003333]  ? __down_trylock_console_sem+0x90/0xa4
> [    0.003333]  ? __down_trylock_console_sem+0x9d/0xa4
> [    0.003333]  ? vprintk_emit+0x7ec/0x823
> [    0.003333]  ? console_unlock+0x960/0x960
> [    0.003333]  ? memblock_merge_regions+0x2d/0x154
> [    0.003333]  ? memblock_add_range+0x322/0x333
> [    0.003333]  ? memblock_reserve+0xbb/0xe1
> [    0.003333]  ? memblock_add+0xe1/0xe1
> [    0.003333]  ? set_pte+0x24/0x27
> [    0.003333]  ? vprintk_func+0x94/0xa5
> [    0.003333]  ? printk+0xb5/0xd1
> [    0.003333]  ? show_regs_print_info+0x41/0x41
> [    0.003333]  ? kasan_populate_zero_shadow+0x37b/0x3f6
> [    0.003333]  ? native_flush_tlb_global+0x74/0x80
> [    0.003333]  ? kasan_init+0x211/0x22d
> [    0.003333]  ? setup_arch+0xdfa/0xf3c
> [    0.003333]  ? css_set_populated+0x79/0x79
> [    0.003333]  ? reserve_standard_io_resources+0x39/0x39
> [    0.003333]  ? vprintk_func+0x9d/0xa5
> [    0.003333]  ? printk+0xb5/0xd1
> [    0.003333]  ? show_regs_print_info+0x41/0x41
> [    0.003333]  ? start_kernel+0xa2/0x515
> [    0.003333]  ? mem_encrypt_init+0xa/0xa
> [    0.003333]  ? x86_family+0x2e/0x33
> [    0.003333]  ? load_ucode_bsp+0x58/0xec
> [    0.003333]  ? secondary_startup_64+0xa5/0xb0
> [    0.003333]
> [    0.003333]
> [    0.003333] Memory state around the buggy address:
> [    0.003333]  ffffffff82807880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.003333]  ffffffff82807900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.003333] >ffffffff82807980: 00 00 00 f1 f1 f1 f1 f8 f2 f2 f2 f2 f2 f2 f2 01
> [    0.003333]                                         ^
> [    0.003333]  ffffffff82807a00: f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f3 f3 f3 f3 00
> [    0.003333]  ffffffff82807a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1
> [    0.003333] ==================================================================
> [    0.003333] Disabling lock debugging due to kernel taint
> [    0.003333] ==================================================================
> [    0.003333] BUG: KASAN: use-after-scope in console_unlock+0x185/0x960
> [    0.003333] Write of size 1 at addr ffffffff828079b8 by task swapper/0
> [    0.003333]
> [    0.003333] CPU: 0 PID: 0 Comm: swapper Not tainted 4.14.0-12953-gc162d5b #414
> [    0.003333] Call Trace:
> [    0.003333]  ? dump_stack+0x11d/0x1c5
> [    0.003333]  ? printk+0xb5/0xd1
> [    0.003333]  ? arch_local_irq_restore+0x17/0x17
> [    0.003333]  ? do_raw_spin_unlock+0x137/0x169
> [    0.003333]  ? irq_trace+0x2e/0x32
> [    0.003333]  ? console_unlock+0x185/0x960
> [    0.003333]  ? print_address_description+0x6e/0x23b
> [    0.003333]  ? console_unlock+0x185/0x960
> [    0.003333]  ? kasan_report+0x223/0x249
> [    0.003333]  ? console_unlock+0x185/0x960
> [    0.003333]  ? wake_up_klogd+0xdf/0xdf
> [    0.003333]  ? do_raw_spin_unlock+0x145/0x169
> [    0.003333]  ? do_raw_spin_trylock+0xed/0xed
> [    0.003333]  ? irq_trace+0x2e/0x32
> [    0.003333]  ? _raw_spin_unlock_irqrestore+0x3b/0x54
> [    0.003333]  ? time_hardirqs_off+0x12/0x2d
> [    0.003333]  ? arch_local_save_flags+0x7/0x8
> [    0.003333]  ? trace_hardirqs_off_caller+0x127/0x139
> [    0.003333]  ? irq_trace+0x2e/0x32
> [    0.003333]  ? vprintk_emit+0x579/0x823
> [    0.003333]  ? __down_trylock_console_sem+0x90/0xa4
> [    0.003333]  ? __down_trylock_console_sem+0x9d/0xa4
> [    0.003333]  ? vprintk_emit+0x7ec/0x823
> [    0.003333]  ? console_unlock+0x960/0x960
> [    0.003333]  ? memblock_merge_regions+0x2d/0x154
> [    0.003333]  ? memblock_add_range+0x322/0x333
> [    0.003333]  ? memblock_reserve+0xbb/0xe1
> [    0.003333]  ? memblock_add+0xe1/0xe1
> [    0.003333]  ? set_pte+0x24/0x27
> [    0.003333]  ? vprintk_func+0x94/0xa5
> [    0.003333]  ? printk+0xb5/0xd1
> [    0.003333]  ? show_regs_print_info+0x41/0x41
> [    0.003333]  ? kasan_populate_zero_shadow+0x37b/0x3f6
> [    0.003333]  ? native_flush_tlb_global+0x74/0x80
> [    0.003333]  ? kasan_init+0x211/0x22d
> [    0.003333]  ? setup_arch+0xdfa/0xf3c
> [    0.003333]  ? css_set_populated+0x79/0x79
> [    0.003333]  ? reserve_standard_io_resources+0x39/0x39
> [    0.003333]  ? vprintk_func+0x9d/0xa5
> [    0.003333]  ? printk+0xb5/0xd1
> [    0.003333]  ? show_regs_print_info+0x41/0x41
> [    0.003333]  ? start_kernel+0xa2/0x515
> [    0.003333]  ? mem_encrypt_init+0xa/0xa
> [    0.003333]  ? x86_family+0x2e/0x33
> [    0.003333]  ? load_ucode_bsp+0x58/0xec
> [    0.003333]  ? secondary_startup_64+0xa5/0xb0
> [    0.003333]
> [    0.003333]
> [    0.003333] Memory state around the buggy address:
> [    0.003333]  ffffffff82807880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.003333]  ffffffff82807900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.003333] >ffffffff82807980: 00 00 00 f1 f1 f1 f1 f8 f2 f2 f2 f2 f2 f2 f2 01
> [    0.003333]                                         ^
> [    0.003333]  ffffffff82807a00: f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f3 f3 f3 f3 00
> [    0.003333]  ffffffff82807a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1
> [    0.003333] ==================================================================
> [    0.003333] Disabling lock debugging due to kernel taint
> [    0.003333] ==================================================================
>
>
>
> # ./scripts/faddr2line vmlinux console_unlock+0x185/0x960
> console_unlock+0x185/0x960:
> console_lock_spinning_disable_and_check at kernel/printk/printk.c:1600
>  (inlined by) console_unlock at kernel/printk/printk.c:2386
>
>
>
> ffffffff81190da4 <console_unlock>:
>  * If there is output waiting, we wake /dev/kmsg and syslog() users.
>  *
>  * console_unlock(); may be called from any context.
>  */
> void console_unlock(void)
> {
> ffffffff81190da4:       e8 57 e1 da 00          callq  ffffffff81f3ef00 <__fentry__>
> ffffffff81190da9:       55                      push   %rbp
> ffffffff81190daa:       48 89 e5                mov    %rsp,%rbp
> ffffffff81190dad:       41 57                   push   %r15
> ffffffff81190daf:       41 56                   push   %r14
> ffffffff81190db1:       48 8d 85 f8 fe ff ff    lea    -0x108(%rbp),%rax
> ffffffff81190db8:       41 55                   push   %r13
> ffffffff81190dba:       41 54                   push   %r12
> ffffffff81190dbc:       53                      push   %rbx
> ffffffff81190dbd:       48 bb 00 00 00 00 00    movabs $0xdffffc0000000000,%rbx
> ffffffff81190dc4:       fc ff df
> ffffffff81190dc7:       48 c1 e8 03             shr    $0x3,%rax
> ffffffff81190dcb:       48 81 ec 20 01 00 00    sub    $0x120,%rsp
> ffffffff81190dd2:       48 89 85 d0 fe ff ff    mov    %rax,-0x130(%rbp)
> ffffffff81190dd9:       48 01 d8                add    %rbx,%rax
> ffffffff81190ddc:       48 c7 85 f8 fe ff ff    movq   $0x41b58ab3,-0x108(%rbp)
> ffffffff81190de3:       b3 8a b5 41
> ffffffff81190de7:       48 c7 85 00 ff ff ff    movq   $0xffffffff825fb4c2,-0x100(%rbp)
> ffffffff81190dee:       c2 b4 5f 82
> ffffffff81190df2:       48 c7 85 08 ff ff ff    movq   $0xffffffff81190da4,-0xf8(%rbp)
> ffffffff81190df9:       a4 0d 19 81
> ffffffff81190dfd:       c7 00 f1 f1 f1 f1       movl   $0xf1f1f1f1,(%rax)
> ffffffff81190e03:       c7 40 04 01 f2 f2 f2    movl   $0xf2f2f201,0x4(%rax)
> ffffffff81190e0a:       c7 40 08 f2 f2 f2 f2    movl   $0xf2f2f2f2,0x8(%rax)
> ffffffff81190e11:       c7 40 0c 01 f2 f2 f2    movl   $0xf2f2f201,0xc(%rax)
> ffffffff81190e18:       c7 40 10 f2 f2 f2 f2    movl   $0xf2f2f2f2,0x10(%rax)
> ffffffff81190e1f:       c7 40 14 00 f2 f2 f2    movl   $0xf2f2f200,0x14(%rax)
> ffffffff81190e26:       c7 40 18 f3 f3 f3 f3    movl   $0xf3f3f3f3,0x18(%rax)
>         static u64 seen_seq;
>         unsigned long flags;
>         bool wake_klogd = false;
>         bool do_cond_resched, retry;
>
>         if (console_suspended) {
> ffffffff81190e2d:       e8 3f 82 08 00          callq  ffffffff81219071 <__sanitizer_cov_trace_pc>
> ffffffff81190e32:       83 3d a7 c2 14 03 00    cmpl   $0x0,0x314c2a7(%rip)        # ffffffff842dd0e0 <console_suspended>
> ffffffff81190e39:       74 0a                   je     ffffffff81190e45 <console_unlock+0xa1>
>                 up_console_sem();
> ffffffff81190e3b:       e8 31 82 08 00          callq  ffffffff81219071 <__sanitizer_cov_trace_pc>
> ffffffff81190e40:       e9 85 08 00 00          jmpq   ffffffff811916ca <console_unlock+0x926>
>          *
>          * console_trylock() is not able to detect the preemptive
>          * context reliably. Therefore the value must be stored before
>          * and cleared after the the "again" goto label.
>          */
>         do_cond_resched = console_may_schedule;
> ffffffff81190e45:       e8 27 82 08 00          callq  ffffffff81219071 <__sanitizer_cov_trace_pc>
> ffffffff81190e4a:       8b 05 b0 c0 14 03       mov    0x314c0b0(%rip),%eax        # ffffffff842dcf00 <console_may_schedule>
> {
>         static char ext_text[CONSOLE_EXT_LOG_MAX];
>         static char text[LOG_LINE_MAX + PREFIX_MAX];
>         static u64 seen_seq;
>         unsigned long flags;
>         bool wake_klogd = false;
> ffffffff81190e50:       45 31 ed                xor    %r13d,%r13d
> ffffffff81190e53:       48 89 9d e8 fe ff ff    mov    %rbx,-0x118(%rbp)
>          *
>          * console_trylock() is not able to detect the preemptive
>          * context reliably. Therefore the value must be stored before
>          * and cleared after the the "again" goto label.
>          */
>         do_cond_resched = console_may_schedule;
> ffffffff81190e5a:       89 85 cc fe ff ff       mov    %eax,-0x134(%rbp)
> again:
>         console_may_schedule = 0;
> ffffffff81190e60:       e8 0c 82 08 00          callq  ffffffff81219071 <__sanitizer_cov_trace_pc>
>  * unless they're explicitly marked as being able to cope (CON_ANYTIME) don't
>  * call them until this CPU is officially up.
>  */
> static inline int can_use_console(void)
> {
>         return cpu_online(raw_smp_processor_id()) || have_callable_console();
> ffffffff81190e65:       65 8b 05 bc 22 e8 7e    mov    %gs:0x7ee822bc(%rip),%eax        # 13128 <cpu_number>
>          * context reliably. Therefore the value must be stored before
>          * and cleared after the the "again" goto label.
>          */
>         do_cond_resched = console_may_schedule;
> again:
>         console_may_schedule = 0;
> ffffffff81190e6c:       c7 05 8a c0 14 03 00    movl   $0x0,0x314c08a(%rip)        # ffffffff842dcf00 <console_may_schedule>
> ffffffff81190e73:       00 00 00
>  *
>  * Returns 1 if @cpu is set in @cpumask, else returns 0
>  */
> static inline int cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
> {
>         return test_bit(cpumask_check(cpu), cpumask_bits((cpumask)));
> ffffffff81190e76:       89 c0                   mov    %eax,%eax
>
> static __always_inline bool variable_test_bit(long nr, volatile const unsigned long *addr)
> {
>         bool oldbit;
>
>         asm volatile("bt %2,%1"
> ffffffff81190e78:       48 0f a3 05 a8 ad c8    bt     %rax,0x1c8ada8(%rip)        # ffffffff82e1bc28 <__cpu_online_mask>
> ffffffff81190e7f:       01
> ffffffff81190e80:       49 c7 c6 28 bc e1 82    mov    $0xffffffff82e1bc28,%r14
>  * unless they're explicitly marked as being able to cope (CON_ANYTIME) don't
>  * call them until this CPU is officially up.
>  */
> static inline int can_use_console(void)
> {
>         return cpu_online(raw_smp_processor_id()) || have_callable_console();
> ffffffff81190e87:       0f 82 a3 01 00 00       jb     ffffffff81191030 <console_unlock+0x28c>
>  */
> static int have_callable_console(void)
> {
>         struct console *con;
>
>         for_each_console(con)
> ffffffff81190e8d:       e8 df 81 08 00          callq  ffffffff81219071 <__sanitizer_cov_trace_pc>
> ffffffff81190e92:       48 8b 1d 07 c3 14 03    mov    0x314c307(%rip),%rbx        # ffffffff842dd1a0 <console_drivers>
> ffffffff81190e99:       e8 d3 81 08 00          callq  ffffffff81219071 <__sanitizer_cov_trace_pc>
> ffffffff81190e9e:       48 85 db                test   %rbx,%rbx
> ffffffff81190ea1:       0f 84 14 08 00 00       je     ffffffff811916bb <console_unlock+0x917>
>                 if ((con->flags & CON_ENABLED) &&
> ffffffff81190ea7:       e8 c5 81 08 00          callq  ffffffff81219071 <__sanitizer_cov_trace_pc>
> ffffffff81190eac:       48 8d 7b 40             lea    0x40(%rbx),%rdi
> ffffffff81190eb0:       e8 bd 51 1f 00          callq  ffffffff81386072 <__asan_load2>
> ffffffff81190eb5:       8b 43 40                mov    0x40(%rbx),%eax
> ffffffff81190eb8:       83 e0 14                and    $0x14,%eax
> ffffffff81190ebb:       66 83 f8 14             cmp    $0x14,%ax
> ffffffff81190ebf:       0f 84 6b 01 00 00       je     ffffffff81191030 <console_unlock+0x28c>
>  */
> static int have_callable_console(void)
> {
>         struct console *con;
>
>         for_each_console(con)
> ffffffff81190ec5:       e8 a7 81 08 00          callq  ffffffff81219071 <__sanitizer_cov_trace_pc>
> ffffffff81190eca:       48 8d 7b 50             lea    0x50(%rbx),%rdi
> ffffffff81190ece:       e8 89 53 1f 00          callq  ffffffff8138625c <__asan_load8>
> ffffffff81190ed3:       48 8b 5b 50             mov    0x50(%rbx),%rbx
> ffffffff81190ed7:       eb c0                   jmp    ffffffff81190e99 <console_unlock+0xf5>
> ffffffff81190ed9:       e8 93 81 08 00          callq  ffffffff81219071 <__sanitizer_cov_trace_pc>
> ffffffff81190ede:       65 8b 05 43 22 e8 7e    mov    %gs:0x7ee82243(%rip),%eax        # 13128 <cpu_number>
> ffffffff81190ee5:       89 c0                   mov    %eax,%eax
> ffffffff81190ee7:       49 0f a3 06             bt     %rax,(%r14)
> ffffffff81190eeb:       0f 82 6c 04 00 00       jb     ffffffff8119135d <console_unlock+0x5b9>
> {
>         struct console *con;
>
>         trace_console_rcuidle(text, len);
>
>         if (!console_drivers)
> ffffffff81190ef1:       e8 7b 81 08 00          callq  ffffffff81219071 <__sanitizer_cov_trace_pc>
> ffffffff81190ef6:       48 8b 1d a3 c2 14 03    mov    0x314c2a3(%rip),%rbx        # ffffffff842dd1a0 <console_drivers>
> ffffffff81190efd:       48 85 db                test   %rbx,%rbx
> ffffffff81190f00:       0f 85 5c 05 00 00       jne    ffffffff81191462 <console_unlock+0x6be>
> ffffffff81190f06:       48 8d 9d 18 ff ff ff    lea    -0xe8(%rbp),%rbx
> ffffffff81190f0d:       4c 8d a5 58 ff ff ff    lea    -0xa8(%rbp),%r12
>                  */
>                 console_lock_spinning_enable();
>
>                 stop_critical_timings();        /* don't trace print latency */
>                 call_console_drivers(ext_text, ext_len, text, len);
>                 start_critical_timings();
> ffffffff81190f14:       e8 58 81 08 00          callq  ffffffff81219071 <__sanitizer_cov_trace_pc>
> ffffffff81190f19:       e8 18 a2 0c 00          callq  ffffffff8125b136 <start_critical_timings>
> ffffffff81190f1e:       48 89 df                mov    %rbx,%rdi
> static int console_lock_spinning_disable_and_check(void)
> {
>         int waiter;
>
>         raw_spin_lock(&console_owner_lock);
>         waiter = READ_ONCE(console_waiter);
> ffffffff81190f21:       49 89 df                mov    %rbx,%r15
> ffffffff81190f24:       e8 04 51 1f 00          callq  ffffffff8138602d <__asan_store1>
> ffffffff81190f29:       4c 89 e7                mov    %r12,%rdi                              /*** console_unlock+0x185/0x960 ***/
> ffffffff81190f2c:       c6 85 18 ff ff ff 00    movb   $0x0,-0xe8(%rbp)
> ffffffff81190f33:       49 c1 ef 03             shr    $0x3,%r15
> ffffffff81190f37:       e8 f1 50 1f 00          callq  ffffffff8138602d <__asan_store1>
>  */
> static int console_lock_spinning_disable_and_check(void)
> {
>         int waiter;
>
>         raw_spin_lock(&console_owner_lock);
> ffffffff81190f3c:       48 c7 c7 e0 96 95 82    mov    $0xffffffff829596e0,%rdi   /*** ffffffff829596e0 d console_owner_lock ***/
> ffffffff81190f43:       c6 85 58 ff ff ff 00    movb   $0x0,-0xa8(%rbp)
> ffffffff81190f4a:       e8 9a bd da 00          callq  ffffffff81f3cce9 <_raw_spin_lock>
>         waiter = READ_ONCE(console_waiter);
> ffffffff81190f4f:       4c 03 bd e8 fe ff ff    add    -0x118(%rbp),%r15
> ffffffff81190f56:       8a 05 c4 bb 04 03       mov    0x304bbc4(%rip),%al        # ffffffff841dcb20 <console_waiter>
> ffffffff81190f5c:       48 89 df                mov    %rbx,%rdi
> ffffffff81190f5f:       88 85 e0 fe ff ff       mov    %al,-0x120(%rbp)
> ffffffff81190f65:       41 c6 07 01             movb   $0x1,(%r15)
> ffffffff81190f69:       e8 bf 50 1f 00          callq  ffffffff8138602d <__asan_store1>
> ffffffff81190f6e:       8a 85 e0 fe ff ff       mov    -0x120(%rbp),%al
> ffffffff81190f74:       48 89 df                mov    %rbx,%rdi
> ffffffff81190f77:       88 85 18 ff ff ff       mov    %al,-0xe8(%rbp)
> ffffffff81190f7d:       e8 69 50 1f 00          callq  ffffffff81385feb <__asan_load1>
> ffffffff81190f82:       8a 85 18 ff ff ff       mov    -0xe8(%rbp),%al
>         console_owner = NULL;
>         raw_spin_unlock(&console_owner_lock);
> ffffffff81190f88:       48 c7 c7 e0 96 95 82    mov    $0xffffffff829596e0,%rdi
> ffffffff81190f8f:       41 c6 07 f8             movb   $0xf8,(%r15)
> {
>         int waiter;
>
>         raw_spin_lock(&console_owner_lock);
>         waiter = READ_ONCE(console_waiter);
>         console_owner = NULL;
> ffffffff81190f93:       48 c7 05 c2 bb 04 03    movq   $0x0,0x304bbc2(%rip)        # ffffffff841dcb60 <console_owner>
> ffffffff81190f9a:       00 00 00 00
> static int console_lock_spinning_disable_and_check(void)
> {
>         int waiter;
>
>         raw_spin_lock(&console_owner_lock);
>         waiter = READ_ONCE(console_waiter);
> ffffffff81190f9e:       88 85 e0 fe ff ff       mov    %al,-0x120(%rbp)
>         console_owner = NULL;
>         raw_spin_unlock(&console_owner_lock);
> ffffffff81190fa4:       e8 9b bf da 00          callq  ffffffff81f3cf44 <_raw_spin_unlock>
> ffffffff81190fa9:       48 8b 9d f0 fe ff ff    mov    -0x110(%rbp),%rbx
>
>         if (!waiter) {
> ffffffff81190fb0:       8a 85 e0 fe ff ff       mov    -0x120(%rbp),%al
> ffffffff81190fb6:       81 e3 00 02 00 00       and    $0x200,%ebx
> ffffffff81190fbc:       84 c0                   test   %al,%al
> ffffffff81190fbe:       0f 85 54 05 00 00       jne    ffffffff81191518 <console_unlock+0x774>
>                 spin_release(&console_owner_dep_map, 1, _THIS_IP_);
> ffffffff81190fc4:       e8 a8 80 08 00          callq  ffffffff81219071 <__sanitizer_cov_trace_pc>
> ffffffff81190fc9:       48 c7 c2 c4 0f 19 81    mov    $0xffffffff81190fc4,%rdx
> ffffffff81190fd0:       be 01 00 00 00          mov    $0x1,%esi
> ffffffff81190fd5:       48 c7 c7 60 97 95 82    mov    $0xffffffff82959760,%rdi
> ffffffff81190fdc:       e8 0d 19 fe ff          callq  ffffffff811728ee <lock_release>
>                 if (console_lock_spinning_disable_and_check()) {
>                         printk_safe_exit_irqrestore(flags);
>                         return;
>                 }
>
>                 printk_safe_exit_irqrestore(flags);
> ffffffff81190fe1:       e8 82 2d 00 00          callq  ffffffff81193d68 <__printk_safe_exit>
> ffffffff81190fe6:       48 85 db                test   %rbx,%rbx
> ffffffff81190fe9:       0f 85 d6 05 00 00       jne    ffffffff811915c5 <console_unlock+0x821>
> ffffffff81190fef:       e8 7d 80 08 00          callq  ffffffff81219071 <__sanitizer_cov_trace_pc>
> ffffffff81190ff4:       48 8b bd f0 fe ff ff    mov    -0x110(%rbp),%rdi
> ffffffff81190ffb:       e8 48 ca ff ff          callq  ffffffff8118da48 <arch_local_irq_restore>
> ffffffff81191000:       e8 42 9f fd ff          callq  ffffffff8116af47 <trace_hardirqs_off>
>
>                 if (do_cond_resched)
> ffffffff81191005:       e8 67 80 08 00          callq  ffffffff81219071 <__sanitizer_cov_trace_pc>
> ffffffff8119100a:       83 bd cc fe ff ff 00    cmpl   $0x0,-0x134(%rbp)
> ffffffff81191011:       74 1d                   je     ffffffff81191030 <console_unlock+0x28c>
>                         cond_resched();
> ffffffff81191013:       e8 59 80 08 00          callq  ffffffff81219071 <__sanitizer_cov_trace_pc>
> ffffffff81191018:       31 d2                   xor    %edx,%edx
> ffffffff8119101a:       be 5a 09 00 00          mov    $0x95a,%esi
> ffffffff8119101f:       48 c7 c7 00 65 07 82    mov    $0xffffffff82076500,%rdi
> ffffffff81191026:       e8 91 77 fa ff          callq  ffffffff811387bc <___might_sleep>
> ffffffff8119102b:       e8 43 66 da 00          callq  ffffffff81f37673 <_cond_resched>
>
>
>
> Forwarded by penguin-kernel@i-love.sakura.ne.jp
> ----------------------- Original Message -----------------------
>  From:    Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
>  To:      Petr Mladek <pmladek@suse.com>
>  Cc:      kernel test robot <shun.hao@intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Dave Hansen <dave.hansen@intel.com>, Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Byungchul Park <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, LKML <linux-kernel@vger.kernel.org>, lkp@01.org
>  Date:    Thu, 01 Mar 2018 12:26:15 +0900
>  Subject: Re: [lkp-robot] [printk]  c162d5b433: BUG:KASAN:use-after-scope_in_c
> ----
>
> Tetsuo Handa wrote:
>> Petr Mladek wrote:
>> > I am really curious what code is proceed on the line
>> > console_unlock+0x185/0x960.
>>
>> I can reproduce this warning with VMware environment.
>> Something is happening inside __asan_store1() before calling raw_spin_lock(&console_owner_lock) ?
>>
>
> Interesting thing is that as of commit 97ace515f01439d4 on linux.git, there is no
> such __asan_store1() before calling raw_spin_lock(&console_owner_lock) and hence
> cannot reproduce this warning. Maybe a KASAN bug as of commit c162d5b4338d72de ?
>
>
>
> ffffffff8115d3a1 <console_unlock>:
>  * If there is output waiting, we wake /dev/kmsg and syslog() users.
>  *
>  * console_unlock(); may be called from any context.
>  */
> void console_unlock(void)
> {
> ffffffff8115d3a1:       e8 5a 44 ca 00          callq  ffffffff81e01800 <__fentry__>
> ffffffff8115d3a6:       41 57                   push   %r15
> ffffffff8115d3a8:       41 56                   push   %r14
> ffffffff8115d3aa:       41 55                   push   %r13
> ffffffff8115d3ac:       41 54                   push   %r12
> ffffffff8115d3ae:       55                      push   %rbp
> ffffffff8115d3af:       53                      push   %rbx
> ffffffff8115d3b0:       48 83 ec 28             sub    $0x28,%rsp
>         static u64 seen_seq;
>         unsigned long flags;
>         bool wake_klogd = false;
>         bool do_cond_resched, retry;
>
>         if (console_suspended) {
> ffffffff8115d3b4:       e8 6e e6 06 00          callq  ffffffff811cba27 <__sanitizer_cov_trace_pc>
> ffffffff8115d3b9:       83 3d 60 e1 34 03 00    cmpl   $0x0,0x334e160(%rip)        # ffffffff844ab520 <console_suspended>
> ffffffff8115d3c0:       74 0a                   je     ffffffff8115d3cc <console_unlock+0x2b>
>                 up_console_sem();
> ffffffff8115d3c2:       e8 60 e6 06 00          callq  ffffffff811cba27 <__sanitizer_cov_trace_pc>
> ffffffff8115d3c7:       e9 4d 07 00 00          jmpq   ffffffff8115db19 <console_unlock+0x778>
>          *
>          * console_trylock() is not able to detect the preemptive
>          * context reliably. Therefore the value must be stored before
>          * and cleared after the the "again" goto label.
>          */
>         do_cond_resched = console_may_schedule;
> ffffffff8115d3cc:       e8 56 e6 06 00          callq  ffffffff811cba27 <__sanitizer_cov_trace_pc>
> ffffffff8115d3d1:       8b 05 69 df 34 03       mov    0x334df69(%rip),%eax        # ffffffff844ab340 <console_may_schedule>
> {
>         static char ext_text[CONSOLE_EXT_LOG_MAX];
>         static char text[LOG_LINE_MAX + PREFIX_MAX];
>         static u64 seen_seq;
>         unsigned long flags;
>         bool wake_klogd = false;
> ffffffff8115d3d7:       45 31 f6                xor    %r14d,%r14d
>
> static __always_inline bool variable_test_bit(long nr, volatile const unsigned long *addr)
> {
>         bool oldbit;
>
>         asm volatile("bt %2,%1"
> ffffffff8115d3da:       49 c7 c5 e8 92 01 83    mov    $0xffffffff830192e8,%r13
>          *
>          * console_trylock() is not able to detect the preemptive
>          * context reliably. Therefore the value must be stored before
>          * and cleared after the the "again" goto label.
>          */
>         do_cond_resched = console_may_schedule;
> ffffffff8115d3e1:       89 44 24 18             mov    %eax,0x18(%rsp)
> again:
>         console_may_schedule = 0;
> ffffffff8115d3e5:       e8 3d e6 06 00          callq  ffffffff811cba27 <__sanitizer_cov_trace_pc>
>  * unless they're explicitly marked as being able to cope (CON_ANYTIME) don't
>  * call them until this CPU is officially up.
>  */
> static inline int can_use_console(void)
> {
>         return cpu_online(raw_smp_processor_id()) || have_callable_console();
> ffffffff8115d3ea:       65 8b 05 3f ad eb 7e    mov    %gs:0x7eebad3f(%rip),%eax        # 18130 <cpu_number>
>          * context reliably. Therefore the value must be stored before
>          * and cleared after the the "again" goto label.
>          */
>         do_cond_resched = console_may_schedule;
> again:
>         console_may_schedule = 0;
> ffffffff8115d3f1:       c7 05 45 df 34 03 00    movl   $0x0,0x334df45(%rip)        # ffffffff844ab340 <console_may_schedule>
> ffffffff8115d3f8:       00 00 00
>  *
>  * Returns 1 if @cpu is set in @cpumask, else returns 0
>  */
> static inline int cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
> {
>         return test_bit(cpumask_check(cpu), cpumask_bits((cpumask)));
> ffffffff8115d3fb:       89 c0                   mov    %eax,%eax
> ffffffff8115d3fd:       49 0f a3 45 00          bt     %rax,0x0(%r13)
>  * unless they're explicitly marked as being able to cope (CON_ANYTIME) don't
>  * call them until this CPU is officially up.
>  */
> static inline int can_use_console(void)
> {
>         return cpu_online(raw_smp_processor_id()) || have_callable_console();
> ffffffff8115d402:       0f 82 26 01 00 00       jb     ffffffff8115d52e <console_unlock+0x18d>
>  */
> static int have_callable_console(void)
> {
>         struct console *con;
>
>         for_each_console(con)
> ffffffff8115d408:       e8 1a e6 06 00          callq  ffffffff811cba27 <__sanitizer_cov_trace_pc>
> ffffffff8115d40d:       48 8b 1d cc e1 34 03    mov    0x334e1cc(%rip),%rbx        # ffffffff844ab5e0 <console_drivers>
> ffffffff8115d414:       e8 0e e6 06 00          callq  ffffffff811cba27 <__sanitizer_cov_trace_pc>
> ffffffff8115d419:       48 85 db                test   %rbx,%rbx
> ffffffff8115d41c:       0f 84 e8 06 00 00       je     ffffffff8115db0a <console_unlock+0x769>
>                 if ((con->flags & CON_ENABLED) &&
> ffffffff8115d422:       e8 00 e6 06 00          callq  ffffffff811cba27 <__sanitizer_cov_trace_pc>
> ffffffff8115d427:       48 8d 7b 40             lea    0x40(%rbx),%rdi
> ffffffff8115d42b:       e8 4c 1c 1a 00          callq  ffffffff812ff07c <__asan_load2>
> ffffffff8115d430:       8b 43 40                mov    0x40(%rbx),%eax
> ffffffff8115d433:       83 e0 14                and    $0x14,%eax
> ffffffff8115d436:       66 83 f8 14             cmp    $0x14,%ax
> ffffffff8115d43a:       0f 84 ee 00 00 00       je     ffffffff8115d52e <console_unlock+0x18d>
>  */
> static int have_callable_console(void)
> {
>         struct console *con;
>
>         for_each_console(con)
> ffffffff8115d440:       e8 e2 e5 06 00          callq  ffffffff811cba27 <__sanitizer_cov_trace_pc>
> ffffffff8115d445:       48 8d 7b 50             lea    0x50(%rbx),%rdi
> ffffffff8115d449:       e8 18 1e 1a 00          callq  ffffffff812ff266 <__asan_load8>
> ffffffff8115d44e:       48 8b 5b 50             mov    0x50(%rbx),%rbx
> ffffffff8115d452:       eb c0                   jmp    ffffffff8115d414 <console_unlock+0x73>
> ffffffff8115d454:       e8 ce e5 06 00          callq  ffffffff811cba27 <__sanitizer_cov_trace_pc>
> ffffffff8115d459:       65 8b 05 d0 ac eb 7e    mov    %gs:0x7eebacd0(%rip),%eax        # 18130 <cpu_number>
> ffffffff8115d460:       89 c0                   mov    %eax,%eax
> ffffffff8115d462:       49 0f a3 45 00          bt     %rax,0x0(%r13)
> ffffffff8115d467:       0f 82 b1 03 00 00       jb     ffffffff8115d81e <console_unlock+0x47d>
> {
>         struct console *con;
>
>         trace_console_rcuidle(text, len);
>
>         if (!console_drivers)
> ffffffff8115d46d:       e8 b5 e5 06 00          callq  ffffffff811cba27 <__sanitizer_cov_trace_pc>
> ffffffff8115d472:       48 8b 1d 67 e1 34 03    mov    0x334e167(%rip),%rbx        # ffffffff844ab5e0 <console_drivers>
> ffffffff8115d479:       48 85 db                test   %rbx,%rbx
> ffffffff8115d47c:       0f 85 63 04 00 00       jne    ffffffff8115d8e5 <console_unlock+0x544>
>                  */
>                 console_lock_spinning_enable();
>
>                 stop_critical_timings();        /* don't trace print latency */
>                 call_console_drivers(ext_text, ext_len, text, len);
>                 start_critical_timings();
> ffffffff8115d482:       e8 a0 e5 06 00          callq  ffffffff811cba27 <__sanitizer_cov_trace_pc>
> ffffffff8115d487:       e8 ce 49 0a 00          callq  ffffffff81201e5a <start_critical_timings>
>  */
> static int console_lock_spinning_disable_and_check(void)
> {
>         int waiter;
>
>         raw_spin_lock(&console_owner_lock);
> ffffffff8115d48c:       48 c7 c7 00 38 b5 82    mov    $0xffffffff82b53800,%rdi     /*** ffffffff82b53800 d console_owner_lock ***/
> ffffffff8115d493:       48 89 eb                mov    %rbp,%rbx
> ffffffff8115d496:       e8 5e b3 bf 00          callq  ffffffff81d587f9 <_raw_spin_lock>
> ffffffff8115d49b:       44 8a 25 7e da 24 03    mov    0x324da7e(%rip),%r12b        # ffffffff843aaf20 <console_waiter>
>         waiter = READ_ONCE(console_waiter);
>         console_owner = NULL;
>         raw_spin_unlock(&console_owner_lock);
> ffffffff8115d4a2:       48 c7 c7 00 38 b5 82    mov    $0xffffffff82b53800,%rdi
> {
>         int waiter;
>
>         raw_spin_lock(&console_owner_lock);
>         waiter = READ_ONCE(console_waiter);
>         console_owner = NULL;
> ffffffff8115d4a9:       48 c7 05 ac da 24 03    movq   $0x0,0x324daac(%rip)        # ffffffff843aaf60 <console_owner>
> ffffffff8115d4b0:       00 00 00 00
> ffffffff8115d4b4:       81 e3 00 02 00 00       and    $0x200,%ebx
>         raw_spin_unlock(&console_owner_lock);
> ffffffff8115d4ba:       e8 95 b5 bf 00          callq  ffffffff81d58a54 <_raw_spin_unlock>
>
>         if (!waiter) {
> ffffffff8115d4bf:       45 84 e4                test   %r12b,%r12b
> ffffffff8115d4c2:       0f 85 cf 04 00 00       jne    ffffffff8115d997 <console_unlock+0x5f6>
>                 spin_release(&console_owner_dep_map, 1, _THIS_IP_);
> ffffffff8115d4c8:       e8 5a e5 06 00          callq  ffffffff811cba27 <__sanitizer_cov_trace_pc>
> ffffffff8115d4cd:       48 c7 c2 c8 d4 15 81    mov    $0xffffffff8115d4c8,%rdx
> ffffffff8115d4d4:       be 01 00 00 00          mov    $0x1,%esi
> ffffffff8115d4d9:       48 c7 c7 80 38 b5 82    mov    $0xffffffff82b53880,%rdi
> ffffffff8115d4e0:       e8 97 82 fe ff          callq  ffffffff8114577c <lock_release>
>                 if (console_lock_spinning_disable_and_check()) {
>                         printk_safe_exit_irqrestore(flags);
>                         return;
>                 }
>
>                 printk_safe_exit_irqrestore(flags);
> ffffffff8115d4e5:       e8 f3 25 00 00          callq  ffffffff8115fadd <__printk_safe_exit>
> ffffffff8115d4ea:       48 85 db                test   %rbx,%rbx
> ffffffff8115d4ed:       0f 85 22 05 00 00       jne    ffffffff8115da15 <console_unlock+0x674>
> ffffffff8115d4f3:       e8 2f e5 06 00          callq  ffffffff811cba27 <__sanitizer_cov_trace_pc>
> ffffffff8115d4f8:       48 89 ef                mov    %rbp,%rdi
> ffffffff8115d4fb:       e8 f4 cf ff ff          callq  ffffffff8115a4f4 <arch_local_irq_restore>
> ffffffff8115d500:       e8 94 25 fe ff          callq  ffffffff8113fa99 <trace_hardirqs_off>
>
>                 if (do_cond_resched)
> ffffffff8115d505:       e8 1d e5 06 00          callq  ffffffff811cba27 <__sanitizer_cov_trace_pc>
> ffffffff8115d50a:       83 7c 24 18 00          cmpl   $0x0,0x18(%rsp)
> ffffffff8115d50f:       74 1d                   je     ffffffff8115d52e <console_unlock+0x18d>
>                         cond_resched();
> ffffffff8115d511:       e8 11 e5 06 00          callq  ffffffff811cba27 <__sanitizer_cov_trace_pc>
> ffffffff8115d516:       31 d2                   xor    %edx,%edx
> ffffffff8115d518:       be 66 09 00 00          mov    $0x966,%esi
> ffffffff8115d51d:       48 c7 c7 20 85 27 82    mov    $0xffffffff82278520,%rdi
> ffffffff8115d524:       e8 24 8b fb ff          callq  ffffffff8111604d <___might_sleep>
> ffffffff8115d529:       e8 ad 68 bf 00          callq  ffffffff81d53ddb <_cond_resched>


+Ard, Kees

This is a problem with GCC_PLUGIN_STRUCTLEAK_BYREF_ALL. It inserts an
initializing write for __u used in READ_ONCE outside of live scope of
the variable.
Below "movb   $0x1,0x0(%r13)" and "movb   $0xf8,0x0(%r13)" denote live
scope of the variable __u (the 0xf8 that appears in the KASAN report).
But the initializing store at ffffffff811a5f84 (and the corresponding
KASAN check) are outside of that scope, which causes the KASAN report.


ffffffff811a5f61: 49 8d 9f 40 ff ff ff lea    -0xc0(%r15),%rbx
ffffffff811a5f68: 4d 8d 67 80          lea    -0x80(%r15),%r12
kernel/printk/printk.c:1600
waiter = READ_ONCE(console_waiter);
ffffffff811a5f79: 49 89 dd              mov    %rbx,%r13
ffffffff811a5f7c: e8 d3 4e 21 00        callq  ffffffff813bae54 <__asan_store1>
ffffffff811a5f81: 4c 89 e7              mov    %r12,%rdi
ffffffff811a5f84: 41 c6 87 40 ff ff ff movb   $0x0,-0xc0(%r15)
ffffffff811a5f8b: 00
ffffffff811a5f8c: 49 c1 ed 03          shr    $0x3,%r13
ffffffff811a5f90: e8 bf 4e 21 00        callq  ffffffff813bae54 <__asan_store1>
kernel/printk/printk.c:1599
raw_spin_lock(&console_owner_lock);
ffffffff811a5f95: 48 c7 c7 e0 90 b5 82 mov    $0xffffffff82b590e0,%rdi
ffffffff811a5f9c: 41 c6 47 80 00        movb   $0x0,-0x80(%r15)
ffffffff811a5fa1: e8 92 a9 e7 00        callq  ffffffff82020938 <_raw_spin_lock>
kernel/printk/printk.c:1600
waiter = READ_ONCE(console_waiter);
ffffffff811a5fa6: 4c 03 ad e8 fe ff ff add    -0x118(%rbp),%r13
__read_once_size():
./include/linux/compiler.h:178
})

static __always_inline
void __read_once_size(const volatile void *p, void *res, int size)
{
__READ_ONCE_SIZE;
ffffffff811a5fad: 44 8a 35 2c 7b e6 02 mov    0x2e67b2c(%rip),%r14b
    # ffffffff8400dae0 <console_waiter>
ffffffff811a5fb4: 48 89 df              mov    %rbx,%rdi
console_lock_spinning_disable_and_check():
kernel/printk/printk.c:1600
ffffffff811a5fb7: 41 c6 45 00 01        movb   $0x1,0x0(%r13)
__read_once_size():
./include/linux/compiler.h:178
ffffffff811a5fbc: e8 93 4e 21 00        callq  ffffffff813bae54 <__asan_store1>
console_lock_spinning_disable_and_check():
kernel/printk/printk.c:1600
ffffffff811a5fc1: 48 89 df              mov    %rbx,%rdi
__read_once_size():
./include/linux/compiler.h:178
ffffffff811a5fc4: 45 88 b7 40 ff ff ff mov    %r14b,-0xc0(%r15)
console_lock_spinning_disable_and_check():
kernel/printk/printk.c:1600
ffffffff811a5fcb: e8 3d 4e 21 00        callq  ffffffff813bae0d <__asan_load1>
ffffffff811a5fd0: 45 8a b7 40 ff ff ff mov    -0xc0(%r15),%r14b
kernel/printk/printk.c:1602
raw_spin_unlock(&console_owner_lock);
ffffffff811a5fd7: 48 c7 c7 e0 90 b5 82 mov    $0xffffffff82b590e0,%rdi
ffffffff811a5fde: 41 c6 45 00 f8        movb   $0xf8,0x0(%r13)
kernel/printk/printk.c:1601
console_owner = NULL;
ffffffff811a5fe3: 48 c7 05 32 7b e6 02 movq   $0x0,0x2e67b32(%rip)
   # ffffffff8400db20 <console_owner>
ffffffff811a5fea: 00 00 00 00
kernel/printk/printk.c:1602
raw_spin_unlock(&console_owner_lock);
ffffffff811a5fee: e8 d1 ab e7 00        callq  ffffffff82020bc4
<_raw_spin_unlock>



We either need to fix GCC_PLUGIN_STRUCTLEAK_BYREF_ALL (and probably
GCC_PLUGIN_STRUCTLEAK) to insert initialization at proper places or
run before KASAN instrumentation (though, since the initializing
stores are instrumented, it already runs partially before KASAN), or
declare GCC_PLUGIN_STRUCTLEAK incompatible with KASAN (it's not the
first time we debug this).
