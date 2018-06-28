Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFCFC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF502797C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGHb0UlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF502797C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967279AbeF1WEf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966628AbeF1WEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:04:32 -0400
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1396C27A0D;
        Thu, 28 Jun 2018 22:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530223472;
        bh=Mmeqw3YH4GYdWX05xs9GyVXvUOckmUYVOJfxBhmi/8w=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=lGHb0UlW7TWNWvDBu3x4zos/nj2A3tN2N3SrVpSKVY+ipQkPBUpJjaITXwl4ZPypG
         R1GuOymsBIxUdWosFa38LZP9j1qJQyaTE1iP+m+qZLqq8cxqCWRHGgVe5/25pMx1td
         oQQp90HyHCRszUA0RPF1wc9oKkDDtUs1dHGfR88M=
Received: by mail-oi0-f43.google.com with SMTP id c2-v6so6666058oic.1;
        Thu, 28 Jun 2018 15:04:32 -0700 (PDT)
X-Gm-Message-State: APt69E2lwBIlEWlBp0XondiKaL6/wrg3EpeI3Qj5DAxsl5SohoSgRZS9
        e8/G2xBO02ZdEC0BsVEqBQpxqg5JJCV+zeS0mLI=
X-Google-Smtp-Source: AAOMgpcH/n49paDupa2CFdef4eCfFdyab/fez7vZk30lsSK87+vTiHIR0BVm0hoCTAeJqWtHXw000KgDIuKvkjRPnGc=
X-Received: by 2002:aca:c42:: with SMTP id i2-v6mr6964097oiy.309.1530223471370;
 Thu, 28 Jun 2018 15:04:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4b11:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 15:04:30
 -0700 (PDT)
In-Reply-To: <20180621115312.rfmbitrhqi44wu5w@gondor.apana.org.au>
References: <20180618141259.23141-1-vkoul@kernel.org> <20180618141259.23141-4-vkoul@kernel.org>
 <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au> <966e9cd4-70a3-8d54-df0f-16df3df45fb5@linaro.org>
 <20180621101506.rnklbtapvfdev4xb@gondor.apana.org.au> <e39deb02-8fa4-84ac-b33e-d692402189a1@linaro.org>
 <20180621115312.rfmbitrhqi44wu5w@gondor.apana.org.au>
From:   Timur Tabi <timur@kernel.org>
Date:   Thu, 28 Jun 2018 17:04:30 -0500
X-Gmail-Original-Message-ID: <CAOZdJXVO-0JDvX4OdJMNCmY_BXrEenXpoWBf=Ww5uFBtXKN86A@mail.gmail.com>
Message-ID: <CAOZdJXVO-0JDvX4OdJMNCmY_BXrEenXpoWBf=Ww5uFBtXKN86A@mail.gmail.com>
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        linux-crypto@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 6:53 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, Jun 21, 2018 at 02:27:10PM +0300, Stanimir Varbanov wrote:

> So does it generate one bit of output for each bit of hardware-
> generated entropy like /dev/random? Or does it use a hardware-
> generated seed to power a PRNG?

I have some information to answer this question, although I'm not sure
I can give a strict "yes/no" answer.

There are a couple relevant documents:

https://www.qualcomm.com/news/onq/2014/11/07/cryptographic-module-snapdragon-805-fips-140-2-certified
https://csrc.nist.gov/CSRC/media/projects/cryptographic-module-validation-program/documents/security-policies/140sp2944.pdf

I also got response from a Qualcomm employee:

"The Qualcomm random number generator used in Snapdragon chips
consists of an entropy source coupled with the HASH-DRBG deterministic
random bit generator from NIST Special Publication 800-90A, using
SHA-256 as the hash function.

The entropy source is based on sampled ring oscillators.  Four ring
oscillators are used to provide high assurance of adequate entropy.
The entropy from the ring oscillators is conditioned using the
'derivation function' specified by NIST Special Publication 800-90A.
The conditioned entropy is essentially perfect fully entropic data.
It is used both to seed and to periodically reseed the DRGB."

My understanding is that the PRNG is a real entropy source with some
logic used to normalize the values.  To quote: "No RNG uses data
directly from the entropy source; bits in the output are likely
correlated and unlikely to occur with 50% probability. The entropy
post-processing is designed to turn dirty data in clean data."

Based on the above, it seems to me that the Qualcomm PRNG qualifies as
a real hardware RNG and porting to algif_rng is not the correct path.
