Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AIpwx4+xxTzB8OpGhfuUlgtDanV/p3UELhPpaPZDXWWt8jNM+d3qxtTk/y9VRDsEEc4fEfz4jZ8j
ARC-Seal: i=1; a=rsa-sha256; t=1524446021; cv=none;
        d=google.com; s=arc-20160816;
        b=dHHku2ex773TJPE38knFbh0i/HugadZG+uQ8Lz0AjSnBfy1Tb5ASNV54xtQARUhciI
         61Wj0WGjnurhbPGbrEaQTWMD1CqOnUAiXkG7FToUNXfyRGswfGtnBTTCMM49xkpaGiyi
         TuJrqPTggJMpPrywCJvonYTXwNJKmXVEICjQM+yakukS6HNjcmIM8MWYvh0bOlRXTsvA
         bafMaF9onq2UfmZyCxwHswPtoRNNIgx7k++39QxWGa3koQuXz6TdmVxM62JH2zqb06nB
         2Z9dpS5E6PqUqSM0OKMt4Gm+GPhqIne0YXb2nOzVeLTs9BVutUcu27w+bOHh5qaUiOd0
         oFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:date:mime-version:cc:to:from:subject
         :message-id:arc-authentication-results;
        bh=aSo6YKLMT3SOSxb+9CudkvBhYo4dIAEqAMFOHTbkhZ0=;
        b=IaKjDuTBpBi0wYlovqx3CqmrdBz61WISXHEXTXJukCaov/f79pfbfsVfXpaKCJzOsr
         7fvPwyrI6uA8LsvHmcXeBTMxun3R2gi0QpKzE9CapnMUKCufe23Aglar158Zotb3O2C/
         WuF9Pead2sS1YJgQuP9lwZS+V71dFXBm0vYzIlVNojJW5Ielw8j1/L8Ptz2wHE/PaD1V
         DPdYGb0C1QSzjnHCwHEvIvcGFmX/HnF5KGRCHAGruAwnEna2aVWcBO0ppg9lqlgKsPAb
         3Hwus5n+FYGCh8O4PLfEeJbGNzE3pnheI9pXxFOgrsbzIZFAnx9mqF1QCAAE9eHO94/+
         Qm7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Message-Id: <201804230113.w3N1DdQB055512@www262.sakura.ne.jp>
Subject: random: =?ISO-2022-JP?B?R0ZQX0tFUk5FTHxfX0dGUF9OT0ZBSUwgYWxsb2NhdGlvbiBm?=
 =?ISO-2022-JP?B?cm9tIElSUSBjb250ZXh0?=
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To: tytso@mit.edu, jannh@google.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
MIME-Version: 1.0
Date: Mon, 23 Apr 2018 10:13:39 +0900
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598497511894864077?=
X-GMAIL-MSGID: =?utf-8?q?1598497511894864077?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello.

