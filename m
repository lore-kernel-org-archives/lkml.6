Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAC6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83F220817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83F220817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbeK1BoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:44:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:62065 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbeK1BoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:44:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 06:46:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="112292528"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by orsmga001.jf.intel.com with ESMTP; 27 Nov 2018 06:46:04 -0800
Date:   Tue, 27 Nov 2018 06:46:04 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 12/13] x86/fault: Decode page fault OOPSes better
Message-ID: <20181127144603.GA3130@linux.intel.com>
References: <cover.1542667307.git.luto@kernel.org>
 <9c621efcf6a86f7d215941dab3dca0acd1274638.1542667307.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c621efcf6a86f7d215941dab3dca0acd1274638.1542667307.git.luto@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 02:45:36PM -0800, Andy Lutomirski wrote:
> One of Linus' favorite hobbies seems to be looking at OOPSes and
> decoding the error code in his head.  This is not one of my favorite
> hobbies :)
> 
> Teach the page fault OOPS hander to decode the error code.  If it's
> a !USER fault from user mode, print an explicit note to that effect
> and print out the addresses of various tables that might cause such
> an error.
> 
> With this patch applied, if I intentionally point the LDT at 0x0 and
> run the x86 selftests, I get:
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> HW error: normal kernel read fault
> This was a system access from user code
> IDT: 0xfffffe0000000000 (limit=0xfff) GDT: 0xfffffe0000001000 (limit=0x7f)
> LDTR: 0x50 -- base=0x0 limit=0xfff7
> TR: 0x40 -- base=0xfffffe0000003000 limit=0x206f
> PGD 800000000456e067 P4D 800000000456e067 PUD 4623067 PMD 0
> SMP PTI
> CPU: 0 PID: 153 Comm: ldt_gdt_64 Not tainted 4.19.0+ #1317
> Hardware name: ...
> RIP: 0033:0x401454
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/mm/fault.c | 84 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 092ed6b1df8a..f34241fcc633 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -27,6 +27,7 @@
>  #include <asm/vm86.h>			/* struct vm86			*/
>  #include <asm/mmu_context.h>		/* vma_pkey()			*/
>  #include <asm/efi.h>			/* efi_recover_from_page_fault()*/
> +#include <asm/desc.h>			/* store_idt(), ...		*/
>  
>  #define CREATE_TRACE_POINTS
>  #include <asm/trace/exceptions.h>
> @@ -571,10 +572,53 @@ static int is_f00f_bug(struct pt_regs *regs, unsigned long address)
>  	return 0;
>  }
>  
> +static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
> +{
> +	u32 offset = (index >> 3) * sizeof(struct desc_struct);
> +	unsigned long addr;
> +	struct ldttss_desc desc;
> +
> +	if (index == 0) {
> +		pr_alert("%s: NULL\n", name);
> +		return;
> +	}
> +
> +	if (offset + sizeof(struct ldttss_desc) >= gdt->size) {
> +		pr_alert("%s: 0x%hx -- out of bounds\n", name, index);
> +		return;
> +	}
> +
> +	if (probe_kernel_read(&desc, (void *)(gdt->address + offset),
> +			      sizeof(struct ldttss_desc))) {
> +		pr_alert("%s: 0x%hx -- GDT entry is not readable\n",
> +			 name, index);
> +		return;
> +	}
> +
> +	addr = desc.base0 | (desc.base1 << 16) | (desc.base2 << 24);
> +#ifdef CONFIG_X86_64
> +	addr |= ((u64)desc.base3 << 32);
> +#endif
> +	pr_alert("%s: 0x%hx -- base=0x%lx limit=0x%x\n",
> +		 name, index, addr, (desc.limit0 | (desc.limit1 << 16)));
> +}
> +
> +static void errstr(unsigned long ec, char *buf, unsigned long mask,
> +		   const char *txt)
> +{
> +	if (ec & mask) {
> +		if (buf[0])
> +			strcat(buf, " ");
> +		strcat(buf, txt);
> +	}
> +}
> +
>  static void
>  show_fault_oops(struct pt_regs *regs, unsigned long error_code,
>  		unsigned long address)
>  {
> +	char errtxt[64];
> +
>  	if (!oops_may_print())
>  		return;
>  
> @@ -602,6 +646,46 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
>  		 address < PAGE_SIZE ? "NULL pointer dereference" : "paging request",
>  		 (void *)address);
>  
> +	errtxt[0] = 0;
> +	errstr(error_code, errtxt, X86_PF_PROT, "PROT");
> +	errstr(error_code, errtxt, X86_PF_WRITE, "WRITE");
> +	errstr(error_code, errtxt, X86_PF_USER, "USER");
> +	errstr(error_code, errtxt, X86_PF_RSVD, "RSVD");
> +	errstr(error_code, errtxt, X86_PF_INSTR, "INSTR");
> +	errstr(error_code, errtxt, X86_PF_PK, "PK");
> +	pr_alert("HW error: %s\n", error_code ? errtxt :
> +		 "normal kernel read fault");

What about something like this instead of manually handling the case
where error_code==0 so that we get e.g. "!PROT KERNEL READ" instead of
"normal kernel read fault"?  Not sure !PROT and/or KERNEL are needed,
but getting at least "PROT READ" seems useful.

	errstr(!error_code, errtxt, X86_PF_PROT, "!PROT");
	errstr(!error_code, errtxt, X86_PF_USER, "KERNEL");
	errstr(!error_code, errtxt, X86_PF_WRITE | X86_PF_INSTR, "READ");

And change the pr_alert to "HW error code:"?

The original is confusing (to me) because "HW error: normal kernel read fault"
obfuscates the fact that we're printing the #PF error code, i.e. it looks
like an arbitrary kernel message.


This:

    HW error code: !PROT KERNEL READ
    This was a system access from user code

or:

    HW error code: !PROT READ
    This was a system access from user code

or:

    HW error code: KERNEL READ
    This was a system access from user code

or:
    HW error code: READ
    This was a system access from user code

are all less confusing IMO.

> +	if (!(error_code & X86_PF_USER) && user_mode(regs)) {
> +		struct desc_ptr idt, gdt;
> +		u16 ldtr, tr;
> +
> +		pr_alert("This was a system access from user code\n");
> +
> +		/*
> +		 * This can happen for quite a few reasons.  The more obvious
> +		 * ones are faults accessing the GDT, or LDT.  Perhaps
> +		 * surprisingly, if the CPU tries to deliver a benign or
> +		 * contributory exception from user code and gets a page fault
> +		 * during delivery, the page fault can be delivered as though
> +		 * it originated directly from user code.  This could happen
> +		 * due to wrong permissions on the IDT, GDT, LDT, TSS, or
> +		 * kernel or IST stack.
> +		 */
> +		store_idt(&idt);
> +
> +		/* Usable even on Xen PV -- it's just slow. */
> +		native_store_gdt(&gdt);
> +
> +		pr_alert("IDT: 0x%lx (limit=0x%hx) GDT: 0x%lx (limit=0x%hx)\n",
> +			 idt.address, idt.size, gdt.address, gdt.size);
> +
> +		store_ldt(ldtr);
> +		show_ldttss(&gdt, "LDTR", ldtr);
> +
> +		store_tr(tr);
> +		show_ldttss(&gdt, "TR", tr);
> +	}
> +
>  	dump_pagetable(address);
>  }
>  
> -- 
> 2.17.2
> 
