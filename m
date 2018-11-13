Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B090C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2B32086A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2B32086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387608AbeKMXz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:55:27 -0500
Received: from foss.arm.com ([217.140.101.70]:56074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387513AbeKMXz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:55:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28C7DA78;
        Tue, 13 Nov 2018 05:57:11 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8F853F5A0;
        Tue, 13 Nov 2018 05:57:09 -0800 (PST)
Date:   Tue, 13 Nov 2018 13:57:07 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux@armlinux.org.uk, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH v3] ARM: module: Fix function kallsyms on Thumb-2
Message-ID: <20181113135705.GI3505@e103592.cambridge.arm.com>
References: <20181113112745.15945-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113112745.15945-1-vincent.whitchurch@axis.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 12:27:45PM +0100, Vincent Whitchurch wrote:
> Thumb-2 functions have the lowest bit set in the symbol value in the
> symtab.  When kallsyms are generated for the vmlinux, the kallsyms are
> generated from the output of nm, and nm clears the lowest bit.
> 
>  $ arm-linux-gnueabihf-readelf -a vmlinux | grep show_interrupts
>   95947: 8015dc89   686 FUNC    GLOBAL DEFAULT    2 show_interrupts
>  $ arm-linux-gnueabihf-nm vmlinux | grep show_interrupts
>  8015dc88 T show_interrupts
>  $ cat /proc/kallsyms | grep show_interrupts
>  8015dc88 T show_interrupts
> 
> However, for modules, the kallsyms uses the values in the symbol table
> without modification, so for functions in modules, the lowest bit is set
> in kallsyms.
> 
>  $ arm-linux-gnueabihf-readelf -a drivers/net/tun.ko | grep tun_get_socket
>     268: 000000e1    44 FUNC    GLOBAL DEFAULT    2 tun_get_socket
>  $ arm-linux-gnueabihf-nm drivers/net/tun.ko | grep tun_get_socket
>  000000e0 T tun_get_socket
>  $ cat /proc/kallsyms | grep tun_get_socket
>  7fcd30e1 t tun_get_socket  [tun]
> 
> Because of this, the offset of the crashing instruction shown in oopses
> is incorrect when the crash is in a module.  For example, given a
> tun_get_socket which starts like this,
> 
>  000000e0 <tun_get_socket>:
>        e0:       b500            push    {lr}
>        e2:       f7ff fffe       bl      0 <__gnu_mcount_nc>
>        e6:       4b08            ldr     r3, [pc, #32]
>        e8:       6942            ldr     r2, [r0, #20]
>        ea:       429a            cmp     r2, r3
>        ec:       d002            beq.n   f4 <tun_get_socket+0x14>
> 
> a crash when tun_get_socket is called with NULL results in:
> 
>  PC is at tun_get_socket+0x7/0x2c [tun]
>  pc : [<7fcdb0e8>]
> 
> which can result in the incorrect line being reported by gdb if this
> symbol+offset is used there.  If the crash is on the first instruction
> of a function, the "PC is at" line would also report the symbol name of
> the preceding function.
> 
> To solve this, introduce a weak module_kallsyms_symbol_value() function
> which arches can override to fix up these symbol values, and implement

(Jumping into this patch without having reviewed previous versions in
detail, so I may have misunderstood some things...)


Anyway:

I prefer this to the previous approach of directly hacking the symbol
values in the module kallsyms table.

> this for Thumb-2.  We need to move elf_type() to st_other so that the
> original value of st_info is preserved.

Are you sure modifying st_other won't break anything?

It's hard to imagine how ELF symbol visibility would be relevant in the
kernel, but some arches put other stuff in st_other.  See alpha,
powerpc, sh for example.  I haven't attempted to understand whether any
of those uses matters here.


Ideally, we wouldn't abuse st_info to store elf_type() in the first
place, but that may be messier to solve.  kallsyms could wrap the
ElfXX_Sym in another struct to store extra metadata for example, but it
would increase runtime memory consumption.

Another option would be wedge STT_FUNC in bit 7 of st_info, say.
Since elf_type() always yields an ASCII char, that bit shouldn't be
used for anything today.  We would of course need to wrap further
access to st_info to mask that bit off as appropriate.

Cheers
---Dave

[...]

> diff --git a/kernel/module.c b/kernel/module.c
> index 49a405891587..5a588cfbb8f8 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2682,7 +2682,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
>  
>  	/* Set types up while we still have access to sections. */
>  	for (i = 0; i < mod->kallsyms->num_symtab; i++)
> -		mod->kallsyms->symtab[i].st_info
> +		mod->kallsyms->symtab[i].st_other
>  			= elf_type(&mod->kallsyms->symtab[i], info);
>  
>  	/* Now populate the cut down core kallsyms for after init. */
> @@ -3916,6 +3916,11 @@ static const char *symname(struct mod_kallsyms *kallsyms, unsigned int symnum)
>  	return kallsyms->strtab + kallsyms->symtab[symnum].st_name;
>  }
>  
> +unsigned long __weak module_kallsyms_symbol_value(Elf_Sym *sym)
> +{
> +	return sym->st_value;
> +}
> +

Can we make this a header inline that the arch can override?

Otherwise, we add a little overhead to every arch in kallsyms core
loops, just to support the arm Thumb-2 kernel case.

[...]

Cheers
---Dave
