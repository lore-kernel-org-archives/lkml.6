Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C886FC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDC020837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDC020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeLGWGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:06:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:33566 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeLGWGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 17:06:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 14:06:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,327,1539673200"; 
   d="scan'208";a="257744394"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by orsmga004.jf.intel.com with ESMTP; 07 Dec 2018 14:06:47 -0800
Date:   Fri, 7 Dec 2018 14:06:47 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dave.hansen@linux.intel.com, Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>, yu-cheng.yu@intel.com,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] x86/fault: Decode and print #PF oops in human
 readable form
Message-ID: <20181207220646.GH10404@linux.intel.com>
References: <20181207184423.1962-1-sean.j.christopherson@intel.com>
 <20181207195223.23968-1-sean.j.christopherson@intel.com>
 <CAHk-=wgtN9nQBimLuOmBxY8eYqDRhNeBOW_uvnhqtZSFycyHuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgtN9nQBimLuOmBxY8eYqDRhNeBOW_uvnhqtZSFycyHuA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 12:46:30PM -0800, Linus Torvalds wrote:
> On Fri, Dec 7, 2018 at 11:52 AM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > Remove the per-bit decoding of the error code and instead print:
> 
> The patch looks fine to me, so feel free to add an acked-by, but:
> 
>  (a) I'm not the one who wanted the human-legible version in the first
> place, since I'm also perfectly ok with just the error code, so my
> judgement is obviously garbage wrt this whole thing
> 
>  (b) it would be good to have a couple of actual examples of the
> printout to judge.
> 
> I can certainly imagine how it looks just from the patch, but maybe if
> I actually see reality I'd go "eww". Or somebody else goes "eww".

Here's what it looks like in the full oops context:

[   14.109977] BUG: unable to handle kernel paging request at ffffbeef00000000
[   14.110604] #PF: error_code(0x0000) - not-present page
[   14.111048] #PF: supervisor-privileged read access from kernel code
[   14.111594] PGD 0 P4D 0
[   14.111820] Oops: 0000 [#1] SMP
[   14.112098] CPU: 4 PID: 1007 Comm: modprobe Not tainted 4.20.0-rc2+ #91
[   14.112668] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[   14.113344] RIP: 0010:hardware_setup+0xab/0x6f1 [kvm_intel]
[   14.113825] Code: 05 30 8c ff ff 0f 84 56 05 00 00 0f 31 83 e0 03 75 13 48 b8 00 00 00 00 ef be ff ff 48 c7 00 00 00 00 00 eb 2b 48 ff c8 75 0c <48> a1 00 00 00 00 ef be ff ff eb 1a 48 8b 15 50 ff f6 ff 48 b8 00
[   14.115421] RSP: 0018:ffffc9000058bbb8 EFLAGS: 00010246
[   14.115878] RAX: 0000000000000000 RBX: 0000000000000006 RCX: ffffea0009d42148
[   14.116497] RDX: 000000000000000a RSI: dead000000000200 RDI: 00000000006000c0
[   14.117115] RBP: ffffc9000058bc50 R08: 0000000000000006 R09: 000000000016a6d0
[   14.117731] R10: ffffc9000058bc68 R11: ffff8882750ef5e8 R12: 0000000000005e40
[   14.118346] R13: ffffffffa014dd00 R14: ffff888270273480 R15: ffffc9000058be98
[   14.118961] FS:  00007ffac1c70700(0000) GS:ffff888277800000(0000) knlGS:0000000000000000
[   14.119661] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.120160] CR2: ffffbeef00000000 CR3: 0000000270352004 CR4: 0000000000360ee0
[   14.120778] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   14.121393] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   14.122006] Call Trace:
[   14.122235]  kvm_arch_hardware_setup+0x42/0x200 [kvm]
[   14.122685]  ? vmx_check_processor_compat+0x8d/0x8d [kvm_intel]
[   14.123201]  ? kvm_init+0x79/0x280 [kvm]
[   14.123552]  kvm_init+0x79/0x280 [kvm]
[   14.123883]  ? vmx_check_processor_compat+0x8d/0x8d [kvm_intel]
[   14.124394]  vmx_init+0x9d/0x400 [kvm_intel]
[   14.124766]  ? vmx_check_processor_compat+0x8d/0x8d [kvm_intel]
[   14.125277]  do_one_initcall+0x4d/0x1c4
[   14.125613]  ? kmem_cache_alloc_trace+0x30/0x1a0
[   14.126014]  do_init_module+0x5b/0x20d
[   14.126342]  load_module+0x2389/0x2980
[   14.126670]  ? vfs_read+0x117/0x130
[   14.126976]  ? __do_sys_finit_module+0xd2/0x100
[   14.127369]  __do_sys_finit_module+0xd2/0x100
[   14.127751]  do_syscall_64+0x4f/0x100
[   14.128078]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   14.128504] RIP: 0033:0x7ffac178e4d9
[   14.128810] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   14.130358] RSP: 002b:00007ffc5b68d0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   14.131023] RAX: ffffffffffffffda RBX: 00005581920445c0 RCX: 00007ffac178e4d9
[   14.131658] RDX: 0000000000000000 RSI: 0000558192048850 RDI: 0000000000000005
[   14.132256] RBP: 0000558192048850 R08: 0000000000000000 R09: 0000000000000008
[   14.132856] R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000000000
[   14.133454] R13: 0000558192044640 R14: 0000000000040000 R15: 0000000000000008
[   14.134055] Modules linked in: kvm_intel(+) kvm irqbypass bridge stp llc
[   14.134649] CR2: ffffbeef00000000
[   14.134933] ---[ end trace 8dce06ca17fa1e39 ]---


