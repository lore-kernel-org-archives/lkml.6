Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B8FC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC3D21757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCb0H3w6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC3D21757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeHHBgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:36:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeHHBgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:36:25 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FEA621736;
        Tue,  7 Aug 2018 23:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533683982;
        bh=KQo53lsxG2Qv89B8xS/HeA8vH7OtC4T/WpK8UHCCX98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iCb0H3w6csp/gsFIj3V5HVxq0VXqGJg8kHH+eRQcg8ZRzNqnCYsNqR9SLa6T00Z8s
         ctCuVsavxqD9bsTSQJEEOzmdj1FsghhiFl75WRStDgt277dfrMeyJgEyg1Vgly58A5
         PVKiPBxSGrw5WAVVGwZMcyDFh5HPnpQv+jS87qkk=
Date:   Tue, 7 Aug 2018 16:19:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [RFC PATCH 8/9] crypto: arm/poly1305 - add NEON accelerated
 Poly1305 implementation
Message-ID: <20180807231941.GC25300@gmail.com>
References: <20180806223300.113891-1-ebiggers@kernel.org>
 <20180806223300.113891-9-ebiggers@kernel.org>
 <CAKv+Gu_T+f=isb_dBF7icfTHApG+E8Y5njSQ=NmtyTHEN2VMgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_T+f=isb_dBF7icfTHApG+E8Y5njSQ=NmtyTHEN2VMgg@mail.gmail.com>
User-Agent: Mutt/1.10.1+60 (20b17ca5) (2018-08-02)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Tue, Aug 07, 2018 at 02:09:05PM +0200, Ard Biesheuvel wrote:
> On 7 August 2018 at 00:32, Eric Biggers <ebiggers@kernel.org> wrote:
> > From: Eric Biggers <ebiggers@google.com>
> >
> > Add the Poly1305 code from OpenSSL, which was written by Andy Polyakov.
> > I took the .S file from WireGuard, whose author has made the needed
> > tweaks for Linux kernel integration and verified that Andy had given
> > permission for GPLv2 distribution.  I didn't make any additional changes
> > to the .S file.
> >
> > Note, for HPolyC I'd eventually like a Poly1305 implementation that
> > allows precomputing powers of the key.  But for now this implementation
> > just provides the existing semantics where the key and nonce are treated
> > as a "one-time key" that must be provided for every message.
> >
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Hi Eric,
> 
> In the past, I worked with Andy on several occasions to get my kernel
> changes incorporated into the upstream OpenSSL version of the
> 'perlasm' .pl file.
> 
> This achieves a number of things:
> - we get a readable version of the code in the kernel tree,
> - our changes are reviewed upstream
> - upgrading involves grabbing the latest .pl file rather than merging
> generated code (which requires careful review)
> - GPLv2 permission is made explicit, rather than something someone
> claims to have reached agreement on,
> - no legal ambiguity whether the output of the perl script is covered
> by the license (which is what we incorporate here)
> 
> Note that the 'available under GPL depending on where you obtained the
> code' in the CRYPTOGAMS license likely conflicts with the GPL itself,
> but I am not a lawyer so I'd much prefer having the upstream copy
> mention this explicitly.

First, note that Jason is proposing adding this exact same .S file as part of
his new "zinc" cryptography library, along with 7 other OpenSSL .S files.  So it
may really be him you need to convince.

But yes, I don't really like the approach of just including the .S output of the
.pl script either, as it loses semantic information that was in the .pl script.
Ideally the source should either be the .pl script, or else a real hand written
.S file with the proper comments and macros to make it readable -- not something
in-between.

Getting the license clarification and possibly other changes upstream is a good
idea too.  I noticed, though, that the actual wording used in some files
upstream ("Permission to use under GPLv2 terms is granted") apparently still
isn't considered sufficient by some, so a separate clarification from Andy was
apparently still needed: see kernel commit c2e415fe75bbc83c1...

- Eric
