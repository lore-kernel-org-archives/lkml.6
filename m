Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeDZEwf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 00:52:35 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:44555 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeDZEwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 00:52:33 -0400
X-Google-Smtp-Source: AIpwx48zRZ2DO9z83z5YXvtrUrP9/S495O+OSpGilsWBwNjXCDksCdQCv+IaxANJtPda1eK8pd0e8A==
Date: Thu, 26 Apr 2018 13:52:27 +0900
From: DaeRyong Jeong <threeearcat@gmail.com>
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        byoungyoung@purdue.edu, kt0755@gmail.com, bammanag@purdue.edu
Subject: Unable to handle kernel paging request in snd_seq_oss_readq_puts
Message-ID: <20180426045223.GA15307@dragonet.kaist.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report the crash:
unable to handle kernel paging request in snd_seq_oss_readq_puts

This crash has been found in v4.16 using RaceFuzzer (a modified
version of Syzkaller), which we describe more at the end of this
report. Our analysis shows that the race occurs when invoking two
syscalls concurrently, write$eventfd and write$sndseq.

Analysis:
We think the concurrent execution of snd_virmidi_output_trigger() and
snd_midi_event_encode_byte() causes the crash. Since the first call site
of snd_seq_kernel_client_dispatch() in snd_virmidi_output_trigger() is not
protected by substream->runtime->lock, it is possible that
snd_seq_oss_readq_puts() and snd_midi_event_encode_byte() are executed
concurrently in the call sequences as below, and snd_seq_oss_readq_puts()
accesses ev->data.ex.ptr before it is initialized.

Thread Interleaving:
CPU1 (snd_virmidi_output_trigger)                   CPU2(snd_midi_event_encode_byte)

                                                    ev->type = SNDRV_SEQ_EVENT_SYSEX;
