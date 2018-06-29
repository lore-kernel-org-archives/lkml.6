Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9FAC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A6222451
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yPq7mQyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A6222451
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965314AbeF2Iht (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:37:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965245AbeF2Ihq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:37:46 -0400
Received: from localhost (unknown [122.167.66.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5322122451;
        Fri, 29 Jun 2018 08:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530261466;
        bh=lktdXRbnjeE+COp7Q8uWvwlE3wLVf0XHUYlu6i5q460=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yPq7mQyy21BjPSYXQ25HsmK5wsLrGllRCq7nRimxRbsTvUBowbwFxwI/osfelvq46
         PR3apEffv77w4Y+9tb8geyFO7uZLaHbaZmKE5ykeRQmM3aqR14JWDvrlsK2tIW5bdt
         nInE2TVMQqFLaS2PxSTAQ86XsWigSn/knKONNltg=
Date:   Fri, 29 Jun 2018 14:07:32 +0530
From:   Vinod <vkoul@kernel.org>
To:     Timur Tabi <timur@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-crypto@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
Message-ID: <20180629083732.GB22377@vkoul-mobl>
References: <20180618141259.23141-1-vkoul@kernel.org>
 <20180618141259.23141-4-vkoul@kernel.org>
 <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au>
 <966e9cd4-70a3-8d54-df0f-16df3df45fb5@linaro.org>
 <20180621101506.rnklbtapvfdev4xb@gondor.apana.org.au>
 <e39deb02-8fa4-84ac-b33e-d692402189a1@linaro.org>
 <20180621115312.rfmbitrhqi44wu5w@gondor.apana.org.au>
 <CAOZdJXVO-0JDvX4OdJMNCmY_BXrEenXpoWBf=Ww5uFBtXKN86A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOZdJXVO-0JDvX4OdJMNCmY_BXrEenXpoWBf=Ww5uFBtXKN86A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-06-18, 17:04, Timur Tabi wrote:
> On Thu, Jun 21, 2018 at 6:53 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > On Thu, Jun 21, 2018 at 02:27:10PM +0300, Stanimir Varbanov wrote:
> 
> > So does it generate one bit of output for each bit of hardware-
> > generated entropy like /dev/random? Or does it use a hardware-
> > generated seed to power a PRNG?
> 
> I have some information to answer this question, although I'm not sure
> I can give a strict "yes/no" answer.
> 
> There are a couple relevant documents:
> 
> https://www.qualcomm.com/news/onq/2014/11/07/cryptographic-module-snapdragon-805-fips-140-2-certified
> https://csrc.nist.gov/CSRC/media/projects/cryptographic-module-validation-program/documents/security-policies/140sp2944.pdf
> 
> I also got response from a Qualcomm employee:
> 
> "The Qualcomm random number generator used in Snapdragon chips
> consists of an entropy source coupled with the HASH-DRBG deterministic
> random bit generator from NIST Special Publication 800-90A, using
> SHA-256 as the hash function.
> 
> The entropy source is based on sampled ring oscillators.  Four ring
> oscillators are used to provide high assurance of adequate entropy.
> The entropy from the ring oscillators is conditioned using the
> 'derivation function' specified by NIST Special Publication 800-90A.
> The conditioned entropy is essentially perfect fully entropic data.
> It is used both to seed and to periodically reseed the DRGB."
> 
> My understanding is that the PRNG is a real entropy source with some
> logic used to normalize the values.  To quote: "No RNG uses data
> directly from the entropy source; bits in the output are likely
> correlated and unlikely to occur with 50% probability. The entropy
> post-processing is designed to turn dirty data in clean data."
> 
> Based on the above, it seems to me that the Qualcomm PRNG qualifies as
> a real hardware RNG and porting to algif_rng is not the correct path.

I think Stan did bring this point earlier that PRNG is compliant to
FIPS-140-2. So it can be used by rng clients for various purposes but
should not be fed to dev/random as the hw_random does.

Herbert, can you please confirm..

-- 
~Vinod