Commit 8ef35c866f8862df ("random: set up the NUMA crng instances after
the CRNG is fully initialized") is causing sleep inside atomic warning
due to GFP_KERNEL|__GFP_NOFAIL allocation from IRQ context. Though it
unlikely sleeps because there will be enough free memory at boot up...

Please don't backport that patch now.

[    9.712722] BUG: sleeping function called from invalid context at mm/slab.h:421
[    9.715231] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper/2
[    9.717396] INFO: lockdep is turned off.
[    9.718717] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.17.0-rc1+ #480
[    9.720857] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
[    9.724328] Call Trace:
[    9.725176]  <IRQ>
[    9.725880]  dump_stack+0xb1/0xfc
[    9.727003]  ___might_sleep+0x23e/0x270
[    9.728285]  __might_sleep+0x45/0x80
[    9.729479]  __kmalloc+0x284/0x3e0
[    9.730642]  ? crng_reseed+0x122/0x320
[    9.731876]  crng_reseed+0x122/0x320
[    9.733078]  credit_entropy_bits+0x2f6/0x370
[    9.734503]  ? add_timer_randomness+0xb8/0xd0
[    9.735880]  add_timer_randomness+0xb8/0xd0
[    9.737201]  add_disk_randomness+0x32/0x170
[    9.738666]  scsi_end_request+0x182/0x210
[    9.740004]  scsi_io_completion+0x2cd/0x620
[    9.741448]  scsi_finish_command+0xf3/0x170
[    9.742844]  scsi_softirq_done+0x12b/0x170
[    9.744209]  blk_done_softirq+0xb2/0xd0
[    9.745501]  __do_softirq+0xcf/0x49b
[    9.746726]  irq_exit+0xbc/0xd0
[    9.747785]  smp_call_function_single_interrupt+0x17a/0x270
[    9.749603]  call_function_single_interrupt+0xf/0x20
[    9.751240]  </IRQ>
[    9.751970] RIP: 0010:native_safe_halt+0x6/0x10
[    9.753467] RSP: 0018:ffff88011963fe78 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff04
[    9.755922] RAX: ffff880119626380 RBX: ffff880119626380 RCX: 0000000000000000
[    9.758362] RDX: ffff880119626380 RSI: 0000000000000001 RDI: ffff880119626380
[    9.760743] RBP: ffff88011963fe78 R08: 0000000000000000 R09: 0000000000000000
[    9.763068] R10: 0000000000000001 R11: ffff88011a4a3693 R12: 0000000000000002
[    9.765382] R13: 0000000000000000 R14: 0000000000000000 R15: ffff880119626380
[    9.767709]  ? trace_hardirqs_on+0xd/0x10
[    9.769044]  default_idle+0x2c/0x1a0
[    9.770333]  arch_cpu_idle+0x10/0x20
[    9.771526]  default_idle_call+0x1e/0x40
[    9.772833]  do_idle+0x196/0x2a0
[    9.773923]  ? complete+0x48/0x50
[    9.775068]  cpu_startup_entry+0x5f/0x62
[    9.776392]  start_secondary+0x1a3/0x1f0
[    9.777697]  secondary_startup_64+0xa5/0xb0
[    9.779101] random: crng init done

# ./scripts/faddr2line vmlinux crng_reseed+0x122/0x320
crng_reseed+0x122/0x320:
kmalloc_array at include/linux/slab.h:631
626     {
627             if (size != 0 && n > SIZE_MAX / size)
628                     return NULL;
629             if (__builtin_constant_p(n) && __builtin_constant_p(size))
630                     return kmalloc(n * size, flags);
631             return __kmalloc(n * size, flags);
632     }
633
634     /**
635      * kcalloc - allocate memory for an array. The memory is set to zero.
636      * @n: number of elements.
(inlined by) kcalloc at include/linux/slab.h:642
637      * @size: element size.
638      * @flags: the type of memory to allocate (see kmalloc).
639      */
640     static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
641     {
642             return kmalloc_array(n, size, flags | __GFP_ZERO);
643     }
644
645     /*
646      * kmalloc_track_caller is a special version of kmalloc that records the
647      * calling function of the routine calling it for slab leak tracking instead
(inlined by) numa_crng_init at drivers/char/random.c:798
793     {
794             int i;
795             struct crng_state *crng;
796             struct crng_state **pool;
797
798             pool = kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL|__GFP_NOFAIL);
799             for_each_online_node(i) {
800                     crng = kmalloc_node(sizeof(struct crng_state),
801                                         GFP_KERNEL | __GFP_NOFAIL, i);
802                     spin_lock_init(&crng->lock);
803                     crng_initialize(crng);
(inlined by) crng_reseed at drivers/char/random.c:923
918             memzero_explicit(&buf, sizeof(buf));
919             crng->init_time = jiffies;
920             spin_unlock_irqrestore(&crng->lock, flags);
921             if (crng == &primary_crng && crng_init < 2) {
922                     invalidate_batched_entropy();
923                     numa_crng_init();
924                     crng_init = 2;
925                     process_random_ready_list();
926                     wake_up_interruptible(&crng_init_wait);
927                     pr_notice("random: crng init done\n");
928             }
