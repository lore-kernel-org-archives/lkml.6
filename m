Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeDQOlg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:41:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52500 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752778AbeDQOld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:41:33 -0400
Date: Tue, 17 Apr 2018 16:40:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/9] x86/dumpstack: Cleanups and user opcode bytes Code:
 section, v2
Message-ID: <20180417144042.GB20840@pd.tnic>
References: <20180315154448.16222-1-bp@alien8.de>
 <CA+55aFyvwdG49eCgX9Bs9UGEo4VWgS7dY6ZuEkBuugxTR58GnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFyvwdG49eCgX9Bs9UGEo4VWgS7dY6ZuEkBuugxTR58GnA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 10:51:06AM -0700, Linus Torvalds wrote:
> This version looks ok to me. I'm sure there's room for tweaking here,
> but I'm not seeing anything alarming.

So I'm redoing the series ontop of 17-rc1 and I see a *lot* of output
during testing. For example:

1) is from the userspace fault, 2) is the panic from sysrq but then you have 3)
which is

	WARN_ON_ONCE(!cpu_online(new_cpu));

in set_task_cpu() and to top it all off, we have 4) coming from
native_smp_send_reschedule():

static void native_smp_send_reschedule(int cpu)
{
        if (unlikely(cpu_is_offline(cpu))) {
                WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);

so all the "fine tuning" we did to try to fit the most important splat
on the screen is for shit because those loud WARNs simply pushed it all
up into oblivion.

And the executive summary and registers are just as worthless in such a
case.

We could start thinking about caching all that data from the very first
splat, when we're not tainted yet and dump it last but then we can't
even know what is going out last.

Not only because we can't guess from where stuff might warn and what
could execute - the below splats case-in-point - also, and more
importantly, we don't know how much of that data would actually go out
as there are no guarantees *when* the machine will die and stop spewing
to the serial port.

So maybe the most important splat coming out first is maybe a good thing
because it has a higher chance of coming out before the box locks up
completely.

So I guess we should keep hoping that serial console works and keeps on
working...

Hmmm.

1.
---

[  211.766286] strsep[2240]: segfault at 40066b ip 00007f9d4e0a301b sp 00007ffcd158a1e0 error 7 in libc-2.24.so[7f9d4e01a000+195000]
[  211.778147] Code: 53 48 83 ec 08 48 8b 2f 48 85 ed 74 27 0f b6 06 48 89 fb 84 c0 74 34 80 7e 01 00 74 22 48 89 ef e8 7a 68 f9 ff 48 85 c0 74 21 <c6> 00 00 48 83 c0 01 48 89 03 48 83 c4 08 48 89 e8 5b 5d c3 90 0f 

2.
---

[  218.747919] sysrq: SysRq : Trigger a crash
[  218.752258] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[  218.760044] PGD 8000000439bb8067 P4D 8000000439bb8067 PUD 4381ac067 PMD 0 
[  218.766888] Oops: 0002 [#1] PREEMPT SMP PTI
[  218.771052] CPU: 5 PID: 2200 Comm: bash Not tainted 4.17.0-rc1+ #1
[  218.777203] Hardware name: Dell Inc. Precision T3600/0PTTT9, BIOS A13 05/11/2014
[  218.784562] RIP: 0010:sysrq_handle_crash+0x41/0x80
[  218.789319] Code: e8 c4 17 c4 ff 48 c7 c2 87 b6 4a 81 be 01 00 00 00 48 c7 c7 c0 07 25 82 e8 2c 23 c2 ff c7 05 82 7a 39 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 e8 61 43 c4 ff 84 c0 75 c4 48 c7 c2 50 
[  218.808148] RSP: 0018:ffffc90003d03de8 EFLAGS: 00010286
[  218.813338] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 3e2d9cbd00000000
[  218.820422] RDX: ffff88043804cd38 RSI: 000000006cb322e4 RDI: 0000000000000000
[  218.827508] RBP: ffffc90003d03e10 R08: 000000003f352d81 R09: 0000000000000001
[  218.834595] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000007
[  218.841680] R13: ffffffff822c09e0 R14: 0000000000000000 R15: 0000000000000000
[  218.848773] FS:  00007f4105bce280(0000) GS:ffff88043df40000(0000) knlGS:0000000000000000
[  218.856808] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  218.862514] CR2: 0000000000000000 CR3: 0000000439428005 CR4: 00000000000606e0
[  218.869599] Call Trace:
[  218.872041]  __handle_sysrq+0xcd/0x210
[  218.875774]  write_sysrq_trigger+0x48/0x50
[  218.879853]  proc_reg_write+0x3c/0x60
[  218.883501]  __vfs_write+0x36/0x160
[  218.886986]  ? rcu_read_lock_sched_held+0x74/0x80
[  218.891666]  ? rcu_sync_lockdep_assert+0x2e/0x60
[  218.896268]  ? __sb_start_write+0x157/0x200
[  218.900425]  ? __sb_start_write+0x16d/0x200
[  218.904585]  vfs_write+0xbe/0x1b0
[  218.907886]  ksys_write+0x55/0xc0
[  218.911193]  do_syscall_64+0x64/0x200
[  218.914858]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  218.919881] RIP: 0033:0x7f41050a9620
[  218.923429] Code: 73 01 c3 48 8b 0d 78 c8 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 29 21 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae 9b 01 00 48 89 04 24 
[  218.942261] RSP: 002b:00007ffe8c2ad378 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  218.949778] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f41050a9620
[  218.956863] RDX: 0000000000000002 RSI: 00000000008fe408 RDI: 0000000000000001
[  218.963949] RBP: 00000000008fe408 R08: 00007f4105368760 R09: 00007f4105bce280
[  218.971047] R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000002
[  218.978138] R13: 0000000000000001 R14: 00007f4105367600 R15: 0000000000000002
[  218.985240] Modules linked in: binfmt_misc xfs nls_iso8859_15 nls_cp437 btrfs xor zstd_decompress zstd_compress xxhash raid6_pq sb_edac libcrc32c x86_pkg_temp_thermal coretemp kvm_intel kvm irqbypass crc32_pclmul snd_hda_codec_hdmi crc32c_intel ghash_clmulni_intel usbhid aesni_intel aes_x86_64 snd_hda_codec_realtek snd_hda_codec_generic crypto_simd cryptd snd_hda_intel glue_helper iTCO_wdt intel_cstate snd_hda_codec intel_uncore snd_hwdep dcdbas snd_hda_core dell_smm_hwmon iTCO_vendor_support intel_rapl_perf snd_pcm efi_pstore snd_timer serio_raw lpc_ich efivars i2c_i801 mfd_core snd soundcore button
[  219.038108] CR2: 0000000000000000
[  219.041499] ---[ end trace 75992131ce321254 ]---
[  219.046095] RIP: 0010:sysrq_handle_crash+0x41/0x80
[  219.050848] Code: e8 c4 17 c4 ff 48 c7 c2 87 b6 4a 81 be 01 00 00 00 48 c7 c7 c0 07 25 82 e8 2c 23 c2 ff c7 05 82 7a 39 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 e8 61 43 c4 ff 84 c0 75 c4 48 c7 c2 50 
[  219.069577] RSP: 0018:ffffc90003d03de8 EFLAGS: 00010286
[  219.074770] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 3e2d9cbd00000000
[  219.081842] RDX: ffff88043804cd38 RSI: 000000006cb322e4 RDI: 0000000000000000
[  219.088919] RBP: ffffc90003d03e10 R08: 000000003f352d81 R09: 0000000000000001
[  219.096000] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000007
[  219.103077] R13: ffffffff822c09e0 R14: 0000000000000000 R15: 0000000000000000
[  219.110151] FS:  00007f4105bce280(0000) GS:ffff88043df40000(0000) knlGS:0000000000000000
[  219.118168] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  219.124199] CR2: 0000000000000000 CR3: 0000000439428005 CR4: 00000000000606e0
[  219.131603] Kernel panic - not syncing: Fatal exception
[  219.137135] Kernel Offset: disabled
[  219.140909] ---[ end Kernel panic - not syncing: Fatal exception ]---

