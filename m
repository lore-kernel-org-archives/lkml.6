Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261D3C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02062145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3TEfebI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02062145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeK3Njs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:39:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:38742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbeK3Njs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 08:39:48 -0500
Received: from devnote (p35161-mobac01.tokyo.ocn.ne.jp [153.233.26.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D14F52081C;
        Fri, 30 Nov 2018 02:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543545126;
        bh=7fb/mknNp2uDvoF30aUIHW5Fpu9ka7CwGvHKm9X3eFE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R3TEfebIqSMGFP5w6RT/EGLFX3OSHQLLaQT2D6Sk5h1x5m44ov9KU4DUTFNlyYTJf
         uHmNALwLYCT2Lsk5EyolS3oFdrO+XCpOOMR/zSB3wZgU4eZgyxw8xELz0vmIXqVjPM
         pVCwxz9tVN+CrrdVKujE4PtZOC9TmqeN7poqanQo=
Date:   Fri, 30 Nov 2018 11:32:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v6 08/10] x86: avoid W^X being broken during modules
 loading
Message-Id: <20181130113201.c215e2a48c756230ddb48da3@kernel.org>
In-Reply-To: <5E938E6F-6BE6-4F86-AC9E-5C389B492682@vmware.com>
References: <20181120203545.34928-1-namit@vmware.com>
        <20181120203545.34928-9-namit@vmware.com>
        <5E938E6F-6BE6-4F86-AC9E-5C389B492682@vmware.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 18:59:30 +0000
Nadav Amit <namit@vmware.com> wrote:

> > On Nov 20, 2018, at 12:35 PM, Nadav Amit <namit@vmware.com> wrote:
> > 
> > When modules and BPF filters are loaded, there is a time window in
> > which some memory is both writable and executable. An attacker that has
> > already found another vulnerability (e.g., a dangling pointer) might be
> > able to exploit this behavior to overwrite kernel code. This patch
> > prevents having writable executable PTEs in this stage.
> > 
> > In addition, avoiding having R+X mappings can also slightly simplify the
> > patching of modules code on initialization (e.g., by alternatives and
> > static-key), as would be done in the next patch.
> > 
> > To avoid having W+X mappings, set them initially as RW (NX) and after
> > they are set as RO set them as X as well. Setting them as executable is
> > done as a separate step to avoid one core in which the old PTE is cached
> > (hence writable), and another which sees the updated PTE (executable),
> > which would break the W^X protection.
> > 
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Suggested-by: Andy Lutomirski <luto@amacapital.net>
> > Signed-off-by: Nadav Amit <namit@vmware.com>
> > ---
> > arch/x86/kernel/alternative.c | 28 +++++++++++++++++++++-------
> > arch/x86/kernel/module.c      |  2 +-
> > include/linux/filter.h        |  6 ++++++
> > kernel/module.c               | 10 ++++++++++
> > 4 files changed, 38 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index 8fc4685f3117..18415e3b6000 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -667,15 +667,29 @@ void __init alternative_instructions(void)
> >  * handlers seeing an inconsistent instruction while you patch.
> >  */
> > void *__init_or_module text_poke_early(void *addr, const void *opcode,
> > -					      size_t len)
> > +				       size_t len)
> > {
> > 	unsigned long flags;
> > -	local_irq_save(flags);
> > -	memcpy(addr, opcode, len);
> > -	local_irq_restore(flags);
> > -	sync_core();
> > -	/* Could also do a CLFLUSH here to speed up CPU recovery; but
> > -	   that causes hangs on some VIA CPUs. */
> > +
> > +	if (static_cpu_has(X86_FEATURE_NX) &&
> > +	    is_module_text_address((unsigned long)addr)) {
> > +		/*
> > +		 * Modules text is marked initially as non-executable, so the
> > +		 * code cannot be running and speculative code-fetches are
> > +		 * prevented. We can just change the code.
> > +		 */
> > +		memcpy(addr, opcode, len);
> > +	} else {
> > +		local_irq_save(flags);
> > +		memcpy(addr, opcode, len);
> > +		local_irq_restore(flags);
> > +		sync_core();
> > +
> > +		/*
> > +		 * Could also do a CLFLUSH here to speed up CPU recovery; but
> > +		 * that causes hangs on some VIA CPUs.
> > +		 */
> > +	}
> > 	return addr;
> > }
> > 
> > diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> > index b052e883dd8c..cfa3106faee4 100644
> > --- a/arch/x86/kernel/module.c
> > +++ b/arch/x86/kernel/module.c
> > @@ -87,7 +87,7 @@ void *module_alloc(unsigned long size)
> > 	p = __vmalloc_node_range(size, MODULE_ALIGN,
> > 				    MODULES_VADDR + get_module_load_offset(),
> > 				    MODULES_END, GFP_KERNEL,
> > -				    PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> > +				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> > 				    __builtin_return_address(0));
> > 	if (p && (kasan_module_alloc(p, size) < 0)) {
> > 		vfree(p);
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index de629b706d1d..ee9ae03c5f56 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -704,7 +704,13 @@ static inline void bpf_prog_unlock_ro(struct bpf_prog *fp)
> > 
> > static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
> > {
> > +	/*
> > +	 * Perform mapping changes in two stages to avoid opening a time-window
> > +	 * in which a PTE is cached in any TLB as writable, but marked as
> > +	 * executable in the memory-resident mappings (e.g., page-tables).
> > +	 */
> > 	set_memory_ro((unsigned long)hdr, hdr->pages);
> > +	set_memory_x((unsigned long)hdr, hdr->pages);
> > }
> > 
> > static inline void bpf_jit_binary_unlock_ro(struct bpf_binary_header *hdr)
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 49a405891587..7cb207249437 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -1946,9 +1946,19 @@ void module_enable_ro(const struct module *mod, bool after_init)
> > 	if (!rodata_enabled)
> > 		return;
> > 
> > +	/*
> > +	 * Perform mapping changes in two stages to avoid opening a time-window
> > +	 * in which a PTE is cached in any TLB as writable, but marked as
> > +	 * executable in the memory-resident mappings (e.g., page-tables).
> > +	 */
> > 	frob_text(&mod->core_layout, set_memory_ro);
> > +	frob_text(&mod->core_layout, set_memory_x);
> > +
> > 	frob_rodata(&mod->core_layout, set_memory_ro);
> > +
> > 	frob_text(&mod->init_layout, set_memory_ro);
> > +	frob_text(&mod->init_layout, set_memory_x);
> > +
> > 	frob_rodata(&mod->init_layout, set_memory_ro);
> > 
> > 	if (after_init)
> > -- 
> > 2.17.1
> 
> Rick pointed out that I screwed up ftrace and kprobes.
> 
> For kprobes, I think I need to add set_memory_x() to alloc_insn_page() and
> change arch_ftrace_update_trampoline().

Oops, right. It should be easy to fix for kprobe :) what you need is below.

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index c33b06f..51818f3 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -431,8 +431,10 @@ void *alloc_insn_page(void)
        void *page;
 
        page = module_alloc(PAGE_SIZE);
-       if (page)
+       if (page) {
                set_memory_ro((unsigned long)page & PAGE_MASK, 1);
+               set_memory_x((unsigned long)page & PAGE_MASK, 1);
+       }
 
        return page;
 }


> 
> For arch_ftrace_update_trampoline(), I think I should remove not use
> set_memory_rw() when patching in __probe_kernel_write() should be done
> through text_poke().

right.

> 
> I’ll give it another look and send another version later.

Thank you,

> 
> Regards,
> Nadav
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
