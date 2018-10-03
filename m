Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDB9C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 01:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205022082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 01:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LIe52dxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205022082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeJCHt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 03:49:28 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:51063 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbeJCHt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 03:49:28 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 472b9b18;
        Wed, 3 Oct 2018 01:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=dXOih4WeXhYPQcclndDyyEar5p0=; b=LIe52d
        xo38m4gQrNP2E77wfyrsLIQCZ1fX+fssx8qJv3ZFUQ8hLsRRQ1TbbmfU9E4gMKww
        TyNToIUsAw7RYrhuING7/ojLpo1m4R3Z0da/AzEJ1OX8TajclbsE83U0fL3osyzJ
        N+WYVPshvJHDTanVcBZSnWzL237JXxQ3CbLmu4PsZVROhg1Q/QTtqQTdlCMvpD9u
        hZQcxB1k5qw2WuIZopl7qUo25VBBvp7etwDPlAniaNCSLoAAba+Csvr0hcDrfDzY
        gE9YY9KGn3h+ba+POhzQUiW/kCJdCGVxVgU1OrjYwKTsEsdOUFbgsV38pLPB0L+P
        ffoluV0Pe/ef3kGA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c3d2dbfe (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 3 Oct 2018 01:03:14 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id e17-v6so3109264oig.12;
        Tue, 02 Oct 2018 18:03:21 -0700 (PDT)
X-Gm-Message-State: ABuFfoiPqVmQNRiTl2CvPgpbdR/JLI5hcAHi25MTtD+kJZnTLEcCn0h6
        vPeHr+KHRoN8bWtDHKdA/EXkjX7L01MEfA96Iqk=
X-Google-Smtp-Source: ACcGV61omk0WxQaTnjP9rV8fyE7k8yRYZ1GybUmogXLwl6MHkEmwKzisHApk0nba6ODI56yleprw5qVVV2B3xqZ3KsU=
X-Received: by 2002:aca:df42:: with SMTP id w63-v6mr8347618oig.295.1538528600437;
 Tue, 02 Oct 2018 18:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-20-Jason@zx2c4.com>
 <CAKv+Gu9FLDRLxHReKcveZYHNYerR5Y2pZd9gn-hWrU0jb2KgfA@mail.gmail.com>
In-Reply-To: <CAKv+Gu9FLDRLxHReKcveZYHNYerR5Y2pZd9gn-hWrU0jb2KgfA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 3 Oct 2018 03:03:09 +0200
X-Gmail-Original-Message-ID: <CAHmME9rp0Fi5ObK5oi8FHj1_nK5hP4T2Bq7_dAmzq4OQ0mp0uw@mail.gmail.com>
Message-ID: <CAHmME9rp0Fi5ObK5oi8FHj1_nK5hP4T2Bq7_dAmzq4OQ0mp0uw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 19/23] zinc: Curve25519 ARM implementation
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Peter Schwabe <peter@cryptojedi.org>,
        "Daniel J . Bernstein" <djb@cr.yp.to>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+Dan,Peter in CC. Replying to:
<https://lore.kernel.org/lkml/CAKv+Gu9FLDRLxHReKcveZYHNYerR5Y2pZd9gn-hWrU0jb2KgfA@mail.gmail.com/>
for context.)

Hi Ard,

On Tue, Oct 2, 2018 at 6:59 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Shouldn't this use the new simd abstraction as well?

Yes, it probably should, thanks.

> I guess qhasm means generated code, right?
> Because many of these adds are completely redundant ...
> This looks odd as well.
> Could you elaborate on what qhasm is exactly? And, as with the other
> patches, I would prefer it if we could have your changes as a separate
> patch (although having the qhasm base would be preferred)

Indeed qhasm converts this --
<https://github.com/floodyberry/supercop/blob/master/crypto_scalarmult/curve25519/neon2/scalarmult.pq>
-- into this. It's a thing from Dan (CC'd now) --
<http://cr.yp.to/qhasm.html>. As you've requested, I can layer the
patches to show our changes on top.

> ... you can drop this add
> same here
> and here
> and here
> and here
> and here
> and here
> and here
> redundant add
> I'll stop here - let me just note that this code does not strike me as
> particularly well optimized for in-order cores (such as A7).
> For instance, the sequence
> can be reordered as
> and not have every other instruction depend on the output of the previous one.
> Obviously, the ultimate truth is in the benchmark numbers, but I'd
> thought I'd mention it anyway.

Yes indeed the output is suboptimal in a lot of places. We can
gradually clean this up -- slowly and carefully over time -- if you
want. I can also look into producing a new implementation within HACL*
so that it's verified. Assurance-wise, though, I feel pretty good
about this implementation considering its origins, its breadth of use
(in BoringSSL), the fuzzing hours it's incurred, and the actual
implementation itself.

 Either way, performance-wise, it's really worth having.

For example, on a Cortex-A7, we get these results (according to get_cycles()):

neon: 23142 cycles per call
fiat32: 49136 cycles per call
donna32: 71988 cycles per call

And on a Cortex-A9, we get these results (according to get_cycles()):

neon: 5020 cycles per call
fiat32: 17326 cycles per call
donna32: 28076 cycles per call

Jason
