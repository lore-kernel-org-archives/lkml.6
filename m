Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578B1C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B17021902
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfBTOwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:52:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:51260 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfBTOwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:52:33 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x1KEpYL4023289;
        Wed, 20 Feb 2019 08:51:34 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x1KEpPRx023288;
        Wed, 20 Feb 2019 08:51:25 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 20 Feb 2019 08:51:25 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Balbir Singh <bsingharora@gmail.com>, erhard_f@mailbox.org,
        jack@suse.cz, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due to pgd/pud_present()
Message-ID: <20190220145112.GW14180@gate.crashing.org>
References: <20190214062339.7139-1-mpe@ellerman.id.au> <20190216105511.GA31125@350D> <20190216142206.GE14180@gate.crashing.org> <20190217062333.GC31125@350D> <87ef86dd9v.fsf@concordia.ellerman.id.au> <20190217215556.GH31125@350D> <87imxhrkdt.fsf@concordia.ellerman.id.au> <20190219201539.GT14180@gate.crashing.org> <87sgwi7lo1.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgwi7lo1.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:18:38PM +1100, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> > On Mon, Feb 18, 2019 at 11:49:18AM +1100, Michael Ellerman wrote:
> >> Balbir Singh <bsingharora@gmail.com> writes:
> >> > Fair enough, my point was that the compiler can help out. I'll see what
> >> > -Wconversion finds on my local build :)
> >> 
> >> I get about 43MB of warnings here :)
> >
> > Yes, -Wconversion complains about a lot of things that are idiomatic C.
> > There is a reason -Wconversion is not in -Wall or -Wextra.
> 
> Actually a lot of those go away when I add -Wno-sign-conversion.
> 
> And what's left seems mostly reasonable, they all indicate the
> possibility of a bug I think.
> 
> In fact this works and would have caught the bug:
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index d8c8d7c9df15..3114e3f368e2 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -904,7 +904,12 @@ static inline int pud_none(pud_t pud)
>  
>  static inline int pud_present(pud_t pud)
>  {
> +	__diag_push();
> +	__diag_warn(GCC, 8, "-Wconversion", "ulong -> int");
> +
>  	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PRESENT));
> +
> +	__diag_pop();
>  }
>  
>  extern struct page *pud_page(pud_t pud);
> 
> 
> 
> Obviously we're not going to instrument every function like that. But we
> could start instrumenting particular files.

So you want to instrument the functions that you know are buggy, using some
weird incantations to catch only those errors you already know about?

(I am worried this does not scale, in many dimensions).


Segher
