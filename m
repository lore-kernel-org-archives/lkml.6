Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED4DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5809E2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="iAxhA6B7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5809E2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbeKLGB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:01:26 -0500
Received: from st13p15im-asmtp003.me.com ([17.164.72.57]:59045 "EHLO
        st13p15im-asmtp003.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeKLGBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:01:24 -0500
X-Greylist: delayed 3614 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Nov 2018 01:01:23 EST
Received: from process-dkim-sign-daemon.st13p15im-asmtp003.me.com by
 st13p15im-asmtp003.me.com
 (Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built May 31
 2018)) id <0PI100Z00MGVL800@st13p15im-asmtp003.me.com> for
 linux-kernel@vger.kernel.org; Sun, 11 Nov 2018 19:11:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;     s=04042017;
 t=1541963508;  bh=H7Frku9R4zv02TfxEkiIiYpj1gRppdQqsK+dvbjpF5I=;
        h=Date:From:To:Subject:Message-id:MIME-version:Content-type;
        b=iAxhA6B7+HphQqfNQ5U0TqVWsfyKYyulCJuGx2uNcP7GG7wDIiIpHHsuqQET/qXZW
 CNq12kQ8uRwcVJ8KHKqyD+OAJ3VHz0/3p7FtfoBz4lkvTjTlP08bJRjbLXInYTxePj
 /P2H/B8bZX4Os8DqLqIiqByITRbAnVyRVfEfkcNPv1Ha+LGn2raYhPxgbbBTKH1r1E
 jJaN22nAWIECptelY1frItLTLQ4cfRywrPLKjMLB2e9U0YuVYo1DWJXiSAYEsIIZt5
 J1yqSOl+pnw3OhODyLSBK7REb7JVVoW2GIIbyS9jdQLT8qbBw9yVuRKJiBHJHyN+YC
 kysks/0+ZYx6w==
Received: from icloud.com ([127.0.0.1]) by st13p15im-asmtp003.me.com
 (Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built May 31
 2018)) with ESMTPSA id <0PI10109XMNIAK00@st13p15im-asmtp003.me.com>; Sun,
 11 Nov 2018 19:11:47 +0000 (GMT)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811110183
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2018-11-11_13:,, signatures=0
Date:   Sun, 11 Nov 2018 20:11:42 +0100
From:   Damian Tometzki <linux_dti@icloud.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 06/10] x86/alternative: use temporary mm for text poking
Message-id: <20181111191141.GA1996@Ubuntu-DTI>
Mail-followup-to: Nadav Amit <namit@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>,
 Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <20181110231732.15060-1-namit@vmware.com>
 <20181110231732.15060-7-namit@vmware.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-disposition: inline
