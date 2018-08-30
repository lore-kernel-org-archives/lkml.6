Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80280C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED952082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="Hiu7BHB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED952082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeH3RBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:01:05 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:16610 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbeH3RBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1535633942;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=3YPU515KjwZS3K4Fkd8NRjgkOQW1EcQEfZybFhiBmFs=;
        b=Hiu7BHB/jUbCysV1cH/ICkNfqCzD8MM4WKi7AmK9rY8d+/FvqAvXUAaxaYLMvhYqXh
        mroducwxQ3gA1IOq0vyBM+iCi0T4sINc90G4mB3AowKsZgbYJh/crDVOU2912WT4ye2n
        qOuytL3fTF6tZC5mDcT96kAw94ONhfPkhl79ZJZ/uyzusg3WRbpzf83kUx6gi8EDw6In
        zhspR9O8Bfj/hqMUyIBdeUXDfjYoPlgKxCRdAliJ5y5igO3DGDYjZD9eWpBe6cTsb9ed
        6K43wVoq+eT/U1hkU7wWWUuCp8IFQALPmWdVVA8TieTu9rUS0nsyVUHajz+2jquF3JDI
        s1WQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaIfSfABn3"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 43.21 DYNA|AUTH)
        with ESMTPSA id e08f60u7UCu2HU6
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 30 Aug 2018 14:56:02 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Locking for HW crypto accelerators
Date:   Thu, 30 Aug 2018 14:56:01 +0200
Message-ID: <3053033.se6UkFii4W@tauon.chronox.de>
In-Reply-To: <CAJKOXPfVXnazraHq-NCCM+h26FFi1U6Z3OSYOX17XH3bj-UDLQ@mail.gmail.com>
References: <CAJKOXPfVXnazraHq-NCCM+h26FFi1U6Z3OSYOX17XH3bj-UDLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 30. August 2018, 14:22:22 CEST schrieb Krzysztof Kozlowski:

Hi Krzysztof,

> Hi,
> 
> I am trying to figure out necessary locking on the driver side of
> crypto HW accelerator for symmetric hash (actually: CRC). I
> implemented quite simple driver for shash_alg.
> 
> I looked at the docs, I looked at the crypto kcapi core code... and
> there is nothing about necessary locking. kcapi does not perform it.
> 
> My HW is quite similar to drivers/crypto/stm32/stm32_crc32.c so it has
> only one HW set of registers for dealing with CRC. Or in other words,
> only one queue of one element. :) I implemented all shash_alg
> callbacks - init(), update(), final()... and also finup() (manually
> calling update+final) and digest() (init+update+final).
> 
> Now imagine multiple user-space users of this crypto alg where all of
> them call kcapi_md_digest() (so essentially init() -> update() ->
> final()). It seems that kcapi does not perform any locking here so at
> some point updates from different processes might be mixed with
> finals:
> 
> Process A:             Process B:
> init()
>                        init()
> update()
>                        update()
> final()
>                        final()
> 
> My findings show that the requests are indeed being mixed with each other...
> 
> Should driver perform any weird locking here? Or maybe that is the
> case of using ONLY the digest() callback (so no update, no final)
> because my HW cannot track different kcapi requests?

The hashing is performed on a buffer provided by the caller. E.g. it is the 
buffer pointed to by the ahash request or the shash desc structure. All 
operations of init/update/final operate on that memory.

If you have parallel requests, each caller has a private buffer that it 
provides to the kernel crypto API. This applies also to AF_ALG.

Thus, as long as the individual operations of init/update and final are atomic 
operations, there should be no locking necessary.

Thus, all your driver needs to guarantee is the atomicitcy of the init/update/
final operation in respect to your hardware state.

Ciao
Stephan


