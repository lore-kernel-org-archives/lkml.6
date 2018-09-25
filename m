Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228E5C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7E8208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DKRtb+17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7E8208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbeIYVrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:47:18 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41080 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbeIYVrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:47:17 -0400
Received: by mail-yw1-f65.google.com with SMTP id q129-v6so9473803ywg.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mfwCTU3gBuwKB0JS+HTf1c/pKKqrJ0HMnISheVsQs5k=;
        b=DKRtb+17jotvuUM9ICHQ1jMRgPUbB88Cj2LK7Ty0gWqcrFgCJ95cu+j4zjvtpumD1T
         QqctzFbB1kVWrUyORVm93ZRwT2nnPsTqarWfjDZxq4zZxDFQtFipjEXTQQqQpkn9JZ8X
         LZVOiffpFUuzxg5uJzsMvsCFVCv6Ofwm6pVPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mfwCTU3gBuwKB0JS+HTf1c/pKKqrJ0HMnISheVsQs5k=;
        b=RJeegiKd6K0A6Wc87qYoSYsWetimbvQh47+BYdHLtA9oK8Jywz8/DzHGX7jsp5SD7m
         /UO0/8A4DenNPrKZ7EabA62prycMJ15omYhjgiyey01CGl4XkrMNHjdtDblCyKUHDd8V
         57npdBsyUFjbLEwsiAMdAlMTv7fq/cB0LilloPNONjuAsZXDFFEtuUJAZ903MDjjLPDh
         EAM67rLm3g3RofZUr6PqgvrH1lm9KaB8nN74hmuOXxITNOVpeZT59lLCAi12wB232/j7
         HM+lpuqk3tERRQjhSPQ+ZzYnx5RSq5nGUq1ePvelShKP0z21g6DYJyMWlV6k85TCmfZg
         4Uvw==
X-Gm-Message-State: ABuFfoiR4ZgIfpHjnZHyB8sYOmYLniN5o5ICCHEQ5P2Q8UVZaziGPLQa
        lCtGFHLfVKpjoh7vvllmBW5Shbex7a8=
X-Google-Smtp-Source: ACcGV61jJX5YDfM4WN/u+xUu4F+jNKCngCaep4pfocppe7aweX5pdRudzgs/FOwtN3gX+9oxnzwEIQ==
X-Received: by 2002:a81:ae5f:: with SMTP id g31-v6mr865452ywk.372.1537889952989;
        Tue, 25 Sep 2018 08:39:12 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id j66-v6sm1880065ywc.61.2018.09.25.08.39.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 08:39:11 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id m129-v6so3702888ywc.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 08:39:11 -0700 (PDT)
X-Received: by 2002:a81:1194:: with SMTP id 142-v6mr902590ywr.168.1537889951317;
 Tue, 25 Sep 2018 08:39:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 08:39:10
 -0700 (PDT)
In-Reply-To: <20180925044926.vkkj2fnfvshjqpt5@gondor.apana.org.au>
References: <20180919021100.3380-1-keescook@chromium.org> <CAGXu5jKFdMXYGJ9AmR9=OkTqrU9_RqtMXeOmXfivv0VvwPfOmg@mail.gmail.com>
 <20180925044926.vkkj2fnfvshjqpt5@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 25 Sep 2018 08:39:10 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJGYJ_ePK+7pfWgjpLN2cQQ57fcE5P-k2p8MXX_SnmLnQ@mail.gmail.com>
Message-ID: <CAGXu5jJGYJ_ePK+7pfWgjpLN2cQQ57fcE5P-k2p8MXX_SnmLnQ@mail.gmail.com>
Subject: Re: [PATCH crypto-next 00/23] crypto: skcipher - Remove VLA usage
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 9:49 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Mon, Sep 24, 2018 at 05:49:37PM -0700, Kees Cook wrote:
>>
>> > Kees Cook (23):
>> >   crypto: skcipher - Introduce crypto_sync_skcipher
>> >   gss_krb5: Remove VLA usage of skcipher
>> >   lib80211: Remove VLA usage of skcipher
>> >   mac802154: Remove VLA usage of skcipher
>> >   s390/crypto: Remove VLA usage of skcipher
>> >   x86/fpu: Remove VLA usage of skcipher
>> >   block: cryptoloop: Remove VLA usage of skcipher
>> >   libceph: Remove VLA usage of skcipher
>> >   ppp: mppe: Remove VLA usage of skcipher
>> >   rxrpc: Remove VLA usage of skcipher
>> >   wusb: Remove VLA usage of skcipher
>> >   crypto: ccp - Remove VLA usage of skcipher
>> >   crypto: vmx - Remove VLA usage of skcipher
>> >   crypto: null - Remove VLA usage of skcipher
>> >   crypto: cryptd - Remove VLA usage of skcipher
>> >   crypto: sahara - Remove VLA usage of skcipher
>> >   crypto: qce - Remove VLA usage of skcipher
>> >   crypto: artpec6 - Remove VLA usage of skcipher
>> >   crypto: chelsio - Remove VLA usage of skcipher
>> >   crypto: mxs-dcp - Remove VLA usage of skcipher
>> >   crypto: omap-aes - Remove VLA usage of skcipher
>> >   crypto: picoxcell - Remove VLA usage of skcipher
>> >   crypto: skcipher - Remove SKCIPHER_REQUEST_ON_STACK()
>>
>> How do these look to you, Herbert? I'd really like to make sure these
>> make it for the next merge window -- they're the last VLAs left in the
>> kernel now. :)
>
> I have no problems with the crypto parts.  Do we have acks for
> all of the others?

Some have trickled in (wusb, lib80211), along with some Reviewed-bys
from Ard. I was hoping that since it was a wrapper-only change there
wouldn't be a need to block on waiting for Acks.

Thanks for looking at it; I'm excited to finally be done with VLA removals. :)

-Kees

-- 
Kees Cook
Pixel Security
