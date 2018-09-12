Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4C2C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8812087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0SHDYbWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8812087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeIMEwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbeIMEwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:52:22 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF0CA2146E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 23:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536795933;
        bh=Czl782qIU6oXU+hLju+22NmAWbzVC0QdQXchewUZA3Q=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=0SHDYbWi3N9o5Uqfw2rG4fSutT46EKxYdGtceA+RQeFJjm7E3K/1Q9kl+sUmOpvIQ
         HVTFaEgp08yDzxgBuSk/w0xcMd7YcI1JoPO+O2jfnt42evNITLeKkIimh31gyqJbTM
         v1hKaCVtuA/g0Oe9QTTrDtxwRXv4siAOu9fGR1aE=
Received: by mail-wr1-f51.google.com with SMTP id 20-v6so3711500wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 16:45:32 -0700 (PDT)
X-Gm-Message-State: APzg51DdWJ/Vn988qGuQOx5tiC4z99aunZWwRqth89uFBorpL18WsnsV
        b+lwcCyboRsixCJ+5P/s6tRxM/RykFJ6cINtGmvtIg==
X-Google-Smtp-Source: ANB0VdamDq5IA8jKSlVE6GQA9InXQMDdMw9QqQhGh9FKiMF5b5XUEG9FEBnItaGAP6xsR4NTbiUv8+P30QL3bxmuFF8=
X-Received: by 2002:adf:dcc1:: with SMTP id x1-v6mr3311842wrm.21.1536795931083;
 Wed, 12 Sep 2018 16:45:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7810:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 16:45:10
 -0700 (PDT)
In-Reply-To: <CAKv+Gu9RGo9rtGsmwMLZ_=-WSQ_h7har4agXP-2XOKupq-KYtA@mail.gmail.com>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com> <CAKv+Gu9RGo9rtGsmwMLZ_=-WSQ_h7har4agXP-2XOKupq-KYtA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 12 Sep 2018 16:45:10 -0700
X-Gmail-Original-Message-ID: <CALCETrU2qkLVaxC=cpU5iAeT5B7xGsR+m2ZWtLVK37jMMWtcAA@mail.gmail.com>
Message-ID: <CALCETrU2qkLVaxC=cpU5iAeT5B7xGsR+m2ZWtLVK37jMMWtcAA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 3:56 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> I realize you've put a lot of good and hard work into the existing
> I am also concerned about your claim that all software algorithms will
> be moved into this crypto library. You are not specific about whose
> responsibility it will be that this is going to happen in a timely
> fashion. But more importantly, it is not clear at all how you expect
> this to work for, e.g., h/w instruction based SHAxxx or AES in various
> chaining modes, which should be used only on cores that implement
> those instructions (note that on arm64, we have optional instructions
> for AES, PMULL, SHA1, SHA256, SHA512, SHA3, SM3 and SM4). Are all
> those implementations (only few of which will be used on a certain
> core) going to be part of the monolithic library? What are the APIs
> going to look like for block ciphers, taking chaining modes into
> account?

I'm not convinced that there's any real need for *all* crypto
algorithms to move into lib/zinc or to move at all.  As I see it,
there are two classes of crypto algorithms in the kernel:

a) Crypto that is used by code that chooses its algorithm statically
and wants synchronous operations.  These include everything in
drivers/char/random.c, but also a bunch of various networking things
that are hardcoded and basically everything that uses stack buffers.
(This means it includes all the code that I broke when I did
VMAP_STACK.  Sign.)

b) Crypto that is used dynamically.  This includes dm-crypt
(aes-xts-plain64, aes-cbc-essiv, etc), all the ALG_IF interfaces, a
lot of IPSEC stuff, possibly KCM, and probably many more.  These will
get comparatively little benefit from being converted to a zinc-like
interface.  For some of these cases, it wouldn't make any sense at all
to convert them.  Certainly the ones that do async hardware crypto
using DMA engines will never look at all like zinc, even under the
hood.

I think that, as a short-term goal, it makes a lot of sense to have
implementations of the crypto that *new* kernel code (like Wireguard)
wants to use in style (a) that live in /lib, and it obviously makes
sense to consolidate their implementations with the crypto/
implementations in a timely manner.  As a medium-term goal, adding
more algorithms as needed for things that could use the simpler APIs
(Bluetooth, perhaps) would make sense.

But I see no reason at all that /lib should ever contain a grab-bag of
crypto implementations just for the heck of it.  They should have real
in-kernel users IMO.  And this means that there will probably always
be some crypto implementations in crypto/ for things like aes-xts.

--Andy
