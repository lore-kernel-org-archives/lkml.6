Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6B4C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41B323ABE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVugKZaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41B323ABE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbeF0G1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 02:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751917AbeF0G1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 02:27:10 -0400
Received: from localhost (unknown [106.201.61.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4177E23ABE;
        Wed, 27 Jun 2018 06:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530080829;
        bh=F3lkHXicC0/e4zmEnRfdemkjX52Y69EKXLWKDaTX3AM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fVugKZaJO/8FAblgKv0/e1J1FKjL42YzdrZWI/oF+zp8D3kQQquoE8BFHm497JIX9
         uhXrecV6oxGMJ9yUYj1v6zI/mjAMp74jcrnNHv4LGu69XiAqgGR/QtaXCFHftIHKgO
         1+9ZxLYyE65IJcAefpGZji6q0Fxik7lmzb8U90h0=
Date:   Wed, 27 Jun 2018 11:57:01 +0530
From:   Vinod <vkoul@kernel.org>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
Message-ID: <20180627062701.GF22377@vkoul-mobl>
References: <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au>
 <70ED61EB-BD3E-48D1-8B4D-D7835494C035@chronox.de>
 <20180627050853.GE22377@vkoul-mobl>
 <52764537.cSZCttAJ1I@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52764537.cSZCttAJ1I@tauon.chronox.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

Thanks for the answers, they are helpful.

On 27-06-18, 08:13, Stephan Mueller wrote:
> > I have two follow up question on crypto:
> > 
> >  - If there a way to avoid using a global variable in driver to hold the
> >    pointer for driver memory? Looks like exynos driver does that.
> > 
> >    I understand that the crypto callback don't provide driver context as
> >    they copy the data structures passed in registration API, but a simpler
> >    way to get driver context would be desirable.
> 
> Sure the kernel crypto API can and has to maintain a per-instance data 
> structure.
> 
> See the crypto/drbg.c for instance.
> 
> static int drbg_kcapi_random(struct crypto_rng *tfm,
>                              const u8 *src, unsigned int slen,
>                              u8 *dst, unsigned int dlen)
> {
>         struct drbg_state *drbg = crypto_rng_ctx(tfm);
> 
> static int drbg_kcapi_seed(struct crypto_rng *tfm,
>                            const u8 *seed, unsigned int slen)
> {
>         struct drbg_state *drbg = crypto_rng_ctx(tfm);
> 
> The key is:
> 
>         alg->base.cra_ctxsize   = sizeof(struct drbg_state);
> 
> during initialization since the kernel crypto API allocates that buffer for 
> you and releases it during deallocation.

The difference here is that memory is allocated by crypto and driver has
no way to pass "it's" own data while doing registration. Ideally
registration should accept a pointer/long and pass that back on a
callbacks

Currently am doing bunch of initialization in .probe (platform driver)
and I think recommendation would be to move that to .cra_init, which seem
plausible but I don't have pdev to read hw_resource etc.. so would still
need to get that.

FWIW here is the code I wrote:
https://git.linaro.org/people/vinod.koul/kernel.git/commit/?h=topic/rng_v2&id=feb23a41afb0d4cf42a2825b84a43dbc9a49e8b9

-- 
~Vinod
