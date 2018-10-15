Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BE8C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C26B2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MirkMOvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C26B2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeJPF6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:58:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40927 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeJPF6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:58:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id 1-v6so9945989plv.7;
        Mon, 15 Oct 2018 15:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h1/tjLhKEkq5vfSYRVgMxHVlvDDGLhlWjdPLBYlQu5o=;
        b=MirkMOvP11fWKUHCgX9udqobSbGkYYWb4kUqOCxF30JAFu7OnXglVAG7jUtWCNh2W6
         yud8X5blHpflEF7BpNG3UqlPrTP7nwjrNpaw03MseOtv06FDvMo9F5/SkHhe7pAl2avF
         imphmyNmgtlSTxcxSuG1jodmbnvTttjg+lnC34njh9RSRLBmndqRiTdPctnanNiqtmKA
         ZU4smoMIstGeOLZbcqu4deQy7Vpxst5R83jfgyRa8M/pVdryepjZ+d629NsctRAEEtRX
         BBiTyCpNVyBAzODSuvvmruM86DNeH3IUCKP7vmhrxfekAvpyZr8UFmtNy+Fqbpewri90
         3LMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=h1/tjLhKEkq5vfSYRVgMxHVlvDDGLhlWjdPLBYlQu5o=;
        b=ked936MoD+tlJFgaPYm73T5hlcaVdJWsQYJg++fsRkmKq3YJgu1Hgplm+YnB3vYB5A
         pb48c+Q+1tfgcFHH31zukLVSWKIPc/m0dbBPi0rP6a2c480fUzmTgagG/DKh88ORrYQB
         fEc0N9zUbu0+dj0XluHKqz2oVA2XqjBUcFEgms8eE6PQojVWWeh3dhmS5cZMKDktqiRH
         +Qo6pPyVBgLSlNrQyAn3u+GyVIsNTwbuzb3JmxzLyHVZ+Og65bb3K76UR5Suq0RBYw5U
         5f3+d+d5Pf0XxpCltGyicC1Blp7t+hCek9p1oWHB3EMpyXDRPLvfv7y+4CTenHAY9rom
         UFoQ==
X-Gm-Message-State: ABuFfojoqY2YZmkvoufb85Uqa7KJRbpjsxLvvvmh283/lMtiRGi5i/75
        7zR8dokJ3BEHC6mogFdtKmM=
X-Google-Smtp-Source: ACcGV62Dw//zngEV5minU18QoBS2FGVM7O0V0WXQUC7cKwfTcfJilsHs4+1Jax3yiJs8dGNdhxbBAQ==
X-Received: by 2002:a17:902:4383:: with SMTP id j3-v6mr14994587pld.265.1539641455772;
        Mon, 15 Oct 2018 15:10:55 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d124-v6sm10890534pfa.163.2018.10.15.15.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 15:10:55 -0700 (PDT)
Date:   Mon, 15 Oct 2018 15:10:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: Tree for Oct 15
Message-ID: <20181015221053.GA19822@roeck-us.net>
References: <20181015192546.15faf3a1@canb.auug.org.au>
 <20181015182637.GA16445@roeck-us.net>
 <20181016071240.3f62816d@canb.auug.org.au>
 <CAL_Jsq+DAEEa6i9xb-9MMSxu-znc9tZLZwFRADqE+kcxQYXrTg@mail.gmail.com>
 <20181015211815.GA24993@roeck-us.net>
 <CAL_JsqKXS0rmmwHgLRDy+6k=GYRt-nFJHJD1A+CkFCDEAEAKvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKXS0rmmwHgLRDy+6k=GYRt-nFJHJD1A+CkFCDEAEAKvg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 04:48:27PM -0500, Rob Herring wrote:
