Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FA3C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4580F208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0VokU1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4580F208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751022AbeFUESC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 00:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750798AbeFUESA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 00:18:00 -0400
Received: from localhost (unknown [106.200.222.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9311020883;
        Thu, 21 Jun 2018 04:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529554680;
        bh=RXUixn/EiPJWO3e3rDYygjv9Kmm4pjcyzUs2zCUMrhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z0VokU1imoTvrDmS9SzyHQp4eEvM/QluDxdQFxS9stvJ+Z9XAKc8RFsm2elLneS3w
         c9ubDSeW8Vx6LcpR1bEOoRmU/aRhOBvnzZxhnu4j6ZI1ANtEJQwfabd9haG1N9cbKk
         V38dII/OO0vJLt2zW9q3dk9CBdWX/Zh0fMA7qyRA=
Date:   Thu, 21 Jun 2018 09:47:51 +0530
From:   Vinod <vkoul@kernel.org>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
Message-ID: <20180621041751.GC27187@vkoul-mobl>
References: <20180618141259.23141-1-vkoul@kernel.org>
 <20180618141259.23141-4-vkoul@kernel.org>
 <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au>
 <20180620053204.GG13316@vkoul-mobl>
 <CANc+2y5-7S_1bvMYs54X3MqCkcsha3iNe1BGa-pG=_xH5xYn1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANc+2y5-7S_1bvMYs54X3MqCkcsha3iNe1BGa-pG=_xH5xYn1Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi PrasannaKumar,

On 20-06-18, 23:15, PrasannaKumar Muralidharan wrote:
> Hi Vinod,
> 
> On 20 June 2018 at 11:02, Vinod <vkoul@kernel.org> wrote:
> > On 19-06-18, 22:28, Herbert Xu wrote:
> >> On Mon, Jun 18, 2018 at 07:42:59PM +0530, Vinod Koul wrote:
> >> > Qcom 8996 and later chips support prng v2 where we need to only
> >> > implement .read callback for hwrng.
> >> >
> >> > Add a new table for v2 which supports this and get version required for
> >> > driver data.
> >> >
> >> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> >>
> >> Is this really a pseudo-RNG? If so it needs to be moved over to
> >> the algif_rng interface.
> >>
> >> hwrng is for true hardware RNGs only, because it may be directly
> >> fed into /dev/random.
> >
> > I am trying to find how how much random output this hardware generates.
> >
> > Meanwhile, can you please point out examples/Documentation for algif_rng
> > and if any test tools for this?
> 
> As Herbert suggested exynos rng is a good example. It was wrongly
> using hwrng framework then switched to using crypto framework.
> 
> I have a patch for msm rng using crypto framework, only compile tested
> though. You can find the patch at
> https://pastebin.ubuntu.com/p/44r6BJgBkN/. I am having a hard time
> sending patches via git send-email form a gmail account so I have put
> it in pastebin. Feel free to use it if that is useful.

Ah, I already started based on msm downstream implementation (they had
one using crypto APIs too). Ideally you should have posted it and tested
it.

Thanks
-- 
~Vinod
