Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA94ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 22:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8B72083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 22:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksPI6UiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8B72083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeJVGjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 02:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbeJVGjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 02:39:36 -0400
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE60220836;
        Sun, 21 Oct 2018 22:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540160624;
        bh=Rgullb1m/3PB9xdtND/wOy1zQk70tg18IPL7vTj/+iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ksPI6UiRmGbVyEQwvHc43yNxOB8pAgkQ1cfQnoSKUyWdawIhEL4yLooklFnZvuV8N
         qXX5hDYqOA1VWUgGSOxejwm5mDY7Xo05H9YXV99lNM9tQlA76qwuJaVzU8UwTlILFb
         tqD8Z92PmSoTzC8ebEJE5/TOTU/O40iCHgiZ/4lA=
Date:   Sun, 21 Oct 2018 15:23:42 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
Subject: Re: [RFC PATCH v2 00/12] crypto: Adiantum support
Message-ID: <20181021222341.GA742@sol.localdomain>
References: <20181015175424.97147-1-ebiggers@kernel.org>
 <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
 <20181019190411.GB246441@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019190411.GB246441@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 12:04:11PM -0700, Eric Biggers wrote:
> Hi Jason,
> 
> On Fri, Oct 19, 2018 at 05:58:35PM +0200, Jason A. Donenfeld wrote:
> > Hello Eric,
> > 
> > > As before, some of these patches conflict with the new "Zinc" crypto
> > > library.  But I don't know when Zinc will be merged, so for now I've
> > > continued to base this patchset on the current 'cryptodev'.
> > 
> > I'd appreciate it if you waited to merge this until you can rebase it
> > on top of Zinc. In fact, if you already want to build it on top of
> > Zinc, I'm happy to work with you on that in a shared repo or similar.
> > We can also hash out the details of that in person in Vancouver in a
> > few weeks. I think pushing this in before will create undesirable
> > churn for both of us.
> > 
> 
> I won't be at Plumbers, sorry!  For if/when it's needed, I'll start a version of
> this based on Zinc.  The basic requirements are that we need (1) xchacha12 and
> xchacha20 available as 'skciphers' in the crypto API, and (2) the poly1305_core
> functions (see patch 08/12).  In principle, these can be implemented in Zinc.
> The Adiantum template and all the NHPoly1305 stuff will be the same either way.
> (Unless you'll want one or both of those moved to Zinc too.  To be honest, even
> after your explanations I still don't have a clear idea of what is supposed to
> go in Zinc and what isn't...)
> 
> However, for now I'm hesitant to completely abandon the current approach and bet
> the farm on Zinc.  Zinc has a large scope and various controversies that haven't
> yet been fully resolved to everyone's satisfaction, including unclear licenses
> on some of the essential assembly files.  It's not appropriate to grind kernel
> crypto development to grind a halt while everyone waits for Zinc.
> 
> So if Zinc is ready, then it makes sense for it to go first;
> otherwise, it doesn't.  It's not yet clear which is the case.
> 

I started a branch based on Zinc:
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git,
branch "adiantum-zinc".

For Poly1305, for now I decided to just use the existing functions, passing 0
for the 16-byte element is added at the end.  This causes some unnecessary
overhead, but it's not very much.  It also results in a much larger size of
'struct nhpoly1305_state', but that doesn't matter too much anymore either [1].

For ChaCha, I haven't yet updated all the "Zinc" assembly to support 12 rounds.
So far I've updated my ARM scalar implementation.  I still don't see how you
expect people to maintain the files like chacha20-x86_64.S from which all
comments, register aliases, etc. were removed in comparison to the original
OpenSSL code.  I find it hard to very understand what's going on from what is
nearly an 'objdump' output.  (I'll figure it out eventually, but it will take
some time.)  I don't see how dumping thousands of lines of undocumented,
generated assembly code into the kernel fits with your goals of "Zinc's focus is
on simplicity and clarity" and "inviting collaboration".  Note that the
OpenSSL-derived assembly files still have an unclear license as well.

I'm also still not a fan of the remaining duplication between "zinc" and
"crypto", e.g. we still have both crypto/chacha.h and zinc/chacha.h, and
separate tests for "zinc" and "crypto".  (I haven't yet gotten around to adding
"zinc tests" for XChaCha12, though I did add "crypto tests".  Note that "crypto
tests" are much easier to add, since all algorithms of the same type share a
common test framework -- not the case for Zinc.)

Of course, both myself and others have expressed concerns about these issues
previously too, yet they remain unaddressed nor is there a documentation file
explaining things.  So please understand that until it's clear that Zinc is
ready, I still have to have Adiantum ready to go without Zinc, just in case.

Thanks,

- Eric

[1] Originally we were going to define Adiantum's hash function to be
    Poly1305(message_length || tweak_length || tweak || NH(message)), which
    would have made it desirable to export the Poly1305 state before NH, so that
    it could be imported for the second hash step to avoid redundantly hashing
    the message length and tweak.  But later we changed it to
    Poly1305(message_length || tweak) + Poly1305(NH(message)).
