Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932649AbeCISyj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:54:39 -0500
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:60284 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932551AbeCISyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:54:35 -0500
Date: Fri, 9 Mar 2018 20:54:29 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 4.15-rc9 new insecure W+X mapping warning
In-Reply-To: <alpine.LRH.2.21.1801242127140.27627@math.ut.ee>
Message-ID: <alpine.LRH.2.21.1803091732210.7679@math.ut.ee>
References: <alpine.LRH.2.21.1801242127140.27627@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is Intel SE7520JR22S mainboard with 2 64-bit P4 xeons. Earlier 
> kernels up to 4.14 have had W+X checking on but found nothing. Now I 
> tried 4.15.0-rc9-00023-g1f07476ec143 and it gives a new W+X warning. 

Actually, I was wrong about earlier kernels - I just did not have 
CONFIG_DEBUG_WX turned on before and eralier kernels did not check it.

Recompiled 4.14 with CONFIG_DEBUG_WX=y and the problem is there. So this 
is not a Linux regression but a peculiarity with the SE7520JR22S, it 
seems.

Is there anything that Linux might be doing wrong?

> [   10.880663] ------------[ cut here ]------------
> [   10.880755] x86/mm: Found insecure W+X mapping at address 00000000d051fb08/0xffff880000000000
> [   10.880900] WARNING: CPU: 2 PID: 1 at arch/x86/mm/dump_pagetables.c:266 note_page+0x718/0xb89
> [   10.881035] Modules linked in:
> [   10.881128] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc9-00023-g1f07476ec143 #104
> [   10.881264] Hardware name: Intel                                  /SE7520JR22S, BIOS SE7520JR22.86B.P.10.00.0087.120820051348 12/08/2005
> [   10.881405] RIP: 0010:note_page+0x718/0xb89
> [   10.881491] RSP: 0000:ffffc90000013e48 EFLAGS: 00010296
> [   10.881578] RAX: 0000000000000051 RBX: ffffc90000013ec8 RCX: ffffffff8164f938
> [   10.881666] RDX: 0000000000000001 RSI: 0000000000000092 RDI: ffffffff82b468cc
> [   10.881756] RBP: 0000000000000061 R08: 0000000000000177 R09: 00000000000001d7
> [   10.881844] R10: 0720072007200720 R11: 0720072007200720 R12: 0000000000000000
> [   10.881932] R13: 0000000000000000 R14: 0000000000000001 R15: 8800000990000000
> [   10.882022] FS:  0000000000000000(0000) GS:ffff88003fc80000(0000) knlGS:0000000000000000
> [   10.882156] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   10.882243] CR2: 0000000000000000 CR3: 000000000200a000 CR4: 00000000000006e0
> [   10.882331] Call Trace:
> [   10.882423]  ptdump_walk_pgd_level_core+0x367/0x3a5
> [   10.882511]  ptdump_walk_pgd_level_checkwx+0x10/0x3e
> [   10.882602]  kernel_init+0x2e/0x10f
> [   10.882688]  ? rest_init+0xb9/0xb9
> [   10.882775]  ret_from_fork+0x35/0x40
> [   10.882861] Code: fb ff ff 41 f7 c7 00 10 00 00 0f 85 e2 fe ff ff e9 36 fd ff ff c6 05 7d 45 6f 01 01 48 89 f2 48 c7 c7 08 5b ee 81 e8 4b d6 00 00 <0f> ff 48 8b 73 10 e9 bc f9 ff ff 4d 85 ed 0f 84 b9 01 00 00 41 
> [   10.883103] ---[ end trace bc3e2cf1a1adfa39 ]---
> [   10.896336] x86/mm: Checked W+X mappings: FAILED, 266243 W+X pages found.
> [   10.896430] x86/mm: Checking user space page tables
> [   10.909522] x86/mm: Checked W+X mappings: FAILED, 56 W+X pages found.

-- 
Meelis Roos (mroos@linux.ee)
