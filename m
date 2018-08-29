Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35803C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5228205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bXLddv8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5228205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbeH2ULx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:11:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55576 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeH2ULx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VlG+qIOjq4ELptMpQOsUdBOO02kYYhYCM6s2FctM1lA=; b=bXLddv8imDgdZ9qTIufJ1SqPC
        VbzVtnEYrOmswm8y01r86pFRRuqDXYqagCc7DVyyBnQayOiH1lm83IIn/tu6hfLGVTwhL9EwTdQKg
        9d/zLtWl5XYrWODgxyJIBIgyh8USTDxUQVJlCI59ug6q+UDpg10CjCraC7UtJS89KGUgpZJVWpKX0
        0kMmYA/AJ656WuJG0cx3c5amSKGj2LjOR4KHoOiRQx+da39+GcW0R6baITIZ1VATSCYYuuX1+WgCA
        em1GxL8iwDlfz0xOcTtlbjbVPv5R09ZEWKDExOhc52tg6WE59JwdSsXyFF83m4muIdkZ3kF/K4emj
        87PDCBduA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fv36Y-0002z9-Ma; Wed, 29 Aug 2018 16:14:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 427A52024D700; Wed, 29 Aug 2018 18:14:00 +0200 (CEST)
Date:   Wed, 29 Aug 2018 18:14:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 5/6] x86/alternatives: use temporary mm for text
 poking
Message-ID: <20180829161400.GV24124@hirez.programming.kicks-ass.net>
References: <20180829081147.184610-1-namit@vmware.com>
 <20180829081147.184610-6-namit@vmware.com>
 <20180829092839.GP24124@hirez.programming.kicks-ass.net>
 <CALCETrXe9CUMo3c44UtmkxD4w68PvmoypdCyvCFvWiZVuxy=sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXe9CUMo3c44UtmkxD4w68PvmoypdCyvCFvWiZVuxy=sQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 08:46:04AM -0700, Andy Lutomirski wrote:
> On Wed, Aug 29, 2018 at 2:28 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Wed, Aug 29, 2018 at 01:11:46AM -0700, Nadav Amit wrote:
> 
> >> +     pte_clear(poking_mm, poking_addr, ptep);
> >> +
> >> +     /*
> >> +      * __flush_tlb_one_user() performs a redundant TLB flush when PTI is on,
> >> +      * as it also flushes the corresponding "user" address spaces, which
> >> +      * does not exist.
> >> +      *
> >> +      * Poking, however, is already very inefficient since it does not try to
> >> +      * batch updates, so we ignore this problem for the time being.
> >> +      *
> >> +      * Since the PTEs do not exist in other kernel address-spaces, we do
> >> +      * not use __flush_tlb_one_kernel(), which when PTI is on would cause
> >> +      * more unwarranted TLB flushes.
> >> +      */
> >
> > yuck :-), but yeah.
> 
> I'm sure we covered this ad nauseum when PTI was being developed, but
> we were kind of in a rush, so:
> 
> Why do we do INVPCID at all?  The fallback path for non-INVPCID
> systems uses invalidate_user_asid(), which should be faster than the
> invpcid path.  And doesn't do a redundant flush in this case.

I don't remember; and you forgot to (re)add dhansen.

Logically INVPCID_SINGLE should be faster since it pokes out a single
translation in another PCID instead of killing all user translations.

Is it just a matter of (current) chips implementing INVLPCID_SINGLE
inefficient, or something else?