3.
---

[  219.147613] WARNING: CPU: 5 PID: 2200 at kernel/sched/core.c:1163 set_task_cpu+0x24e/0x2c0
[  219.157314] Modules linked in: binfmt_misc xfs nls_iso8859_15 nls_cp437 btrfs xor zstd_decompress zstd_compress xxhash raid6_pq sb_edac libcrc32c x86_pkg_temp_thermal coretemp kvm_intel kvm irqbypass crc32_pclmul snd_hda_codec_hdmi crc32c_intel ghash_clmulni_intel usbhid aesni_intel aes_x86_64 snd_hda_codec_realtek snd_hda_codec_generic crypto_simd cryptd snd_hda_intel glue_helper iTCO_wdt intel_cstate snd_hda_codec intel_uncore snd_hwdep dcdbas snd_hda_core dell_smm_hwmon iTCO_vendor_support intel_rapl_perf snd_pcm efi_pstore snd_timer serio_raw lpc_ich efivars i2c_i801 mfd_core snd soundcore button
[  219.214593] CPU: 5 PID: 2200 Comm: bash Tainted: G      D           4.17.0-rc1+ #1
[  219.223581] Hardware name: Dell Inc. Precision T3600/0PTTT9, BIOS A13 05/11/2014
[  219.232396] RIP: 0010:set_task_cpu+0x24e/0x2c0
[  219.238281] Code: 85 c0 0f 85 2a fe ff ff 0f 0b e9 23 fe ff ff 0f 0b e9 f7 fd ff ff f7 43 60 fd ff ff ff 0f 84 01 fe ff ff 0f 0b e9 fa fd ff ff <0f> 0b e9 12 fe ff ff e8 f6 c0 04 00 85 c0 0f 85 72 ff ff ff 48 c7 
[  219.260179] RSP: 0018:ffff88043df43d78 EFLAGS: 00010046
[  219.266967] RAX: 0000000000000000 RBX: ffff880439e81700 RCX: 0000000000000000
[  219.275649] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff880439e81700
[  219.284264] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  219.292805] R10: 0000000000000000 R11: ffffffff822507c0 R12: ffff880439e81e78
[  219.301344] R13: 0000000000000000 R14: 0000000000000046 R15: 0000000000021b40
[  219.309884] FS:  00007f4105bce280(0000) GS:ffff88043df40000(0000) knlGS:0000000000000000
[  219.319375] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  219.326549] CR2: 0000000000000000 CR3: 0000000439428005 CR4: 00000000000606e0
[  219.335106] Call Trace:
[  219.339018]  <IRQ>
[  219.342481]  try_to_wake_up+0x176/0x530
[  219.347751]  ? lock_acquire+0xa6/0x220
[  219.352928]  autoremove_wake_function+0xe/0x30
[  219.358773]  __wake_up_common+0x74/0x120
[  219.364114]  __wake_up_common_lock+0x7c/0xc0
[  219.369795]  ? tick_sched_do_timer+0x80/0x80
[  219.375482]  irq_work_run_list+0x49/0x70
[  219.380820]  update_process_times+0x3b/0x50
[  219.386416]  tick_sched_timer+0x37/0x70
[  219.391674]  __hrtimer_run_queues+0x114/0x590
[  219.397444]  hrtimer_interrupt+0xd5/0x220
[  219.402867]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  219.408983]  smp_apic_timer_interrupt+0x80/0x2e0
[  219.415014]  apic_timer_interrupt+0xf/0x20
[  219.420538]  </IRQ>
[  219.424076] RIP: 0010:panic+0x1fe/0x24c
[  219.429321] Code: a6 83 3d 28 97 7d 01 00 74 05 e8 c9 c9 02 00 48 c7 c6 60 31 84 82 48 c7 c7 90 e3 0a 82 e8 c4 68 07 00 e8 01 1e 06 00 fb 31 db <e8> f9 c7 0c 00 4c 39 eb 7c 1d 41 83 f4 01 48 8b 05 e9 96 7d 01 44 
[  219.450965] RSP: 0018:ffffc90003d03b90 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[  219.459921] RAX: 0000000000000039 RBX: 0000000000000000 RCX: 0000000000000001
[  219.468443] RDX: 0000000000000000 RSI: ffffffff81069a1f RDI: ffffffff81069a1f
[  219.476966] RBP: ffffc90003d03c08 R08: 0000000000000000 R09: 0000000000000000
[  219.485493] R10: ffffc90003d03ad0 R11: ffffffff8224e338 R12: 0000000000000000
[  219.494018] R13: 0000000000000000 R14: 000000000000000b R15: 0000000000000009
[  219.502549]  ? panic+0x1fb/0x24c
[  219.507175]  ? panic+0x1fb/0x24c
[  219.511771]  oops_end+0xbb/0xc0
[  219.516248]  no_context+0x17e/0x400
[  219.521044]  __do_page_fault+0x3f4/0x570
[  219.526260]  ? trace_hardirqs_off_caller+0x83/0xe0
[  219.532326]  do_page_fault+0x2c/0x2b0
[  219.537210]  page_fault+0x1e/0x30
[  219.541677] RIP: 0010:sysrq_handle_crash+0x41/0x80
[  219.547600] Code: e8 c4 17 c4 ff 48 c7 c2 87 b6 4a 81 be 01 00 00 00 48 c7 c7 c0 07 25 82 e8 2c 23 c2 ff c7 05 82 7a 39 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 e8 61 43 c4 ff 84 c0 75 c4 48 c7 c2 50 
[  219.568890] RSP: 0018:ffffc90003d03de8 EFLAGS: 00010286
[  219.575381] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 3e2d9cbd00000000
[  219.583774] RDX: ffff88043804cd38 RSI: 000000006cb322e4 RDI: 0000000000000000
[  219.592163] RBP: ffffc90003d03e10 R08: 000000003f352d81 R09: 0000000000000001
[  219.600544] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000007
[  219.608918] R13: ffffffff822c09e0 R14: 0000000000000000 R15: 0000000000000000
[  219.617290]  ? sysrq_handle_crash+0x34/0x80
[  219.622727]  __handle_sysrq+0xcd/0x210
[  219.627731]  write_sysrq_trigger+0x48/0x50
[  219.633075]  proc_reg_write+0x3c/0x60
[  219.637980]  __vfs_write+0x36/0x160
[  219.642686]  ? rcu_read_lock_sched_held+0x74/0x80
[  219.648556]  ? rcu_sync_lockdep_assert+0x2e/0x60
[  219.654302]  ? __sb_start_write+0x157/0x200
[  219.659595]  ? __sb_start_write+0x16d/0x200
[  219.664866]  vfs_write+0xbe/0x1b0
[  219.669268]  ksys_write+0x55/0xc0
[  219.673602]  do_syscall_64+0x64/0x200
[  219.678202]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  219.684177] RIP: 0033:0x7f41050a9620
[  219.688682] Code: 73 01 c3 48 8b 0d 78 c8 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 29 21 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae 9b 01 00 48 89 04 24 
[  219.709570] RSP: 002b:00007ffe8c2ad378 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  219.718195] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f41050a9620
[  219.726391] RDX: 0000000000000002 RSI: 00000000008fe408 RDI: 0000000000000001
[  219.734584] RBP: 00000000008fe408 R08: 00007f4105368760 R09: 00007f4105bce280
[  219.742793] R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000002
[  219.750973] R13: 0000000000000001 R14: 00007f4105367600 R15: 0000000000000002
[  219.759145] irq event stamp: 80113
[  219.763626] hardirqs last  enabled at (80113): [<ffffffff810544f9>] __do_page_fault+0x2f9/0x570
[  219.773371] hardirqs last disabled at (80112): [<ffffffff81a01096>] error_entry+0x86/0x100
[  219.782690] softirqs last  enabled at (80104): [<ffffffff81c0039e>] __do_softirq+0x39e/0x504
[  219.792196] softirqs last disabled at (80095): [<ffffffff810719d5>] irq_exit+0xd5/0xe0
[  219.801181] ---[ end trace 75992131ce321255 ]---

