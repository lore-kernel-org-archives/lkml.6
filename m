Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536BDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156CD20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156CD20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbeKJEva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:51:30 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47709 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJEva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:51:30 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gLC9p-00036f-K0; Fri, 09 Nov 2018 20:09:29 +0100
Date:   Fri, 9 Nov 2018 20:09:29 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 22/23] x86/fpu: Don't restore the FPU state directly from
 userland in __fpu__restore_sig()
Message-ID: <20181109190929.xb7nciwy3yvntja6@linutronix.de>
References: <20181107194858.9380-1-bigeasy@linutronix.de>
 <20181107194858.9380-23-bigeasy@linutronix.de>
 <CALCETrXYTSsxYUmxb6FmvQrSaMPJ77jqgnfzG_7yRGxLUw3_QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrXYTSsxYUmxb6FmvQrSaMPJ77jqgnfzG_7yRGxLUw3_QQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-08 10:25:24 [-0800], Andy Lutomirski wrote:
> On Wed, Nov 7, 2018 at 11:49 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > __fpu__restore_sig() restores the CPU's FPU state directly from
> > userland. If we restore registers on return to userland then we can't
> > load them directly from userland because a context switch/BH could
> > destroy them.
> >
> > Restore the FPU registers after they have been copied from userland.
> > __fpregs_changes_begin() ensures that they are not modified while beeing
> > worked on. TIF_NEED_FPU_LOAD is clreared we want to keep our state, not
> > the saved state.
> 
> I'm conceptually okay with this change, but what happens if the
> registers that are copied into the kernel are garbage?  We used to
> fail the restore and presumably kill the task.  What happens now?

What means garbage? Assume you mean something like memset(xstate, 0xff,)
then this would happen:

| ------------[ cut here ]------------
| Bad FPU state detected at __fpu__restore_sig+0x2a3/0x660, reinitializing FPU registers.
| WARNING: CPU: 0 PID: 1687 at arch/x86/mm/extable.c:113 ex_handler_fprestore+0x60/0x70
| Modules linked in:
| CPU: 0 PID: 1687 Comm: ssltc Not tainted 4.20.0-rc1+ #116
| Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.1-1 04/01/2014
| RIP: 0010:ex_handler_fprestore+0x60/0x70
| Code: 00 00 00 5d c3 48 0f ae 0d 0d 13 2c 01 b8 01 00 00 00 5d c3 48 89 c6 48 c7 c7 40 39 02 82 c6 05 c3 1d 2b 01 01 e8 0a 01 01 00 <0f> 0b eb b9 66 66 2e 0f 1f 84 00 00 7
| RSP: 0018:ffffc90000563cf8 EFLAGS: 00010282
| RAX: 0000000000000000 RBX: ffffc90000563d68 RCX: 0000000000000000
| RDX: 0000000000000046 RSI: 0000000000000000 RDI: ffff88003a1516c0
| RBP: ffffc90000563cf8 R08: 0000000000000000 R09: 0000000000000000
| R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000d
| R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
| FS:  00007f17678f1b80(0000) GS:ffff88003e800000(0000) knlGS:0000000000000000
| CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
| CR2: 00007f1767dc2000 CR3: 000000003d0b6003 CR4: 0000000000060ef0
| Call Trace:
|  fixup_exception+0x45/0x5c
|  do_general_protection+0x61/0x1a0
|  general_protection+0x1e/0x30
| RIP: 0010:__fpu__restore_sig+0x2a3/0x660
| Code: 00 00 48 8b 95 48 ff ff ff 48 f7 d2 48 21 d0 0f 85 73 03 00 00 48 8b 85 48 ff ff ff 4c 89 f7 48 89 c2 48 c1 ea 20 48 0f ae 2f <65> 48 8b 04 25 00 4f 01 00 f0 80 60 e
| RSP: 0018:ffffc90000563e18 EFLAGS: 00010246
| RAX: 0000000000000007 RBX: 00007ffe7f19df40 RCX: 00000000000031d7
| RDX: 0000000000000000 RSI: 0000000000000200 RDI: ffff88003a152a40
| RBP: ffffc90000563ed0 R08: 0000000000000000 R09: 0000000000000000
| R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
| R13: ffff88003a1516c0 R14: ffff88003a152a40 R15: ffff88003a152a00
|  ? __fpu__restore_sig+0x261/0x660
|  ? trace_hardirqs_on+0x22/0x110
|  fpu__restore_sig+0x28/0x40
|  __ia32_sys_rt_sigreturn+0x218/0x2aa
|  do_syscall_64+0x50/0x1a0
|  entry_SYSCALL_64_after_hwframe+0x49/0xbe
| RIP: 0033:0x7f1767ca8a7b
| Code: 31 d8 0f a4 ed 05 c5 79 7f 4c 24 30 01 fa 21 c6 c5 b9 72 d4 1f 31 d8 01 ea 0f ac ed 07 31 de c5 a9 73 fc 0c c5 d9 fe e4 89 d7 <03> 4c 24 08 31 c5 0f a4 d2 05 c4 c1 1
| RSP: 002b:00007ffe7f19e340 EFLAGS: 00000282
| RAX: 000000001c9f00ab RBX: 00000000837732a0 RCX: 000000001bff4f26
| RDX: 0000000037535a7c RSI: 00000000979700a8 RDI: 0000000037535a7c
| RBP: 00000000053caff3 R08: 00005615ffd442a0 R09: 00007f1767dc54c0
| R10: 00007f1767dc6000 R11: 00007ffe7f19e3c8 R12: 00007f1767dc2000
| R13: 00005615ff6c30a0 R14: 00007f1767cab080 R15: 00007f1767d95100
| irq event stamp: 12775
| hardirqs last  enabled at (12774): [<ffffffff810de72c>] vprintk_emit+0xac/0x270
| hardirqs last disabled at (12775): [<ffffffff81001c01>] trace_hardirqs_off_thunk+0x1a/0x1c
| softirqs last  enabled at (12756): [<ffffffff81c003a2>] __do_softirq+0x3a2/0x4d1
| softirqs last disabled at (12760): [<ffffffff8102a210>] __fpu__restore_sig+0x230/0x660
| ---[ end trace 163c456a84752e26 ]---

