Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1F2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1186206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UUmN5Ppr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfBRMxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:53:50 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44636 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbfBRMxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o9duW35qkVBByBckeYSVEKqqj00p/T7Hi5MwdEAEhQc=; b=UUmN5PprHGZoQhOVHvZZxxJb6
        hHw50LSLCBROSQL9dckvU4QK0G/XtpZkGlOE+IrG+Y3MjB8IcVVJNHqDu2HdKKRDJA+2dmdwNvo15
        QwQpbpiQ16sHm+WUw5EUSP0G9AE4KToH8ivrK8ZBdcvtxBcc+HLCzZHeDamtsfBX8gS0Em6FACMYx
        68vR6PCWS0O5qe7x/LTU2hEqxCztkwJImv7YffHR/lCLtRvtVOd2imCaEFcFFI+1zU3HPd7ZVlQsK
        POL7d7amdHmnvg8t+qHVMR96ym+N+D/NMxmBIr0C85eSdoo2UoOIgwOv7pgu8BDdKkFfUU4Ns+nfL
        vsFqBi97Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gviQL-0006Mc-Hs; Mon, 18 Feb 2019 12:53:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F9C9286A33C8; Mon, 18 Feb 2019 13:53:27 +0100 (CET)
Date:   Mon, 18 Feb 2019 13:53:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <Mark.Rutland@arm.com>
Cc:     Steven Price <Steven.Price@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <James.Morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 03/13] mm: Add generic p?d_large() macros
Message-ID: <20190218125327.GT32494@hirez.programming.kicks-ass.net>
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-4-steven.price@arm.com>
 <20190218111421.GC8036@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218111421.GC8036@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 11:14:23AM +0000, Mark Rutland wrote:
> > +#ifndef pgd_large
> > +#define pgd_large(x)0
> > +#endif
> > +#ifndef pud_large
> > +#define pud_large(x)0
> > +#endif
> > +#ifndef pmd_large
> > +#define pmd_large(x)0
> > +#endif
> 
> It might be worth a comment defining the semantics of these, e.g. how
> they differ from p?d_huge() and p?d_trans_huge().

Yes; I took it to mean any large page mapping, so it would explicitly
include huge and thp.


