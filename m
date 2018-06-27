Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA72C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F92268AC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="NibQDgo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F92268AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeF0Gn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 02:43:26 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:18880 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeF0GnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 02:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530081800;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=L9oMeRyLmRDqVBxKeAX0WxBhdg3tsuO2YIrzX3fldvU=;
        b=NibQDgo2OxCnUR0n6RDxxYhY2WGxAdJP+PPdDthXQdNUQ1R/VxuEWE6hnOoQNLBdgR
        H05hx7ZdxxzECcRVHzq0tErD53CaEXU2NFnB+1uuzllTQXsvG2m85veQpOAYd35myAsu
        ApZlbAKbZrPLm2MqzRdZL20rRhQd1ZBIdHULKeMteNv/F12Q8Z6BHicEHYPzLSDTlY4k
        K8hdNMTYbfzQvGNRoxoNBHK2mwiAMQPjCwa0RsgQZZIAuRcW2skBlOApNoWWmwerRHBq
        uZKU/geqd+sF4YEDdqFxLw3IL6c924xUODnIQugOEqEJsxZXXRBc18NQ7EKF4hbY2YXZ
        dEuw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zW4DNhHoQE+naq/Tly14H1nAt7oghSPofJc0EJAN2fP8qsY44dqiWA=="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 43.10 AUTH)
        with ESMTPSA id j06b90u5R6hGu0A
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 27 Jun 2018 08:43:16 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Vinod <vkoul@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
Date:   Wed, 27 Jun 2018 08:43:16 +0200
Message-ID: <170012246.0U45yCEtus@tauon.chronox.de>
In-Reply-To: <20180627062701.GF22377@vkoul-mobl>
References: <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au> <52764537.cSZCttAJ1I@tauon.chronox.de> <20180627062701.GF22377@vkoul-mobl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 27. Juni 2018, 08:27:01 CEST schrieb Vinod:

Hi Vinod,

> Hi Stephan,
> 
> Thanks for the answers, they are helpful.
> 
> On 27-06-18, 08:13, Stephan Mueller wrote:
> > > I have two follow up question on crypto:
> > >  - If there a way to avoid using a global variable in driver to hold the
> > >  
> > >    pointer for driver memory? Looks like exynos driver does that.
> > >    
> > >    I understand that the crypto callback don't provide driver context as
> > >    they copy the data structures passed in registration API, but a
> > >    simpler
> > >    way to get driver context would be desirable.
> > 
> > Sure the kernel crypto API can and has to maintain a per-instance data
> > structure.
> > 
> > See the crypto/drbg.c for instance.
> > 
> > static int drbg_kcapi_random(struct crypto_rng *tfm,
> > 
> >                              const u8 *src, unsigned int slen,
> >                              u8 *dst, unsigned int dlen)
> > 
> > {
> > 
> >         struct drbg_state *drbg = crypto_rng_ctx(tfm);
> > 
> > static int drbg_kcapi_seed(struct crypto_rng *tfm,
> > 
> >                            const u8 *seed, unsigned int slen)
> > 
> > {
> > 
> >         struct drbg_state *drbg = crypto_rng_ctx(tfm);
> > 
> > The key is:
> >         alg->base.cra_ctxsize   = sizeof(struct drbg_state);
> > 
> > during initialization since the kernel crypto API allocates that buffer
> > for
> > you and releases it during deallocation.
> 
> The difference here is that memory is allocated by crypto and driver has
> no way to pass "it's" own data while doing registration. Ideally
> registration should accept a pointer/long and pass that back on a
> callbacks

Looking at your code, it seems you do what makes sense: there is only one 
instance of the driver, if at all. Thus, having qcom_rng_dev as static makes 
sense. The kernel crypto API allows arbitrary instances of the RNG as well as 
frequent allocations and deallocations. And this is why there must be a 
disconnect between the one hardware-resource driver-instance data structure 
and the (potentially) multiple crypto API RNG instances and their data 
structures.

> 
> Currently am doing bunch of initialization in .probe (platform driver)
> and I think recommendation would be to move that to .cra_init, which seem
> plausible but I don't have pdev to read hw_resource etc.. so would still
> need to get that.

It seems that your allocation during probe relates to the hardware resource 
where you only have one in the system. Thus, doing the allocation here makes 
sense. And, you do not want to perform probe or such resource allocation once 
per crypto API RNG instance allocation. As said, there can be multiple or even 
they can be allocated and deallocated frequently. This in particular applies 
if your driver's "stdrng" has the highest prio which means that it will be 
allocated and deallocated frequently.

Ciao
Stephan


