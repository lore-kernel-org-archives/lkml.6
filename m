Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C04C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3040F20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oHUFv0BO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3040F20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeICMya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:54:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34678 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeICMy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8lQVV6BgBneRbh6weoRWgGuOx3KFs5swKmFPHzGdnb4=; b=oHUFv0BOqfvz/N1h/4OTpFE2q
        VZvCUjsfSfTsYwqovIYX83UfXtKIuFn4o70FwEv4RjZo+LE+SJUknwlH7FLSGX8JaO/tDVq0UU3L1
        L3VpFo8UAs92ChMfJagPG/6O4aHri7tpxq4ynqxca86WLRMTeT9s9dHJ47wEqTo7thgESll5Hpmni
        60fVbLzOxfEphZp7FA9z4raLAjJyX+bAbIOJ34c9r3wtBeUWQsSlqODpS1fk5j2mMVSChpEQL6e0m
        FKrBb/LcKILFcPxGWOV+TEcJ03dB2yI60Yk8eAHqHIY7TR1gf85aAsJ5vpHiF/70Bwg6n9G69bdJG
        xFlwOc3Tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwkK5-0006az-5g; Mon, 03 Sep 2018 08:35:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7B22205F8650; Mon,  3 Sep 2018 10:34:59 +0200 (CEST)
Date:   Mon, 3 Sep 2018 10:34:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ricardo.neri@intel.com, matt@codeblueprint.co.uk,
        Lee Chun-Yi <jlee@suse.com>, Al Stone <astone@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 5/6] x86/mm: If in_atomic(), allocate pages without
 sleeping
Message-ID: <20180903083459.GT24124@hirez.programming.kicks-ass.net>
References: <1535881594-25469-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1535881594-25469-6-git-send-email-sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535881594-25469-6-git-send-email-sai.praneeth.prakhya@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2018 at 02:46:33AM -0700, Sai Praneeth Prakhya wrote:
> From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
> 
> A page fault occurs when any EFI Runtime Service tries to reference a
> memory region which it shouldn't. If the illegally accessed region
> is EFI_BOOT_SERVICES_<CODE/DATA>, the efi specific page fault handler
> fixes it up by dynamically creating VA->PA mappings using
> efi_map_region().
> 
> Originally, efi_map_region() and hence the functionality of creating
> mappings for efi regions was intended to be used *only* during boot time
> (please note __init modifier) and hence when called during runtime (i.e.
> from efi page fault handler), the page allocators complain. Calling
> efi_map_region() during runtime complains because "gfp_allowed_mask"
> value changes from boot time to runtime (GFP_BOOT_MASK to
> __GFP_BITS_MASK). During boot, even though efi_map_region() calls
> alloc_<pte/pmd>_page with GFP_KERNEL, the page allocator doesn't
> complain because "__GFP_RECLAIM" flag is cleared by "gfp_allowed_mask",
> but during runtime it isn't cleared and hence prints below stack trace.
> 
> BUG: sleeping function called from invalid context at mm/page_alloc.c:4320

> get_zeroed_page+0x12/0x40
> alloc_pmd_page+0x13/0x50
> populate_pmd+0xc0/0x2e0
> __cpa_process_fault+0x2e1/0x5d0
> __change_page_attr_set_clr+0x7c3/0xcd0
> kernel_map_pages_in_pgd+0x8c/0x160
> __map_region+0x3c/0x60
> efi_map_region+0x83/0xd0
> efi_illegal_accesses_fixup+0x1ca/0x1e0
> no_context+0x112/0x390
> __do_page_fault+0xc7/0x4f0

> Fix the above warning by conditionally changing the allocation from
> GFP_KERNEL to GFP_ATOMIC, so that efi page fault handler could use
> efi_map_region() during runtime. This change shouldn't effect any other
> generic page allocations because this allocation is used only by efi
> functions [1].

> diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> index 3bded76e8d5c..1b28a333c8ce 100644
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -926,7 +926,13 @@ static void unmap_pud_range(p4d_t *p4d, unsigned long start, unsigned long end)
>  
>  static int alloc_pte_page(pmd_t *pmd)
>  {
> -	pte_t *pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
> +	pte_t *pte;
> +
> +	if (in_atomic())
> +		pte = (pte_t *)get_zeroed_page(GFP_ATOMIC);
> +	else
> +		pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
> +
>  	if (!pte)
>  		return -1;
>  

This looks like tinkering to me..
