Return-Path: <threeearcat@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524125357; cv=none;
        d=google.com; s=arc-20160816;
        b=vvPOvl+pnGI8yD3hpGwHdlqnAN+NVlXcWnloFkAxCTkSgbiOHJ3df59BuHMaPyZcio
         TKVY6oLvy8R/wJoTDIMkgHySKU8ja9HR/85Kf4HSCKBxwZS2Ldcw4wbwHa7vY54HJtg7
         SIy+7Uw3C53z7Bk1CbtD4bgSesGVMfdPUIiVbYRnmmO5asU21aYYTL9BCbykb+T3GTRp
         zHaMiPiASS00JH7b7eS2OI4rVbue/UeLo02sIUkGd/swzUE4lZhBERlaT8taVT90pPPI
         5bElDLtwJW6LHRXhvO03dXXiFNF4Fahr1hG0TmypmF+Qk8nTNysjo3Iz8n1CY28P0nEf
         rzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:subject:message-id:date:from:mime-version:dkim-signature
         :arc-authentication-results;
        bh=fpXtOalgmdoYcrzh++XQshSBd7QyeLeARQWkpe9uzKA=;
        b=mevi4p2KpRdev4yuRH8Rk70nrGhIiQsxTQM00rE2931D6A2L7c2JXu8Y4MKFfJwhPl
         +ijMxHrzglRu0lLwjbPpzDLnzpEenYS3laOqIBJSH1JcIMba8M7URi0dkP/lrcP+oDmU
         Vtr1sl7czUsnZW7yZEQ3w4yBuvWqEWb16mrkzhXFf8TdxufUgEA2cn1kR4z0J6mPmYkr
         nu2pz6gCaFzXdOrnhPeg+xA4s4bMQ+GoRICU/zk8zFKiGJZ5s73xn5jnX1klVw7AC6KW
         MiVU44ZkRPe/hI9RnAyW+k8cpQLFlyY2qHaPDKb3b0m/7+YY5G/AYjqR2H2dV2upmpcW
         GK/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hOiVAHCx;
       spf=pass (google.com: domain of threeearcat@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=threeearcat@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hOiVAHCx;
       spf=pass (google.com: domain of threeearcat@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=threeearcat@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/KG9RrXkJU7zBMTFYt07vHmHwYSjVi8hYIpmY4J9iHYO3+sIdWO2ee+yYJ5qs62pEX1R3PkjkrZRJHnPUVM6g=
MIME-Version: 1.0
From: DaeRyong Jeong <threeearcat@gmail.com>
Date: Thu, 19 Apr 2018 17:09:16 +0900
Message-ID: <CACsK=jfSRSLYvPJKzFrRQgNa10DsF8xLLKGYfqqE_hF9ucX-yw@mail.gmail.com>
Subject: KASAN: slab-out-of-bounds Write in tty_insert_flip_string_fixed_flag
To: Byoungyoung Lee <byoungyoung@purdue.edu>, Kyungtae Kim <kt0755@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598161270730760907?=
X-GMAIL-MSGID: =?utf-8?q?1598161270730760907?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We report the crash:
KASAN: slab-out-of-bounds Write in tty_insert_flip_string_fixed_flag

This crash has been found in v4.16 using RaceFuzzer (a modified
version of Syzkaller), which we describe more at the end of this
report. Our analysis shows that the race occurs when invoking two
syscalls concurrently, ioctl$TCXONC(r0, 0x540a, 0x2) and
ioctl$TCXONC(r0, 0x540a, 0x1).

C repro code:
https://kiwi.cs.purdue.edu/static/race-fuzzer/tty_insert_flip_string_fixed_flag.c
kernel config v4.16:
https://kiwi.cs.purdue.edu/static/race-fuzzer/tty_insert_flip_string_fixed_flag.config

Analysis:
We think the concurrent execution of tty_insert_filp_string_fixed_flag
causes the crash.
Unsynchronized copying data to a buffer and updating an offset may
cause crashes slab-out-of-bounds write in
tty_insert_flip_string_fixed_flag or slab-out-of-bounds read in
flush_to_ldisc.

Call Sequence (v4.16):
CPU0 (ioctl$TCXONC(r0, 0x540a, 0x1))
n_tty_ioctl_helper
  __start_tty
    tty_wakeup
      n_hdlc_tty_wakeup
        n_hdlc_send_frames
          pty_write
            tty_insert_flip_string
              tty_insert_flip_string_fixed_flag

CPU1 (ioctl$TCXONC(r0, 0x540a, 0x2))
n_tty_ioctl_helper
  tty_send_xchar
    pty_write
      tty_insert_flip_string
        tty_insert_flip_string_fixed_flag

Crash log:
==================================================================
[  149.605804] BUG: KASAN: slab-out-of-bounds in
tty_insert_flip_string_fixed_flag+0xaf/0x130
[  149.606914] Write of size 1 at addr ffff8800b1373ae0 by task
a.out/3899
[  149.607801]
[  149.608033] CPU: 0 PID: 3899 Comm: a.out Not tainted 4.16.0 #1
[  149.608852] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  149.610040] Call Trace:
[  149.610379]  dump_stack+0x155/0x1f6
[  149.610847]  ? arch_local_irq_restore+0x3c/0x3c
[  149.611438]  ? show_regs_print_info+0x18/0x18
[  149.612012]  ? flush_to_ldisc+0x310/0x310
[  149.612548]  ? tty_insert_flip_string_fixed_flag+0xaf/0x130
[  149.613273]  print_address_description+0x73/0x250
[  149.613889]  ? tty_insert_flip_string_fixed_flag+0xaf/0x130
[  149.614609]  kasan_report+0x23f/0x360
[  149.615106]  check_memory_region+0x140/0x1a0
[  149.615669]  memcpy+0x37/0x50
[  149.616076]  tty_insert_flip_string_fixed_flag+0xaf/0x130
[  149.616807]  pty_write+0x7f/0xc0
[  149.617248]  tty_send_xchar+0x114/0x180
[  149.617765]  n_tty_ioctl_helper+0xec/0x1e0
[  149.618312]  n_hdlc_tty_ioctl+0x118/0x370
[  149.618848]  ? n_hdlc_tty_wakeup+0xa0/0xa0
[  149.619410]  ? ldsem_down_read+0x37/0x40
[  149.619923]  ? ldsem_down_read+0x37/0x40
[  149.620474]  tty_ioctl+0x292/0x1030
[  149.620914]  ? n_hdlc_tty_wakeup+0xa0/0xa0
[  149.621431]  ? tty_vhangup+0x30/0x30
[  149.621883]  ? rcu_is_watching+0x8f/0xd0
[  149.622378]  ? rcutorture_record_progress+0x10/0x10
[  149.622998]  ? __lock_is_held+0x30/0xc0
[  149.623505]  ? ___might_sleep+0x258/0x340
[  149.624010]  ? check_same_owner+0x240/0x240
[  149.624535]  ? __vfs_write+0xe5/0x480
[  149.624997]  ? rcu_note_context_switch+0x4e0/0x4e0
[  149.625594]  ? rcu_note_context_switch+0x4e0/0x4e0
[  149.626186]  ? kernel_read+0xa0/0xa0
[  149.626648]  ? tty_vhangup+0x30/0x30
[  149.627099]  do_vfs_ioctl+0x145/0xd00
[  149.627557]  ? _cond_resched+0x14/0x30
[  149.628039]  ? ioctl_preallocate+0x1c0/0x1c0
[  149.628583]  ? selinux_capable+0x40/0x40
[  149.629087]  ? SyS_futex+0x22b/0x2f0
[  149.629562]  ? security_file_ioctl+0x62/0x90
[  149.630094]  ? security_file_ioctl+0x6e/0x90
[  149.630633]  SyS_ioctl+0x8f/0xc0
[  149.631049]  ? do_vfs_ioctl+0xd00/0xd00
[  149.631534]  do_syscall_64+0x1f2/0x530
[  149.632017]  ? syscall_return_slowpath+0x360/0x360
[  149.632632]  ? syscall_return_slowpath+0x1fd/0x360
[  149.633204]  ? mark_held_locks+0x23/0xa0
[  149.633675]  ? entry_SYSCALL_64_after_hwframe+0x52/0xb7
[  149.634295]  ? trace_hardirqs_off_caller+0xb5/0x120
[  149.634874]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  149.635444]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[  149.636051] RIP: 0033:0x7f4079e59b79
[  149.636493] RSP: 002b:00007f4079d7ddd8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  149.637377] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
00007f4079e59b79
[  149.638194] RDX: 0000000000000002 RSI: 000000000000540a RDI:
0000000000000062
[  149.639014] RBP: 00007f4079d7de20 R08: 0000000000000000 R09:
0000000000000000
[  149.639839] R10: 0000000000000000 R11: 0000000000000246 R12:
000000000072fef0
[  149.640675] R13: 00007f4079d7e9c0 R14: 00007f407a548040 R15:
0000000000000003
[  149.641529]
[  149.641722] Allocated by task 3899:
[  149.642140]  save_stack+0x43/0xd0
[  149.642539]  kasan_kmalloc+0xae/0xe0
[  149.642968]  __kmalloc+0x162/0x760
[  149.643376]  __tty_buffer_request_room+0x1cb/0x400
[  149.643934]  tty_insert_flip_string_fixed_flag+0x67/0x130
[  149.644585]  pty_write+0x7f/0xc0
[  149.644959]  n_hdlc_send_frames+0x1a4/0x340
[  149.645432]  n_hdlc_tty_write+0x3f3/0x480
[  149.645887]  tty_write+0x320/0x510
[  149.646275]  __vfs_write+0xdd/0x480
[  149.646672]  vfs_write+0x12d/0x2d0
[  149.647059]  SyS_write+0xca/0x190
[  149.647438]  do_syscall_64+0x1f2/0x530
[  149.647863]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[  149.648434]
[  149.648624] Freed by task 0:
[  149.648937] (stack is not available)
[  149.649322]
[  149.649501] The buggy address belongs to the object at
ffff8800b1372cc0
[  149.649501]  which belongs to the cache kmalloc-4096 of size 4096
[  149.650820] The buggy address is located 3616 bytes inside of
[  149.650820]  4096-byte region [ffff8800b1372cc0, ffff8800b1373cc0)
[  149.652054] The buggy address belongs to the page:
[  149.652581] page:ffffea0002c4dc80 count:1 mapcount:0
mapping:ffff8800b1372cc0 index:0x0 compound_mapcount: 0
[  149.653629] flags: 0x1fffc0000008100(slab|head)
[  149.654122] raw: 01fffc0000008100 ffff8800b1372cc0 0000000000000000
0000000100000001
[  149.654941] raw: ffffea0002cb1c20 ffff8800b4801a48 ffff8800b4800dc0
0000000000000000
[  149.655748] page dumped because: kasan: bad access detected
[  149.656346]
[  149.656520] Memory state around the buggy address:
[  149.657031]  ffff8800b1373980: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[  149.657805]  ffff8800b1373a00: 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00
[  149.658563] >ffff8800b1373a80: 00 00 00 00 00 00 00 00 00 00 00 00
fc fc fc fc
[  149.659320]
^
[  149.659989]  ffff8800b1373b00: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[  149.660759]  ffff8800b1373b80: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[  149.661535]
==================================================================
[  149.662297] Disabling lock debugging due to kernel taint



= About RaceFuzzer

RaceFuzzer is a customized version of Syzkaller, specifically tailored
to find race condition bugs in the Linux kernel. While we leverage
many different technique, the notable feature of RaceFuzzer is in
leveraging a custom hypervisor (QEMU/KVM) to interleave the
scheduling. In particular, we modified the hypervisor to intentionally
stall a per-core execution, which is similar to supporting per-core
breakpoint functionality. This allows RaceFuzzer to force the kernel
to deterministically trigger racy condition (which may rarely happen
in practice due to randomness in scheduling).

RaceFuzzer's C repro always pinpoints two racy syscalls. Since C
repro's scheduling synchronization should be performed at the user
space, its reproducibility is limited (reproduction may take from 1
second to 10 minutes (or even more), depending on a bug). This is
because, while RaceFuzzer precisely interleaves the scheduling at the
kernel's instruction level when finding this bug, C repro cannot fully
utilize such a feature. Please disregard all code related to
"should_hypercall" in the C repro, as this is only for our debugging
purposes using our own hypervisor.
