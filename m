Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828FBECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514A421528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514A421528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeJRABO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:01:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46374 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeJRABO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:01:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id d8-v6so30616775qtk.13;
        Wed, 17 Oct 2018 09:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8qIE4YFd936zhgyWBPbFS/u+ZCdQrZskD39AnQet0w=;
        b=fZFpuHmg+2aluhFp+HRL0hGX0pNc5d2Al7I/9ObqS0daaksJjt4lNs2asmYu34SnGH
         ecpvyJaQM7BEWc85zBBmQUkg2MLQhWMUjWfTwDS0ohjI6y+qGV7c2dDvTqEPI6f9uH3o
         xG8mieihFKjMOVPNknTweaRjUgbOXBI72eWVbXRBCxkxpVwBpjZCJM3TWxjhdgZxZ90R
         YPmFxJ3d0ztL+RynQpfAyPOf7HhuiQUrpPDjyb04RWVMF/qUuk2Oi65Bv440Z9r84ig2
         OWp0TQ+6EevI3BIdA7Mvduxj7dMhp/ZP7Kx8EcEHAUAbQNYK9sDsHdExJ9c8PkyO60HK
         R9mw==
X-Gm-Message-State: ABuFfoi5Y6tTBTuSchQyC5PdJvVeX50uYx81Nxx3nUjAodtmiiIJY6QE
        VUktTSPgEymuX5aEGSp3pya8Jfo435X1jTp6p2M=
X-Google-Smtp-Source: ACcGV60AZMEEvWXeDCoYlDnNFEOswUDBmNAkI4sZViE7iHDot+mwjAZbiFDJHEXDht88RIj9Iiauipkt1aV+3khIasU=
X-Received: by 2002:aed:3968:: with SMTP id l95-v6mr24193510qte.96.1539792291214;
 Wed, 17 Oct 2018 09:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181016100848.1329843-1-arnd@arndb.de> <07e372cb-06da-bf95-bc53-64ee09fc8e76@oracle.com>
 <3f8e7a6e9532abcd772927432d5f00cebeba08b8.camel@intel.com>
In-Reply-To: <3f8e7a6e9532abcd772927432d5f00cebeba08b8.camel@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 18:04:35 +0200
Message-ID: <CAK8P3a3RiMHVkoA+Wp_abPJ5Fzwk5UdhoOaxt++q4_YnzDRwfA@mail.gmail.com>
Subject: Re: [PATCH net-next] ixgbe: fix XFRM_ALGO dependency
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     shannon.nelson@oracle.com, David Miller <davem@davemloft.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 5:53 PM Jeff Kirsher
<jeffrey.t.kirsher@intel.com> wrote:
> On Tue, 2018-10-16 at 09:35 -0700, Shannon Nelson wrote:
> > On 10/16/2018 3:03 AM, Arnd Bergmann wrote:
> > > A separate Kconfig symbol now controls whether we include the ipsec
> > > offload code. To keep the old behavior, this is left as 'default
> > > y'. The
> > > dependency in XFRM_OFFLOAD still causes a circular dependency but
> > > is
> > > not actually needed because this symbol is not user visible, so
> > > removing
> > > that dependency on top makes it all work.
> > >
> > > Fixes: eda0333ac293 ("ixgbe: add VF IPsec management")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I agree with Shannon's suggested changes.  Arnd, are you working on v2?
> Or would you like me to take care of it?

I was planning to respin it, but didn't get around to it yet, and will
be travelling for the next week, so I'd welcome if you can take over
from here. Shannon's comments all make sense to me as well.

> > > +config IXGBE_IPSEC
> > > +   bool "IPSec XFRM cryptography-offload accelaration"
> > > +   default n
> >
> > remove this "default n" line?

I meant for this to say "default y", as I said in the changelog,
but feel free to pick whichever default makes sense to you
make make the description match ;-)

Thanks,

       Arnd
