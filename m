Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbeFDOFR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753313AbeFDOFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:05:14 -0400
Date: Mon, 4 Jun 2018 16:05:11 +0200
From: Jessica Yu <jeyu@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH] module: exclude SHN_UNDEF symbols from kallsyms api
Message-ID: <20180604140510.jovmjhamo24mzh3l@d217.suse.de>
References: <20180602173209.merjb4o5a3wsdnbh@treble>
 <20180604080528.4z6rbhapbhn7xf5e@d217.suse.de>
 <20180604095416.rlthplerswzznyoc@d217.suse.de>
 <20180604130131.slyhtgyywffusf67@d217.suse.de>
 <20180604131648.eykjibc3iubckeiu@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180604131648.eykjibc3iubckeiu@treble>
X-OS: Linux d217 4.12.14-lp150.10-default x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Josh Poimboeuf [04/06/18 08:16 -0500]:
>On Mon, Jun 04, 2018 at 03:01:31PM +0200, Jessica Yu wrote:
>> +++ Jessica Yu [04/06/18 11:54 +0200]:
>> > +++ Jessica Yu [04/06/18 10:05 +0200]:
>> > > +++ Josh Poimboeuf [02/06/18 12:32 -0500]:
>> > > > Hi Jessica,
>> > > >
>> > > > I found a bug:
>> > > >
>> > > > [root@f25 ~]# modprobe livepatch-sample
>> > > > [root@f25 ~]# grep ' u ' /proc/kallsyms
>> > > > ffffffff81161080 u klp_enable_patch	[livepatch_sample]
>> > > > ffffffff81a01800 u __fentry__	[livepatch_sample]
>> > > > ffffffff81161250 u klp_unregister_patch	[livepatch_sample]
>> > > > ffffffff81161870 u klp_register_patch	[livepatch_sample]
>> > > > ffffffff8131f0b0 u seq_printf	[livepatch_sample]
>> > > >
>> > > > Notice that livepatch modules' undefined symbols are showing up in
>> > > > /proc/kallsyms.  This can confuse klp_find_object_symbol() which can
>> > > > cause subtle bugs in livepatch.
>> > > >
>> > > > I stared at the module kallsyms code for a bit, but I don't see the bug.
>> > > > Maybe it has something to do with how we save the symbol table in
>> > > > copy_module_elf().  Any ideas?
>> > >
>> > > Hi Josh!
>> > >
>> > > This is because we preserve the entire symbol table for livepatch
>> > > modules, including the SHN_UNDEF symbols. IIRC, this is so that we can
>> > > still apply relocations properly with apply_relocate_add() after a
>> > > to-be-patched object is loaded. Normally we don't save these SHN_UNDEF
>> > > symbols for modules so they do not appear in /proc/kallsyms.
>> >
>> > Hm, if having the full symtab in kallsyms is causing trouble, one
>> > possibility would be to just have the module kallsyms code simply
>> > skip/ignore undef symbols. That's what we technically do for normal
>> > modules anyway (we normally cut undef syms out of the symtab). Haven't
>> > tested this idea but does that sound like it'd help?
>>
>> See if the following patch (untested) helps. It does not fix the
>> /proc/kallsyms lookup, that requires a separate patch. But it should
>> exclude the undef symbols from module_kallsyms_on_each_symbol() and
>> thus also from klp_find_object_symbol().
>
>That seems like it would work.  But wouldn't it be more robust if we
>don't store the SHN_UNDEF symbols to start with?  Really it's only the
>SHN_LIVEPATCH symbols that we need to keep, right?

Hm, didn't we have a reason for preserving the original symbol tables?
It's not that we're storing the undef symbols on purpose, it's just
that in the case of a livepatch module we keep *all* the symbols.
IIRC, the original reasoning was that we needed to keep the original
symtab indices in place, otherwise apply_relocate() (which uses the
original symbol index encoded in the relocation) won't work.
Selectively copying only SHN_LIVEPATCH symbols when building the
module's symbol table will unfortunately mess the symbol indices up :/
Under these restrictions, it just seemed easier to make kallsyms
ignore undef symbols.

>What do you think about the following (untested)?
>
>diff --git a/kernel/module.c b/kernel/module.c
>index c9bea7f2b43e..78ec9de856e3 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2586,6 +2586,9 @@ static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
> {
> 	const Elf_Shdr *sec;
>
>+	if (src->st_shndx == SHN_LIVEPATCH)
>+		return true;
>+
> 	if (src->st_shndx == SHN_UNDEF
> 	    || src->st_shndx >= shnum
> 	    || !src->st_name)
>@@ -2632,9 +2635,9 @@ static void layout_symtab(struct module *mod, struct load_info *info)
>
> 	/* Compute total space required for the core symbols' strtab. */
> 	for (ndst = i = 0; i < nsrc; i++) {
>-		if (i == 0 || is_livepatch_module(mod) ||
>-		    is_core_symbol(src+i, info->sechdrs, info->hdr->e_shnum,
>-				   info->index.pcpu)) {
>+		if (i == 0 || is_core_symbol(src+i, info->sechdrs,
>+					     info->hdr->e_shnum,
>+					     info->index.pcpu)) {
> 			strtab_size += strlen(&info->strtab[src[i].st_name])+1;
> 			ndst++;
> 		}
>@@ -2691,9 +2694,9 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
> 	mod->core_kallsyms.strtab = s = mod->core_layout.base + info->stroffs;
> 	src = mod->kallsyms->symtab;
> 	for (ndst = i = 0; i < mod->kallsyms->num_symtab; i++) {
>-		if (i == 0 || is_livepatch_module(mod) ||
>-		    is_core_symbol(src+i, info->sechdrs, info->hdr->e_shnum,
>-				   info->index.pcpu)) {
>+		if (i == 0 || is_core_symbol(src+i, info->sechdrs,
>+					     info->hdr->e_shnum,
>+					     info->index.pcpu)) {
> 			dst[ndst] = src[i];
> 			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
> 			s += strlcpy(s, &mod->kallsyms->strtab[src[i].st_name],
