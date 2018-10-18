Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491FBC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E444F21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTohPGhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E444F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJRU7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeJRU7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:59:21 -0400
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 727F72087A;
        Thu, 18 Oct 2018 12:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539867505;
        bh=8MhlpBduEZAG3iVaBCq0rYQXBSoA114IrTIa0SJNgR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GTohPGhMM+sxoluvxkxgdsr4eBxCTcnUhtqO9mAPVJfD4Gtz7rUjwp8mggJsYCYR8
         1wLIZdVUDuSOtCdi+ChPN4VeSaI5HFJCdYow3faThO9VQq0M9Y+1o8oVpDRW62IzIp
         U0um9SxxzdWl9BeTtYAlNk5WLUkP70gST7XF9kDk=
Date:   Thu, 18 Oct 2018 14:58:20 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/4] arm64: implement live patching
Message-ID: <20181018125820.iw54zbirq74ulknj@linux-8ccs>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <alpine.LSU.2.21.1810171051560.21847@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1810171051560.21847@pobox.suse.cz>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.16-default x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Miroslav Benes [17/10/18 15:39 +0200]:
>On Mon, 1 Oct 2018, Torsten Duwe wrote:
>
>> Based on ftrace with regs, do the usual thing. Also allocate a
>> task flag for whatever consistency handling will be used.
>> Watch out for interactions with the graph tracer.
>
>Similar to what Mark wrote about 2/4, I'd appreciate a better commit log.
>Could you explain traditional "what/why/how", please?
>
>> Signed-off-by: Torsten Duwe <duwe@suse.de>
>>
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -119,6 +119,7 @@ config ARM64
>>  	select HAVE_GENERIC_DMA_COHERENT
>>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS
>>  	select HAVE_IRQ_TIME_ACCOUNTING
>> +	select HAVE_LIVEPATCH
>>  	select HAVE_MEMBLOCK
>>  	select HAVE_MEMBLOCK_NODE_MAP if NUMA
>>  	select HAVE_NMI
>> @@ -1349,4 +1350,6 @@ if CRYPTO
>>  source "arch/arm64/crypto/Kconfig"
>>  endif
>>
>> +source "kernel/livepatch/Kconfig"
>> +
>>  source "lib/Kconfig"
>> --- a/arch/arm64/include/asm/thread_info.h
>> +++ b/arch/arm64/include/asm/thread_info.h
>> @@ -76,6 +76,7 @@ void arch_release_task_struct(struct tas
>>  #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
>>  #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
>>  #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
>> +#define TIF_PATCH_PENDING	6
>>  #define TIF_NOHZ		7
>>  #define TIF_SYSCALL_TRACE	8
>>  #define TIF_SYSCALL_AUDIT	9
>> @@ -94,6 +95,7 @@ void arch_release_task_struct(struct tas
>>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
>>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>>  #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
>> +#define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
>>  #define _TIF_NOHZ		(1 << TIF_NOHZ)
>>  #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
>>  #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
>> @@ -106,7 +108,8 @@ void arch_release_task_struct(struct tas
>>
>>  #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
>>  				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
>> -				 _TIF_UPROBE | _TIF_FSCHECK)
>> +				 _TIF_UPROBE | _TIF_FSCHECK | \
>> +				 _TIF_PATCH_PENDING)
>
>Could you add a note to the changelog what this means? My ability to read
>arm64 entry.S is very limited, but I can see that _TIF_WORK_MASK is
>process in a syscall exit and irq return paths. That's good. It is also
>called (via "b ret_to_user") in a couple of different places (el0_*
>labels). I guess those are returns from exception handling. A comment
>about it in the changelog would be appreciated.
>
>>  #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
>>  				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/livepatch.h
>> @@ -0,0 +1,36 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> + *
>> + * livepatch.h - arm64-specific Kernel Live Patching Core
>> + *
>> + * Copyright (C) 2016,2018 SUSE
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version 2
>> + * of the License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +#ifndef _ASM_ARM64_LIVEPATCH_H
>> +#define _ASM_ARM64_LIVEPATCH_H
>> +
>> +#include <linux/module.h>
>> +#include <linux/ftrace.h>
>
>I think that only
>
>#include <asm/ptrace.h>
>
>is in fact needed, because of "struct pt_regs".
>
>
>Ad relocations. I checked that everything in struct mod_arch_specific
>stays after the module is load. Both core and init get SHF_ALLOC set
>(mod->arch.core.plt->sh_flags in module_frob_arch_sections(). It is
>important because apply_relocate_add() may use those sections
>through module_emit_plt_entry() call.

Yes, it looks like the needed .plt sections will remain in module
memory. However, I think I found a slight issue... :/

In module_frob_arch_sections(), mod->arch.core.plt is set to an offset
within info->sechdrs:

             if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
                     mod->arch.core.plt = sechdrs + i;

sechdrs is from info->sechdrs, which is freed at the end of
load_module() via free_copy(). So although the relevant plt section(s)
are in module memory, mod->arch.core.plt will point to invalid memory
after info is freed. In other words, the section (.plt) *is* in memory
but the section header (struct elf64_shdr) containing section metadata
like sh_addr, sh_size etc., is not.

But we have mod->klp_info->sechdrs (which is a copy of the section
headers) for this very reason. It is initialized only at the very end
of load_module(). I don't think copy_module_elf() is dependent on
anything, so it can just be moved earlier.

Note that we cannot set mod->arch.core.plt to mod->klp_info->sechdrs + i
during module_frob_arch_sections() because it is still too early, none
of the module sections have been copied and none of their sh_addr's
have been set to their final locations as this is all happening before
move_module() is called. So we can use a module_finalize() function
for arm64 to switch the mod->arch.core.plt to use the klp_info section
headers.

Maybe this will be more clear in the example fix below (completely
untested and unreviewed!):

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 97d0ef12e2ff..150afc29171b 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -25,6 +25,7 @@ struct mod_plt_sec {
 	struct elf64_shdr	*plt;
 	int			plt_num_entries;
 	int			plt_max_entries;
+	int			plt_shndx;
 };
 
 struct mod_arch_specific {
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index f0690c2ca3e0..c23cef8f0165 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -196,6 +196,21 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
 	return ret;
 }
 
+int module_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
+		    struct module *mod)
+{
+	/*
+	 * Livepatch modules need to keep access to section headers to apply
+	 * relocations. Note mod->klp_info should have already been initialized
+	 * and all section sh_addr's should have their final addresses by the
+	 * time module_finalize() is called.
+	 */
+	if (is_livepatch_module(mod))
+		mod->arch.core.plt = mod->klp_info->sechdrs + mod->arch.core.plt_shndx;
+
+	return 0;
+}
+
 int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
@@ -210,11 +225,13 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	 * entries. Record the symtab address as well.
 	 */
 	for (i = 0; i < ehdr->e_shnum; i++) {
-		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
+		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt")) {
 			mod->arch.core.plt = sechdrs + i;
-		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt"))
+			mod->arch.core.plt_shndx = i;
+		} else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt")) {
 			mod->arch.init.plt = sechdrs + i;
-		else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
+			mod->arch.init.plt_shndx = i;
+		} else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
 			 !strcmp(secstrings + sechdrs[i].sh_name,
 				 ".text.ftrace_trampoline"))
 			tramp = sechdrs + i;
