Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753588AbeDRMTH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 08:19:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:56774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752116AbeDRMTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 08:19:06 -0400
Date: Wed, 18 Apr 2018 14:18:57 +0200
From: Borislav Petkov <bp@suse.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86/ldt: Fix support_pte_mask filtering in
 map_ldt_struct()
Message-ID: <20180418121403.GA3434@pd.tnic>
References: <1523871837-8378-1-git-send-email-joro@8bytes.org>
 <CALCETrVgQspiO3nnyhqiXi17iaGG7bRDsr3gpHwdDnYfFDZabQ@mail.gmail.com>
 <07e2c23e-10b7-b03f-5706-3d4b910537ba@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07e2c23e-10b7-b03f-5706-3d4b910537ba@linux.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Rafael.

On Mon, Apr 16, 2018 at 08:39:37AM -0700, Dave Hansen wrote:
> On 04/16/2018 08:16 AM, Andy Lutomirski wrote:
> > On Mon, Apr 16, 2018 at 2:43 AM, Joerg Roedel <joro@8bytes.org> wrote:
> >> From: Joerg Roedel <jroedel@suse.de>
> >>
> >> The |= operator will let us end up with an invalid PTE. Use
> >> the correct &= instead.
> > D'oh!  Looks good.
> 
> Yes, agreed.  Thanks for finding that, Joerg!

Btw, even with Jörg's fix,

fb43d6cb91ef ("x86/mm: Do not auto-massage page protections")

is still broken. In my case

# CONFIG_MODIFY_LDT_SYSCALL is not set

so Jörg's patch doesn't have any effect.

I tried the patch before fb43d6cb91ef:

6baf4bec02db ("x86/espfix: Document use of _PAGE_GLOBAL")

and the machine's fine. But with fb43d6cb91ef I can't resume from disk
properly and I'm seeing is the below splat:

[    5.417480] PM: Image loading progress:   0%
[    5.631174] PM: Image loading progress:  10%
[    5.716705] PM: Image loading progress:  20%
[    5.805258] PM: Image loading progress:  30%
[    5.884919] random: crng init done
[    5.899245] PM: Image loading progress:  40%
[    5.980752] PM: Image loading progress:  50%
[    6.058269] PM: Image loading progress:  60%
[    6.138994] PM: Image loading progress:  70%
[    6.219384] PM: Image loading progress:  80%
[    6.299277] PM: Image loading progress:  90%
[    6.382403] PM: Image loading progress: 100%
[    6.386971] PM: Image loading done
[    6.390424] PM: Read 598112 kbytes in 1.03 seconds (580.69 MB/s)
[    6.397450] PM: Image successfully loaded
[    6.631431] ACPI: EC: interrupt blocked
[    6.635383] Disabling non-boot CPUs ...
[    6.821452] ------------[ cut here ]------------
[    6.826115] kernel BUG at arch/x86/mm/physaddr.c:27!
[    6.831126] invalid opcode: 0000 [#1] PREEMPT SMP
[    6.835872] Modules linked in:
[    6.838976] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0+ #6
[    6.845026] Hardware name: To be filled by O.E.M. To be filled by O.E.M./M5A97 EVO R2.0, BIOS 1503 01/16/2013
[    6.854996] RIP: 0010:__phys_addr+0x38/0x50
[    6.859220] RSP: 0018:ffffc90000017dc8 EFLAGS: 00010087
[    6.864490] RAX: 0000780000000000 RBX: ffff880426f5b000 RCX: 0000000000000030
[    6.871667] RDX: 0000000080000000 RSI: 000000001fe46a1b RDI: 0000000000000000
[    6.878841] RBP: ffffc90000017e48 R08: 0000000000000000 R09: 0000000000000002
[    6.886018] R10: 000000005ad731e5 R11: 00000000000002de R12: 0000000000000063
[    6.893221] R13: 0000000000000000 R14: 00000000016001e3 R15: 0000000000000000
[    6.900396] FS:  0000000000000000(0000) GS:ffff88043dc00000(0000) knlGS:0000000000000000
[    6.908544] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.914333] CR2: ffff88043efff000 CR3: 0000000002209000 CR4: 00000000000406f0
[    6.921507] Call Trace:
[    6.924007]  swsusp_arch_resume+0x112/0x3c0
[    6.928235]  ? hibernate_resume_nonboot_cpu_disable+0x30/0x30
[    6.934024]  ? save_processor_state+0xc9/0x250
[    6.938514]  ? set_debug_rodata+0x11/0x11
[    6.942570]  hibernation_restore+0x8d/0x130
[    6.946797]  ? hibernation_restore+0x130/0x130
[    6.951286]  load_image_and_restore+0x5e/0x99
[    6.955690]  software_resume+0x20f/0x2a0
[    6.959661]  do_one_initcall+0x5c/0x1b0
[    6.963544]  kernel_init_freeable+0x123/0x1a5
[    6.967945]  ? rest_init+0xc0/0xc0
[    6.971394]  kernel_init+0xa/0x100
[    6.974869]  ret_from_fork+0x27/0x50
[    6.978518] Code: 48 89 c2 72 28 48 b8 00 00 00 00 00 78 00 00 48 01 f8 48 39 c2 72 14 0f b6 0d fe e6 22 01 48 89 c2 48 d3 ea 48 85 d2 75 02 f3 c3 <0f> 0b 48 8b 05 0f 71 16 01 48 01 d0 48 81 fa ff ff ff 1f 76 e9 
[    6.997454] RIP: __phys_addr+0x38/0x50 RSP: ffffc90000017dc8
[    7.003159] ---[ end trace 4b9d4661c2110f43 ]---
[    7.007820] note: swapper/0[1] exited with preempt_count 1
[    7.013353] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    7.013353] 
[    7.022563] Kernel Offset: disabled
[    7.026098] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    7.026098]  ]---

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
