Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9549FECDE43
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 03:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8DF214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 03:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J86Z/P/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8DF214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeJTLdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 07:33:00 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52053 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeJTLdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 07:33:00 -0400
Received: by mail-it1-f195.google.com with SMTP id 74-v6so6500677itw.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 20:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NZ10Ylsl3AN9EZ+hzni4RNeIwZbU1+s0IaMEe6oKYpE=;
        b=J86Z/P/2z/3W7yX8WtBchlG5ztpgIn7z4W/TkWWKZzU435tHiUxDFI/pW7epzelYPE
         /Si7PHgJ21R5uU1R9fSb4fUixr6xVkukHYyWGk8IM2orf+nEgL9KiwEy10sEHNMnKhSO
         xUfyl/4y2foq5DlHF8YAEHCz2ci72B/m6V9kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NZ10Ylsl3AN9EZ+hzni4RNeIwZbU1+s0IaMEe6oKYpE=;
        b=I7YJ+TN3Iw893foYBluuk552ownguuTA5pPwIS6J+Q7Ggan0Bm/WlSvoR+1aCWfnI+
         5dpMPp+3gF3XO5VW9JCwy1lc5CpX+Z1TY8hZONf7kXeNlXVthuBKPMW/M4ixCMFXtesI
         8HVU+ngWU+EKwmbeVm9nZipkE2wMvGHOE0wM/I3U3vEMH4QYYE8aU4OZz1wuNqzfuqw+
         o6o3z9nwGJiHPhbNCYnoHIzTslK2nSFe7Byuz0n5jBrp7XIHQUkytTZcBJgx42Oe1Ood
         lCK6XjF6+DYoutdS2NA4FogNr/fkRy8wP131CyZKUJUFWqWaPO6Vk2POlYOU8UPAGNWQ
         Jchg==
X-Gm-Message-State: ABuFfoi2HjqprOGbT09bmpZDnVEZMpAL0WXJYA8Mt2TVZpgpjwT/Cs7z
        EK4MXBCOzyQW+dvS2wVVIj2bSt5Lqg6DAxZLaPPtrA==
X-Google-Smtp-Source: ACcGV60mDPOC0aclh7eqvxfviaNiAiyfUENwniL4SzQat3uoWmJIPbGFIAt8AECs+JIC7R7N80QtCFIC2YecXOylfvs=
X-Received: by 2002:a24:e08f:: with SMTP id c137-v6mr4998647ith.71.1540005846200;
 Fri, 19 Oct 2018 20:24:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 20:24:05
 -0700 (PDT)
In-Reply-To: <CA+_SqcDszvqfH7qvEyi8QW2RqkA1kpV6L7VWxhtw5Ogzeovhbg@mail.gmail.com>
References: <20181015175424.97147-1-ebiggers@kernel.org> <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
 <CA+_SqcDszvqfH7qvEyi8QW2RqkA1kpV6L7VWxhtw5Ogzeovhbg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 20 Oct 2018 11:24:05 +0800
Message-ID: <CAKv+Gu9be0LDSzkinzwJ50LN+g7Omdjh5Z7xUmpoQc+oCzxZ_Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/12] crypto: Adiantum support
To:     Paul Crowley <paulcrowley@google.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 October 2018 at 02:19, Paul Crowley <paulcrowley@google.com> wrote:
> On Fri, 19 Oct 2018 at 08:58, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> Before merging this into the kernel, do you want to wait until you've
>> received some public review from academia?
>
> I would prefer not to wait. Unlike a new primitive whose strength can
> only be known through attempts at cryptanalysis, Adiantum is a
> construction based on
> well-understood and trusted primitives; it is secure if the proof
> accompanying it is correct. Given that (outside competitions or
> standardization efforts) no-one ever issues public statements that
> they think algorithms or proofs are good, what I'm expecting from
> academia is silence :) The most we could hope for would be getting the
> paper accepted at a conference, and we're pursuing that but there's a
> good chance that won't happen simply because it's not very novel. It
> basically takes existing ideas and applies them using a stream cipher
> instead of a block cipher, and a faster hashing mode; it's also a
> small update from HPolyC. I've had some private feedback that the
> proof seems correct, and that's all I'm expecting to get.

Hi Paul, Eric,

The Adiantum paper claims

"On an ARM Cortex-A7 processor, Adiantum decrypts 4096-byte messages
at 11 cycles per byte, five times faster than AES-256-XTS, with a
constant-time implementation."

which is surprising to me. The bit slicing NEON AES core runs at ~14
cycle per byte on a Cortex-A15 (when encrypting), so 55 cycles per
byte on A7 sounds rather high. Is it really that bad?

Also, the paper mentions that the second hash pass and the stream
cipher en/decryption pass could be executed in parallel, while your
implementation performs three distinct passes. Do you have any
estimates on the potential performance gain of implementing that? In
my experience (which is mostly A53 rather than A7 based, mind you),
removing memory accesses can help tremendously to speed up the
execution on low end cores.
