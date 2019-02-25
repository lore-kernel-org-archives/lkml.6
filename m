Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A15C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B342147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="E+C+dj8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfBYMb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:31:57 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33125 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfBYMb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:31:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id h11so4455509pgl.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 04:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W4pYAX7xbHcDiiYh3ubJFH8H1j5DbOD4geOT+SnaXBc=;
        b=E+C+dj8NCm5/W1jAibgTQZwN01T4vLqzwv5mn7K4CaO33xHtonM0fv9J9BhmzHBlj+
         1fhNz84LQv1eLAZu8Ar2TDhOw4JXa+Hz4dJeCFW+5VZxaWAP4Yadn9ErukZEG5NOHhV3
         FathJI7l4kkCBx8QUUJiqdsXnixJ5bbA68u08OLGvOTghWz0jzQzhoidyXWPOLlClvPr
         IK9QYFAz1PdgQrkB1oVajLVluPGTKp6CvpdNT7taald3fvshAuZiULo0AXXEuA8UzvpG
         EZlZLgZQr/3b2CcwMcYKWLu/iNO6oNf3usOnEQoEYXf0C6fa57Kb/8cnkq0sxEJpBHYw
         qiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W4pYAX7xbHcDiiYh3ubJFH8H1j5DbOD4geOT+SnaXBc=;
        b=EpIpb1S60lBdbmPzQ734cWwNQZql+bnjjvOyJ1y/K2lAMjWImPByY84Qsxj4ti080G
         2m01njBnY93XymakZ6wfYX74eqpehG6MG3ViVmtvun5wzmuv8On4S5MSeqJkqA3fiRL5
         fGiJMue1pMFnuWeJ1iExKiKYMOELHBxQE4A89wQDyJUDllKwJNjW4Xiq98FRlE6X36Ye
         X04OfW4c6EwssEDx5BhjBpPzM3AZkYwygRuWouzaIPcCPTRS9Lyz0qUlmIJDsN+QfqCO
         tIOsSNIdv9TGThK5UIvJeqJd5VA5KWkd7cMqxvuXfxcsFkiSxa1+4UZ2k5zxq9JwUivg
         3qlg==
X-Gm-Message-State: AHQUAuanVNVd2xT39LIBNpU1TSlUrXITuuRVIUVByalRtE+QtjrBXEwp
        cKi8OlC0EjFfRu3BzBjgZo8nkE1hKq4cCw==
X-Google-Smtp-Source: AHgI3IaNIBdexw+dLYpm8JBK8RAkN5rhUIr/eolyGgOac9vs6cV5FzEE0tmdJfwU7L7vV8/rkV4+yQ==
X-Received: by 2002:a62:cf81:: with SMTP id b123mr20515901pfg.29.1551097915410;
        Mon, 25 Feb 2019 04:31:55 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id v12sm7022475pfn.25.2019.02.25.04.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 04:31:54 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id C23B3301717; Mon, 25 Feb 2019 15:31:50 +0300 (+03)
Date:   Mon, 25 Feb 2019 15:31:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kirill.shutemov@linux.intel.com, keescook@chromium.org,
        thgarnie@google.com
Subject: Re: [PATCH 1/2] x86/mm/KASLR: Only build one PUD entry of area for
 real mode trampoline
Message-ID: <20190225123150.muyzsycmyrbimzqd@kshutemo-mobl1>
References: <20190224132231.4878-1-bhe@redhat.com>
 <20190224132231.4878-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224132231.4878-2-bhe@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 09:22:30PM +0800, Baoquan He wrote:
> The current code builds identity mapping for real mode treampoline by
> borrowing page tables from the direct mapping section if KASLR is
> enabled. It will copy present entries of the first PUD table in 4-level
> paging mode, or the first P4D table in 5-level paging mode.
> 
> However, there's only a very small area under low 1 MB reserved
> for real mode trampoline in reserve_real_mode(). Makes no sense
> to build up so large area of mapping for it. Since the randomization
> granularity in 4-level is 1 GB, and 512 GB in 5-level, only copying
> one PUD entry is enough.

Can we get more of this info into comments in code?