4.
---

[  219.806912] ------------[ cut here ]------------
[  219.812640] sched: Unexpected reschedule of offline CPU#0!
[  219.819253] WARNING: CPU: 5 PID: 2200 at arch/x86/kernel/smp.c:128 native_smp_send_reschedule+0x34/0x40
[  219.829732] Modules linked in: binfmt_misc xfs nls_iso8859_15 nls_cp437 btrfs xor zstd_decompress zstd_compress xxhash raid6_pq sb_edac libcrc32c x86_pkg_temp_thermal coretemp kvm_intel kvm irqbypass crc32_pclmul snd_hda_codec_hdmi crc32c_intel ghash_clmulni_intel usbhid aesni_intel aes_x86_64 snd_hda_codec_realtek snd_hda_codec_generic crypto_simd cryptd snd_hda_intel glue_helper iTCO_wdt intel_cstate snd_hda_codec intel_uncore snd_hwdep dcdbas snd_hda_core dell_smm_hwmon iTCO_vendor_support intel_rapl_perf snd_pcm efi_pstore snd_timer serio_raw lpc_ich efivars i2c_i801 mfd_core snd soundcore button
[  219.886225] CPU: 5 PID: 2200 Comm: bash Tainted: G      D W         4.17.0-rc1+ #1
[  219.895022] Hardware name: Dell Inc. Precision T3600/0PTTT9, BIOS A13 05/11/2014
[  219.903655] RIP: 0010:native_smp_send_reschedule+0x34/0x40
[  219.910397] Code: 05 21 ea 30 01 73 15 48 8b 05 78 34 13 01 be fd 00 00 00 48 8b 40 30 e9 aa 63 bc 00 89 fe 48 c7 c7 88 66 0a 82 e8 ec c5 02 00 <0f> 0b c3 66 0f 1f 84 00 00 00 00 00 66 66 66 66 90 8b 05 55 73 80 
[  219.931962] RSP: 0018:ffff88043df43d60 EFLAGS: 00010082
[  219.938524] RAX: 0000000000000000 RBX: ffff88043de21b40 RCX: 0000000000010004
[  219.946918] RDX: 0000000080010004 RSI: ffffffff820ebfed RDI: 00000000ffffffff
[  219.955301] RBP: ffff880439e81700 R08: 0000000000000000 R09: 0000000000000000
[  219.963686] R10: afb504000afb5041 R11: ffffffff8224e338 R12: ffff880439e81e78
[  219.972069] R13: ffff88043df43db0 R14: 0000000000000046 R15: ffff88043de21b58
[  219.980459] FS:  00007f4105bce280(0000) GS:ffff88043df40000(0000) knlGS:0000000000000000
[  219.989801] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  219.996819] CR2: 0000000000000000 CR3: 0000000439428005 CR4: 00000000000606e0
[  220.005216] Call Trace:
[  220.008992]  <IRQ>
[  220.012324]  check_preempt_curr+0x86/0xb0
[  220.017637]  ttwu_do_wakeup+0x19/0x270
[  220.022687]  try_to_wake_up+0x204/0x530
[  220.027820]  autoremove_wake_function+0xe/0x30
[  220.033553]  __wake_up_common+0x74/0x120
[  220.038771]  __wake_up_common_lock+0x7c/0xc0
[  220.044338]  ? tick_sched_do_timer+0x80/0x80
[  220.049829]  irq_work_run_list+0x49/0x70
[  220.054901]  update_process_times+0x3b/0x50
[  220.060230]  tick_sched_timer+0x37/0x70
[  220.065205]  __hrtimer_run_queues+0x114/0x590
[  220.070695]  hrtimer_interrupt+0xd5/0x220
[  220.075837]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  220.081669]  smp_apic_timer_interrupt+0x80/0x2e0
[  220.087412]  apic_timer_interrupt+0xf/0x20
[  220.092630]  </IRQ>
[  220.095903] RIP: 0010:panic+0x1fe/0x24c
[  220.100861] Code: a6 83 3d 28 97 7d 01 00 74 05 e8 c9 c9 02 00 48 c7 c6 60 31 84 82 48 c7 c7 90 e3 0a 82 e8 c4 68 07 00 e8 01 1e 06 00 fb 31 db <e8> f9 c7 0c 00 4c 39 eb 7c 1d 41 83 f4 01 48 8b 05 e9 96 7d 01 44 
[  220.122141] RSP: 0018:ffffc90003d03b90 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[  220.130970] RAX: 0000000000000039 RBX: 0000000000000000 RCX: 0000000000000001
[  220.139368] RDX: 0000000000000000 RSI: ffffffff81069a1f RDI: ffffffff81069a1f
[  220.147767] RBP: ffffc90003d03c08 R08: 0000000000000000 R09: 0000000000000000
[  220.156178] R10: ffffc90003d03ad0 R11: ffffffff8224e338 R12: 0000000000000000
[  220.164590] R13: 0000000000000000 R14: 000000000000000b R15: 0000000000000009
[  220.173012]  ? panic+0x1fb/0x24c
[  220.177561]  ? panic+0x1fb/0x24c
[  220.182108]  oops_end+0xbb/0xc0
[  220.186559]  no_context+0x17e/0x400
[  220.191290]  __do_page_fault+0x3f4/0x570
[  220.196374]  ? trace_hardirqs_off_caller+0x83/0xe0
[  220.202312]  do_page_fault+0x2c/0x2b0
[  220.207124]  page_fault+0x1e/0x30
[  220.211584] RIP: 0010:sysrq_handle_crash+0x41/0x80
[  220.217507] Code: e8 c4 17 c4 ff 48 c7 c2 87 b6 4a 81 be 01 00 00 00 48 c7 c7 c0 07 25 82 e8 2c 23 c2 ff c7 05 82 7a 39 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 e8 61 43 c4 ff 84 c0 75 c4 48 c7 c2 50 
[  220.238815] RSP: 0018:ffffc90003d03de8 EFLAGS: 00010286
[  220.245319] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 3e2d9cbd00000000
[  220.253709] RDX: ffff88043804cd38 RSI: 000000006cb322e4 RDI: 0000000000000000
[  220.262096] RBP: ffffc90003d03e10 R08: 000000003f352d81 R09: 0000000000000001
[  220.270477] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000007
[  220.278855] R13: ffffffff822c09e0 R14: 0000000000000000 R15: 0000000000000000
[  220.287230]  ? sysrq_handle_crash+0x34/0x80
[  220.292677]  __handle_sysrq+0xcd/0x210
[  220.297690]  write_sysrq_trigger+0x48/0x50
[  220.303037]  proc_reg_write+0x3c/0x60
[  220.307920]  __vfs_write+0x36/0x160
[  220.312595]  ? rcu_read_lock_sched_held+0x74/0x80
[  220.318443]  ? rcu_sync_lockdep_assert+0x2e/0x60
[  220.324172]  ? __sb_start_write+0x157/0x200
[  220.329464]  ? __sb_start_write+0x16d/0x200
[  220.334745]  vfs_write+0xbe/0x1b0
[  220.339116]  ksys_write+0x55/0xc0
[  220.343401]  do_syscall_64+0x64/0x200
[  220.348014]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  220.354001] RIP: 0033:0x7f41050a9620
[  220.358521] Code: 73 01 c3 48 8b 0d 78 c8 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 29 21 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae 9b 01 00 48 89 04 24 
[  220.379421] RSP: 002b:00007ffe8c2ad378 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  220.388042] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f41050a9620
[  220.396231] RDX: 0000000000000002 RSI: 00000000008fe408 RDI: 0000000000000001
[  220.404413] RBP: 00000000008fe408 R08: 00007f4105368760 R09: 00007f4105bce280
[  220.412590] R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000002
[  220.420759] R13: 0000000000000001 R14: 00007f4105367600 R15: 0000000000000002
[  220.428933] irq event stamp: 80113
[  220.433409] hardirqs last  enabled at (80113): [<ffffffff810544f9>] __do_page_fault+0x2f9/0x570
[  220.443155] hardirqs last disabled at (80112): [<ffffffff81a01096>] error_entry+0x86/0x100
[  220.452472] softirqs last  enabled at (80104): [<ffffffff81c0039e>] __do_softirq+0x39e/0x504
[  220.461970] softirqs last disabled at (80095): [<ffffffff810719d5>] irq_exit+0xd5/0xe0
[  220.470953] ---[ end trace 75992131ce321256 ]---

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
