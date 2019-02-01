Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A62C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916512086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fw7t1YDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfBAJWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:22:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBAJWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IwRy9cqrU4imPE1IYM0CS4sSigaQcqDsnbnAj26L0Jk=; b=Fw7t1YDrgiw+935NSPPYgaP9G
        xInznKZ31penVnQrMbBx2x2INLB6wmxzOFCxVHvd/AtZTwQPdULFN36WAR0IKSCfnGP3FsordQyVB
        fPMLCFOOIk1ToMe4u9TJ8OBPB5gLS4jO/3AK3c+c9ShlrncBK5Wjw4UhPwvLjpxZr1GFNJu0x07F3
        eIG0uW0jfISebJwbyYvw2eHbaSgdNYEsDEJTTaSQUvqcG/sY5B4Zl2GTxD6+LZHJbFntMSSvx+9Mf
        nct8aKpEUpZ0pm8hukTUWQoKtLF813cb6KO70ku7HwCcS97Fu06NH1QxNZHztR94jorAK0rCDrRZ7
        egKrYU0eQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpV22-0007wX-JX; Fri, 01 Feb 2019 09:22:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DA6B20423039; Fri,  1 Feb 2019 10:22:40 +0100 (CET)
Date:   Fri, 1 Feb 2019 10:22:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, luto@amacapital.net,
        Vlastimil Babka <vbabka@suse.cz>, kirill@shutemov.name
Subject: Re: [PATCH V4 01/13] perf/core, x86: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20190201092240.GB31498@hirez.programming.kicks-ass.net>
References: <1548966486-49963-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548966486-49963-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 12:27:54PM -0800, kan.liang@linux.intel.com wrote:
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 374a197..229a73b 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2578,3 +2578,34 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
>  	cap->events_mask_len	= x86_pmu.events_mask_len;
>  }
>  EXPORT_SYMBOL_GPL(perf_get_x86_pmu_capability);
> +
> +u64 perf_get_page_size(u64 virt)
> +{
> +	unsigned long flags;
> +	unsigned int level;
> +	pte_t *pte;
> +
> +	if (!virt)
> +		return 0;
> +
> +	/*
> +	 * Interrupts are disabled, so it prevents any tear down
> +	 * of the page tables.
> +	 * See the comment near struct mmu_table_batch.
> +	 */
> +	local_irq_save(flags);
> +	if (virt >= TASK_SIZE)
> +		pte = lookup_address(virt, &level);
> +	else {
> +		if (current->mm) {
> +			pte = lookup_address_in_pgd(pgd_offset(current->mm, virt),
> +						    virt, &level);
> +		} else
> +			level = PG_LEVEL_NUM;
> +	}
> +	local_irq_restore(flags);
> +	if (level >= PG_LEVEL_NUM)
> +		return 0;
> +
> +	return (u64)page_level_size(level);
> +}

*sigh* there really isn't anything x86 specific there.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 236bb8d..d233f45 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6352,6 +6358,12 @@ static u64 perf_virt_to_phys(u64 virt)
>  	return phys_addr;
>  }
>  
> +/* Return page size of given virtual address. IRQ-safe required. */
> +u64 __weak perf_get_page_size(u64 virt)
> +{
> +	return 0;
> +}
> +
>  static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
>  
>  struct perf_callchain_entry *

How about something like so instead?

(completely untested, will likely make your grandma eat puppies)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6357,10 +6357,72 @@ static u64 perf_virt_to_phys(u64 virt)
 	return phys_addr;
 }
 
-/* Return page size of given virtual address. IRQ-safe required. */
-u64 __weak perf_get_page_size(u64 virt)
+static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
 {
-	return 0;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pgd = pgd_offset(mm, addr);
+	if (pgd_none(*pgd))
+		return 0;
+
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d))
+		return 0;
+
+	if (p4d_large(*p4d));
+		return 1ULL << P4D_SHIFT;
+
+	if (!p4d_present(*p4d))
+		return 0;
+
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud))
+		return 0;
+
+	if (pud_large(*pud))
+		return 1ULL << PUD_SHIFT;
+
+	if (!pud_present(*pud))
+		return 0;
+
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd))
+		return 0;
+
+	if (pmd_large(*pmd))
+		return 1ULL << PMD_SHIFT;
+
+	if (!pmd_present(*pmd))
+		return 0;
+
+	return 1ULL << PAGE_SHIFT;
+}
+
+static u64 perf_get_page_size(unsigned long addr)
+{
+	struct mm_struct *mm;
+	unsigned long flags;
+	u64 ret;
+
+	/*
+	 * Software page-table walkers must disable IRQs, see asm-generic/tlb.h.
+	 */
+	local_irq_save(flags);
+	mm = current->mm;
+	if (!mm) {
+		/*
+		 * For kernel threads and the like, use init_mm so that
+		 * we can find kernel memory.
+		 */
+		mm = &init_mm;
+	}
+	ret = __perf_get_page_size(mm, addr);
+	local_irq_restore(flags);
+
+	return ret;
 }
 
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