and the task continues. Before we had this:
| BUG: GPF in non-whitelisted uaccess (non-canonical address?)
| general protection fault: 0000 [#2] PREEMPT SMP DEBUG_PAGEALLOC PTI
| CPU: 1 PID: 1687 Comm: ssltc Tainted: G      D           4.20.0-rc1+ #120
| Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.1-1 04/01/2014
| RIP: 0010:__fpu__restore_sig+0x2fa/0x710
| Code: 34 8b 95 5c ff ff ff 85 d2 75 2a 4c 89 fa 48 f7 d2 48 21 d0 0f 85 b8 03 00 00 66 66 90 4c 89 fa 48 89 df 44 89 f8 48 c1 ea 20 <48> 0f ae 2f 31 db 66 66 90 eb 24 48 2
| RSP: 0018:ffffc900004abe20 EFLAGS: 00010246
| RAX: 0000000000000007 RBX: 00007ffe5b4c1680 RCX: 0000000000000000
| RDX: 0000000000000000 RSI: ffffffff820544ad RDI: 00007ffe5b4c1680
| RBP: ffffc900004abed0 R08: 0000000000000000 R09: 0000000000000001
| R10: 0000000000000000 R11: 0000000000000000 R12: ffff8800394440c0
| R13: ffff880039442d80 R14: ffff8800394440c0 R15: 0000000000000007
| FS:  00007f81db2d4b80(0000) GS:ffff88003e880000(0000) knlGS:0000000000000000
| CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
| CR2: 00007f81db7a5000 CR3: 000000003aafa002 CR4: 0000000000060ee0
| Call Trace:
|  ? trace_hardirqs_on+0x22/0x110
|  fpu__restore_sig+0x28/0x40
|  __ia32_sys_rt_sigreturn+0x218/0x2aa
|  do_syscall_64+0x50/0x180
|  entry_SYSCALL_64_after_hwframe+0x49/0xbe
| RIP: 0033:0x7f81db68bdc7
| Code: 54 24 14 31 df 89 ee 0f a4 ed 05 c5 b9 72 d1 1e c5 79 7f 0c 24 01 fa 31 de 0f ac c0 07 01 ea c5 f1 72 f1 02 03 4c 24 18 31 c6 <89> d7 0f a4 d2 05 01 f1 31 c7 0f ac 3
| RSP: 002b:00007ffe5b4c1a80 EFLAGS: 00000286
| RAX: 00000000ad356612 RBX: 000000007d63f272 RCX: 00000000adc87c8e
| RDX: 00000000d90909d0 RSI: 000000008b541c65 RDI: 00000000188b44f4
| RBP: 00000000605100ab R08: 0000555c9ecd52a0 R09: 00007f81db7a8f80
| R10: 00007f81db7a9000 R11: 00007ffe5b4c1ae8 R12: 00007f81db7a5000
| R13: 0000555c9d0c60a0 R14: 00007f81db68e080 R15: 00007f81db778100
| Modules linked in:
| Dumping ftrace buffer:
|    (ftrace buffer empty)
| ---[ end trace a16fb09d293317cc ]---
| RIP: 0010:__fpu__restore_sig+0x2fa/0x710
| Code: 34 8b 95 5c ff ff ff 85 d2 75 2a 4c 89 fa 48 f7 d2 48 21 d0 0f 85 b8 03 00 00 66 66 90 4c 89 fa 48 89 df 44 89 f8 48 c1 ea 20 <48> 0f ae 2f 31 db 66 66 90 eb 24 48 2
| RSP: 0018:ffffc900004abe20 EFLAGS: 00010246
| RAX: 0000000000000007 RBX: 00007ffe1945ae40 RCX: 0000000000000000
| RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00007ffe1945ae40
| RBP: ffffc900004abed0 R08: 0000000000000000 R09: 0000000000000000
| R10: 0000000000000000 R11: 0000000000000000 R12: ffff8800394440c0
| R13: ffff880039442d80 R14: ffff8800394440c0 R15: 0000000000000007
| FS:  00007f81db2d4b80(0000) GS:ffff88003e880000(0000) knlGS:0000000000000000
| CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
| CR2: 00007f81db7a5000 CR3: 000000003aafa002 CR4: 0000000000060ee0

Noisier but the task segfaulted.
I could add validate_xstate_header() + sanitize_restored_xstate() which
is what we do for 32bit-frames and should catch garbage. Then it ends
with:
| ssltc[1724] bad frame in rt_sigreturn frame:00000000ac8c6496 ip:7f4a10e36eda sp:7fff75054540 orax:ffffffffffffffff in libcrypto.so.1.1[7f4a10ce9000+19f000]

which would be also a segfault but with a smaller backtrace. Also
checking for XFEATURE_MASK_SUPERVISOR sounds like a good thing.
Right now XFEATURE_MASK_SUPERVISOR is not enabled in BV so it should not
make a difference but should be save in future.

Sebastian
