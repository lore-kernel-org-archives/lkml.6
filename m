Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F00C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41CF20870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="lxurE+0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfBAKek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:34:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40983 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbfBAKej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:34:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so2982243pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 02:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MwEByZiDstjswAiVPqKBuWPUuNdXIIUTWPCsHvNnsgQ=;
        b=lxurE+0d/HuwNsihbUmsKo/5+uyBw1WrZoQ/OWVY6w42oG3Mrvk290SyYA0DE8Nv8Z
         BSQuIrAErWxumDuy9NoCKofY6/7lkvlspZrUmaSxoI7IhQfeld0H/2eG1zEE5JR6LYPF
         NJ7dEoREWek+42u2ghq6RxkFgS+leTjjJvWAweDMIEBVJ7xqXsGlDGoq7ceob3bTrmLz
         OAriQyj+hqg351ZdLK6AYdyoV4YpIjwYyz4cBkyjkTwKV3U7n/6fKoKoyEySsm1Wtvlc
         CP8tsl48hSub9P2cix5vlWplIN4PA8mXcx21nPI2v/ywZpAKkaqjrA0M4zLVFsczuDKV
         KAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MwEByZiDstjswAiVPqKBuWPUuNdXIIUTWPCsHvNnsgQ=;
        b=EyzKIP6NWmkprFikx285UpO6joq70IVQVI50U3edaY0tvOIRt7Ins47eQwSWraGBAI
         TLt6peJ6Gx/SCvBIiG6j0kFKKdrmIbM6qnsxomvV/Z0xjr7ctmBt17Hoa6pTDz8n6+5J
         S5XST2iY1yA79Zw6Fr7L6dbhzDyg9kabdOccxFuw+wvaHuyOv80aPDXulmsOR45ufSFa
         n48LnPvShRqn+wDs6LuqvtKJ3REAxPcZuGg+DbB+rBX/cMJJ6bpxCodgOY5mN9vJHmOX
         s+cDp36ZMswaHq5d9LdIO/2v5v2YqeHIXg7UAlO1nreRjclh1NCWICtsKKPZkVWQBUf/
         u1Hw==
X-Gm-Message-State: AJcUukcNxkPv3Kwtw3459ZOcbD2rl+NFtkzOjW5D1k9GJBnFJGa7bddj
        4AzUvqzKQM+N/dDBxLq6dILWNVdeIt0=
X-Google-Smtp-Source: ALg8bN6E0h4G48svLC7G/NfpXnrZZqb5wf8jrrrAU4BlQ/TxjgLgVl968ytvFzjYtRtRA0SMR1TK4A==
X-Received: by 2002:a62:8096:: with SMTP id j144mr39299511pfd.140.1549017278215;
        Fri, 01 Feb 2019 02:34:38 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id c7sm23395424pfh.18.2019.02.01.02.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 02:34:37 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 2284B30A67B; Fri,  1 Feb 2019 13:34:33 +0300 (+03)
Date:   Fri, 1 Feb 2019 13:34:33 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org, eranian@google.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        luto@amacapital.net, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH V4 01/13] perf/core, x86: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20190201103433.5clveqiciw2m2emb@kshutemo-mobl1>
References: <1548966486-49963-1-git-send-email-kan.liang@linux.intel.com>
 <20190201092240.GB31498@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201092240.GB31498@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 10:22:40AM +0100, Peter Zijlstra wrote:
> On Thu, Jan 31, 2019 at 12:27:54PM -0800, kan.liang@linux.intel.com wrote:
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 374a197..229a73b 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -2578,3 +2578,34 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
> >  	cap->events_mask_len	= x86_pmu.events_mask_len;
> >  }
> >  EXPORT_SYMBOL_GPL(perf_get_x86_pmu_capability);
> > +
> > +u64 perf_get_page_size(u64 virt)
> > +{
> > +	unsigned long flags;
> > +	unsigned int level;
> > +	pte_t *pte;
> > +
> > +	if (!virt)
> > +		return 0;
> > +
> > +	/*
> > +	 * Interrupts are disabled, so it prevents any tear down
> > +	 * of the page tables.
> > +	 * See the comment near struct mmu_table_batch.
> > +	 */
> > +	local_irq_save(flags);
> > +	if (virt >= TASK_SIZE)
> > +		pte = lookup_address(virt, &level);
> > +	else {
> > +		if (current->mm) {
> > +			pte = lookup_address_in_pgd(pgd_offset(current->mm, virt),
> > +						    virt, &level);
> > +		} else
> > +			level = PG_LEVEL_NUM;
> > +	}
> > +	local_irq_restore(flags);
> > +	if (level >= PG_LEVEL_NUM)
> > +		return 0;
> > +
> > +	return (u64)page_level_size(level);
> > +}
> 
> *sigh* there really isn't anything x86 specific there.
> 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 236bb8d..d233f45 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6352,6 +6358,12 @@ static u64 perf_virt_to_phys(u64 virt)
> >  	return phys_addr;
> >  }
> >  
> > +/* Return page size of given virtual address. IRQ-safe required. */
> > +u64 __weak perf_get_page_size(u64 virt)
> > +{
> > +	return 0;
> > +}
> > +
> >  static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
> >  
> >  struct perf_callchain_entry *
> 
> How about something like so instead?
> 
> (completely untested, will likely make your grandma eat puppies)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6357,10 +6357,72 @@ static u64 perf_virt_to_phys(u64 virt)
>  	return phys_addr;
>  }
>  
> -/* Return page size of given virtual address. IRQ-safe required. */
> -u64 __weak perf_get_page_size(u64 virt)
> +static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
>  {
> -	return 0;
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +
> +	pgd = pgd_offset(mm, addr);
> +	if (pgd_none(*pgd))
> +		return 0;
> +
> +	p4d = p4d_offset(pgd, addr);
> +	if (p4d_none(*p4d))
> +		return 0;
> +
> +	if (p4d_large(*p4d));

We dont have 512GiB pages yet.

> +		return 1ULL << P4D_SHIFT;

		return P4D_SIZE;

And the same P?D_SIZE below.

> +
> +	if (!p4d_present(*p4d))
> +		return 0;

No need to check p4d_none() *and* p4d_present(). Just p4d_present() should
be enough. Large is still suppose to be present. The same for other levels.

> +
> +	pud = pud_offset(p4d, addr);
> +	if (pud_none(*pud))
> +		return 0;
> +
> +	if (pud_large(*pud))
> +		return 1ULL << PUD_SHIFT;
> +
> +	if (!pud_present(*pud))
> +		return 0;
> +
> +	pmd = pmd_offset(pud, addr);
> +	if (pmd_none(*pmd))
> +		return 0;
> +
> +	if (pmd_large(*pmd))
> +		return 1ULL << PMD_SHIFT;
> +
> +	if (!pmd_present(*pmd))
> +		return 0;
> +
> +	return 1ULL << PAGE_SHIFT;
> +}
> +
> +static u64 perf_get_page_size(unsigned long addr)
> +{
> +	struct mm_struct *mm;
> +	unsigned long flags;
> +	u64 ret;
> +
> +	/*
> +	 * Software page-table walkers must disable IRQs, see asm-generic/tlb.h.
> +	 */
> +	local_irq_save(flags);
> +	mm = current->mm;
> +	if (!mm) {
> +		/*
> +		 * For kernel threads and the like, use init_mm so that
> +		 * we can find kernel memory.
> +		 */
> +		mm = &init_mm;
> +	}
> +	ret = __perf_get_page_size(mm, addr);
> +	local_irq_restore(flags);
> +
> +	return ret;
>  }
>  
>  static struct perf_callchain_entry __empty_callchain = { .nr = 0, };

-- 
 Kirill A. Shutemov
