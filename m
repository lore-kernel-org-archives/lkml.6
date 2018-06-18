Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F77C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2010120864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oIo2NcIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2010120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755231AbeFRP63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:58:29 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32797 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754587AbeFRP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:58:27 -0400
Received: by mail-pf0-f196.google.com with SMTP id b17-v6so8397913pfi.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=DNAPrdt9CHFztoYyQeotE7ehGvNPssajXCc8QYxo/tA=;
        b=oIo2NcIOlDW8NePxu2Fjjx8h6TIu4yrwzrEPb6XG7l1jS/4RkZJ/e5tpCCcs5SqFbI
         Pvn2zO1RmOlvPe5j1uu8osXocsMxLbUsEOPgLbFwwMCE4rFI8/swhQczMZXU8yY0cizE
         /Ii4Ck49D+WBvgf7fhuE5FiuqrkJwN2dZcdts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=DNAPrdt9CHFztoYyQeotE7ehGvNPssajXCc8QYxo/tA=;
        b=CDTZaJ5KuVzLbL1ANGoc9EV6c6VjpfDnpXcid3b67Av14RwOgfS0OPTv9PxjZ0ycJP
         i6RcMbwKm/DIGbFPIQKB8yRwgp9Gg9xiBWgQedN3s4KY4Racp5EFAYkNl0V+1mkkFhQx
         1dNAfli2RAGjzOGlMXEItBShtXotQ3MCVJXyAzhvQQNcyco8IMliqw6B5/Ll9H0sfx15
         GuRGGsSWGV0zZ5NSJ+Tz6/pW+unA1QjKSJvzoH0VFcq5vylGrR9P9qHDvE031SWZUEYH
         Y2k0gFHiSaWRUm+9T5WlZ2bfLIKe6TOeV/SlbPZ6Bfb67idNwnhiTnrfYik8GdsTuMjj
         otrw==
X-Gm-Message-State: APt69E1I8IplUuaUzF09vmM2DNOjC1cdaXfvDF50k9YYN9B21dQZZrJO
        rfiTyZB4ZgXRveM5web1snE1qQ==
X-Google-Smtp-Source: ADUXVKKl2ac8isr1jKey8bhx684PL5D9iVsTFcFIVwfcewRWriy3H7rbSBqhGFAGNX1h6PbPReWN9Q==
X-Received: by 2002:a63:b705:: with SMTP id t5-v6mr11554502pgf.343.1529337506514;
        Mon, 18 Jun 2018 08:58:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id e16-v6sm22038987pff.185.2018.06.18.08.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 08:58:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Vinod Koul <vinod.koul@linaro.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180618141259.23141-2-vkoul@kernel.org>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
References: <20180618141259.23141-1-vkoul@kernel.org>
 <20180618141259.23141-2-vkoul@kernel.org>
Message-ID: <152933750484.16708.1950713243960317531@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/3] hwrng: msm - Move hwrng to a table
Date:   Mon, 18 Jun 2018 08:58:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2018-06-18 07:12:57)
> @@ -127,6 +125,13 @@ static void msm_rng_cleanup(struct hwrng *hwrng)
>         msm_rng_enable(hwrng, 0);
>  }
>  =

> +static struct hwrng msm_rng =3D {
> +       .name =3D KBUILD_MODNAME,
> +       .init =3D msm_rng_init,
> +       .cleanup =3D msm_rng_cleanup,
> +       .read =3D msm_rng_read,
> +};
> +
>  static int msm_rng_probe(struct platform_device *pdev)
>  {
>         struct resource *res;
> @@ -148,12 +153,10 @@ static int msm_rng_probe(struct platform_device *pd=
ev)
>         if (IS_ERR(rng->clk))
>                 return PTR_ERR(rng->clk);
>  =

> -       rng->hwrng.name =3D KBUILD_MODNAME,
> -       rng->hwrng.init =3D msm_rng_init,
> -       rng->hwrng.cleanup =3D msm_rng_cleanup,

Wouldn't it be a lot easier to skip assigning the init and cleanup
functions on v2 devices with an if statement? It would be smaller size
wise too because then we don't have two structs for v1 and v2 hwrngs.
Plus the patch would be smaller overall because we would do everything
else pretty much the same besides the if condition in probe.

> -       rng->hwrng.read =3D msm_rng_read,
> +       rng->hwrng =3D &msm_rng;
>  =

> -       ret =3D devm_hwrng_register(&pdev->dev, &rng->hwrng);
> +       rng->hwrng->priv =3D (unsigned long)rng;
> +       ret =3D devm_hwrng_register(&pdev->dev, rng->hwrng);
>         if (ret) {
>                 dev_err(&pdev->dev, "failed to register hwrng\n");
>                 return ret;
> -- =

> 2.14.4
>=20