diff --git a/kernel/module.c b/kernel/module.c
index 6746c85511fe..2fc4d74288dd 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3363,6 +3363,12 @@ static int post_relocation(struct module *mod, const struct load_info *info)
 	/* Setup kallsyms-specific fields. */
 	add_kallsyms(mod, info);
 
+	if (is_livepatch_module(mod)) {
+		err = copy_module_elf(mod, info);
+		if (err < 0)
+			return err;
+	}
+
 	/* Arch-specific module finalizing. */
 	return module_finalize(info->hdr, info->sechdrs, mod);
 }
@@ -3775,12 +3781,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (err < 0)
 		goto coming_cleanup;
 
-	if (is_livepatch_module(mod)) {
-		err = copy_module_elf(mod, info);
-		if (err < 0)
-			goto sysfs_cleanup;
-	}
-
 	/* Get rid of temporary copy. */
 	free_copy(info);

Thoughts? Does the fix make sense?

>The last thing is count_plts() function called from
>module_frob_arch_sections(). It needed to be changed in 2016 as well. See
>Jessica's patch
>(20160713001113.GA30925@packer-debian-8-amd64.digitalocean.com). The logic
>in the function has changed since then. If I am not mistaken,
>count_plts() is fine as it is right now. It does not consider SHN_UNDEF
>anymore, it looks at the destination section (where a symbol should
>resolved to) only.
>
>Jessica, could you doublecheck, please?

Yes, I think count_plts() is fine now in this case (because it is
always true that sym->st_shndx != dstidx for SHN_LIVEPATCH symbols)
and my old patch from 2016 is no longer needed.

Thanks,

Jessica
