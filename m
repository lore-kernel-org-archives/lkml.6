Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89347C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593F52075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593F52075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbeKTQ3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 11:29:54 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:45356 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732199AbeKTQ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 11:29:54 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gOz7B-0000Ca-SE; Tue, 20 Nov 2018 14:02:26 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gOz73-00065g-AM; Tue, 20 Nov 2018 14:02:17 +0800
Date:   Tue, 20 Nov 2018 14:02:17 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Martin Willi <martin@strongswan.org>
Subject: [RFC PATCH v2 0/4] Exporting existing crypto API code through zinc
Message-ID: <20181120060217.t4nccaqpwnxkl4tx@gondor.apana.org.au>
References: <20181105232526.173947-1-ebiggers@kernel.org>
 <20181105232526.173947-11-ebiggers@kernel.org>
 <CAKv+Gu-o0khD5=0EOkv2PiczMs5uZ=XP9V=G2ogBNMK8Kb93sw@mail.gmail.com>
 <20181112185816.GA8663@gmail.com>
 <20181116060227.hwu4igi6bp26ddpi@gondor.apana.org.au>
 <20181117001718.GA175522@gmail.com>
 <CAHmME9rtsCk8ZLt05xRKMGr4CVRnaUvCaVOS_WX3N22HOat4-A@mail.gmail.com>
 <20181119052451.qttzfgcm4hvbdc4u@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119052451.qttzfgcm4hvbdc4u@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 01:24:51PM +0800, Herbert Xu wrote:
>
> In response to Martin's patch-set which I merged last week, I think
> here is quick way out for the zinc interface.
> 
> Going through the past zinc discussions it would appear that
> everybody is quite happy with the zinc interface per se.  The
> most contentious areas are in fact the algorithm implementations
> under zinc, as well as the conversion of the crypto API algorithms
> over to using the zinc interface (e.g., you can no longer access
> specific implementations).
> 
> My proposal is to merge the zinc interface as is, but to invert
> how we place the algorithm implementations.  IOW the implementations
> should stay where they are now, with in the crypto API.  However,
> we will provide direct access to them for zinc without going through
> the crypto API.  IOW we'll just export the functions directly.
> 
> Here is a proof of concept patch to do it for chacha20-generic.
> It basically replaces patch 3 in the October zinc patch series.
> Actually this patch also exports the arm/x86 chacha20 functions
> too so they are ready for use by zinc.
> 
> If everyone is happy with this then we can immediately add the
> zinc interface and expose the existing crypto API algorithms
> through it.  This would allow wireguard to be merged right away.
> 
> In parallel, the discussions over replacing the implementations
> underneath can carry on without stalling the whole project.
> 
> PS This patch is totally untested :)

Here is an updated version demonstrating how we could access the
accelerated versions of chacha20.  It also includes a final patch
to deposit the new zinc version of x86-64 chacha20 into
arch/x86/crypto where it can be used by both the crypto API as well
as zinc.

The key differences between this and the last zinc patch series:

1. The crypto API algorithms remain individually accessible, this
is crucial as these algorithm names are exported to user-space so
changing the names to foo-zinc is not going to work.

2. The arch-specific algorithm code lives in their own module rather
than in a monolithic module.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
