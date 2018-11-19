Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB10FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911892086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb16klXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911892086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbeKTJUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:20:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731678AbeKTJUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:20:12 -0500
Received: from gmail.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC8C22080C;
        Mon, 19 Nov 2018 22:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542668057;
        bh=fGUekPV8QuiVrLnmF5ztfZWtgeI7vDir/N1XrP0l8mI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kb16klXurTKoz6DVvQatPmkfJyz4CeqMwXnAAOIsQgzm2B7Ja3h4HVwW5aSCTfw+v
         r2KINCMF1ciYmVg7QiXB9uaq1upLDOzLEWugbnnYlDyZKwF5pqkBoLdX9RGKDquBeK
         unOhmRTZE4yQtJ5/bGOgwuFmay/MIMi1cXZlLk1k=
Date:   Mon, 19 Nov 2018 14:54:15 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
Subject: Re: [RFC PATCH] zinc chacha20 generic implementation using crypto
 API code
Message-ID: <20181119225414.GB258711@gmail.com>
References: <20181105232526.173947-1-ebiggers@kernel.org>
 <20181105232526.173947-11-ebiggers@kernel.org>
 <CAKv+Gu-o0khD5=0EOkv2PiczMs5uZ=XP9V=G2ogBNMK8Kb93sw@mail.gmail.com>
 <20181112185816.GA8663@gmail.com>
 <20181116060227.hwu4igi6bp26ddpi@gondor.apana.org.au>
 <20181117001718.GA175522@gmail.com>
 <CAHmME9rtsCk8ZLt05xRKMGr4CVRnaUvCaVOS_WX3N22HOat4-A@mail.gmail.com>
 <20181119052451.qttzfgcm4hvbdc4u@gondor.apana.org.au>
 <CAHmME9oXAnD0sbO2cKeTtotCMohX2Hu6P=uzA_6u0EWECU9Bpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9oXAnD0sbO2cKeTtotCMohX2Hu6P=uzA_6u0EWECU9Bpg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 07:13:07AM +0100, Jason A. Donenfeld wrote:
> Hi Herbert,
> 
> On Mon, Nov 19, 2018 at 6:25 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > My proposal is to merge the zinc interface as is, but to invert
> > how we place the algorithm implementations.  IOW the implementations
> > should stay where they are now, with in the crypto API.  However,
> > we will provide direct access to them for zinc without going through
> > the crypto API.  IOW we'll just export the functions directly.
> 
> Sorry, but there isn't a chance I'll agree to this. The whole idea is
> to have a clean place to focus on synchronous software
> implementations, and not keep it tangled up with the asynchronous API.
> If WireGuard and Zinc go in, it's going to be done right, not in a way
> that introduces more problems and organizational complexity. Avoiding
> the solution proposed here is kind of the point. And given that
> cryptographic code is so security sensitive, I want to make sure this
> is done right, as opposed to rushing it with some half-baked
> concoction that will be maybe possibly be replaced "later". From
> talking to folks at Plumbers, I believe most of the remaining issues
> are taken care of by the upcoming v9, and that you're overstating the
> status of discussions regarding that.

Will v9 include a documentation file for Zinc in Documentation/crypto/?
That's been suggested several times.

> 
> I think the remaining issue right now is how to order my series and
> Eric's series. If Eric's goes in first, it means that I can either a)
> spend some time developing Zinc further _now_ to support chacha12 and
> keep the top two conversion patches, or b) just drop the top two
> conversion patches and work that out carefully with Eric after. I
> think (b) would be better, but I'm happy to do (a) if you disagree.
> And as I mentioned in the last email, I'd prefer Eric's work to go in
> after Zinc, but I don't think the reasoning for that is particularly
> strong, so it seems fine to merge Eric's work first.
> 
> I'll post v9 pretty soon and you can see how things are shaping up.
> Hopefully before then Eric/Ard/you can provide some feedback on
> whether you'd prefer (a) or (b) above.
> 

I'd still prefer to see the conversion patches included.  Skipping them would be
kicking the can down the road and avoiding issues that will need to be addressed
anyway.  Like you, I don't want a "half-baked concoction that will be maybe
possibly be replaced 'later'" :-)

Either way though, it would make things much easier if you at least named the
files, structures, constants, etc. "ChaCha" rather than "ChaCha20" from the
start where appropriate.  For an example, see the commit "crypto: chacha -
prepare for supporting non-20-round variants" on my "adiantum-zinc" branch:
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?h=adiantum-zinc&id=754af8d7d39f31238114426e39786c84d7cc0f98
Then the actual introduction of the 12-round variant is much less noisy.

- Eric
