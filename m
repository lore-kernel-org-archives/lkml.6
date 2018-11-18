Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7947AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 13:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FC920869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 13:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="sClac4sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FC920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeKSAHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:07:07 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:44301 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbeKSAHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:07:06 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 6e602381;
        Sun, 18 Nov 2018 13:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=w5v+EyIL9bIKvbXVhNWxQFxWKuQ=; b=sClac4
        smI3xVrmiex0h8i6aP8kQffeccTJ0aLRBergqusevtvw+SU4xGend0OLm6RjF059
        mkVwrhTmIzphz+608tdI20JJUtlhjWT1LVnRAvgHlEAqp8XfHNs1QMOVGCa4ay0b
        dzdrwG/zPDA/4Ch1egm6gihVQTcULV1PoUdbU+wzXNef63jqZB8dng3YxiUppd7G
        3ihnFLCbSmhAKdtgMhd+OY0X/vkHNYIh/xcEjUKIAMDvS0ze4u1vqhNet69Sl+tE
        WQhrcQLPmZCr4Zt49wMSSxxALlFa7n5P8VPiav0ukkvxynyNgGoN6BsDY5RZGiaa
        8uhF1nO+JvZxRvdQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9769d010 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sun, 18 Nov 2018 13:40:50 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id z33so25345366otz.11;
        Sun, 18 Nov 2018 05:46:42 -0800 (PST)
X-Gm-Message-State: AGRZ1gKO6CW+M0N8l8NDK3oUnjLuQsoBCM4m1E5CwD3HSUnB+EQSuMQS
        i+0VZGU9ITvkSGF/ss7ko8mMYPZGhS7Iypji0dg=
X-Google-Smtp-Source: AJdET5eo8/NS/idvJbrsyEmre84CnFQvNm5fFRQ2PIN2yJg22Ey4WV5uRDXC+k0tMXn4FDfbudxmBIwdQ+d18x+IW5I=
X-Received: by 2002:a9d:12e3:: with SMTP id g90mr6783221otg.223.1542548801761;
 Sun, 18 Nov 2018 05:46:41 -0800 (PST)
MIME-Version: 1.0
References: <20181105232526.173947-1-ebiggers@kernel.org> <20181105232526.173947-11-ebiggers@kernel.org>
 <CAKv+Gu-o0khD5=0EOkv2PiczMs5uZ=XP9V=G2ogBNMK8Kb93sw@mail.gmail.com>
 <20181112185816.GA8663@gmail.com> <20181116060227.hwu4igi6bp26ddpi@gondor.apana.org.au>
 <20181117001718.GA175522@gmail.com>
In-Reply-To: <20181117001718.GA175522@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 18 Nov 2018 14:46:30 +0100
X-Gmail-Original-Message-ID: <CAHmME9rtsCk8ZLt05xRKMGr4CVRnaUvCaVOS_WX3N22HOat4-A@mail.gmail.com>
Message-ID: <CAHmME9rtsCk8ZLt05xRKMGr4CVRnaUvCaVOS_WX3N22HOat4-A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 10/15] crypto: poly1305 - use structures for key
 and accumulator
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Sat, Nov 17, 2018 at 1:17 AM Eric Biggers <ebiggers@kernel.org> wrote:
> Do you prefer that this be merged before or after Zinc?  It seems it may still
> be a while before the community is satisfied with Zinc (and Wireguard which is
> in the same patchset), and I don't want this blocked unnecessarily...  So on my
> part I'd prefer to just have this merged as-is.

Personally I'd prefer this be merged after Zinc, since there's work to
be done on adjusting the 20->12 in chacha20. That's not really much of
a reason though. But maybe we can just sidestep the ordering concern
all together:

What I suspect we should do is make the initial Zinc merge _without_
those top two patches that replace the crypto api's implementations
with Zinc, and defer those until after the initial merges. Those
commits are already written -- so there's no chance it won't happen
due to laziness or something -- and I think the general merge will go
a bit more smoothly if we wait until after. (Somebody suggested we do
it this way at Plumbers, and was actually a bit surprised I had
already ported the crypto API stuff to Zinc.) This way, Adiantum and
Zinc aren't potentially co-dependent in their initial merges and we
can work on the details carefully with each other after both have
landed. I figure this might make things a little bit less stressful
for both of us. How would you feel about doing it that?

Jason
