Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47B5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5718621566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDQTEfcr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5718621566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbeI0HRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:17:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38386 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeI0HRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:17:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id p6-v6so757676ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 18:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tzLI9Nm8T6ipPyv+xsQ8ntnWkTG/eRpO7hmxlGzQR5s=;
        b=PDQTEfcrCSuphgwOhZd/VBBlDjBoyxEVZVvStXzgwKlnuoTdMxBtks123yBKqRaH/x
         GZ9rtKenIHio9znywsAhHmbrro1HaHRSuIyB543DZqpNkEC2hGRuFMSPbx/1reBv0CH9
         9zix+piy610xXWhrHfFtDnJ8W1jrGDOuMza4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tzLI9Nm8T6ipPyv+xsQ8ntnWkTG/eRpO7hmxlGzQR5s=;
        b=V5C+IiQwNA5Iv2F5ln1XkIouFJU86Bp93ux/EgoLk3ntqCv5LDDzpWU/KuFDRYH9EK
         c2KSvYnSBqP2IM5XsL7STPxJaK2pE0N+tVc0zaQYOJpduJA4YfVAMuddoRDK0MTs8ESa
         p3IHfBDrsGsvzBuFsu49hDUsNUswHfecDJhKxUMdplLRNGvrbBULc4/EYVYlgv2UcATH
         DHcilcoRuyYN0+//JSiO9TfSF0TYC4ybBYVsCGIBuwlkC+QXNdlIheryyUnqYh+SHihg
         3432g/EswVpa3Tv6r/DKO9mvJkqg/BaE/ulf9wUWoVkow7ZmtD39ktcva6tLCe4YAQAn
         t7VQ==
X-Gm-Message-State: ABuFfohJzOEncV6c/nDGOTBFm9LvZ9fqguePc2SqJ7G4R/Kbkm51cZzk
        px/KvVtT78SBBZ2nXu+PDx/jwqhkOaDUeK/nM0sR+Q==
X-Google-Smtp-Source: ACcGV63XctakyT+Fydvyazu0iIIxKc2WZgmYsCKpC4cZrthJIkkgC2CnpVqZjXOWDkGIvmmPEcGQPzFCenQ9v7edvZ8=
X-Received: by 2002:a2e:9851:: with SMTP id e17-v6mr5959576ljj.143.1538010082199;
 Wed, 26 Sep 2018 18:01:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 18:01:21
 -0700 (PDT)
In-Reply-To: <20180926125833.2225931-1-arnd@arndb.de>
References: <20180926125833.2225931-1-arnd@arndb.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 27 Sep 2018 09:01:21 +0800
Message-ID: <CAMz4kuKeDorMtrO4vgnrMGmXgQms-pw14vb11Xbi0kQ-fX8egQ@mail.gmail.com>
Subject: Re: [PATCH] spi: sprd: don't mark remove function as __exit
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>,
        linux-spi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 September 2018 at 20:58, Arnd Bergmann <arnd@arndb.de> wrote:
> The __exit section is left out for built-in drivers, so a
> 'remove' callback must not be marked as such to avoid breaking when
> we unbind a device at runtime. This was pointed out by kbuild:
>
> `sprd_spi_remove' referenced in section `.data' of drivers/spi/spi-sprd.o: defined in discarded section `.exit.text' of drivers/spi/spi-sprd.o
>
> Fixes: e7d973a31c24 ("spi: sprd: Add SPI driver for Spreadtrum SC9860")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd.

Acked-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  drivers/spi/spi-sprd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
> index a9a6c5ed443f..8daa24eec624 100644
> --- a/drivers/spi/spi-sprd.c
> +++ b/drivers/spi/spi-sprd.c
> @@ -676,7 +676,7 @@ static int sprd_spi_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> -static int __exit sprd_spi_remove(struct platform_device *pdev)
> +static int sprd_spi_remove(struct platform_device *pdev)
>  {
>         struct spi_controller *sctlr = platform_get_drvdata(pdev);
>         struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
> --
> 2.18.0
>



-- 
Baolin Wang
Best Regards
