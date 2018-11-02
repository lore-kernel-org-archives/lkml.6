Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB0BC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1342082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKxSGpfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1342082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeKBXAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbeKBXAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:00:40 -0400
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 391E72081F;
        Fri,  2 Nov 2018 13:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541166806;
        bh=aqZVIj/TFDJv+HJEIrgeLpq0pmFerbA1TaZqm3GpSj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cKxSGpfyYD9+p12xGrC+JkqncYmp4qfOtQ/Tig2X/1AT+Sk58oSrhJHS3KhSzn6kh
         pUfuCfepW4NfuUQM4IUu6Zfyx3B93aR6qvs/uB5wmNw/X7yTHcPJmemMYCY7uC0No8
         c+2IsfVaD2srPm/Jql0NjQ7ABusHpJF4TDy/Kuck=
Date:   Fri, 2 Nov 2018 14:53:22 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v2] ARM: module: Fix function kallsyms on Thumb-2
Message-ID: <20181102135322.GA5289@linux-8ccs>
References: <20181031084253.9650-1-vincent.whitchurch@axis.com>
 <20181031155341.GA27878@linux-8ccs>
 <20181101152913.r2isskngiahi6o2u@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181101152913.r2isskngiahi6o2u@axis.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.22-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Vincent Whitchurch [01/11/18 16:29 +0100]:
>On Wed, Oct 31, 2018 at 04:53:41PM +0100, Jessica Yu wrote:
>> Could this be done in modpost? I'm guessing the answer is no as some
>> relocations may rely on that bit being set in st_value, right?
>> Therefore we can only clear the bit _after_ relocations to the module
>> are applied at runtime, correct?
>
>Yes, that's correct, it needs to be done after the relocations.
>
>> I'm not against having an arch-specific kallsyms fixup function, my
>> only concern would be if this would interfere with the delayed
>> relocations livepatching does, if there are plans in the future to
>> have livepatching on arm (IIRC there was an attempt at a port in
>> 2016). If there exists some Thumb-2 relocation types that rely on that
>> lowest bit in st_value being set in order to be applied, and we clear
>> it permanently from the symtab, then livepatching wouldn't be able to
>> apply those types of relocations anymore. If this is a legitimate
>> concern, then perhaps an alternative solution would be to have an
>> arch-specific kallsyms symbol-value-fixup function for accesses to
>> sym.st_value, without modifying the module symtab.
>
>I'm not familiar with livepatching, but yes, if it needs to do
>relocations later I guess we should preserve the original value.

Yeah, I think the symtab needs to remain unmodified for livepatch to
be able to do delayed relocations after module load.

>I gave the alternative solution a go and it seems to work.
>add_kallsyms() currently overwrites st_info so I had to move the
>elf_type to the unused st_other field instead to preserve st_info:

I think that's fine, I think the only usages of st_other I've found
are during relocations, and the field is big enough for a char, so it
should be fine to reuse it afterwards.

>diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
>index 3ff571c2c71c..f443d0ccd1a0 100644
>--- a/arch/arm/kernel/module.c
>+++ b/arch/arm/kernel/module.c
>@@ -336,6 +336,16 @@ static const Elf_Shdr *find_mod_section(const Elf32_Ehdr *hdr,
> extern void fixup_pv_table(const void *, unsigned long);
> extern void fixup_smp(const void *, unsigned long);
>
>+#ifdef CONFIG_THUMB2_KERNEL
>+unsigned long symbol_value(Elf_Sym *sym)
>+{
>+	if (ELF_ST_TYPE(sym->st_info) == STT_FUNC)
>+		return sym->st_value & ~1;
>+
>+	return sym->st_value;
>+}
>+#endif
>+
> int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
> 		    struct module *mod)
> {
>diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
>index 31013c2effd3..6bf6118db37f 100644
>--- a/include/linux/moduleloader.h
>+++ b/include/linux/moduleloader.h
>@@ -86,6 +86,8 @@ void module_arch_cleanup(struct module *mod);
> /* Any cleanup before freeing mod->module_init */
> void module_arch_freeing_init(struct module *mod);
>
>+unsigned long symbol_value(Elf_Sym *sym);
>+
> #ifdef CONFIG_KASAN
> #include <linux/kasan.h>
> #define MODULE_ALIGN (PAGE_SIZE << KASAN_SHADOW_SCALE_SHIFT)
>diff --git a/kernel/module.c b/kernel/module.c
>index 49a405891587..871bf4450e9d 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2682,7 +2682,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
>
> 	/* Set types up while we still have access to sections. */
> 	for (i = 0; i < mod->kallsyms->num_symtab; i++)
>-		mod->kallsyms->symtab[i].st_info
>+		mod->kallsyms->symtab[i].st_other
> 			= elf_type(&mod->kallsyms->symtab[i], info);
>
> 	/* Now populate the cut down core kallsyms for after init. */
>@@ -3916,6 +3916,11 @@ static const char *symname(struct mod_kallsyms *kallsyms, unsigned int symnum)
> 	return kallsyms->strtab + kallsyms->symtab[symnum].st_name;
> }
>
>+unsigned long __weak symbol_value(Elf_Sym *sym)
>+{
>+	return sym->st_value;
>+}
>+
> static const char *get_ksymbol(struct module *mod,
> 			       unsigned long addr,
> 			       unsigned long *size,
>@@ -3934,6 +3939,9 @@ static const char *get_ksymbol(struct module *mod,
> 	/* Scan for closest preceding symbol, and next symbol. (ELF
> 	   starts real symbols at 1). */
> 	for (i = 1; i < kallsyms->num_symtab; i++) {
>+		unsigned long thisval = symbol_value(&kallsyms->symtab[i]);
>+		unsigned long bestval = symbol_value(&kallsyms->symtab[best]);
>+
> 		if (kallsyms->symtab[i].st_shndx == SHN_UNDEF)
> 			continue;
>
>@@ -3943,21 +3951,21 @@ static const char *get_ksymbol(struct module *mod,
> 		    || is_arm_mapping_symbol(symname(kallsyms, i)))
> 			continue;
>
>-		if (kallsyms->symtab[i].st_value <= addr
>-		    && kallsyms->symtab[i].st_value > kallsyms->symtab[best].st_value)
>+		if (thisval <= addr
>+		    && thisval > bestval)
> 			best = i;
>-		if (kallsyms->symtab[i].st_value > addr
>-		    && kallsyms->symtab[i].st_value < nextval)
>-			nextval = kallsyms->symtab[i].st_value;
>+		if (thisval > addr
>+		    && thisval < nextval)
>+			nextval = thisval;
> 	}
>
> 	if (!best)
> 		return NULL;
>
> 	if (size)
>-		*size = nextval - kallsyms->symtab[best].st_value;
>+		*size = nextval - symbol_value(&kallsyms->symtab[best]);
> 	if (offset)
>-		*offset = addr - kallsyms->symtab[best].st_value;
>+		*offset = addr - symbol_value(&kallsyms->symtab[best]);
> 	return symname(kallsyms, best);
> }
>
>@@ -4060,8 +4068,8 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> 			continue;
> 		kallsyms = rcu_dereference_sched(mod->kallsyms);
> 		if (symnum < kallsyms->num_symtab) {
>-			*value = kallsyms->symtab[symnum].st_value;
>-			*type = kallsyms->symtab[symnum].st_info;
>+			*value = symbol_value(&kallsyms->symtab[symnum]);
>+			*type = kallsyms->symtab[symnum].st_other;
> 			strlcpy(name, symname(kallsyms, symnum), KSYM_NAME_LEN);
> 			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
> 			*exported = is_exported(name, *value, mod);
>@@ -4082,7 +4090,7 @@ static unsigned long mod_find_symname(struct module *mod, const char *name)
> 	for (i = 0; i < kallsyms->num_symtab; i++)
> 		if (strcmp(name, symname(kallsyms, i)) == 0 &&
> 		    kallsyms->symtab[i].st_shndx != SHN_UNDEF)
>-			return kallsyms->symtab[i].st_value;
>+			return symbol_value(&kallsyms->symtab[i]);
> 	return 0;
> }
>
>@@ -4132,7 +4140,7 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
> 				continue;
>
> 			ret = fn(data, symname(kallsyms, i),
>-				 mod, kallsyms->symtab[i].st_value);
>+				 mod, symbol_value(&kallsyms->symtab[i]));
> 			if (ret != 0)
> 				return ret;
> 		}

This looks pretty good, could you submit it as a real patch? My only
suggestion is to maybe rename symbol_value() to something more
specific, so we could distinguish it from kernel_symbol_value() and
kernel_symbol_name(), which are used for exported syms that operate on
struct kernel_symbol. Maybe kallsyms_symbol_value() or
module_kallsyms_symbol_value()? (That reminds me, I really should
clean up all the kallsyms/exported symbol code in module.c, the naming
scheme is a confusing mess :-/)

Thanks!

Jessica
