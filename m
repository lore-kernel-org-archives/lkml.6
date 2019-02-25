Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F0BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7C02147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cjAQ+/+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfBYLza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 06:55:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfBYLz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 06:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3H02dfyNAcA0ppg3CbN7a9ME/iTc/ftr4SwUp0W7UbI=; b=cjAQ+/+HsjXNZNeXxJ2uxCL59
        YMC1cL5spSf/SiuX2e5whhNeCxVW9YYI3LN6Rlwz5rKTQ11RZ/np/30+obtcK9M13N/us0sjGe4z8
        Ge0g7Y7X1vfv/BhxkeUvqUTwRhND1HA70NNOBnO/d6dt1hk5OJ/z9E8x/bj8c0wILDFIrYmT2IDcS
        AmMDbzEbAZzp8wGlk2piDphdh8GhrR70dmAIzXfjOeijV7GfSIU8bZaHLv7mKKyoVJRTb1yMVYj6e
        oPzH7pohh2W9Lp6+aXKVSE8ok8DPYDaVyrVj567no1n5jmBl0KvBUrD4+5GDfdLI/88302+BGS82H
        l2BSfUowA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyEqx-0005X1-CF; Mon, 25 Feb 2019 11:55:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B13EB2026BE91; Mon, 25 Feb 2019 12:55:21 +0100 (CET)
Date:   Mon, 25 Feb 2019 12:55:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
Message-ID: <20190225115521.GC32494@hirez.programming.kicks-ass.net>
References: <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
 <99aab8c6-0000-b06b-71c0-bd36e0d39768@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99aab8c6-0000-b06b-71c0-bd36e0d39768@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 08:33:35AM +0000, Julien Thierry wrote:
> > It has an AC_SAFE(func) annotation which allows marking specific
> > functions as safe to call. The patch includes 2 instances which were
> > required to make arch/x86 'build':

> I haven't looked at all the details. But could the annotation be called
> UACCESS_SAFE() (and corresponding naming in the objtool checks)? Since
> this is not an x86 only issue and the AC flags only exists for x86.

Sure that works. Lemme sed the patches.
