Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FE6C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E484218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546620169;
	bh=FOi3rGFSQPsBc3mMVnSE2i1zEXBdq4Kl9lZOZ/yfizk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=X6rqm4/X7Ffx7RB3YKpYUqY7gsiX5YtYYM5qq7ATCpDvKLGmH54wy54qqt5EswZ+E
	 wLWVy+GugTWX8DwICJw5bV1U2Esqij7ygTRaG370xpKQVKkzlcrhOUFmZC1E1mg0wM
	 gmnNj2YkgQKU6F+ELaqpjgY8Fxp8PyU2X8kmFbf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfADQms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:42:48 -0500
Received: from twin.jikos.cz ([91.219.245.39]:35669 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfADQms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:42:48 -0500
Received: from twin.jikos.cz (jikos@[127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id x04GgGfF020942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 4 Jan 2019 17:42:17 +0100
Received: from localhost (jikos@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) with ESMTP id x04GgFDx020935;
        Fri, 4 Jan 2019 17:42:16 +0100
X-Authentication-Warning: twin.jikos.cz: jikos owned process doing -bs
Date:   Fri, 4 Jan 2019 17:42:15 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: General protection fault in `switch_mm_irqs_off()`
In-Reply-To: <784ab00e-ed72-c1bc-bc0c-31264deb7726@molgen.mpg.de>
Message-ID: <alpine.LRH.2.00.1901041737290.28043@gjva.wvxbf.pm>
References: <784ab00e-ed72-c1bc-bc0c-31264deb7726@molgen.mpg.de>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ added some CCs ]

On Thu, 3 Jan 2019, Paul Menzel wrote:

> Dear Linux folks,
> 
> 
> On the server board Asus KGPE-D16 with AMD Opteron 6278 processor updating the
> microcode update in the firmware from 0x0600062e to 0x0600063e seems to cause
> a general protection fault with Linux 4.14.87 and 4.20-rc7.
> 
> > 46.859: [    7.573240] microcode: CPU31: patch_level=0x0600063e
> > 46.859: [    7.578507] microcode: Microcode Update Driver: v2.2.
> > 46.860: [    7.578539] sched_clock: Marking stable (6510054745,
> > 1068444659)->(7999876773, -421377369)
> > 46.860: [    7.593013] registered taskstats version 1
> > 46.861: [    7.598091] rtc_cmos 00:00: setting system clock to 2000-01-01
> > 08:01:51 UTC (946713711)
> > 46.862: [    7.606575] ALSA device list:
> > 46.862: [    7.609802]   No soundcards found.
> > 46.865: [    7.615887] Freeing unused kernel image memory: 1564K
> > 46.871: [    7.627073] Write protecting the kernel read-only data: 20480k
> > 46.872: [    7.634366] Freeing unused kernel image memory: 2016K
> > 46.873: [    7.640297] Freeing unused kernel image memory: 584K
> > 46.874: [    7.645521] Run /init as init process
> > 46.877: [    7.652262] general protection fault: 0000 [#1] SMP NOPTI
> > 46.877: [    7.657931] CPU: 18 PID: 0 Comm: swapper/18 Not tainted
> > 4.20.0-rc7.mx64.237 #1
> > 46.877: [    7.665514] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS
> > 4.9-103-g637bef2037 01/02/2019
> > 46.878: [    7.673804] RIP: 0010:switch_mm_irqs_off+0xb2/0x640
> > 46.878: [    7.678948] Code: 48 c1 ef 09 83 e7 01 48 09 c7 65 48 8b 05 8e 34
> > fc 7e 48 39 c7 74 15 48 09 f8 a8 01 74 0e b9 49 00 00 00 b8 01 00 00 00 31
> > d2 <0f> 30 65 48 89 3d 6c 34 fc 7e 8b 05 9a ef a7 01 85 c0 0f 8f 41 04
> > 46.879: [    7.698394] RSP: 0018:ffffc90006343e20 EFLAGS: 00010046
> > 46.879: [    7.703844] RAX: 0000000000000001 RBX: ffff88981ca0b800 RCX:
> > 0000000000000049
> > 46.879: [    7.711238] RDX: 0000000000000000 RSI: ffff88981b87cf80 RDI:
> > ffff88981ca0b800
> > 46.880: [    7.718665] RBP: ffffc90006343e70 R08: 00000001c81bec00 R09:
> > 0000000000000000
> > 46.880: [    7.726092] R10: ffffc90006343e88 R11: 0000000000000000 R12:
> > ffffffff82479b40
> > 46.880: [    7.733494] R13: 0000000000000000 R14: 0000000000000012 R15:
> > ffff88981dd50080
> > 46.881: [    7.740853] FS:  0000000000000000(0000) GS:ffff88981fa80000(0000)
> > knlGS:0000000000000000
> > 46.881: [    7.749318] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 46.881: [    7.755281] CR2: 0000000000000000 CR3: 000000000240a000 CR4:
> > 00000000000406e0
> > 46.881: [    7.762761] Call Trace:
> > 46.881: [    7.765369]  ? __schedule+0x1b9/0x7b0
> > 46.882: [    7.769253]  __schedule+0x1b9/0x7b0
> > 46.882: [    7.772930]  schedule_idle+0x1e/0x40
> > 46.882: [    7.776744]  do_idle+0x146/0x200
> > 46.882: [    7.780181]  cpu_startup_entry+0x19/0x20
> > 46.883: [    7.784274]  start_secondary+0x183/0x1b0
> > 46.883: [    7.788409]  secondary_startup_64+0xa4/0xb0
> > 46.883: [    7.792766] Modules linked in:
> > 46.883: [    7.796105] ---[ end trace a423e363fe1ecf67 ]---
> > 46.884: [    7.800939] RIP: 0010:switch_mm_irqs_off+0xb2/0x640
> > 46.884: [    7.806048] Code: 48 c1 ef 09 83 e7 01 48 09 c7 65 48 8b 05 8e 34
> > fc 7e 48 39 c7 74 15 48 09 f8 a8 01 74 0e b9 49 00 00 00 b8 01 00 00 00 31
> > d2 <0f> 30 65 48 89 3d 6c 34 fc 7e 8b 05 9a ef a7 01 85 c0 0f 8f 41 04

So this faults when writing PRED_CMD_IBPB to MSR_IA32_PRED_CMD, but that 
should be properly patched out on ucodes that don't support IBPB.

This almost looks like the ucode you updated to would advertise IBPB 
availability, but then fault when it's used.

I guess that booting with 'spectre_v2_user=off' makes the issue go away, 
right?

What happens then if you manually wrmsr 0x1 to MSR 0x49 from userspace? 
Could you please post /proc/cpuinfo from such a boot as well?

Leaving the rest of the original mail for reference.

> > 46.884: [    7.825440] RSP: 0018:ffffc90006343e20 EFLAGS: 00010046
> > 46.885: [    7.830855] RAX: 0000000000000001 RBX: ffff88981ca0b800 RCX:
> > 0000000000000049
> > 46.885: [    7.838230] RDX: 0000000000000000 RSI: ffff88981b87cf80 RDI:
> > ffff88981ca0b800
> > 46.885: [    7.845614] RBP: ffffc90006343e70 R08: 00000001c81bec00 R09:
> > 0000000000000000
> > 46.886: [    7.853047] R10: ffffc90006343e88 R11: 0000000000000000 R12:
> > ffffffff82479b40
> > 46.886: [    7.860427] R13: 0000000000000000 R14: 0000000000000012 R15:
> > ffff88981dd50080
> > 46.886: [    7.867862] FS:  0000000000000000(0000) GS:ffff88981fa80000(0000)
> > knlGS:0000000000000000
> > 46.886: [    7.876320] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 46.887: [    7.882351] CR2: 0000000000000000 CR3: 000000000240a000 CR4:
> > 00000000000406e0
> > 46.887: [    7.889746] Kernel panic - not syncing: Attempted to kill the
> > idle task!
> > 46.888: [    7.896907] Kernel Offset: disabled
> > 46.888: [    7.900558] ---[ end Kernel panic - not syncing: Attempted to
> > kill the idle task! ]---
> 
> Please find the whole log, including the coreboot messages, attached. The time
> stamps in the beginning are from the script `readserial.py` from the SeaBIOS
> repository.
> 
> Do you have an idea what is going on, and how to fix it?
> 
> 
> Kind regards,
> 
> Paul
> 

-- 
Jiri Kosina
SUSE Labs
