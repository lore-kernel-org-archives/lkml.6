Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B70AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4217120836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWoXzqjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4217120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757243AbeFSMbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757218AbeFSMbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:31:37 -0400
Received: from localhost (unknown [106.200.222.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E8CF2083D;
        Tue, 19 Jun 2018 12:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529411496;
        bh=W0TZjT7mPnyS0rkwEIu8pbAwFVYRgGmAoKIvqX4/4Dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jWoXzqjnRMjIK7EjfgOkQR5Kx0I1tNpw3iNBp9VHQ6cFHAlKR09xwTJGmfxY466C6
         kB55dzADfFLZejYrWSHtL1/F3mEBLTyj2gPESJvEoEcS5Ze+mGbTcO1RcA8UUN/Z9t
         sRj8v64cuC2V8+yBpj3v5PG5fKMkClTCnYdvrbDA=
Date:   Tue, 19 Jun 2018 18:01:28 +0530
From:   Vinod <vkoul@kernel.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 2/2] hwrng: msm - Add support for prng v2
Message-ID: <20180619123128.GD13316@vkoul-mobl>
References: <20180619095430.26358-1-vkoul@kernel.org>
 <20180619095430.26358-3-vkoul@kernel.org>
 <b7543a73-e35a-c015-3bba-1e3ab3a389d5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7543a73-e35a-c015-3bba-1e3ab3a389d5@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-18, 15:11, Stanimir Varbanov wrote:

Hi Stan,

> On 06/19/2018 12:54 PM, Vinod Koul wrote:

> >  	rng->hwrng.name = KBUILD_MODNAME,
> > -	rng->hwrng.init = msm_rng_init,
> > -	rng->hwrng.cleanup = msm_rng_cleanup,
> > -	rng->hwrng.read = msm_rng_read,
> > +	rng->hwrng.read = msm_rng_read;
> > +	skip_init = (unsigned long)of_device_get_match_data(&pdev->dev);
> 
> skip_init is unsigned int, despite I think you don't need to cast it.

This is needed. of_device_get_match_data returns void *, so an explicit
cast is required for integer warning, otherwise it shows up as
-Wint-conversion warning

> >  static const struct of_device_id msm_rng_of_match[] = {
> > -	{ .compatible = "qcom,prng", },
> > +	{ .compatible = "qcom,prng", .data = (void *)0},
> > +	{ .compatible = "qcom,prng-v2", .data = (void *)1},
> 
> No need to cast. IMO it'd be better to create defines for these numbers:

again driver_data is void * and we need a cast

> 
> #define PRNG_V1	0
> #define PRNG_V2	1

That can be done. Since it is more used as flag and not version number
here to skip init, it doesn't really mean versions now

Thanks
-- 
~Vinod