if (vmidi->event.type != SNDRV_SEQ_EVENT_NONE) {
    if (snd_seq_kernel_client_dispatch(vmidi->client, &vmidi->event, in_atomic(), 0) < 0)
        ...
        /* In snd_seq_oss_readq_puts(),
         * data has the same value with ev->data.ext.ptr
         * which is not initialized yet
         */
        rec.c[1] = *data++;
                                                    ev->data.ext.len = dev->read;
                                                    ev->data.ext.ptr = dev->buf;

Call sequence:
CPU1
snd_rawmidi_write
  snd_rawmidi_kernel_write1
    snd_rawmidi_output_trigger
      snd_virmidi_output_trigger
        snd_seq_kernel_client_dispatch (line #178 in v4.16)
          snd_seq_deliver_event
            deliver_to_subscribers
              snd_seq_deliver_single_event.constprop.14
                snd_seq_oss_event_input
                  snd_seq_oss_midi_input
                    send_midi_event
                      snd_seq_oss_readq_sysex
                        snd_seq_dump_var_event
                          readq_dump_sysex
                            snd_seq_oss_readq_puts

CPU2
snd_rawmidi_write
  snd_rawmidi_kernel_write1
    snd_rawmidi_output_trigger
      snd_virmidi_output_trigger
        snd_midi_event_encode
            snd_midi_event_encode_byte


Crash log:
==================================================================
BUG: KASAN: null-ptr-deref in snd_seq_oss_readq_puts+0xc5/0x160 sound/core/seq/oss/seq_oss_readq.c:112
Read of size 1 at addr 0000000000000049 by task syz-executor0/12892

CPU: 1 PID: 12892 Comm: syz-executor0 Not tainted 4.16.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x171/0x227 lib/dump_stack.c:53
 kasan_report_error mm/kasan/report.c:352 [inline]
 kasan_report.cold.7+0x13b/0x2f5 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 __asan_load1+0x47/0x50 mm/kasan/kasan.c:695
 snd_seq_oss_readq_puts+0xc5/0x160 sound/core/seq/oss/seq_oss_readq.c:112
 readq_dump_sysex+0x3f/0x50 sound/core/seq/oss/seq_oss_readq.c:133
 snd_seq_dump_var_event+0x375/0x3a0 sound/core/seq/seq_memory.c:107
 snd_seq_oss_readq_sysex+0xec/0x100 sound/core/seq/oss/seq_oss_readq.c:146
 send_midi_event sound/core/seq/oss/seq_oss_midi.c:615 [inline]
 snd_seq_oss_midi_input+0x332/0x710 sound/core/seq/oss/seq_oss_midi.c:535
 snd_seq_oss_event_input+0xe9/0x130 sound/core/seq/oss/seq_oss_event.c:439
 snd_seq_deliver_single_event.constprop.14+0x4bd/0x5a0 sound/core/seq/seq_clientmgr.c:622
 deliver_to_subscribers sound/core/seq/seq_clientmgr.c:677 [inline]
 snd_seq_deliver_event+0x274/0x5d0 sound/core/seq/seq_clientmgr.c:812
 snd_seq_kernel_client_dispatch+0xe2/0x100 sound/core/seq/seq_clientmgr.c:2330
 snd_virmidi_output_trigger+0x156/0x420 sound/core/seq/seq_virmidi.c:178
 snd_rawmidi_output_trigger sound/core/rawmidi.c:150 [inline]
 snd_rawmidi_kernel_write1+0x383/0x410 sound/core/rawmidi.c:1288
 snd_rawmidi_write+0x241/0xa30 sound/core/rawmidi.c:1338
 __vfs_write+0xed/0x510 fs/read_write.c:480
 vfs_write+0x195/0x380 fs/read_write.c:544
 SYSC_write fs/read_write.c:589 [inline]
 SyS_write+0xd7/0x1c0 fs/read_write.c:581
 do_syscall_64+0x209/0x5d0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x453bb9
RSP: 002b:00007f46902c2af8 EFLAGS: 00000212 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000007080d8 RCX: 0000000000453bb9
RDX: 00000000000000f3 RSI: 0000000020004f0d RDI: 0000000000000006
RBP: 0000000000005ed0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000212 R12: 00000000004ab432
R13: 00000000ffffffff R14: 0000000000000006 R15: 0000000020004f0d
==================================================================
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 12892 Comm: syz-executor0 Tainted: G    B            4.16.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x171/0x227 lib/dump_stack.c:53
 panic+0x1c9/0x44c kernel/panic.c:183
 kasan_end_report+0x47/0x4f mm/kasan/report.c:180
 kasan_report_error mm/kasan/report.c:359 [inline]
 kasan_report.cold.7+0xc9/0x2f5 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 __asan_load1+0x47/0x50 mm/kasan/kasan.c:695
 snd_seq_oss_readq_puts+0xc5/0x160 sound/core/seq/oss/seq_oss_readq.c:112
 readq_dump_sysex+0x3f/0x50 sound/core/seq/oss/seq_oss_readq.c:133
 snd_seq_dump_var_event+0x375/0x3a0 sound/core/seq/seq_memory.c:107
 snd_seq_oss_readq_sysex+0xec/0x100 sound/core/seq/oss/seq_oss_readq.c:146
 send_midi_event sound/core/seq/oss/seq_oss_midi.c:615 [inline]
 snd_seq_oss_midi_input+0x332/0x710 sound/core/seq/oss/seq_oss_midi.c:535
 snd_seq_oss_event_input+0xe9/0x130 sound/core/seq/oss/seq_oss_event.c:439
 snd_seq_deliver_single_event.constprop.14+0x4bd/0x5a0 sound/core/seq/seq_clientmgr.c:622
 deliver_to_subscribers sound/core/seq/seq_clientmgr.c:677 [inline]
 snd_seq_deliver_event+0x274/0x5d0 sound/core/seq/seq_clientmgr.c:812
 snd_seq_kernel_client_dispatch+0xe2/0x100 sound/core/seq/seq_clientmgr.c:2330
 snd_virmidi_output_trigger+0x156/0x420 sound/core/seq/seq_virmidi.c:178
 snd_rawmidi_output_trigger sound/core/rawmidi.c:150 [inline]
 snd_rawmidi_kernel_write1+0x383/0x410 sound/core/rawmidi.c:1288
 snd_rawmidi_write+0x241/0xa30 sound/core/rawmidi.c:1338
 __vfs_write+0xed/0x510 fs/read_write.c:480
 vfs_write+0x195/0x380 fs/read_write.c:544
 SYSC_write fs/read_write.c:589 [inline]
 SyS_write+0xd7/0x1c0 fs/read_write.c:581
 do_syscall_64+0x209/0x5d0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x453bb9
RSP: 002b:00007f46902c2af8 EFLAGS: 00000212 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000007080d8 RCX: 0000000000453bb9
RDX: 00000000000000f3 RSI: 0000000020004f0d RDI: 0000000000000006
RBP: 0000000000005ed0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000212 R12: 00000000004ab432
R13: 00000000ffffffff R14: 0000000000000006 R15: 0000000020004f0d
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..

BUG: unable to handle kernel paging request at ffffe0000000007c
IP: snd_seq_oss_readq_puts+0xc9/0x160 sound/core/seq/oss/seq_oss_readq.c:112
PGD 0 P4D 0
Oops: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 30835 Comm: syz-executor0 Not tainted 4.16.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
RIP: 0010:snd_seq_oss_readq_puts+0xc9/0x160 sound/core/seq/oss/seq_oss_readq.c:112
RSP: 0018:ffff880237427238 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 000000000000000e RCX: ffffffff83159785
RDX: 1ffffc000000000f RSI: ffffffff83159775 RDI: ffff880237427269
RBP: ffff8802374272d0 R08: ffff88022e7f63c0 R09: ffff880237427268
R10: ffffed0046e84e4d R11: ffff88023742726f R12: ffffe0000000007c
R13: ffffe0000000007d R14: ffff880237427268 R15: ffff8802374272a8
FS:  00007fa616b6b700(0000) GS:ffff8800bae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffe0000000007c CR3: 00000002316cc000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 readq_dump_sysex+0x3f/0x50 sound/core/seq/oss/seq_oss_readq.c:133
 snd_seq_dump_var_event+0x375/0x3a0 sound/core/seq/seq_memory.c:107
 snd_seq_oss_readq_sysex+0xec/0x100 sound/core/seq/oss/seq_oss_readq.c:146
 send_midi_event sound/core/seq/oss/seq_oss_midi.c:615 [inline]
 snd_seq_oss_midi_input+0x332/0x710 sound/core/seq/oss/seq_oss_midi.c:535
 snd_seq_oss_event_input+0xe9/0x130 sound/core/seq/oss/seq_oss_event.c:439
 snd_seq_deliver_single_event.constprop.14+0x4bd/0x5a0 sound/core/seq/seq_clientmgr.c:622
 deliver_to_subscribers sound/core/seq/seq_clientmgr.c:677 [inline]
 snd_seq_deliver_event+0x274/0x5d0 sound/core/seq/seq_clientmgr.c:812
 snd_seq_kernel_client_dispatch+0xe2/0x100 sound/core/seq/seq_clientmgr.c:2330
 snd_virmidi_output_trigger+0x156/0x420 sound/core/seq/seq_virmidi.c:178
 snd_rawmidi_output_trigger sound/core/rawmidi.c:150 [inline]
 snd_rawmidi_kernel_write1+0x383/0x410 sound/core/rawmidi.c:1288
 snd_rawmidi_write+0x241/0xa30 sound/core/rawmidi.c:1338
 __vfs_write+0xed/0x510 fs/read_write.c:480
 vfs_write+0x195/0x380 fs/read_write.c:544
 SYSC_write fs/read_write.c:589 [inline]
 SyS_write+0xd7/0x1c0 fs/read_write.c:581
 do_syscall_64+0x209/0x5d0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x453bb9
RSP: 002b:00007fa616b6aaf8 EFLAGS: 00000212 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000708020 RCX: 0000000000453bb9
RDX: 0000000000000008 RSI: 0000000020002ff8 RDI: 0000000000000006
RBP: 0000000000005ef0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000212 R12: 00000000004ad178
R13: 00000000ffffffff R14: 0000000000000006 R15: 0000000020002ff8
Code: 8d 7e 02 c6 45 98 05 e8 26 a1 5c fe 44 88 6d 9a eb 4a e8 7b 47 36 fe 4c 89 e7 4d 8d 6c 24 01 83 eb 01 e8 bb a0 5c fe 49 8d 7e 01 <45> 0f b6 24 24 e8 fd a0 5c fe 48 8b bd 70 ff ff ff 4c 89 f6 45
RIP: snd_seq_oss_readq_puts+0xc9/0x160 sound/core/seq/oss/seq_oss_readq.c:112 RSP: ffff880237427238
CR2: ffffe0000000007c
---[ end trace 029460d043170cd7 ]---


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