> Hence, only copy one PUD entry of area where physical address 0
> resides. And this is preparation for later changing the randomization
> granularity of 5-level paging mode from 512 GB to 1 GB.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/mm/kaslr.c | 72 ++++++++++++++++++---------------------------
>  1 file changed, 28 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 754b5da91d43..6b2a06c36b6f 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -226,74 +226,58 @@ void __init kernel_randomize_memory(void)
>  
>  static void __meminit init_trampoline_pud(void)
>  {
> -	unsigned long paddr, paddr_next;
> +	unsigned long paddr, vaddr;
>  	pgd_t *pgd;
> -	pud_t *pud_page, *pud_page_tramp;
> -	int i;
>  
> +	p4d_t *p4d_page, *p4d_page_tramp, *p4d, *p4d_tramp;
> +	pud_t *pud_page, *pud_page_tramp, *pud, *pud_tramp;
> +
> +
> +	p4d_page_tramp = alloc_low_page();

I believe this line should be under

	if (pgtable_l5_enabled()) {

Right?

>  	pud_page_tramp = alloc_low_page();
>  
>  	paddr = 0;
> +	vaddr = (unsigned long)__va(paddr);
>  	pgd = pgd_offset_k((unsigned long)__va(paddr));
> -	pud_page = (pud_t *) pgd_page_vaddr(*pgd);
>  
> -	for (i = pud_index(paddr); i < PTRS_PER_PUD; i++, paddr = paddr_next) {
> -		pud_t *pud, *pud_tramp;
> -		unsigned long vaddr = (unsigned long)__va(paddr);
> +	if (pgtable_l5_enabled()) {
> +		p4d_page = (p4d_t *) pgd_page_vaddr(*pgd);
> +		p4d = p4d_page + p4d_index(vaddr);
>  
> -		pud_tramp = pud_page_tramp + pud_index(paddr);
> +		pud_page = (pud_t *) p4d_page_vaddr(*p4d);
>  		pud = pud_page + pud_index(vaddr);
> -		paddr_next = (paddr & PUD_MASK) + PUD_SIZE;
> -
> -		*pud_tramp = *pud;
> -	}
> -
> -	set_pgd(&trampoline_pgd_entry,
> -		__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
> -}
> -
> -static void __meminit init_trampoline_p4d(void)
> -{
> -	unsigned long paddr, paddr_next;
> -	pgd_t *pgd;
> -	p4d_t *p4d_page, *p4d_page_tramp;
> -	int i;
>  
> -	p4d_page_tramp = alloc_low_page();
> +		p4d_tramp = p4d_page_tramp + p4d_index(paddr);
> +		pud_tramp = pud_page_tramp + pud_index(paddr);
>  
> -	paddr = 0;
> -	pgd = pgd_offset_k((unsigned long)__va(paddr));
> -	p4d_page = (p4d_t *) pgd_page_vaddr(*pgd);
> +		*pud_tramp = *pud;
>  
> -	for (i = p4d_index(paddr); i < PTRS_PER_P4D; i++, paddr = paddr_next) {
> -		p4d_t *p4d, *p4d_tramp;
> -		unsigned long vaddr = (unsigned long)__va(paddr);
> +		set_p4d(p4d_tramp,
> +			__p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));
>  
> -		p4d_tramp = p4d_page_tramp + p4d_index(paddr);
> -		p4d = p4d_page + p4d_index(vaddr);
> -		paddr_next = (paddr & P4D_MASK) + P4D_SIZE;
> +		set_pgd(&trampoline_pgd_entry,
> +			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
> +	} else {
> +		pud_page = (pud_t *) pgd_page_vaddr(*pgd);
> +		pud = pud_page + pud_index(vaddr);
>  
> -		*p4d_tramp = *p4d;
> +		pud_tramp = pud_page_tramp + pud_index(paddr);
> +		*pud_tramp = *pud;
> +		set_pgd(&trampoline_pgd_entry,
> +			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
>  	}
> -
> -	set_pgd(&trampoline_pgd_entry,
> -		__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
>  }
>  
>  /*
> - * Create PGD aligned trampoline table to allow real mode initialization
> - * of additional CPUs. Consume only 1 low memory page.
> + * Create PUD aligned trampoline table to allow real mode initialization
> + * of additional CPUs. Consume only 1 or 2 low memory pages.
>   */
>  void __meminit init_trampoline(void)
>  {
> -
>  	if (!kaslr_memory_enabled()) {
>  		init_trampoline_default();
>  		return;
>  	}
>  
> -	if (pgtable_l5_enabled())
> -		init_trampoline_p4d();
> -	else
> -		init_trampoline_pud();
> +	init_trampoline_pud();
>  }
> -- 
> 2.17.2
> 

-- 
 Kirill A. Shutemov