Content-transfer-encoding: 8bit
In-reply-to: <20181110231732.15060-7-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sa, 10. Nov 15:17, Nadav Amit wrote:
> text_poke() can potentially compromise the security as it sets temporary
> PTEs in the fixmap. These PTEs might be used to rewrite the kernel code
> from other cores accidentally or maliciously, if an attacker gains the
> ability to write onto kernel memory.
> 
> Moreover, since remote TLBs are not flushed after the temporary PTEs are
> removed, the time-window in which the code is writable is not limited if
> the fixmap PTEs - maliciously or accidentally - are cached in the TLB.
> To address these potential security hazards, we use a temporary mm for
> patching the code.
> 
> Finally, text_poke() is also not conservative enough when mapping pages,
> as it always tries to map 2 pages, even when a single one is sufficient.
> So try to be more conservative, and do not map more than needed.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/include/asm/fixmap.h |   2 -
>  arch/x86/kernel/alternative.c | 112 +++++++++++++++++++++++++++-------
>  2 files changed, 89 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
> index 50ba74a34a37..9da8cccdf3fb 100644
> --- a/arch/x86/include/asm/fixmap.h
> +++ b/arch/x86/include/asm/fixmap.h
> @@ -103,8 +103,6 @@ enum fixed_addresses {
>  #ifdef CONFIG_PARAVIRT
>  	FIX_PARAVIRT_BOOTMAP,
>  #endif

Hello Nadav,

with the remove of FIX_TEXT_POKE1 and FIX_TEXT_POKE0 i get the following
build error:

/home/damian/kernel/linux/arch/x86/xen/mmu_pv.c:2321:7: Fehler: »FIX_TEXT_POKE0« nicht deklariert (erstmalige Verwendung in dieser Funktion); meinten Sie »FIX_TBOOT_BASE«?
  case FIX_TEXT_POKE0:
       ^~~~~~~~~~~~~~
       FIX_TBOOT_BASE
/home/damian/kernel/linux/arch/x86/xen/mmu_pv.c:2321:7: Anmerkung: jeder nicht deklarierte Bezeichner wird nur einmal für jede Funktion, in der er vorkommt, gemeldet
/home/damian/kernel/linux/arch/x86/xen/mmu_pv.c:2322:7: Fehler: »FIX_TEXT_POKE1« nicht deklariert (erstmalige Verwendung in dieser Funktion); meinten Sie »FIX_TBOOT_BASE«?
  case FIX_TEXT_POKE1:
       ^~~~~~~~~~~~~~
       FIX_TBOOT_BASE

Best regards
Damian

> -	FIX_TEXT_POKE1,	/* reserve 2 pages for text_poke() */
> -	FIX_TEXT_POKE0, /* first page is last, because allocation is backward */
>  #ifdef	CONFIG_X86_INTEL_MID
>  	FIX_LNW_VRTC,
>  #endif
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index d3ae5c26e5a0..96607ef285c3 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -11,6 +11,7 @@
>  #include <linux/stop_machine.h>
>  #include <linux/slab.h>
>  #include <linux/kdebug.h>
> +#include <linux/mmu_context.h>
>  #include <asm/text-patching.h>
>  #include <asm/alternative.h>
>  #include <asm/sections.h>
> @@ -683,43 +684,108 @@ __ro_after_init unsigned long poking_addr;
>  
>  static int __text_poke(void *addr, const void *opcode, size_t len)
>  {
> +	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
> +	temporary_mm_state_t prev;
> +	struct page *pages[2] = {NULL};
>  	unsigned long flags;
> -	char *vaddr;
> -	struct page *pages[2];
> -	int i, r = 0;
> +	pte_t pte, *ptep;
> +	spinlock_t *ptl;
> +	int r = 0;
>  
>  	/*
> -	 * While boot memory allocator is runnig we cannot use struct
> -	 * pages as they are not yet initialized.
> +	 * While boot memory allocator is running we cannot use struct pages as
> +	 * they are not yet initialized.
>  	 */
>  	BUG_ON(!after_bootmem);
>  
>  	if (!core_kernel_text((unsigned long)addr)) {
>  		pages[0] = vmalloc_to_page(addr);
> -		pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
> +		if (cross_page_boundary)
> +			pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
>  	} else {
>  		pages[0] = virt_to_page(addr);
>  		WARN_ON(!PageReserved(pages[0]));
> -		pages[1] = virt_to_page(addr + PAGE_SIZE);
> +		if (cross_page_boundary)
> +			pages[1] = virt_to_page(addr + PAGE_SIZE);
>  	}
> -	if (!pages[0])
> +
> +	if (!pages[0] || (cross_page_boundary && !pages[1]))
>  		return -EFAULT;
> +
>  	local_irq_save(flags);
> -	set_fixmap(FIX_TEXT_POKE0, page_to_phys(pages[0]));
> -	if (pages[1])
> -		set_fixmap(FIX_TEXT_POKE1, page_to_phys(pages[1]));
> -	vaddr = (char *)fix_to_virt(FIX_TEXT_POKE0);
> -	memcpy(&vaddr[(unsigned long)addr & ~PAGE_MASK], opcode, len);
> -	clear_fixmap(FIX_TEXT_POKE0);
> -	if (pages[1])
> -		clear_fixmap(FIX_TEXT_POKE1);
> -	local_flush_tlb();
> -	sync_core();
> -	/* Could also do a CLFLUSH here to speed up CPU recovery; but
> -	   that causes hangs on some VIA CPUs. */
> -	for (i = 0; i < len; i++)
> -		if (((char *)addr)[i] != ((char *)opcode)[i])
> -			r = -EFAULT;
> +
> +	/*
> +	 * The lock is not really needed, but this allows to avoid open-coding.
> +	 */
> +	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
> +
> +	/*
> +	 * If we failed to allocate a PTE, fail. This should *never* happen,
> +	 * since we preallocate the PTE.
> +	 */
> +	if (WARN_ON_ONCE(!ptep))
> +		goto out;
> +
> +	pte = mk_pte(pages[0], PAGE_KERNEL);
> +	set_pte_at(poking_mm, poking_addr, ptep, pte);
> +
> +	if (cross_page_boundary) {
> +		pte = mk_pte(pages[1], PAGE_KERNEL);
> +		set_pte_at(poking_mm, poking_addr + PAGE_SIZE, ptep + 1, pte);
> +	}
> +
> +	/*
> +	 * Loading the temporary mm behaves as a compiler barrier, which
> +	 * guarantees that the PTE will be set at the time memcpy() is done.
> +	 */
> +	prev = use_temporary_mm(poking_mm);
> +
> +	kasan_disable_current();
> +	memcpy((u8 *)poking_addr + offset_in_page(addr), opcode, len);
> +	kasan_enable_current();
> +
> +	/*
> +	 * Ensure that the PTE is only cleared after the instructions of memcpy
> +	 * were issued by using a compiler barrier.
> +	 */
> +	barrier();
> +
> +	pte_clear(poking_mm, poking_addr, ptep);
> +
> +	/*
> +	 * __flush_tlb_one_user() performs a redundant TLB flush when PTI is on,
> +	 * as it also flushes the corresponding "user" address spaces, which
> +	 * does not exist.
> +	 *
> +	 * Poking, however, is already very inefficient since it does not try to
> +	 * batch updates, so we ignore this problem for the time being.
> +	 *
> +	 * Since the PTEs do not exist in other kernel address-spaces, we do
> +	 * not use __flush_tlb_one_kernel(), which when PTI is on would cause
> +	 * more unwarranted TLB flushes.
> +	 *
> +	 * There is a slight anomaly here: the PTE is a supervisor-only and
> +	 * (potentially) global and we use __flush_tlb_one_user() but this
> +	 * should be fine.
> +	 */
> +	__flush_tlb_one_user(poking_addr);
> +	if (cross_page_boundary) {
> +		pte_clear(poking_mm, poking_addr + PAGE_SIZE, ptep + 1);
> +		__flush_tlb_one_user(poking_addr + PAGE_SIZE);
> +	}
> +
> +	/*
> +	 * Loading the previous page-table hierarchy requires a serializing
> +	 * instruction that already allows the core to see the updated version.
> +	 * Xen-PV is assumed to serialize execution in a similar manner.
> +	 */
> +	unuse_temporary_mm(prev);
> +
> +	pte_unmap_unlock(ptep, ptl);
> +out:
> +	if (memcmp(addr, opcode, len))
> +		r = -EFAULT;
> +
>  	local_irq_restore(flags);
>  	return r;
>  }
> -- 
> 2.17.1
> 
