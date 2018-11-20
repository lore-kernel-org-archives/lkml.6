Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD70CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 03:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4BD20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 03:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4BD20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbeKTNdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:33:44 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:45136 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbeKTNdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 08:33:44 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gOwN8-00076t-HF; Tue, 20 Nov 2018 11:06:42 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gOwN1-00024u-Pz; Tue, 20 Nov 2018 11:06:35 +0800
Date:   Tue, 20 Nov 2018 11:06:35 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
Message-ID: <20181120030635.xfr543j5nngxfnxk@gondor.apana.org.au>
References: <20181105232526.173947-1-ebiggers@kernel.org>
 <20181105232526.173947-11-ebiggers@kernel.org>
 <CAKv+Gu-o0khD5=0EOkv2PiczMs5uZ=XP9V=G2ogBNMK8Kb93sw@mail.gmail.com>
 <20181112185816.GA8663@gmail.com>
 <20181116060227.hwu4igi6bp26ddpi@gondor.apana.org.au>
 <20181117001718.GA175522@gmail.com>
 <CAHmME9rtsCk8ZLt05xRKMGr4CVRnaUvCaVOS_WX3N22HOat4-A@mail.gmail.com>
 <20181119052451.qttzfgcm4hvbdc4u@gondor.apana.org.au>
 <CAHmME9oXAnD0sbO2cKeTtotCMohX2Hu6P=uzA_6u0EWECU9Bpg@mail.gmail.com>
 <20181119225414.GB258711@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119225414.GB258711@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 02:54:15PM -0800, Eric Biggers wrote:
>
> > I think the remaining issue right now is how to order my series and
> > Eric's series. If Eric's goes in first, it means that I can either a)
> > spend some time developing Zinc further _now_ to support chacha12 and
> > keep the top two conversion patches, or b) just drop the top two
> > conversion patches and work that out carefully with Eric after. I
> > think (b) would be better, but I'm happy to do (a) if you disagree.
> > And as I mentioned in the last email, I'd prefer Eric's work to go in
> > after Zinc, but I don't think the reasoning for that is particularly
> > strong, so it seems fine to merge Eric's work first.
> > 
> > I'll post v9 pretty soon and you can see how things are shaping up.
> > Hopefully before then Eric/Ard/you can provide some feedback on
> > whether you'd prefer (a) or (b) above.
> > 
> 
> I'd still prefer to see the conversion patches included.  Skipping them would be
> kicking the can down the road and avoiding issues that will need to be addressed
> anyway.  Like you, I don't want a "half-baked concoction that will be maybe
> possibly be replaced 'later'" :-)

Are you guys talking about the conversion patches to eliminate the
two copies of chacha code that would otherwise exist in crypto as
well as in zinc?

If so I think that's not negotiable.  Having two copies of the same
code is just not acceptable.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
