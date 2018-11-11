Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F6BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2AC214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FqzUe5cu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2AC214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeKLAcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 19:32:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33038 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbeKLAcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 19:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gj1P1RQgOjTgsugLOE7R7BUL5Ok02AgJYAV8aEcJDho=; b=FqzUe5cuDuN+McQZasYLlldtQ
        ZXz2tGKzxU0G20iMQfYMUux+e2xeSpCfnyKrRvNsIkHGNToNb+Fbty7tV8M+JVkNXqlN70FRehEke
        BaXqfAPysBQCQ1jvZ/qQTym+6mmPPdf5J+IbfsArq/NfdN49lGWzAupu1mpACievYQWjEaBAPh80o
        FtOgTusv9lADFDIZcJfycJ2A0GQe7xCzLIKasqfSo3ibwhXDPUqgzsGSWkal5XnouzomxTVeGI5mx
        N88Gf9CRr2aENQX8bEBdmlstyVbh1/wA19QtjLA7iM097hviH/R2jlvHBZp4Pk9zB19ReZtzLFifl
        NxWd1qPPA==;
Received: from [64.114.255.114] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLqxT-00058A-9y; Sun, 11 Nov 2018 14:43:27 +0000
Received: by worktop (Postfix, from userid 1000)
        id 18C826E07F4; Sun, 11 Nov 2018 15:43:27 +0100 (CET)
Date:   Sun, 11 Nov 2018 15:43:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/10] x86/alternative: initializing temporary mm for
 patching
Message-ID: <20181111144327.GG12766@worktop.psav.com>
References: <20181110231732.15060-1-namit@vmware.com>
 <20181110231732.15060-6-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110231732.15060-6-namit@vmware.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I don't seem to have gotten patches 0-2,7 for some reason; I'll try and
dig them out of the LKML folder.

On Sat, Nov 10, 2018 at 03:17:27PM -0800, Nadav Amit wrote:
> +void __init poking_init(void)
> +{
> +	spinlock_t *ptl;
> +	pte_t *ptep;
> +
> +	poking_mm = copy_init_mm();
> +	if (!poking_mm) {
> +		pr_err("x86/mm: error setting a separate poking address space");
> +		return;
> +	}
> +
> +	/*
> +	 * Randomize the poking address, but make sure that the following page
> +	 * will be mapped at the same PMD. We need 2 pages, so find space for 3,
> +	 * and adjust the address if the PMD ends after the first one.
> +	 */
> +	poking_addr = TASK_UNMAPPED_BASE +
> +		(kaslr_get_random_long("Poking") & PAGE_MASK) %
> +		(TASK_SIZE - TASK_UNMAPPED_BASE - 3 * PAGE_SIZE);
> +
> +	if (((poking_addr + PAGE_SIZE) & ~PMD_MASK) == 0)
> +		poking_addr += PAGE_SIZE;
> +
> +	/*
> +	 * We need to trigger the allocation of the page-tables that will be
> +	 * needed for poking now. Later, poking may be performed in an atomic
> +	 * section, which might cause allocation to fail.
> +	 */
> +	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
> +	if (!WARN_ON(!ptep))
> +		pte_unmap_unlock(ptep, ptl);
> +}

The difference in how we deal with -ENOMEM here is weird. I think we
have a _lot_ of code that simply hard assumes we don't fail memory alloc
on init.

I for instance would not mind to simply remove both branches and let the
kernel crash and burn if we ever fail here.