Looking at it again, my own personal preference would be to swap the order
of the #PF lines.  For most cases the three main lines show up in reverse
fir-tree ordering and the cause of the fault is easy to pick out since it's
the last thing highlighted by pr_alert (excepting when we dump the IDT,
GDT, etc...).

[  160.246820] BUG: unable to handle kernel paging request at ffffbeef00000000
[  160.247517] #PF: supervisor-privileged instruction fetch from kernel code
[  160.248085] #PF: error_code(0x0010) - not-present page
[  160.248517] PGD 0 P4D 0
[  160.248738] Oops: 0010 [#1] SMP
[  160.249012] CPU: 4 PID: 1003 Comm: modprobe Not tainted 4.20.0-rc2+ #93
[  160.249566] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[  160.250221] RIP: 0010:0xffffbeef00000000
[  160.250556] Code: Bad RIP value.
[  160.250833] RSP: 0018:ffffc90000447bf8 EFLAGS: 00010246
[  160.251274] RAX: ffffbeef00000000 RBX: 00000000ffffffff RCX: 0000000000000000
[  160.251871] RDX: ffff8882733dd7c0 RSI: 000000000000000c RDI: ffffffff820379c0
[  160.252469] RBP: ffffc90000447c50 R08: 0000000000000006 R09: 0000000000000000
[  160.253120] R10: ffffc90000447c68 R11: ffff88827518cfe8 R12: 0000000000005e40
[  160.253717] R13: ffffffffa014dd00 R14: ffff888274431900 R15: ffffc90000447e98
[  160.254322] FS:  00007f54cc42b700(0000) GS:ffff888277800000(0000) knlGS:0000000000000000
[  160.254982] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  160.255487] CR2: ffffbeeeffffffd6 CR3: 0000000271020006 CR4: 0000000000360ee0
[  160.256074] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  160.256660] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  160.257297] Call Trace:
[  160.257521]  ? kvm_arch_hardware_setup+0x42/0x200 [kvm]
[  160.257964]  ? vmx_check_processor_compat+0x41d/0x41d [kvm_intel]
[  160.258481]  ? kvm_init+0x79/0x280 [kvm]
[  160.258820]  ? kvm_init+0x79/0x280 [kvm]
[  160.259156]  ? vmx_check_processor_compat+0x41d/0x41d [kvm_intel]
[  160.259669]  ? vmx_init+0x9d/0xaee [kvm_intel]
[  160.260047]  ? vmx_check_processor_compat+0x41d/0x41d [kvm_intel]
[  160.260560]  ? do_one_initcall+0x4d/0x1c4
[  160.260911]  ? kmem_cache_alloc_trace+0x30/0x1a0
[  160.261307]  ? do_init_module+0x5b/0x20d
[  160.261641]  ? load_module+0x2389/0x2980
[  160.261974]  ? vfs_read+0x117/0x130
[  160.262272]  ? __do_sys_finit_module+0xd2/0x100
[  160.262655]  ? __do_sys_finit_module+0xd2/0x100
[  160.263038]  ? do_syscall_64+0x4f/0x100
[  160.263364]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  160.263804] Modules linked in: kvm_intel(+) kvm irqbypass bridge stp llc
[  160.264367] CR2: ffffbeef00000000
[  160.264651] ---[ end trace 2b9acada0f38bc58 ]---


