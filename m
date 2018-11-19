Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEBBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D2B2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dF3y11dQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D2B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbeKTJtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:49:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:55466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725722AbeKTJtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:49:50 -0500
Received: from gmail.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5432120851;
        Mon, 19 Nov 2018 23:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542669827;
        bh=jhrCp8fi3OKd2yUxusOW414hCEPKHHo0yjzqTZhz6Xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dF3y11dQ/pwip/joRv2t2HZa/RzTe3nQRGDkLRXaDBnKEdqDaOXsFdInRJDdLNdpa
         PJ/ZXAwSm5yyDGO8Z9VsnSN2L8wPmcbXAWUoDh1+AFydPeth0JQ+Hi/AyBfogaelai
         /K2li+ELVT8UBE2zTjOSa3yDFC4RyB1LCGOFNpCE=
Date:   Mon, 19 Nov 2018 15:23:45 -0800
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
Message-ID: <20181119232345.GC258711@gmail.com>
References: <20181105232526.173947-11-ebiggers@kernel.org>
 <CAKv+Gu-o0khD5=0EOkv2PiczMs5uZ=XP9V=G2ogBNMK8Kb93sw@mail.gmail.com>
 <20181112185816.GA8663@gmail.com>
 <20181116060227.hwu4igi6bp26ddpi@gondor.apana.org.au>
 <20181117001718.GA175522@gmail.com>
 <CAHmME9rtsCk8ZLt05xRKMGr4CVRnaUvCaVOS_WX3N22HOat4-A@mail.gmail.com>
 <20181119052451.qttzfgcm4hvbdc4u@gondor.apana.org.au>
 <CAHmME9oXAnD0sbO2cKeTtotCMohX2Hu6P=uzA_6u0EWECU9Bpg@mail.gmail.com>
 <20181119225414.GB258711@gmail.com>
 <CAHmME9okRjuYUiL0D=6ZmtMX6rvxU+0xvy2tva+LetjU9itx8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9okRjuYUiL0D=6ZmtMX6rvxU+0xvy2tva+LetjU9itx8Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 12:15:17AM +0100, Jason A. Donenfeld wrote:
> Hi Eric,
> 
> On Mon, Nov 19, 2018 at 11:54 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > Will v9 include a documentation file for Zinc in Documentation/crypto/?
> > That's been suggested several times.
> 
> I had started writing that there, but then thought that the requested
> information could go in the commit message instead. But I'm guessing
> you're asking again now because you poked into the repo and didn't
> find the Documentation/, so presumably you still want it. I can
> reorganize the presentation of that to be more suitable for
> Documentation/, and I'll have that for v9.
> 

It's much better to have the documentation in a permanent location.

> > I'd still prefer to see the conversion patches included.  Skipping them would be
> > kicking the can down the road and avoiding issues that will need to be addressed
> > anyway.  Like you, I don't want a "half-baked concoction that will be maybe
> > possibly be replaced 'later'" :-)
> 
> Okay, fair enough. Will do.
> 
> > Either way though, it would make things much easier if you at least named the
> > files, structures, constants, etc. "ChaCha" rather than "ChaCha20" from the
> > start where appropriate.  For an example, see the commit "crypto: chacha -
> > prepare for supporting non-20-round variants" on my "adiantum-zinc" branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?h=adiantum-zinc&id=754af8d7d39f31238114426e39786c84d7cc0f98
> > Then the actual introduction of the 12-round variant is much less noisy.
> 
> That's a good idea. I'll do it like that. I'll likely order it as what
> we have now (renamed to omit the 20), and then put the 12 stuff on top
> of that, so it's easier to see what's changed in the process. I
> noticed in that branch, you didn't port the assembly to support fewer
> rounds. Shall I follow suite, and then expect patches from you later
> doing that? Or were you expecting me to also port the architecture
> implementations to chacha12 as well?
> 

I actually did add ChaCha12 support to most of the Zinc assembly in
"[WIP] crypto: assembly support for ChaCha12"
(https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?h=adiantum-zinc&id=0a7787a515a977e11b680f1752b430ca1744e399).
But I skipped AVX-512 and MIPS since I didn't have a way to test those yet,
and I haven't ported the changes to your new perl scripts yet.

- Eric
