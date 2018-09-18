Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7390CECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3192133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="llhy5RN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3192133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbeISCLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:11:22 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:54467 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729693AbeISCLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:11:21 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id a6ee206a;
        Tue, 18 Sep 2018 20:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=mail; bh=0prtMTtcc0LUR8Htpwrzq7Z6IVk=; b=llhy5RN
        2TS2w+0LzFuiTUcw/vk4SGu7h+tD5P1zBxQss5uVPAxyxqLtxT9SUB/+qs9/1QTG
        Dhz6QZjzMh6xPdDH6ATSrOrGdnkGeZVTDdTValcj8xwnG8O7of0zsGm9aml11E83
        sHNrpiE61OIPI5xSWeszeTQLwk0y/CAkclItAoxxh8p/O+fcOTV3PQi9pGBwH5wu
        rOAqD5WIIL5KtRQoMlmwAQdANBU0enHvyYV3UuVCrvCqRvlqX/d+vf+193om21lc
        u6E6rjsFXTzkDe0+K7aCFPFuFt29s+eZB7O0F+h3+3Fjg7+YmEs3iLBPBZ1jJr12
        S9gmjPXE5lqCC0Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7d3bd141 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 18 Sep 2018 20:19:25 +0000 (UTC)
Date:   Tue, 18 Sep 2018 22:36:59 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography
 library
Message-ID: <20180918203658.GA28723@zx2c4.com>
References: <20180911214737.GA81235@gmail.com>
 <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
 <20180911233015.GD11474@lunn.ch>
 <20180911.165739.2032677219588723041.davem@davemloft.net>
 <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com>
 <CAKv+Gu8QgRo-Oex2Sk5unET3FMq+1Cp2btAWXCB8xsALxjatHg@mail.gmail.com>
 <CAHmME9qwRzuoo-3Hxahwu=Li2LCz06Uowaq1GFmkts6tsffM7w@mail.gmail.com>
 <CAKv+Gu8OKyVvvgLy48GDV2KJt-UmmHbf5x0qNxQC_SDiddb9-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8OKyVvvgLy48GDV2KJt-UmmHbf5x0qNxQC_SDiddb9-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Tue, Sep 18, 2018 at 11:53:11AM -0700, Ard Biesheuvel wrote:
> On 17 September 2018 at 08:52, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > Hi Ard,
> >
> 
> Given that you show no interest whatsoever in gaining an understanding
> of the underlying requirements that we have to deal with in the crypto
> API, the only way to get my point across is by repeatedly stating it

Sorry if I've come across that way, but I am certainly interested in
gaining such an understanding of said requirements.

> I have pointed out to you numerous times (as has Eric) that the
> ChaCha20 ARM code you are importing from the OpenSSL project has been
> found to be slower on Cortex-A7, which represents the vast majority of
> devices expected to be in the field in 1~2 years.

I mentioned in the other thread that I intend immanently to begin
benching on a variety of ARM boards, and I should have numbers and
results and conclusions somewhat soon for the list.

My initial notion here was that it'd be better to go with AndyP's code
no matter what, and then later work with him on contributing said
improvements, and then port these back to the kernel. However, you and
Andy made a compelling point about code replacement -- that it's okay to
replace all in one go only if there are positive benchmark results. So I
think what I'll do to appease this is -- if the benchmarks are indeed
how Eric suggested -- stick with your faster code, and then follow up
with replacement plans after the merge. (I feel a bit more comfortable
with varying ChaCha code, because implementations tend to be pretty
straight forward and harder to screw up in subtle ways than, say,
poly1305 or curve25519.)

> have asked you more than once to split out your changes to the
> upstream OpenSSL code into separate patches so we can more easily
> track them, but v5 now puts them in the commit log (again) [but in a
> corrupted way - the preprocessor directives are filtered out by
> git-commit], which means we cannot use git diff/blame etc to look at
> them.

Didnt't realize this was so important to you. It's trivial to do, so
I'll do that for AndyP's implementations for the next revision.


> Upstreaming code is about taking an interest in other people's use
> cases, and about choosing your battles. It is unfortunate that we have
> spent all this time talking about a couple of crypto routines, while
> the actual meat of your submission is in WireGuard itself, which I'm
> sure you much rather talk about.

I don't find it unfortunate; getting the crypto right is of the utmost
importance.

Regards,
Jason
