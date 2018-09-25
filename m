Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0731C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0B720C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="avT3PFzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0B720C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeIYGyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:54:33 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39629 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbeIYGyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:54:33 -0400
Received: by mail-yw1-f66.google.com with SMTP id v1-v6so1853410ywv.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6agy5zX0q38ScVoosyED7vMXWCaRlaUyR8a3UCIRKx4=;
        b=avT3PFzDJfSBrqY+X4pccrqHbzaPoB7gq8S2VjuWB95L5YfN3RtShGIzsS0pE9KZPk
         98klOvsfs2+YpUhq0s5L7lr3G/3QIxTLEeXsz5uM98AmyEmzY2zzK6ovkYBEnqsSTOQ8
         9m/HlVz4y3j1XnjkfxRcHKEkLZ+twLhJm1c/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6agy5zX0q38ScVoosyED7vMXWCaRlaUyR8a3UCIRKx4=;
        b=CilrStjH5Pyho4Bqd9XkkSAm6NnlBQD06bV1TRndtBemVfnJXOxS/06MahSF2HLt+o
         RuwCdNHc629jgADy1UtTeoH7GGNtYkzCF9906fA24WiScl/Fc79iRMJ2NBKJvkTz0puy
         pUzt7nx0YZ9JPKA1t2iomvafFJCkxetmPi5c05acQiTWEQmw9GjQ6ABPdzEE2HCpWmXl
         Y1bPeZeDYQ8hzS8tPJ/6OnVFkoxiO4UXEa8avKsjXQRayAW3ZWxXa5nZHghVHAfsY6nt
         Nc/MqMqok3OP4t1VySTdYgL6IR4FbtxapLwzA4dGWyEv+fEf/KhWrQhqUvNggdVt2M0P
         GKrw==
X-Gm-Message-State: ABuFfojLFpVK1jQA5SDUIRKvkd1Uno/2RZzDOiuwrr37af50wiIfcHZ1
        U+F30+ReCppsTIrVZya/MtQ0MxzjfME=
X-Google-Smtp-Source: ACcGV608PxI1ewqja6bliPOd0ksfPjfLKhoZe51eTUNhIr+queSFCp9C8nJ2sk8eqA6Nx8myCdBxAg==
X-Received: by 2002:a81:3a48:: with SMTP id h69-v6mr618871ywa.6.1537836580176;
        Mon, 24 Sep 2018 17:49:40 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id f194-v6sm1611895ywb.31.2018.09.24.17.49.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 17:49:38 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id p206-v6so8644387ywg.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:49:38 -0700 (PDT)
X-Received: by 2002:a81:1194:: with SMTP id 142-v6mr667488ywr.168.1537836578110;
 Mon, 24 Sep 2018 17:49:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 17:49:37
 -0700 (PDT)
In-Reply-To: <20180919021100.3380-1-keescook@chromium.org>
References: <20180919021100.3380-1-keescook@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 24 Sep 2018 17:49:37 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKFdMXYGJ9AmR9=OkTqrU9_RqtMXeOmXfivv0VvwPfOmg@mail.gmail.com>
Message-ID: <CAGXu5jKFdMXYGJ9AmR9=OkTqrU9_RqtMXeOmXfivv0VvwPfOmg@mail.gmail.com>
Subject: Re: [PATCH crypto-next 00/23] crypto: skcipher - Remove VLA usage
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 7:10 PM, Kees Cook <keescook@chromium.org> wrote:
> This is the full follow-up to earlier discussions[1] that suggested
> adding a new struct crypto_sync_skcipher to handle the VLA removal from
> SKCIPHER_REQUEST_ON_STACK.
>
> This series is effectively a no-op change: everything is a wrapper
> around struct crypto_skcipher, but provides compile-time enforcement
> for not putting an ASYNC skcipher on the stack, which allows us to
> declare the on-stack requests with a fixed stack size.
>
> [1] https://lkml.kernel.org/r/CAGXu5j+bpLK=EQ9LHkO8V=sdaQwt==6fbGhgn2Vi1E9_WxSGRQ@mail.gmail.com
>
> -Kees
>
> Kees Cook (23):
>   crypto: skcipher - Introduce crypto_sync_skcipher
>   gss_krb5: Remove VLA usage of skcipher
>   lib80211: Remove VLA usage of skcipher
>   mac802154: Remove VLA usage of skcipher
>   s390/crypto: Remove VLA usage of skcipher
>   x86/fpu: Remove VLA usage of skcipher
>   block: cryptoloop: Remove VLA usage of skcipher
>   libceph: Remove VLA usage of skcipher
>   ppp: mppe: Remove VLA usage of skcipher
>   rxrpc: Remove VLA usage of skcipher
>   wusb: Remove VLA usage of skcipher
>   crypto: ccp - Remove VLA usage of skcipher
>   crypto: vmx - Remove VLA usage of skcipher
>   crypto: null - Remove VLA usage of skcipher
>   crypto: cryptd - Remove VLA usage of skcipher
>   crypto: sahara - Remove VLA usage of skcipher
>   crypto: qce - Remove VLA usage of skcipher
>   crypto: artpec6 - Remove VLA usage of skcipher
>   crypto: chelsio - Remove VLA usage of skcipher
>   crypto: mxs-dcp - Remove VLA usage of skcipher
>   crypto: omap-aes - Remove VLA usage of skcipher
>   crypto: picoxcell - Remove VLA usage of skcipher
>   crypto: skcipher - Remove SKCIPHER_REQUEST_ON_STACK()

How do these look to you, Herbert? I'd really like to make sure these
make it for the next merge window -- they're the last VLAs left in the
kernel now. :)

-Kees

-- 
Kees Cook
Pixel Security
