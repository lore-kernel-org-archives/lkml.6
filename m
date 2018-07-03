Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF80C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AB520840
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AB520840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbeGCN5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:57:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43989 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753200AbeGCN5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:57:43 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faLo7-00026a-EG; Tue, 03 Jul 2018 15:57:27 +0200
Date:   Tue, 3 Jul 2018 15:57:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bin Yang <bin.yang@intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/mm: fix cpu stuck issue in
 __change_page_attr_set_clr
In-Reply-To: <1530180340-18593-1-git-send-email-bin.yang@intel.com>
Message-ID: <alpine.DEB.2.21.1807031442030.1601@nanos.tec.linutronix.de>
References: <1530180340-18593-1-git-send-email-bin.yang@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bin,

On Thu, 28 Jun 2018, Bin Yang wrote:

thanks for submitting this.

>     This issue can be easily triggered by free_initmem() functuion on
>     x86_64 cpu.

Please do not use the output of git show for submitting a patch. Use git
format-patch(1).

>     If cpu supports "pdpe1gb", kernel will try to use 1G large page.
>     In worst case, it needs to check every 4K page in 1G range in
>     try_preserve_large_page function. If __change_page_attr_set_clr
>     needs to change lots of 4K pages, cpu will be stuck for long time.

Unfortunately you missed to describe what the actual interface function is
which is called from a driver or whatever, including the parameters.

> @@ -552,16 +552,20 @@ static int
>  try_preserve_large_page(pte_t *kpte, unsigned long address,
>  			struct cpa_data *cpa)
>  {
> +	static unsigned long address_cache;
> +	static unsigned long do_split_cache = 1;

What are the life time and protection rules of these static variables and
why are they static in the first place.

>  	unsigned long nextpage_addr, numpages, pmask, psize, addr, pfn, old_pfn;
>  	pte_t new_pte, old_pte, *tmp;
>  	pgprot_t old_prot, new_prot, req_prot;
>  	int i, do_split = 1;
>  	enum pg_level level;
>  
> -	if (cpa->force_split)
> +	spin_lock(&pgd_lock);
> +	if (cpa->force_split) {
> +		do_split_cache = 1;

Returns with pgd_lock held which will immediately lockup the system on the
next spin_lock(&pgd_lock) operation.

Also what's the point of storing the already available information of
cpa->force_split in yet another variable? This enforces taking the lock on
every invocation for no reason.

>  		return 1;
> +	}
>  
> -	spin_lock(&pgd_lock);
>  	/*
>  	 * Check for races, another CPU might have split this page
>  	 * up already:
> @@ -627,13 +631,25 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
>  
>  	new_prot = static_protections(req_prot, address, pfn);
>  
> +	addr = address & pmask;
> +	pfn = old_pfn;
> +	/*
> +	 * If an address in same range had been checked just now, re-use the
> +	 * cache value without full range check. In the worst case, it needs to
> +	 * check every 4K page in 1G range, which causes cpu stuck for long
> +	 * time.
> +	 */
> +	if (!do_split_cache &&
> +	    address_cache >= addr && address_cache < nextpage_addr &&

On the first call, address_cache contains 0. On any subsequent call
address_caches contains the address of the previous invocation of
try_preserve_large_page().

But addr = address & pmask! So you are comparing apples and oranges. Not
sure how that is supposed to work correctly.

> +	    pgprot_val(new_prot) == pgprot_val(old_prot)) {
> +		do_split = do_split_cache;

This is an very obscure way to write:

   	        do_split = 0;

because do_split_cache must be 0 otherwise it cannot reach that code path.

> +		goto out_unlock;
> +	}
>  	/*
>  	 * We need to check the full range, whether
>  	 * static_protection() requires a different pgprot for one of
>  	 * the pages in the range we try to preserve:
>  	 */
> -	addr = address & pmask;
> -	pfn = old_pfn;
>  	for (i = 0; i < (psize >> PAGE_SHIFT); i++, addr += PAGE_SIZE, pfn++) {
>  		pgprot_t chk_prot = static_protections(req_prot, addr, pfn);
>  
> @@ -670,6 +686,8 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
>  	}
>  
>  out_unlock:
> +	address_cache = address;
> +	do_split_cache = do_split;
>  	spin_unlock(&pgd_lock);

So here you store the 'cache' values and while this code suggests that it
protects the 'cache' via pgd_lock (due to lack of comments), the protection
is actually cpa_lock.

But, that cache information stays around when cpa_lock is dropped,
i.e. when the current (partial) operation has been done and this
information stays stale for the next user. That does not make sense.

I'm still puzzled how that can ever happen at all and which problem you are
trying to solve.

The first invocation of try_to_preserve_large_page() will either preserve
the 1GB page and consume the number of 4K pages which fit into it, or it
splits it into 2M chunks and tries again. The retry will either preserve
the 2M chunk and and consume the number of 4K pages which fit into it, or
it splits it into 4K pages. Once split into 4K, subsequent invocations will
return before reaching the magic cache checks.

Can you please describe the call chain, the driver facing function used and
the parameters which are handed in?

Thanks,

	tglx






