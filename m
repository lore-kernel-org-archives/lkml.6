Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA66BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D26F2083B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aGJO7c+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfBHTKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:10:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53386 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfBHTKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:10:35 -0500
Received: from zn.tnic (p200300EC2BC9F9004919A03E6833219A.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:f900:4919:a03e:6833:219a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A3C081EC0A0E;
        Fri,  8 Feb 2019 20:10:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549653033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Sqc+8dgKZ5ONunDxMzeJaqZ7EXC4yLaNtNJPrJhZsUk=;
        b=aGJO7c+yiHB4n9Y9/TxiXDsKdOpsubN40L4F64hitUZ/TOY59JGdsbHZkUstSaxZs7uxzc
        vkqrAZWaviHSnt6UFBptJASGsJtStaEAeWQFheMA1J2xkzUhBC+QoOFVGBllaVN401zBVa
        QiCWwsxTyvDAwUOCb9oAvRrdgyIOwz0=
Date:   Fri, 8 Feb 2019 20:10:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Guenter Roeck <linux@roeck-us.net>, fanc.fnst@cn.fujitsu.com
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, mingo@redhat.com,
        thomas.lendacky@amd.com, yamada.masahiro@socionext.com,
        caoj.fnst@cn.fujitsu.com, jgross@suse.com, mingo@kernel.org,
        keescook@chromium.org, x86@kernel.org, hpa@zytor.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in
 boot_params
Message-ID: <20190208191024.GL674@zn.tnic>
References: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
 <tip-3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce@git.kernel.org>
 <20190208190248.GA10854@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208190248.GA10854@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 11:02:48AM -0800, Guenter Roeck wrote:
> Hi,
> 
> On Fri, Feb 01, 2019 at 03:01:11AM -0800, tip-bot for Chao Fan wrote:
> > Commit-ID:  3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce
> > Gitweb:     https://git.kernel.org/tip/3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce
> > Author:     Chao Fan <fanc.fnst@cn.fujitsu.com>
> > AuthorDate: Wed, 23 Jan 2019 19:08:48 +0800
> > Committer:  Borislav Petkov <bp@suse.de>
> > CommitDate: Fri, 1 Feb 2019 11:52:55 +0100
> > 
> > x86/boot: Early parse RSDP and save it in boot_params
> > 
> > The RSDP is needed by KASLR so parse it early and save it in
> > boot_params.acpi_rsdp_addr, before KASLR setup runs.
> > 
> > RSDP is needed by other kernel facilities so have the parsing code
> > built-in instead of a long "depends on" line in Kconfig.
> > 
> >  [ bp:
> >     - Trim commit message and comments
> >     - Add CONFIG_ACPI dependency in the Makefile
> >     - Move ->acpi_rsdp_addr assignment with the rest of boot_params massaging in extract_kernel().
> >  ]
> > 
> 
> This patch causes x86_64 boots with efi32 bios to crash early and hard
> (before any console output is seen).
> 
> Sample qemu command line:
> 
> qemu-system-x86_64 -kernel arch/x86/boot/bzImage -M q35 -cpu SandyBridge \
> 	-no-reboot -snapshot -smp 4 \
> 	-bios OVMF-pure-efi-32.fd \
> 	-m 1G \
> 	-usb -device usb-storage,drive=d0 \
> 	-drive file=rootfs.squashfs,if=none,id=d0,format=raw \
> 	--append 'earlycon=uart8250,io,0x3f8,9600n8 root=/dev/sda rootwait panic=-1 console=ttyS0' \
> 	-nographic
> 
> This is with qemu 3.1, though details other than "-bios OVMF-pure-efi-32.fd"
> don't really matter.
> 
> Files used above are available from https://github.com/groeck/linux-build-test/.
> 
> The patch can not be reverted alone, but
> 
> Revert "x86/boot/KASLR: Limit KASLR to extract the kernel in immovable memory only"
> Revert "x86/boot: Parse SRAT table and count immovable memory regions"
> Revert "x86/boot: Early parse RSDP and save it in boot_params"
> 
> fixes the problem.

Does it per chance at least continue booting if you return 0 and early
from efi_get_rsdp_addr() ?

Chao, pls take a look.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