> On Mon, Oct 15, 2018 at 4:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Mon, Oct 15, 2018 at 03:35:12PM -0500, Rob Herring wrote:
> > > On Mon, Oct 15, 2018 at 3:12 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >
> > > > Hi Guenter,
> > > >
> > > > [Just cc'ing the PPC and devicetree folks]
> > > >
> > > > On Mon, 15 Oct 2018 11:26:37 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> > > > >
> > > > > On Mon, Oct 15, 2018 at 07:25:46PM +1100, Stephen Rothwell wrote:
> > > > > >
> > > > > > My qemu boots of a powerpc pseries_le_defconfig kernel failed today.
> > > > >
> > > > > Same here. Interestingly, this only affects little endian pseries
> > > > > boots; big endian works fine. I'll try to bisect later.
> > > > >
> > > > > ALl ppc qemu tests (including big endian pseries) also generate a warning.
> > > > >
> > > > > WARNING: CPU: 0 PID: 0 at mm/memblock.c:1301 .memblock_alloc_range_nid+0x20/0x68
> > > > > Modules linked in:
> > > > > CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc7-next-20181015 #1
> > > > > NIP:  c000000000f99198 LR: c000000000f99490 CTR: c000000000bb8364
> > > > > REGS: c000000001217a78 TRAP: 0700   Not tainted  (4.19.0-rc7-next-20181015)
> > > > > MSR:  0000000080021000 <CE,ME>  CR: 24000422  XER: 20000000
> > > > > IRQMASK: 1
> > > > > GPR00: c000000000f99490 c000000001217d00 c00000000121a500 00000000000000c0
> > > > > GPR04: 0000000000000000 0000000000000000 0000000000000000 ffffffffffffffff
> > > > > GPR08: 0000000000000000 00000000000000c0 0000000000000018 00000000000000b7
> > > > > GPR12: 0000000000000040 c000000000fe7840 0000000000000000 0000000000000000
> > > > > GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > > GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > > GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > > GPR28: c000000000000304 c000000001262088 00000000000000c0 c000000000fea500
> > > > > NIP [c000000000f99198] .memblock_alloc_range_nid+0x20/0x68
> > > > > LR [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > > > > Call Trace:
> > > > > [c000000001217d00] [c000000002a00000] 0xc000000002a00000 (unreliable)
> > > > > [c000000001217d80] [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > > > > [c000000001217df0] [c000000000f7a274] .allocate_paca_ptrs+0x3c/0x74
> > > > > [c000000001217e70] [c000000000f78bf0] .early_init_devtree+0x288/0x320
> > > > > [c000000001217f10] [c000000000f79b6c] .early_setup+0x80/0x130
> > > > > [c000000001217f90] [c000000000000528] start_here_multiplatform+0x68/0x80
> > > > >
> > > > >
> > > > > sparc images crash, starting with next-20181009. Bisect with
> > > > > next-201810112 points to the merge of devicetree/for-next, though
> > > > > devicetree/for-next itself does not have the problem (bisect log
> > > > > attached below). The crash is in devicetree code.
> > > > >
> > > > > Crash logs:
> > > > > https://kerneltests.org/builders/qemu-sparc64-next/builds/981/steps/qemubuildcommand_1/logs/stdio
> > > > > https://kerneltests.org/builders/qemu-sparc-next/builds/975/steps/qemubuildcommand_1/logs/stdio
> > >
> > > The sparc crash appears to be related to changes I made. Looking into it.
> > >
> >
> > Let me know if you need me to test anything or do some debugging.
> 
> Well, I'm not having any luck getting sparc qemu to work. Here's what
> I'm trying with a sparc32_defconfig kernel:
> 
> $ qemu-system-sparc -kernel .build-sparc/vmlinux -M SS-4 -nographic -m
> 256 -no-reboot
> rom: requested regions overlap (rom phdr #0: .build-sparc/vmlinux.
> free=0x000000000000057a, addr=0x0000000000000000)
> qemu-system-sparc: rom check and register reset failed
> 

What is your qemu version ?

Guenter

> Using zImage or image file didn't work any better.
> 
> Then I tried sticking the kernel in a disk image, but that didn't get
> much farther.
> 
> Rob
