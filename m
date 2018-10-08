Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BE7C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A22205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TwDIfgLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A22205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeJIFeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 01:34:07 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41472 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIFeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 01:34:07 -0400
Received: by mail-yb1-f193.google.com with SMTP id e16-v6so8913220ybk.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 15:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zoHpqqSA9IQ/SPGFz8U2W09jevAzL670KNzgXtCf3Yw=;
        b=TwDIfgLZkPhvEGGvjMCzddoOb6lRMRQm/Wg86Us8OGzLJUBuj2DHAp740gi4vR2a//
         YfUdlpvIz7hAtjsN7IEhYRfuGqyZW+Y4Ye8HlRScXq3BfgmaGMUi6c+tNhpb0A2cWIZk
         dWKwGu2bP4stVQ6GZYF+p9B3E2gnAbwIt09RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zoHpqqSA9IQ/SPGFz8U2W09jevAzL670KNzgXtCf3Yw=;
        b=W8ite6ncUjC3lDzIaNjXgNg6BPEAtgPMEssAxBblVkrJ6M1zzM0ioqNzVKNPLK1UAh
         PugJz3gRQ2prQLexeWzd5t3D1NCsU5l6JKUmo5qRGgZqKSHYjA7DbRh94Xcwnf8OjSZ6
         sm5Kp/bukGG+3f7GX4qF7D1OdULylUhJtcm4A+W9FB6b4YPOsY2yvRUAxkW1Qj77pCd/
         4yDC+tlPBGKCZucXqBoI79mOwCYgTfFOfo/obEUn0qxij4BzMJl2uYPYn7BYkmIU9X5U
         2sk5naDRQDRkB06iCd7rWV0f3/ehj3EIG45sMhEQSPlWAQB+dn4OT/T13iKnzuGXAARb
         T8Pg==
X-Gm-Message-State: ABuFfoi3nOIA36fJcgwKYvux4B1hgHvLok+yPRJYbSp79ItwSqaiRCyx
        Sg0Jx0VjOzoileNnLJIDiVCrVCBeQOw=
X-Google-Smtp-Source: ACcGV61nKDpNkt3UIST0AHkXCE5sNGrPz6qcuupLQKOr6T4wYhCeHXVXRVpN7PkJLKKV5wTUJTCXXg==
X-Received: by 2002:a25:4743:: with SMTP id u64-v6mr14291025yba.298.1539037212930;
        Mon, 08 Oct 2018 15:20:12 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id q2-v6sm9584578ywg.87.2018.10.08.15.20.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 15:20:11 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id w7-v6so8940840ybm.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 15:20:11 -0700 (PDT)
X-Received: by 2002:a25:640a:: with SMTP id y10-v6mr14670442ybb.421.1539037211126;
 Mon, 08 Oct 2018 15:20:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 15:20:10 -0700 (PDT)
In-Reply-To: <20181008191712.GA12892@embeddedor.com>
References: <20181008191712.GA12892@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 8 Oct 2018 15:20:10 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+a=81mGFrF5igMXe46mv_PsqzUKCzLWj0oCEMk1PY62g@mail.gmail.com>
Message-ID: <CAGXu5j+a=81mGFrF5igMXe46mv_PsqzUKCzLWj0oCEMk1PY62g@mail.gmail.com>
Subject: Re: [PATCH] crypto: inside-secure: safexcel - fix memory allocation
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 12:17 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> The original intention is to allocate space for EIP197_DEFAULT_RING_SIZE
> *pointers* to struct, so sizeof(priv->ring[i].rdr_req) should be
> sizeof(*priv->ring[i].rdr_req).
>
> Addresses-Coverity-ID: 1473962 ("Sizeof not portable")
> Fixes: 9744fec95f06 ("crypto: inside-secure - remove request list to improve performance")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Luckily, this results in the same size, since it's still a pointer:

struct crypto_async_request **rdr_req;

But yes, it should be fixed.

-Kees

> ---
>  drivers/crypto/inside-secure/safexcel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
> index 86c699c1..bc6c5cb 100644
> --- a/drivers/crypto/inside-secure/safexcel.c
> +++ b/drivers/crypto/inside-secure/safexcel.c
> @@ -1066,7 +1066,7 @@ static int safexcel_probe(struct platform_device *pdev)
>
>                 priv->ring[i].rdr_req = devm_kcalloc(dev,
>                         EIP197_DEFAULT_RING_SIZE,
> -                       sizeof(priv->ring[i].rdr_req),
> +                       sizeof(*priv->ring[i].rdr_req),
>                         GFP_KERNEL);
>                 if (!priv->ring[i].rdr_req) {
>                         ret = -ENOMEM;
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
