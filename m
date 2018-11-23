Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FF7C04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BDF20824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BDF20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395338AbeKXFTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:19:49 -0500
Received: from foss.arm.com ([217.140.101.70]:51002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395280AbeKXFTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:19:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FBC33620;
        Fri, 23 Nov 2018 10:34:23 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C8863F5CF;
        Fri, 23 Nov 2018 10:34:22 -0800 (PST)
Date:   Fri, 23 Nov 2018 18:34:19 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux@armlinux.org.uk, jeyu@kernel.org,
        Vincent Whitchurch <rabinv@axis.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: module: Fix function kallsyms on Thumb-2
Message-ID: <20181123183419.GM3505@e103592.cambridge.arm.com>
References: <20181119162513.16562-1-vincent.whitchurch@axis.com>
 <20181119162513.16562-2-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119162513.16562-2-vincent.whitchurch@axis.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 05:25:13PM +0100, Vincent Whitchurch wrote:
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
>     333: 00002d4d    36 FUNC    GLOBAL DEFAULT    1 tun_get_socket
>  $ arm-linux-gnueabihf-nm drivers/net/tun.ko | grep tun_get_socket
>  00002d4c T tun_get_socket
>  $ cat /proc/kallsyms | grep tun_get_socket
>  7f802d4d t tun_get_socket      [tun]
> 
> Because of this, the symbol+offset of the crashing instruction shown in
> oopses is incorrect when the crash is in a module.  For example, given a
> tun_get_socket which starts like this,
> 
>  00002d4c <tun_get_socket>:
>      2d4c:       6943            ldr     r3, [r0, #20]
>      2d4e:       4a07            ldr     r2, [pc, #28]
>      2d50:       4293            cmp     r3, r2
> 
> a crash when tun_get_socket is called with NULL results in:
> 
>  PC is at tun_xdp+0xa3/0xa4 [tun]
>  pc : [<7f802d4c>]
> 
> As can be seen, the "PC is at" line reports the wrong symbol name, and
> the symbol+offset will point to the wrong source line if it is passed to
> gdb.
> 
> To solve this, add a way for archs to fixup the reading of these module
> kallsyms values, and use that to clear the lowest bit for function
> symbols on Thumb-2.
> 
> After the fix:
> 
>  # cat /proc/kallsyms | grep tun_get_socket
>  7f802d4c t tun_get_socket       [tun]
> 
>  PC is at tun_get_socket+0x0/0x24 [tun]
>  pc : [<7f802d4c>]
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> v4: Split out st_value overwrite change.  Add HAVE* macro to avoid function call.
> v3: Do not overwrite st_value
> v2: Fix build warning with !MODULES
> 
>  arch/arm/include/asm/module.h | 11 +++++++++++
>  include/linux/module.h        |  7 +++++++
>  kernel/module.c               | 25 ++++++++++++++-----------
>  3 files changed, 32 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
> index 9e81b7c498d8..e2ccec651e71 100644
> --- a/arch/arm/include/asm/module.h
> +++ b/arch/arm/include/asm/module.h
> @@ -61,4 +61,15 @@ u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val);
>  	MODULE_ARCH_VERMAGIC_ARMTHUMB \
>  	MODULE_ARCH_VERMAGIC_P2V
>  
> +#ifdef CONFIG_THUMB2_KERNEL
> +#define HAVE_ARCH_MODULE_KALLSYMS_SYMBOL_VALUE
> +static inline unsigned long module_kallsyms_symbol_value(Elf_Sym *sym)
> +{
> +	if (ELF_ST_TYPE(sym->st_info) == STT_FUNC)
> +		return sym->st_value & ~1;
> +
> +	return sym->st_value;
> +}
> +#endif
> +
>  #endif /* _ASM_ARM_MODULE_H */
> diff --git a/include/linux/module.h b/include/linux/module.h
> index fce6b4335e36..cfc55f358800 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -486,6 +486,13 @@ struct module {
>  #define MODULE_ARCH_INIT {}
>  #endif
>  
> +#ifndef HAVE_ARCH_MODULE_KALLSYMS_SYMBOL_VALUE
> +static inline unsigned long module_kallsyms_symbol_value(Elf_Sym *sym)
> +{
> +	return sym->st_value;
> +}
> +#endif
> +
>  extern struct mutex module_mutex;
>  
>  /* FIXME: It'd be nice to isolate modules during init, too, so they
> diff --git a/kernel/module.c b/kernel/module.c
> index 3d86a38b580c..a36d7915ed2b 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3934,6 +3934,9 @@ static const char *get_ksymbol(struct module *mod,
>  	/* Scan for closest preceding symbol, and next symbol. (ELF
>  	   starts real symbols at 1). */
>  	for (i = 1; i < kallsyms->num_symtab; i++) {
> +		unsigned long thisval = module_kallsyms_symbol_value(&kallsyms->symtab[i]);
> +		unsigned long bestval = module_kallsyms_symbol_value(&kallsyms->symtab[best]);
> +
>  		if (kallsyms->symtab[i].st_shndx == SHN_UNDEF)
>  			continue;
>  
> @@ -3943,21 +3946,21 @@ static const char *get_ksymbol(struct module *mod,
>  		    || is_arm_mapping_symbol(symname(kallsyms, i)))
>  			continue;
>  
> -		if (kallsyms->symtab[i].st_value <= addr
> -		    && kallsyms->symtab[i].st_value > kallsyms->symtab[best].st_value)
> +		if (thisval <= addr
> +		    && thisval > bestval)

Nit: this fits easily on one line now.

>  			best = i;

Can we declare bestval outside the loop and update it here, so that
we always have
bestval == module_kallsyms_symbol_value(&kallsyms->symtab[best]) ?

Then we wouldn't need to call module_kallsyms_symbol_value() again
afterwards at [1], [2] below.

> -		if (kallsyms->symtab[i].st_value > addr
> -		    && kallsyms->symtab[i].st_value < nextval)
> -			nextval = kallsyms->symtab[i].st_value;
> +		if (thisval > addr
> +		    && thisval < nextval)
> +			nextval = thisval;

Nit: same again.

>  	}
>  
>  	if (!best)
>  		return NULL;
>  
>  	if (size)
> -		*size = nextval - kallsyms->symtab[best].st_value;
> +		*size = nextval - module_kallsyms_symbol_value(&kallsyms->symtab[best]);

[1]

>  	if (offset)
> -		*offset = addr - kallsyms->symtab[best].st_value;
> +		*offset = addr - module_kallsyms_symbol_value(&kallsyms->symtab[best]);

[2]

>  	return symname(kallsyms, best);
>  }
>  
> @@ -4060,7 +4063,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
>  			continue;
>  		kallsyms = rcu_dereference_sched(mod->kallsyms);
>  		if (symnum < kallsyms->num_symtab) {
> -			*value = kallsyms->symtab[symnum].st_value;
> +			*value = module_kallsyms_symbol_value(&kallsyms->symtab[symnum]);
>  			*type = kallsyms->symtab[symnum].st_size;
>  			strlcpy(name, symname(kallsyms, symnum), KSYM_NAME_LEN);
>  			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
> @@ -4082,7 +4085,7 @@ static unsigned long mod_find_symname(struct module *mod, const char *name)
>  	for (i = 0; i < kallsyms->num_symtab; i++)
>  		if (strcmp(name, symname(kallsyms, i)) == 0 &&
>  		    kallsyms->symtab[i].st_shndx != SHN_UNDEF)
> -			return kallsyms->symtab[i].st_value;
> +			return module_kallsyms_symbol_value(&kallsyms->symtab[i]);
>  	return 0;
>  }
>  
> @@ -4131,8 +4134,8 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
>  			if (kallsyms->symtab[i].st_shndx == SHN_UNDEF)
>  				continue;
>  
> -			ret = fn(data, symname(kallsyms, i),
> -				 mod, kallsyms->symtab[i].st_value);
> +			ret = fn(data, symname(kallsyms, i), mod,
> +				 module_kallsyms_symbol_value(&kallsyms->symtab[i]));

Nit: We have some more overlong lines throughout this file now, which is
mildly annoying (though hardly a big deal).

In may places the expression kallsyms->symtab[foo] appears multiple
times and adds to verbosity.

Is it worth stashing the pointer first?  For example, in this case:

			const Elf_Sym *sym = &kallsyms->symtab[i];

			if (sym->st_shndx == SHN_UNDEF)
				continue;

			ret = fn(data, symname(kallsyms, i), mod,
				module_kallsyms_symbol_value(sym));

This adds two lines in the diffstat of course.  Take your pick!

Cheers
---Dave
