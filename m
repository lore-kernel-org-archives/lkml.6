Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05D6C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3877421729
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3877421729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeHHMPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:15:25 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:43588 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeHHMPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:15:25 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fnLCc-0001Wu-VE; Wed, 08 Aug 2018 17:56:27 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fnLCX-0005eq-L3; Wed, 08 Aug 2018 17:56:21 +0800
Date:   Wed, 8 Aug 2018 17:56:21 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Megha Dey <megha.dey@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC] crypto: Remove mcryptd
Message-ID: <20180808095621.h7ecacftx5ofe5ki@gondor.apana.org.au>
References: <1526089453-6542-1-git-send-email-megha.dey@linux.intel.com>
 <20180720035325.m5tzeuqsfej3y6wd@gondor.apana.org.au>
 <1532651107.19157.24.camel@megha-Z97X-UD7-TH>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532651107.19157.24.camel@megha-Z97X-UD7-TH>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 05:25:07PM -0700, Megha Dey wrote:
> 
> 1. On the existing algorithms covered in aesni_intel-glue.c (eg:
> __cbc-aes-aesni), 3 algorithms are registered in /proc/crypto:
> 
>      __cbc(aes)
>      cryptd(__cbc-aes-aesni)--> registered via cryptd_create_skcipher
> 
>      cbc(aes)
>      cbc-aes-aesni	--> registered via simd_skcipher_create_compat
> 
>      __cbc(aes)
>      __cbc-aes-aesni    --> registered as the internal algorithm
> 
> I would want to know why do we need the cryptd(__cbc-aes-aesni)
> algorithm at all. I do not see any of the associated setkey, encrypt or
> decrypt functions getting called during the selftest or while running
> tcrypt. I just see the simd_(setkey, encrypt, decrypt) functions
> directly called the inner algorithms. However, if I remove the cryptd
> algorithm, none of the algorithms are registered.

The simd functions are the fast path where you are running in a
context where SIMD can be used directly.  cryptd is the slow path
where we defer the work to a work queue.

> > What you need to do is create an actual simd wrapper with cryptd
>  
> This simd wrapper is already present for skcipher right(in simd.c)?
> Assuming we only have ciphers and no hash algorithms, are any changes
> required in these wrappers?

For skcipher yes they already exist.  But this thread was about
hashes.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
