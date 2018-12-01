Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DEDC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DDD2081D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DDD2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeLAUAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 15:00:48 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:34382 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeLAUAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 15:00:48 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gT0xC-0001Jd-J0; Sat, 01 Dec 2018 16:48:46 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gT0x5-00017V-Jw; Sat, 01 Dec 2018 16:48:39 +0800
Date:   Sat, 1 Dec 2018 16:48:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dave Rodgman <dave.rodgman@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        nd <nd@arm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: Re: [PATCH 7/8] lib/lzo: separate lzo-rle from lzo
Message-ID: <20181201084839.m6lqnuvb2vioh6d4@gondor.apana.org.au>
References: <20181130142600.13782-1-dave.rodgman@arm.com>
 <20181130142600.13782-8-dave.rodgman@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130142600.13782-8-dave.rodgman@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 02:26:30PM +0000, Dave Rodgman wrote:
> To prevent any issues with persistent data, separate lzo-rle
> from lzo so that it is treated as a separate algorithm, and
> lzo is still available.
> 
> Link: http://lkml.kernel.org/r/20181127161913.23863-8-dave.rodgman@arm.com
> Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Markus F.X.J. Oberhumer <markus@oberhumer.com>
> Cc: Matt Sealey <matt.sealey@arm.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Nitin Gupta <nitingupta910@gmail.com>
> Cc: Richard Purdie <rpurdie@openedhand.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Cc: Sonny Rao <sonnyrao@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
> ---
>  Documentation/lzo.txt      |  12 ++-
>  crypto/Makefile            |   2 +-
>  crypto/lzo-rle.c           | 175 +++++++++++++++++++++++++++++++++++++
>  crypto/tcrypt.c            |   4 +-
>  drivers/block/zram/zcomp.c |   1 +
>  include/linux/lzo.h        |   4 +
>  lib/lzo/lzo1x_compress.c   |  42 +++++++--
>  lib/lzo/lzodefs.h          |   3 +-
>  8 files changed, 226 insertions(+), 17 deletions(-)
>  create mode 100644 crypto/lzo-rle.c

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