Other combinations with the current order:

[    0.143436] BUG: unable to handle kernel paging request at ffffc90000230000
[    0.143985] #PF: error_code(0x000b) - reserved bit violation
[    0.144505] #PF: supervisor-privileged write access from kernel code

[    0.145090] BUG: unable to handle kernel paging request at ffffc90000230000
[    0.145755] #PF: error_code(0x0019) - reserved bit violation
[    0.146244] #PF: supervisor-privileged instruction fetch from kernel code

[    0.146847] BUG: unable to handle kernel paging request at ffffc90000230000
[    0.147040] #PF: error_code(0x0009) - reserved bit violation
[    0.147040] #PF: supervisor-privileged read access from kernel code

[    0.147040] BUG: unable to handle kernel paging request at ffffc90000230000
[    0.147040] #PF: error_code(0x0023) - protection keys violation
[    0.147040] #PF: supervisor-privileged write access from kernel code

[    0.147040] BUG: unable to handle kernel paging request at ffffc90000230000
[    0.147040] #PF: error_code(0x0031) - protection keys violation
[    0.147040] #PF: supervisor-privileged instruction fetch from kernel code

[    0.147040] BUG: unable to handle kernel paging request at ffffc90000230000
[    0.147040] #PF: error_code(0x0021) - protection keys violation
[    0.147040] #PF: supervisor-privileged read access from kernel code

[    0.147040] BUG: unable to handle kernel paging request at ffffc90000230000
[    0.147040] #PF: error_code(0x0025) - protection keys violation
[    0.147040] #PF: user-privileged read access from kernel code

[    0.147040] BUG: unable to handle kernel paging request at ffffc90000230000
[    0.147040] #PF: error_code(0x0007) - permissions violation
[    0.147040] #PF: user-privileged write access from kernel code

[    0.147040] BUG: unable to handle kernel paging request at ffffc90000230000
[    0.147040] #PF: error_code(0x0015) - permissions violation
[    0.147040] #PF: user-privileged instruction fetch from kernel code

[    0.147040] BUG: unable to handle kernel paging request at ffffc90000230000
[    0.147040] #PF: error_code(0x0005) - permissions violation
[    0.147040] #PF: user-privileged read access from kernel code

[    0.147040] BUG: unable to handle kernel paging request at ffffc90000230000
[    0.147040] #PF: error_code(0x0004) - not-present page
[    0.147040] #PF: user-privileged read access from kernel code

[    0.147040] BUG: unable to handle kernel paging request at ffffc90000230000
[    0.147040] #PF: error_code(0x0000) - not-present page
[    0.147040] #PF: supervisor-privileged read access from kernel code
