Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF98C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 03:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2C420831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 03:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="rqzWohxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2C420831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbeKTNf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:35:28 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:52291 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbeKTNf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 08:35:27 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 00e4c3f4;
        Tue, 20 Nov 2018 03:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=mereSPzVOQppYrikIBedDROpvUI=; b=rqzWoh
        xwM0paerHrqqPnLZT8OfQ8oYSQo0F5XbllNjEnnW/CiYzqRiUTTYh7vSH8c/ubfp
        8FtEJ7qIIAQjI1I88Fgv4PLH4/HG5icgKpL3vLDe764e4sCpoHAivCh0FwSG3bcx
        EoyW7i94J4rISmnsvp4mSugkpUbnZ3MvuGr61Rel/s4wbYZ0CgIMthpuPQMvoBwV
        l2aFrifkNkadvySZsRBblOOfeWVRU/qqPd5t/4qtfwAb4F3P2sxUmZZjSdwTdYNq
        NyahRz5XMYNNH9isfeiR49nb65ogVK7xmUaHWqmrDo+JCIKT11S5Dmmv5PhQW5uF
        dY8ER1LxBlaaB45g==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3c164fdd (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 20 Nov 2018 03:02:27 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id 40so412386oth.4;
        Mon, 19 Nov 2018 19:08:31 -0800 (PST)
X-Gm-Message-State: AA+aEWbZrdjSl9Q+Q2kup2wYGxnm+E8Tl9MPG+i9mVtqS5OlzuVRLuzc
        bpWyjSOvXKtGxVAz5+u6PLaH2xyNrYwowFjefrE=
X-Google-Smtp-Source: AFSGD/UaSWq5Xb8cDZvAtGx0XiWOWDC84fMjaYmmXnnGuHi3DAR9MU0itPNT5cAHwHEpIB1EU8FBIiQdcMzazLDTITI=
X-Received: by 2002:a9d:4e5:: with SMTP id 92mr158705otm.199.1542683310900;
 Mon, 19 Nov 2018 19:08:30 -0800 (PST)
MIME-Version: 1.0
References: <20181105232526.173947-1-ebiggers@kernel.org> <20181105232526.173947-11-ebiggers@kernel.org>
 <CAKv+Gu-o0khD5=0EOkv2PiczMs5uZ=XP9V=G2ogBNMK8Kb93sw@mail.gmail.com>
 <20181112185816.GA8663@gmail.com> <20181116060227.hwu4igi6bp26ddpi@gondor.apana.org.au>
 <20181117001718.GA175522@gmail.com> <CAHmME9rtsCk8ZLt05xRKMGr4CVRnaUvCaVOS_WX3N22HOat4-A@mail.gmail.com>
 <20181119052451.qttzfgcm4hvbdc4u@gondor.apana.org.au> <CAHmME9oXAnD0sbO2cKeTtotCMohX2Hu6P=uzA_6u0EWECU9Bpg@mail.gmail.com>
 <20181119225414.GB258711@gmail.com> <20181120030635.xfr543j5nngxfnxk@gondor.apana.org.au>
In-Reply-To: <20181120030635.xfr543j5nngxfnxk@gondor.apana.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 20 Nov 2018 04:08:19 +0100
X-Gmail-Original-Message-ID: <CAHmME9qxY-LRiik8p3xJGskVAEM2UQj1KdzJnwNGnKghuGvrkw@mail.gmail.com>
Message-ID: <CAHmME9qxY-LRiik8p3xJGskVAEM2UQj1KdzJnwNGnKghuGvrkw@mail.gmail.com>
Subject: Re: [RFC PATCH] zinc chacha20 generic implementation using crypto API code
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers@kernel.org>,
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

Hi Herbert,

On Tue, Nov 20, 2018 at 4:06 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > I'd still prefer to see the conversion patches included.  Skipping them would be
> > kicking the can down the road and avoiding issues that will need to be addressed
> > anyway.  Like you, I don't want a "half-baked concoction that will be maybe
> > possibly be replaced 'later'" :-)
>
> Are you guys talking about the conversion patches to eliminate the
> two copies of chacha code that would otherwise exist in crypto as
> well as in zinc?
>
> If so I think that's not negotiable.  Having two copies of the same
> code is just not acceptable.

Yes, that's the topic. Eric already expressed his preference to keep
them, and I agreed, so the plan is to keep them.

Jason
