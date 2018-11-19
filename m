Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB8AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D3620851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="u2EuYM97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D3620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbeKTGzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:55:39 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:52383 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728938AbeKTGzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:55:39 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 5ad95bd6;
        Mon, 19 Nov 2018 20:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=AWRGcqde4IOouWBK+AB/ed75Z4c=; b=u2EuYM
        97JScgVSupOnSV6e74HP3e27LXv/xFJaeEXr3yB7zsskSitJUgooFSIp+3hvYewu
        mITzuVKobKr7u/r6SdEzLvVSoaow5KOb5Rukt7IpW6fqs/Q2UlMh16dJulG658Wk
        6VzAAQlpATV18npkFnHr/0oVcXBPsGU8X1VSxSOprKsuNW6lZ567FJgBWAi6AXMo
        uJXnp4gBamfao3clAyYUjkTiBMg38EWQ7aNYkCimCYjbsC5aCGPPNmSI8SdmtQWr
        IHROGGvf74ZTaOErH8WmPCpLLz98CoByDqacj9o4ianAkTQEZOdvZVi1EaAKzIrQ
        EvWps8on9ql5nibw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e25c9c71 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 19 Nov 2018 20:24:15 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id u16so28599166otk.8;
        Mon, 19 Nov 2018 12:30:17 -0800 (PST)
X-Gm-Message-State: AA+aEWYU10+hQjSixjc+3x/KExHSkFy23rjrQYOuzHDamOvyHIxkyRJF
        tRGhOLvyU8V8kMEeaeUkYmt1O3ydZAxb+9Mn1jA=
X-Google-Smtp-Source: AFSGD/V5WGy25oEcw1s4Rl0YIT1JDMVnpGSBjIWmHeQv0isPc8x1zLlOwV1iRxzys3Sv2QPv0aJQdpPZlc2OgOh3ATU=
X-Received: by 2002:a9d:17ca:: with SMTP id j68mr1702271otj.268.1542659416695;
 Mon, 19 Nov 2018 12:30:16 -0800 (PST)
MIME-Version: 1.0
References: <20181015175424.97147-1-ebiggers@kernel.org> <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
 <20181019190411.GB246441@gmail.com> <1f65ce09-93b3-f43e-49d5-9d9d6c0bb9e0@gmail.com>
 <20181116215249.GA27149@gmail.com> <56883f08-26cb-ecef-5698-1c2948714773@gmail.com>
 <20181119192821.GA258711@gmail.com> <1e9ec59a-6a2c-3536-0722-c6d96d6714b2@gmail.com>
In-Reply-To: <1e9ec59a-6a2c-3536-0722-c6d96d6714b2@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 19 Nov 2018 21:30:05 +0100
X-Gmail-Original-Message-ID: <CAHmME9pU79WRKWd32ihp2aQgQ1D6Kh+jh2e2sETm8tqjNxgdvg@mail.gmail.com>
Message-ID: <CAHmME9pU79WRKWd32ihp2aQgQ1D6Kh+jh2e2sETm8tqjNxgdvg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/12] crypto: Adiantum support
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
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

On Mon, Nov 19, 2018 at 9:05 PM Milan Broz <gmazyland@gmail.com> wrote:
> p.s.
> Reading the discussion about Zinc/Adiantum - I would perhaps prefer to merge
> Adiantum first (if it is ready).
> It is a new feature, I see it as useful cipher alternative for dm-crypt and it can be
> esily backported without Zinc to older kernels (I am testing it actually this way).

Seems reasonable to me.

Jason
