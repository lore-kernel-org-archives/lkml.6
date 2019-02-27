Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A48EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A282087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bGImwP3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbfB0MVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:21:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfB0MVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KYASYRr2fQcP2RQHSHZ0og4fpiFY/wuH+5u51oO4sdU=; b=bGImwP3RByCRX3z6gqVtY/qoP
        gM/vqDZKwJG48lF42LdbT2CjUml5qxeQlx9/UVOzqhzwFmZNCOaV24stNPRuVQiovQvWHlfMNVjQc
        xFbu4WuTxQov9k/yWQWz3qOnQk3pKZFIpG9JrFMz9A1uo1KZeBXX9zZoRmMSgAMPLZeXsnd0rqTqs
        bjR+m9W2RM9b9bA1zz2OrbWvBPFbJkolS/BPO4wqnZciB25b86hi4SDo3/9evEHGxdGWkv8vMC8OP
        Axzw0nVZkXFc6mM6zsFa1u7uh2QKFFUJ4/Xwgz5mwYLtYeYIu5R6Gzh6jFCkPWCpSFweHv64b1Q86
        2SR+FtV7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyyCq-0002ci-Px; Wed, 27 Feb 2019 12:21:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E29B25D10E32; Wed, 27 Feb 2019 13:20:59 +0100 (CET)
Date:   Wed, 27 Feb 2019 13:20:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] objtool: Replace STACK_FRAME_NON_STANDARD annotation
Message-ID: <20190227122059.GO32494@hirez.programming.kicks-ass.net>
References: <20190225124330.613028745@infradead.org>
 <20190225125232.107098740@infradead.org>
 <20190225161124.cq6c45r3wlwktyuz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225161124.cq6c45r3wlwktyuz@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:11:24AM -0600, Josh Poimboeuf wrote:
> On Mon, Feb 25, 2019 at 01:43:34PM +0100, Peter Zijlstra wrote:

> > -#define STACK_FRAME_NON_STANDARD(func) \
> > -	static void __used __section(.discard.func_stack_frame_non_standard) \
> > -		*__func_stack_frame_non_standard_##func = func
> > +#define STACK_FRAME_NON_STANDARD(func)					\
> > +	asm (".pushsection .discard.nonstd_frame_strtab, \"S\", @3\n\t"	\
> > +	     "999: .ascii \"" #func "\"\n\t"				\
> > +	     "     .byte 0\n\t"						\
> > +	     ".popsection\n\t"						\
> > +	     ".pushsection .discard.nonstd_frame\n\t"			\
> > +	     ".long 999b - .\n\t"					\
> > +	     ".popsection\n\t")
> > +
> 
> I don't think this will work in the case where GCC does an IPA
> optimization and renames the function (e.g., renames func to
> func.isra.1234), right?  That might be a deal breaker...

Or; as has been found by 0day; the whole function gets inlined and
the symbol no longer exists at all.

That's curable with a noinline, but all things considered, I think we
should go back to the old horrible scheme. Andy?
