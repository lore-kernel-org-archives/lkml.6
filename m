Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4318C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EEF21874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LtfLBIed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfADPrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:47:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47392 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfADPrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:47:14 -0500
Received: from nazgul.tnic (unknown [78.130.214.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E3F91EC0987;
        Fri,  4 Jan 2019 16:47:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1546616833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U98oQ5HRMEpAfx4IRvAzZSJVsNKO+ehD2S9LRo7FPaY=;
        b=LtfLBIeduMbSz5Dv/w3kWVdMqPQcjlMV94QGBzrMw5R9N1Ny7O0WWnusPRXC8phMW5euUs
        9mRoINKoMJihNJMsPrYCfisbQLNr6dWmy4K7VKLUbUxz8OR31Kbx2EGZXlHTtEtMaR0mAe
        9vWfqxKpsmW8zlGfoT6tkoKDI6VGHBQ=
Date:   Fri, 4 Jan 2019 16:47:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: General protection fault in `switch_mm_irqs_off()`
Message-ID: <20190104154710.GA18252@nazgul.tnic>
References: <784ab00e-ed72-c1bc-bc0c-31264deb7726@molgen.mpg.de>
 <65b3aa5c-c11b-6435-5761-3f1489f18ce5@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65b3aa5c-c11b-6435-5761-3f1489f18ce5@molgen.mpg.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 01:41:25PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On 01/03/19 22:45, Paul Menzel wrote:
> 
> > On the server board Asus KGPE-D16 with AMD Opteron 6278 processor updating the microcode update in the firmware from 0x0600062e to 0x0600063e seems to cause a general protection fault with Linux 4.14.87 and 4.20-rc7.
> > 
> >> 46.859: [    7.573240] microcode: CPU31: patch_level=0x0600063e
> >> 46.859: [    7.578507] microcode: Microcode Update Driver: v2.2.
> >> 46.860: [    7.578539] sched_clock: Marking stable (6510054745, 1068444659)->(7999876773, -421377369)
> >> 46.860: [    7.593013] registered taskstats version 1
> >> 46.861: [    7.598091] rtc_cmos 00:00: setting system clock to 2000-01-01 08:01:51 UTC (946713711)
> >> 46.862: [    7.606575] ALSA device list:
> >> 46.862: [    7.609802]   No soundcards found.
> >> 46.865: [    7.615887] Freeing unused kernel image memory: 1564K
> >> 46.871: [    7.627073] Write protecting the kernel read-only data: 20480k
> >> 46.872: [    7.634366] Freeing unused kernel image memory: 2016K
> >> 46.873: [    7.640297] Freeing unused kernel image memory: 584K
> >> 46.874: [    7.645521] Run /init as init process
> >> 46.877: [    7.652262] general protection fault: 0000 [#1] SMP NOPTI
> >> 46.877: [    7.657931] CPU: 18 PID: 0 Comm: swapper/18 Not tainted 4.20.0-rc7.mx64.237 #1
> >> 46.877: [    7.665514] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4.9-103-g637bef2037 01/02/2019
> >> 46.878: [    7.673804] RIP: 0010:switch_mm_irqs_off+0xb2/0x640
> >> 46.878: [    7.678948] Code: 48 c1 ef 09 83 e7 01 48 09 c7 65 48 8b 05 8e 34 fc 7e 48 39 c7 74 15 48 09 f8 a8 01 74 0e b9 49 00 00 00 b8 01 00 00 00 31 d2 <0f> 30 65 48 89 3d 6c 34 fc 7e 8b 05 9a ef a7 01 85 c0 0f 8f 41 04
> >> 46.879: [    7.698394] RSP: 0018:ffffc90006343e20 EFLAGS: 00010046
> >> 46.879: [    7.703844] RAX: 0000000000000001 RBX: ffff88981ca0b800 RCX: 0000000000000049
> >> 46.879: [    7.711238] RDX: 0000000000000000 RSI: ffff88981b87cf80 RDI: ffff88981ca0b800
> >> 46.880: [    7.718665] RBP: ffffc90006343e70 R08: 00000001c81bec00 R09: 0000000000000000
> >> 46.880: [    7.726092] R10: ffffc90006343e88 R11: 0000000000000000 R12: ffffffff82479b40
> >> 46.880: [    7.733494] R13: 0000000000000000 R14: 0000000000000012 R15: ffff88981dd50080
> >> 46.881: [    7.740853] FS:  0000000000000000(0000) GS:ffff88981fa80000(0000) knlGS:0000000000000000
> >> 46.881: [    7.749318] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> 46.881: [    7.755281] CR2: 0000000000000000 CR3: 000000000240a000 CR4: 00000000000406e0
> >> 46.881: [    7.762761] Call Trace:
> >> 46.881: [    7.765369]  ? __schedule+0x1b9/0x7b0
> >> 46.882: [    7.769253]  __schedule+0x1b9/0x7b0
> >> 46.882: [    7.772930]  schedule_idle+0x1e/0x40
> >> 46.882: [    7.776744]  do_idle+0x146/0x200
> >> 46.882: [    7.780181]  cpu_startup_entry+0x19/0x20
> >> 46.883: [    7.784274]  start_secondary+0x183/0x1b0
> >> 46.883: [    7.788409]  secondary_startup_64+0xa4/0xb0
> >> 46.883: [    7.792766] Modules linked in:
> >> 46.883: [    7.796105] ---[ end trace a423e363fe1ecf67 ]---
> >> 46.884: [    7.800939] RIP: 0010:switch_mm_irqs_off+0xb2/0x640
> >> 46.884: [    7.806048] Code: 48 c1 ef 09 83 e7 01 48 09 c7 65 48 8b 05 8e 34 fc 7e 48 39 c7 74 15 48 09 f8 a8 01 74 0e b9 49 00 00 00 b8 01 00 00 00 31 d2 <0f> 30 65 48 89 3d 6c 34 fc 7e 8b 05 9a ef a7 01 85 c0 0f 8f 41 04
> >> 46.884: [    7.825440] RSP: 0018:ffffc90006343e20 EFLAGS: 00010046
> >> 46.885: [    7.830855] RAX: 0000000000000001 RBX: ffff88981ca0b800 RCX: 0000000000000049
> >> 46.885: [    7.838230] RDX: 0000000000000000 RSI: ffff88981b87cf80 RDI: ffff88981ca0b800
> >> 46.885: [    7.845614] RBP: ffffc90006343e70 R08: 00000001c81bec00 R09: 0000000000000000
> >> 46.886: [    7.853047] R10: ffffc90006343e88 R11: 0000000000000000 R12: ffffffff82479b40
> >> 46.886: [    7.860427] R13: 0000000000000000 R14: 0000000000000012 R15: ffff88981dd50080
> >> 46.886: [    7.867862] FS:  0000000000000000(0000) GS:ffff88981fa80000(0000) knlGS:0000000000000000
> >> 46.886: [    7.876320] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> 46.887: [    7.882351] CR2: 0000000000000000 CR3: 000000000240a000 CR4: 00000000000406e0
> >> 46.887: [    7.889746] Kernel panic - not syncing: Attempted to kill the idle task!
> >> 46.888: [    7.896907] Kernel Offset: disabled
> >> 46.888: [    7.900558] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
> > 
> > Please find the whole log, including the coreboot messages, attached. The time stamps in the beginning are from the script `readserial.py` from the SeaBIOS repository.
> > 
> > Do you have an idea what is going on, and how to fix it?
> 
> Decoding the code, give the output below.
> 
> ```
> $ scripts/decodecode < /dev/shm/test.log 
> [ 7.806048] Code: 48 c1 ef 09 83 e7 01 48 09 c7 65 48 8b 05 8e 34 fc 7e 48 39 c7 74 15 48 09 f8 a8 01 74 0e b9 49 00 00 00 b8 01 00 00 00 31 d2 <0f> 30 65 48 89 3d 6c 34 fc 7e 8b 05 9a ef a7 01 85 c0 0f 8f 41 04
> All code
> ========
>    0:	48 c1 ef 09          	shr    $0x9,%rdi
>    4:	83 e7 01             	and    $0x1,%edi
>    7:	48 09 c7             	or     %rax,%rdi
>    a:	65 48 8b 05 8e 34 fc 	mov    %gs:0x7efc348e(%rip),%rax        # 0x7efc34a0
>   11:	7e 
>   12:	48 39 c7             	cmp    %rax,%rdi
>   15:	74 15                	je     0x2c
>   17:	48 09 f8             	or     %rdi,%rax
>   1a:	a8 01                	test   $0x1,%al
>   1c:	74 0e                	je     0x2c
>   1e:	b9 49 00 00 00       	mov    $0x49,%ecx
>   23:	b8 01 00 00 00       	mov    $0x1,%eax
>   28:	31 d2                	xor    %edx,%edx
>   2a:*	0f 30                	wrmsr  		<-- trapping instruction
>   2c:	65 48 89 3d 6c 34 fc 	mov    %rdi,%gs:0x7efc346c(%rip)        # 0x7efc34a0
>   33:	7e 
>   34:	8b 05 9a ef a7 01    	mov    0x1a7ef9a(%rip),%eax        # 0x1a7efd4
>   3a:	85 c0                	test   %eax,%eax
>   3c:	0f                   	.byte 0xf
>   3d:	8f 41 04             	popq   0x4(%rcx)
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 30                	wrmsr  
>    2:	65 48 89 3d 6c 34 fc 	mov    %rdi,%gs:0x7efc346c(%rip)        # 0x7efc3476
>    9:	7e 
>    a:	8b 05 9a ef a7 01    	mov    0x1a7ef9a(%rip),%eax        # 0x1a7efaa
>   10:	85 c0                	test   %eax,%eax
>   12:	0f                   	.byte 0xf
>   13:	8f 41 04             	popq   0x4(%rcx)
> ```
> 
> So the problem is with the instruction *wrmsr* [1].
> 
> The content of ECX, which according to [1] is written to, is not
> in the logs though, as far as I can see.

Of course it is:

>   1e:	b9 49 00 00 00       	mov    $0x49,%ecx

which is strange.

Tom, is patch_level=0x0600063e on BD supposed to #GP when writing
MSR_IA32_PRED_CMD...

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
