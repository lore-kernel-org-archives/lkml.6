Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D99ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 22:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE222083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 22:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nvYf5kHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE222083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeJVHIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 03:08:07 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:50329 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbeJVHIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 03:08:07 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 75ff71f0;
        Sun, 21 Oct 2018 22:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=nLbnq+O5Yf6wX78GRfTMfmle79Y=; b=nvYf5k
        HJmrzII5wOE9Vla8BOLNa7FQLif7i73EePU6hd7s/VvLUW4XhR5yee7y65WKVE9G
        0s/7FnP5x/DLfJjWt/uSvUop31lD20AvbEsqfnisbzUkNxTF5fTUvtcdjPrNZDDO
        XBhBOozGz2dLb9Mnzou3YfLtMAAjY5ueWtQZMf0ZMeVP5gdOT23odcmgxOHEsM9C
        w7tpPxQCEGc7NPIg9bRbFEd0uyhwqW2ZWGZBH8rEg4nKvmC2dBmfguGjro7/zQgk
        ZUQ8tEvkciX0QnO99gvFRfnD6hbkoEfLDfmIOhQKTNEMGGfSoxfl/J37zZraJ3LZ
        hMiXhJ7UMSQkkpWQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c348ab38 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sun, 21 Oct 2018 22:49:42 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id c32so38199484otb.8;
        Sun, 21 Oct 2018 15:52:07 -0700 (PDT)
X-Gm-Message-State: ABuFfogrEQCqdfJm8QNtec8i9JrC0xKemF3Cv0pIOhp1x/uES9OJVeWB
        P2Ra6qiOUAG8t+dk0wtik5/OjWG4nG3K9AOBHv4=
X-Google-Smtp-Source: ACcGV60J9mEaa064/kLuKKPryLrLSg1qQjc4CVRarPKlUOxHgaRpV5Yo+HIfAbEOaubNG8DXKHQEZT/QvuM7K08RFRk=
X-Received: by 2002:a9d:48b9:: with SMTP id d54mr26388560otf.144.1540162326640;
 Sun, 21 Oct 2018 15:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181015175424.97147-1-ebiggers@kernel.org> <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
 <20181019190411.GB246441@gmail.com> <20181021222341.GA742@sol.localdomain>
In-Reply-To: <20181021222341.GA742@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 22 Oct 2018 00:51:56 +0200
X-Gmail-Original-Message-ID: <CAHmME9oEQVTJ0xB+dpi8MKxohRfdogqnV+bN63EWTaoS5dE6Pw@mail.gmail.com>
Message-ID: <CAHmME9oEQVTJ0xB+dpi8MKxohRfdogqnV+bN63EWTaoS5dE6Pw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/12] crypto: Adiantum support
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Eric,

On Mon, Oct 22, 2018 at 12:23 AM Eric Biggers <ebiggers@kernel.org> wrote:
> I started a branch based on Zinc:

Nice to see. I'm heading to bed in a second, so I'll give this a
thorough read-through tomorrow, but some preliminary notes on your
comments:

> For Poly1305, for now I decided to just use the existing functions, passing 0
> for the 16-byte element is added at the end.  This causes some unnecessary
> overhead, but it's not very much.  It also results in a much larger size of
> 'struct nhpoly1305_state', but that doesn't matter too much anymore either [1].
> [1] Originally we were going to define Adiantum's hash function to be
>     Poly1305(message_length || tweak_length || tweak || NH(message)), which
>     would have made it desirable to export the Poly1305 state before NH, so that
>     it could be imported for the second hash step to avoid redundantly hashing
>     the message length and tweak.  But later we changed it to
>     Poly1305(message_length || tweak) + Poly1305(NH(message)).

Out of curiosity, why this change?

> For ChaCha, I haven't yet updated all the "Zinc" assembly to support 12 rounds.
> So far I've updated my ARM scalar implementation.  I still don't see how you
> expect people to maintain the files like chacha20-x86_64.S from which all
> comments, register aliases, etc. were removed in comparison to the original
> OpenSSL code.

For at least the ARM[64] and MIPS64 code, I think it will be feasible
to import the .pl eventually. There's an open PR from Andy importing
some of the necessary changes. For the x86_64, that might be a little
trickier, but I can take another stab at it.

> I don't see how dumping thousands of lines of undocumented,
> generated assembly code into the kernel fits with your goals of "Zinc's focus is
> on simplicity and clarity" and "inviting collaboration".

It's not totally "undocumented" and totally "dumped"; that's a bit
hyperbolic. But I can understand it's not as friendly as we'd like.
I'll try to improve that.

> Note that the
> OpenSSL-derived assembly files still have an unclear license as well.

Andy's been pretty clear about the CRYPTOGAMS aspect with me. But, as
you pointed out on lkml and in the private thread, it hasn't yet
migrated over to the CRYPTOGAMS repo. I don't think this is a cause
for immediate concern, because it seems pretty certain it will wind up
there soon enough.

> (I haven't yet gotten around to adding
> "zinc tests" for XChaCha12, though I did add "crypto tests".  Note that "crypto
> tests" are much easier to add, since all algorithms of the same type share a
> common test framework -- not the case for Zinc.)

Actually the advantage of not working with a winding abstraction layer
is that specific tests can test particular aspects of particular
primitives -- for example, by looking at different chunking patterns.
It also enables you to write tests for internal, non-exported
functions.

> nor is there a documentation file
> explaining things.

Sorry, my bad on delaying that one. I'll be sure the Documentation/
stuff is ready before posting another series.

> So please understand that until it's clear that Zinc is
> ready, I still have to have Adiantum ready to go without Zinc, just in case.

Makes sense. I do really appreciate you taking the time, though, to
try this out with Zinc as well. Thanks for that.

Regards,
Jason
