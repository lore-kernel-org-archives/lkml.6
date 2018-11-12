Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0888CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCA220866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aPg4A5il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCA220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbeKLKYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:24:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeKLKYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 05:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/CsDxASX/xWQbwdXl5IiplVTXHdEVTx3byb4PI8F+9U=; b=aPg4A5ilBc3EH2O+/m73a6KLWc
        ++5IdH3cEo+Jzut/oMukYFOnv/0PKAzWHDMkoplFHjo4ZzD8+lh3/vksv9MNzfORm/X791Eoc9I+/
        JiKpBF43tksuI7d4p1Lk6IGVYdoHuNmuIYFIzA8FeNzszSvQhAYGQb7jqz/d1XtebQ/adv12qEB0m
        KCski0wR3ynlPcbcmxCXLO8ygVhkzG6K5MpQoU1NdbagrB3NrUeEZ7rjZKEYui28qSuf4dyOt0plh
        L196zbMy8YIQ2bswMspYxaVK5T24Os0QTXJEdJ2eChMCnR21Ja4wmRL/N8yb8Xklsq88BbWYW9gRR
        i8ytl5mQ==;
Received: from [64.114.255.97] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gM0BC-0004ho-9o; Mon, 12 Nov 2018 00:34:14 +0000
Received: by worktop (Postfix, from userid 1000)
        id E28636E061A; Mon, 12 Nov 2018 01:34:13 +0100 (CET)
Date:   Mon, 12 Nov 2018 01:34:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/10] x86/alternative: initializing temporary mm for
 patching
Message-ID: <20181112003413.GE3056@worktop>
References: <20181110231732.15060-1-namit@vmware.com>
 <20181110231732.15060-6-namit@vmware.com>
 <20181111144327.GG12766@worktop.psav.com>
 <0A01B5B5-C771-45AC-81B3-92EE9611D8B2@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0A01B5B5-C771-45AC-81B3-92EE9611D8B2@vmware.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 08:38:53PM +0000, Nadav Amit wrote:
> From: Peter Zijlstra
> > On Sat, Nov 10, 2018 at 03:17:27PM -0800, Nadav Amit wrote:
> >> +void __init poking_init(void)
> >> +{
> >> +	spinlock_t *ptl;
> >> +	pte_t *ptep;
> >> +
> >> +	poking_mm = copy_init_mm();
> >> +	if (!poking_mm) {
> >> +		pr_err("x86/mm: error setting a separate poking address space");
> >> +		return;
> >> +	}
> >> +
> >> +	/*
> >> +	 * Randomize the poking address, but make sure that the following page
> >> +	 * will be mapped at the same PMD. We need 2 pages, so find space for 3,
> >> +	 * and adjust the address if the PMD ends after the first one.
> >> +	 */
> >> +	poking_addr = TASK_UNMAPPED_BASE +
> >> +		(kaslr_get_random_long("Poking") & PAGE_MASK) %
> >> +		(TASK_SIZE - TASK_UNMAPPED_BASE - 3 * PAGE_SIZE);
> >> +
> >> +	if (((poking_addr + PAGE_SIZE) & ~PMD_MASK) == 0)
> >> +		poking_addr += PAGE_SIZE;
> >> +
> >> +	/*
> >> +	 * We need to trigger the allocation of the page-tables that will be
> >> +	 * needed for poking now. Later, poking may be performed in an atomic
> >> +	 * section, which might cause allocation to fail.
> >> +	 */
> >> +	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
> >> +	if (!WARN_ON(!ptep))
> >> +		pte_unmap_unlock(ptep, ptl);
> >> +}
> > 
> > The difference in how we deal with -ENOMEM here is weird. I think we
> > have a _lot_ of code that simply hard assumes we don't fail memory alloc
> > on init.
> > 
> > I for instance would not mind to simply remove both branches and let the
> > kernel crash and burn if we ever fail here.
> 
> Actually, now that we removed the fallback of patching without poking_mm, a
> failure to allocate poking_mm should have had a BUG_ON().
> 
> For the second case, I think we still need either WARN_ON() or BUG_ON(), at
> least as some sort of an in-code comment. I’ll change it to BUG_ON() if you
> prefer.

Sure, two BUG_ON()s works for me.
