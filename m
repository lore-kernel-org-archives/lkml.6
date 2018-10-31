Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D45ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2F520821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrtixMdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2F520821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbeKAAwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729440AbeKAAwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:52:22 -0400
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 512702064C;
        Wed, 31 Oct 2018 15:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541001226;
        bh=dRdFGEhaTC/i/0Mfp6jlLXibTVabH05dQnp8Z/R0eIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rrtixMdE78fQY58kUQUnkJJ5J/3eVrp+Zspc/j4mHWLRogl7UVVAkyQUyNp14P4EX
         K37nPHDtunUQEiNXbndGkyodqSASrbNw8EF0ER3PAYJRV5ybL5G+gYKZsOVv9jIVeL
         aLVpaQTk5+Z5IAuNkAHpbq7GOVZkGM0NDBsd+TUI=
Date:   Wed, 31 Oct 2018 16:53:41 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v2] ARM: module: Fix function kallsyms on Thumb-2
Message-ID: <20181031155341.GA27878@linux-8ccs>
References: <20181031084253.9650-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181031084253.9650-1-vincent.whitchurch@axis.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.16-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Vincent Whitchurch [31/10/18 09:42 +0100]:
>Thumb-2 functions have the lowest bit set in the symbol value in the
>symtab.  When kallsyms are generated for the vmlinux, the kallsyms are
>generated from the output of nm, and nm clears the lowest bit.
>
> $ arm-linux-gnueabihf-readelf -a vmlinux | grep show_interrupts
>  95947: 8015dc89   686 FUNC    GLOBAL DEFAULT    2 show_interrupts
> $ arm-linux-gnueabihf-nm vmlinux | grep show_interrupts
> 8015dc88 T show_interrupts
> $ cat /proc/kallsyms | grep show_interrupts
> 8015dc88 T show_interrupts
>
>However, for modules, the kallsyms uses the values in the symbol table
>without modification, so for functions in modules, the lowest bit is set
>in kallsyms.
>
> $ arm-linux-gnueabihf-readelf -a drivers/net/tun.ko | grep tun_get_socket
>    268: 000000e1    44 FUNC    GLOBAL DEFAULT    2 tun_get_socket
> $ arm-linux-gnueabihf-nm drivers/net/tun.ko | grep tun_get_socket
> 000000e0 T tun_get_socket
> $ cat /proc/kallsyms | grep tun_get_socket
> 7fcd30e1 t tun_get_socket  [tun]
>
>Because of this, the offset of the crashing instruction shown in oopses
>is incorrect when the crash is in a module.  For example, given a
>tun_get_socket which starts like this,
>
> 000000e0 <tun_get_socket>:
>       e0:       b500            push    {lr}
>       e2:       f7ff fffe       bl      0 <__gnu_mcount_nc>
>       e6:       4b08            ldr     r3, [pc, #32]
>       e8:       6942            ldr     r2, [r0, #20]
>       ea:       429a            cmp     r2, r3
>       ec:       d002            beq.n   f4 <tun_get_socket+0x14>
>
>a crash when tun_get_socket is called with NULL results in:
>
> PC is at tun_get_socket+0x7/0x2c [tun]
> pc : [<7fcdb0e8>]
>
>which can result in the incorrect line being reported by gdb if this
>symbol+offset is used there.  If the crash is on the first instruction
>of a function, the "PC is at" line would also report the symbol name of
>the preceding function.
>
>To solve this, fix up these symbols like nm does.  For this, we need a
>new hook in the generic module loading code, before the symbols' st_info
>is overwritten by add_kallsyms().  After the fix:
>
> $ cat /proc/kallsyms | grep tun_get_socket
> 7fcd30e0 t tun_get_socket  [tun]
>
> PC is at tun_get_socket+0x8/0x2c [tun]
> pc : [<7fcdb0e8>]
>
>Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
>---
>v2: Fix build warning with !MODULES


Hi Vincent,

Just a few questions -

Could this be done in modpost? I'm guessing the answer is no as some
relocations may rely on that bit being set in st_value, right?
Therefore we can only clear the bit _after_ relocations to the module
are applied at runtime, correct?

I'm not against having an arch-specific kallsyms fixup function, my
only concern would be if this would interfere with the delayed
relocations livepatching does, if there are plans in the future to
have livepatching on arm (IIRC there was an attempt at a port in
2016). If there exists some Thumb-2 relocation types that rely on that
lowest bit in st_value being set in order to be applied, and we clear
it permanently from the symtab, then livepatching wouldn't be able to
apply those types of relocations anymore. If this is a legitimate
concern, then perhaps an alternative solution would be to have an
arch-specific kallsyms symbol-value-fixup function for accesses to
sym.st_value, without modifying the module symtab.


Thanks,

Jessica

> arch/arm/kernel/module.c     | 14 ++++++++++++++
> include/linux/moduleloader.h |  3 +++
> kernel/module.c              |  6 ++++++
> 3 files changed, 23 insertions(+)
>
>diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
>index 3ff571c2c71c..771f86318d84 100644
>--- a/arch/arm/kernel/module.c
>+++ b/arch/arm/kernel/module.c
>@@ -399,6 +399,20 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
> 	return 0;
> }
>
>+#if defined(CONFIG_THUMB2_KERNEL) && defined(CONFIG_KALLSYMS)
>+void module_fixup_kallsyms(struct mod_kallsyms *kallsyms)
>+{
>+	int i;
>+
>+	for (i = 0; i < kallsyms->num_symtab; i++) {
>+		Elf_Sym *sym = &kallsyms->symtab[i];
>+
>+		if (ELF_ST_TYPE(sym->st_info) == STT_FUNC)
>+			sym->st_value &= ~1;
>+	}
>+}
>+#endif
>+
> void
> module_arch_cleanup(struct module *mod)
> {
>diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
>index 31013c2effd3..b1ac5584eaa5 100644
>--- a/include/linux/moduleloader.h
>+++ b/include/linux/moduleloader.h
>@@ -86,6 +86,9 @@ void module_arch_cleanup(struct module *mod);
> /* Any cleanup before freeing mod->module_init */
> void module_arch_freeing_init(struct module *mod);
>
>+struct mod_kallsyms;
>+void module_fixup_kallsyms(struct mod_kallsyms *kallsyms);
>+
> #ifdef CONFIG_KASAN
> #include <linux/kasan.h>
> #define MODULE_ALIGN (PAGE_SIZE << KASAN_SHADOW_SCALE_SHIFT)
>diff --git a/kernel/module.c b/kernel/module.c
>index 49a405891587..ded4f4b49824 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2659,6 +2659,10 @@ static void layout_symtab(struct module *mod, struct load_info *info)
> 	mod->init_layout.size = debug_align(mod->init_layout.size);
> }
>
>+void __weak module_fixup_kallsyms(struct mod_kallsyms *kallsyms)
>+{
>+}
>+
> /*
>  * We use the full symtab and strtab which layout_symtab arranged to
>  * be appended to the init section.  Later we switch to the cut-down
>@@ -2680,6 +2684,8 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
> 	/* Make sure we get permanent strtab: don't use info->strtab. */
> 	mod->kallsyms->strtab = (void *)info->sechdrs[info->index.str].sh_addr;
>
>+	module_fixup_kallsyms(mod->kallsyms);
>+
> 	/* Set types up while we still have access to sections. */
> 	for (i = 0; i < mod->kallsyms->num_symtab; i++)
> 		mod->kallsyms->symtab[i].st_info
>-- 
>2.11.0
>
