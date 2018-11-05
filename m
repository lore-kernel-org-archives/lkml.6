Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4833C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761DA20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDAFC3eC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761DA20819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbeKEVed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:34:33 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37091 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbeKEVed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:34:33 -0500
Received: by mail-io1-f67.google.com with SMTP id k17-v6so6299960ioc.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y1q5v58v/6Ck2XolErxmYzdO5X/qMLyw5rYY/tQh7Gs=;
        b=HDAFC3eCS3hE6oq/z8TEQfC5OFHR/+lDNCyVYoNLfjIoONYqrvpfidJiLZERRPUXB9
         w6557ROFXo8GLrAV3OaVxpbH/Re2gKTXWGZU1piDB3Cjn8FxnNB0zb7VDvDZEfFtj7yf
         a32XR+PRTNiXvqd0xKLKKwfTWTJLgXRJVdr70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y1q5v58v/6Ck2XolErxmYzdO5X/qMLyw5rYY/tQh7Gs=;
        b=NLqSmzeAdPqe1DfrfBPOEznes5aDTuSTlT25atnAICoBbH7CAn3ovdb/m9yyHQaPgs
         cBDKwq5lSGSdT4kLOoQQ4txiL/aXlJqpWDvN7wtEFr6MO7PlDKbmwDEDZxFdUqSTWiNw
         RrAsQp6aR3JNxY3cqZax1LucZUZdunebGbDYxcQhun6jA4Ab7rVoZGOY/vuM98dfJ24b
         E08MPfeqEdd5BQfAklKOhZrR2/Ck9HZCCqeNy+kU84N/iV7/izOdnAEn7YH2JQV8E2x8
         QtwhNBvKmWt+ZPabDeQRpd3K/qj/yJablqBYh4sTZvaXyu5sLsFitJRDXz7LMgf4VEak
         TrMA==
X-Gm-Message-State: AGRZ1gJfoDpZrKwoeKayfRfv9KbHi1ixek67WUkvqAemxTw0OFQH9zVP
        tqnoE/rirvKUz6L/IiM+KS92VyI/KgWn8LP8LydpDG4c
X-Google-Smtp-Source: AJdET5ei82Y/UDnCjuvtV5Mc+gtreeV7ELfKWfWDZ1tRuQr2z1J8rqTvnsyYAIggajkCiE73SHcqN00blGh6dHdn90A=
X-Received: by 2002:a6b:5d18:: with SMTP id r24-v6mr16986228iob.170.1541420105082;
 Mon, 05 Nov 2018 04:15:05 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 04:15:04 -0800 (PST)
In-Reply-To: <1541419502-7286-1-git-send-email-gilad@benyossef.com>
References: <1541419502-7286-1-git-send-email-gilad@benyossef.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 13:15:04 +0100
Message-ID: <CAKv+Gu8cmGbJVCe4HJ0Jsyh4bB=X0psk02cFkq9e20ev9C-Opg@mail.gmail.com>
Subject: Re: [PATCH] crypto: cts: document NIST standard status
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <Ofir.Drang@arm.com>,
        Yael Chemla <Yael.Chemla@arm.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 November 2018 at 13:05, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> cts(cbc(aes)) as used in the kernel has been added to NIST
> standard as CBC-CS3. Document it as such.
>
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> Suggested-by: Stephan Mueller <smueller@chronox.de>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  crypto/Kconfig | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index f7a235d..9176023 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -430,11 +430,14 @@ config CRYPTO_CTS
>         help
>           CTS: Cipher Text Stealing
>           This is the Cipher Text Stealing mode as described by
> -         Section 8 of rfc2040 and referenced by rfc3962.
> -         (rfc3962 includes errata information in its Appendix A)
> +         Section 8 of rfc2040 and referenced by rfc3962
> +         (rfc3962 includes errata information in its Appendix A) or
> +         CBC-CS3 as defined by NIST in Sp800-38A addendum from Oct 2010.
>           This mode is required for Kerberos gss mechanism support
>           for AES encryption.
>
> +         See: https://csrc.nist.gov/publications/detail/sp/800-38a/addendum/final
> +
>  config CRYPTO_ECB
>         tristate "ECB support"
>         select CRYPTO_BLKCIPHER
> --
> 2.7.4
>
