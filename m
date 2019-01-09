Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5684C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829BD21738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="teFJFHpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfAIKf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:35:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIKf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DKgsdzVesd550B56YYW6BiVOUbTgiz3WrdBRaQWMslk=; b=teFJFHpubLE2+1NUpcxSxO5Kw
        6azao4j+JZ9TMOVT3Ej94PwYU7Pry8nWqVdci9exHH4KNOsmHlvKjpm79Pe5XkVhplIoi7GLhOU4x
        OYO83kv/6O7z+n3ekyLXOuOsAnFpgtUSCjTlW9DleRz7FzXGju2MK9t8gOQnOiF29YlaC1iImOQw8
        BmMENYBnbNVpDNnRVrra3fYUhOTvQUl5Y/XR3eJRHMoDe0izoDNTgQZ6k5pBWG/XEBgx3zlGIofaH
        4nxcG8MMmsKZzrkfUAWzcOFj6ToKLCzqO5Yjd0hkIWnDzekWsfX3mpMe6Jprn9sMxGmVMLZPN6Gwe
        /i+E7la3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghBD8-0001Du-36; Wed, 09 Jan 2019 10:35:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B15020280450; Wed,  9 Jan 2019 11:35:44 +0100 (CET)
Date:   Wed, 9 Jan 2019 11:35:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        songliubraving@fb.com
Subject: Re: [RFC v2 0/6] x86: dynamic indirect branch promotion
Message-ID: <20190109103544.GH1900@hirez.programming.kicks-ass.net>
References: <87zhshe66w.fsf@linux.intel.com>
 <20190107163227.GH14122@hirez.programming.kicks-ass.net>
 <c4e836e8-1949-27f5-f6a0-ed860f590ec5@intel.com>
 <20190108092559.GA6808@hirez.programming.kicks-ass.net>
 <306d38fb-7ce6-a3ec-a351-6c117559ebaa@intel.com>
 <20190108101058.GB6808@hirez.programming.kicks-ass.net>
 <20190108172721.GN6118@tassilo.jf.intel.com>
 <D1A153D5-D23B-45E6-9E7A-EB9CBAE84B7E@gmail.com>
 <20190108190104.GC1900@hirez.programming.kicks-ass.net>
 <7EB5F9ED-8743-4225-BE97-8D5C8D8E0F84@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7EB5F9ED-8743-4225-BE97-8D5C8D8E0F84@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 12:47:42PM -0800, Nadav Amit wrote:

> A general solution is more complicated, however, due to the racy nature of
> cross-modifying code. There would need to be TSC recording of the time
> before the modifications start and after they are done.
> 
> BTW: I am not sure that static-keys are much better. Their change also
> affects the control flow, and they do affect the control flow.

Any text_poke() user is a problem; which is why I suggested a
PERF_RECORD_TEXT_POKE that emits the new instruction. Such records are
timestamped and can be correlated to the trace.

As to the racy nature of text_poke, yes, this is a wee bit tricky and
might need some care. I _think_ we can make it work, but I'm not 100%
sure on exactly how PT works, but something like:

 - write INT3 byte
 - IPI-SYNC

and ensure the poke_handler preserves the existing control flow (which
it currently does not, but should be possible).

 - emit RECORD_TEXT_POKE with the new instruction

at this point the actual control flow will be through the INT3 and
handler and not hit the actual instruction, so the actual state is
irrelevant.

 - write instruction tail
 - IPI-SYNC
 - write first byte
 - IPI-SYNC

And at this point we start using the new instruction, but this is after
the timestamp from the RECORD_TEXT_POKE event and decoding should work
just fine.
