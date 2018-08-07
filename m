Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14E9C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F59D21A6A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYJSFLn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F59D21A6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbeHGDSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 23:18:24 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39444 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388552AbeHGDSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 23:18:24 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so25554622oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 18:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ns3Zmy+67Iw3hhweVJkYjHyOixg6gmMd79eJy5P0MaI=;
        b=eYJSFLn52zvbfzXtLmVcX0dbdCsOA0YO54bfWoQ6GxmPKgupkEqNcBpTq5+UNMnwl/
         qQvoMiaAPesjDdZXl7M8ags1BzswhT9myUTn83bw0OdTpAgnkabSGSqS4buc1vvtMINi
         OZsbYkvdSQ8Kao0KTdbm053FK7EB4CB94q2utPgcdqs1plWp02H09vcXGxXE5Imk4XO2
         z4Y8T7Y2jBJxfr53w8t+Ccw0taDZV/jwyZaBkZzbErX4xo9CbLZt75OR8n0gnWVUqJkN
         bGP4pDLR7gfUlBVfvH9rEReN19M72esykt67HUsMo3G/YqMou3ex2aLEFVX8hGdpM9Hn
         6AtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ns3Zmy+67Iw3hhweVJkYjHyOixg6gmMd79eJy5P0MaI=;
        b=dN/0cPxu0EtRwthacT2alHHMF2Sga91t234d7F8lGWFCAPdxnwTCWGh+AkeNZ3sr9t
         hOyPLksaV4QKoL035PatrbKchgpNA563HNMnSXMihD85FsqWvTRNH2k9LH2HEwUCMDjE
         bRqUGyKF+MrkOzlbaxLYr7Y5cwk3IL8bAky2MgFlrZJUUlMV3Qe+d9+6jw2w7a6bqo1R
         pRH9qHUvK0J2JxTS8twAIUzZwUOv1pR8dDgl63pnNnIrLEmDLHihi+TNfG0WeveXSxaw
         8paETfuNXL6l2S6bKMgBKb+xFpqVbbO6iSnuboK2jZsDQwYhQ4SVWPTAwsFsls26jdMT
         ai2w==
X-Gm-Message-State: AOUpUlEqDhskQZAun9+cAPn1JEpAnK0d+6nTvg5vVMq36FmVffZXEwIY
        djlfSZWhLTRMQdZo59wZGs5GuvgMFCovhpWMt9khvQ==
X-Google-Smtp-Source: AA+uWPwVhcKJPQ0kwLB26m0Uw3zOlRY8MHiYSMz//WSTvgpplw+2sEx+VUGdszztnYr9HFRFQRshdGX3iFqkxVicVL4=
X-Received: by 2002:aca:a8c1:: with SMTP id r184-v6mr17888462oie.215.1533603998912;
 Mon, 06 Aug 2018 18:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180806223300.113891-1-ebiggers@kernel.org> <20180806223300.113891-4-ebiggers@kernel.org>
 <CAHmME9rbe6eT6dkUqKnp-GxcqGrp-tvMfTMr8kZtsn=S3cmP8A@mail.gmail.com>
 <CA+_SqcD+KpQ_X6iXUCpQh0N6pWzBorstBJDx7eBqcybY4Dvy8Q@mail.gmail.com> <CAHmME9o6XQ+16d4b8+BiQViSiOOApi-J_ML2UOOBpTN8hV3iVA@mail.gmail.com>
In-Reply-To: <CAHmME9o6XQ+16d4b8+BiQViSiOOApi-J_ML2UOOBpTN8hV3iVA@mail.gmail.com>
From:   Paul Crowley <paulcrowley@google.com>
Date:   Mon, 6 Aug 2018 18:06:27 -0700
Message-ID: <CA+_SqcBS-xi7xXK0BFW5UneQ6ocqZKLuUHCaVTMTqMpj4Wu7Pg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] crypto: chacha20-generic - refactor to allow
 varying number of rounds
To:     Jason@zx2c4.com
Cc:     ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        samuel.c.p.neves@gmail.com, tomer.ashur@esat.kuleuven.be,
        Eric Biggers <ebiggers@google.com>, djb@cr.yp.to
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've done enough performance testing to know that the short answer
is: HPolyC is still a lot slower than I'm happy with, and encryption
still has a quite noticeable effect on the feel of low end devices.
Indeed, this proposal may change if I find a faster way to do the
first and last rounds. We don't know how long chipsets without
hardware AES will be around, but especially in this post-Moore's Law
era, I'd bet on Schneier's maxim: the low end doesn't go away, and if
a day comes where we don't have to worry about this in handsets, we'll
probably be worrying about it for IoT devices.

On Mon, 6 Aug 2018 at 17:15, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Paul,
>
> On 8/6/18, Paul Crowley <paulcrowley@google.com> wrote:
> > Salsa20 was one of the earlier ARX proposals, and set a very
> > conservative number of rounds as befits our state of knowledge at the
> > time. Since then we've learned a lot more about cryptanalysis of such
> > offerings, and I think we can be comfortable with fewer rounds. The
> > best attack on ChaCha breaks 7 rounds, and that attack requires 2^248
> > operations. Every round of ChaCha makes attacks vastly harder.
>
> I'm well aware of that, which is why I mentioned that ChaCha12
> _probably_ has an adequate security. My primary concerns are a bit
> different actually from where you're going - that it breaks from
> what's becoming a pretty widely accepted "norm" and, more importantly,
> that it increases implementation complexity. These aren't really
> drastic concerns, but I am in earnest wondering the type of hardware
> analysis you did to determine that you really do need the 12-speedup.
> What's the practical landscape out there look like? What disk speeds
> were too low for which specific kind of Android usage on which
> particular hardware? Did you hit the bottlenecks when paging for code
> or when filling up caches when writing asynchronously? And for how
> much longer do you foresee underpowered hardware like that being a not
> insignificant part of the market? I'm especially curious to know
> because ostensibly at Google you have all sorts metrics regarding that
> kind of thing.
>
> Jason
