Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94317C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501B320881
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d34YHbjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501B320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeIJPRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbeIJPRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:17:12 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 093E620881;
        Mon, 10 Sep 2018 10:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536575030;
        bh=Fa9EWbfhv2PCKSH1EMmaImakFzc0io5d5mH8SxNkKZw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d34YHbjOcm8jyb3oWhLL9CVBE/DjRXhelsYiJmiFsQ7/doMYezvcBPTqVKXz1N69K
         XN0qolFdM3/Y9M3tf0yKbK9ktKoRmhxLHelgHmNJB9RI/t3JFiWWp0z+9gLXh2qp9O
         56b1bs/NopwYIF19sidwEXgZLwxP/KyNQab/FkMI=
Received: by mail-wm0-f51.google.com with SMTP id j192-v6so20897093wmj.1;
        Mon, 10 Sep 2018 03:23:49 -0700 (PDT)
X-Gm-Message-State: APzg51BUPRQUb7I6YxUbuqQeS9UG+DZDGtFbm/DHWtJSCpirHpdxXd4+
        A9FLea7E12xlR4mw1w1YcqOP0hMS1lUtOt29dZQ=
X-Google-Smtp-Source: ANB0VdYYHFfcj4wSVN0EpgYSeJPPrHPU0qS00xi6iqNdWySQg7hZ70g1xlALFsW4tOdlr9uSgp3LaDJyG1HQiRLf0nc=
X-Received: by 2002:a1c:d785:: with SMTP id o127-v6mr217287wmg.67.1536575028422;
 Mon, 10 Sep 2018 03:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180907215446.15160-1-sed@free.fr> <20180907215446.15160-2-sed@free.fr>
In-Reply-To: <20180907215446.15160-2-sed@free.fr>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 10 Sep 2018 12:23:37 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeYO3VR5LABP3zKYnKckqUBahKPt7MCjzuo3j6oe+d87w@mail.gmail.com>
Message-ID: <CAJKOXPeYO3VR5LABP3zKYnKckqUBahKPt7MCjzuo3j6oe+d87w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: s3c24xx: Correct SD card write protect
 detection on Mini2440
To:     sed@free.fr
Cc:     kgene@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2018 at 23:53, Cedric Roux <sed@free.fr> wrote:
>
> The mini2440 computer uses "active high" to signal that the "write protect"
> of the inserted MMC is set. The current code uses the opposite, leading to
> a wrong detection of write protection. The solution is simply to use
> ".wprotect_invert = 1" in the description of the MMC.
>
> Signed-off-by: Cedric Roux <sed@free.fr>
> ---
>  arch/arm/mach-s3c24xx/mach-mini2440.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
> index 4a0bf6abba8c..bfce7971d741 100644
> --- a/arch/arm/mach-s3c24xx/mach-mini2440.c
> +++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
> @@ -234,10 +234,11 @@ static struct s3c2410fb_mach_info mini2440_fb_info __initdata = {
>  /* MMC/SD  */
>
>  static struct s3c24xx_mci_pdata mini2440_mmc_cfg __initdata = {
> -       .gpio_detect   = S3C2410_GPG(8),
> -       .gpio_wprotect = S3C2410_GPH(8),
> -       .set_power     = NULL,
> -       .ocr_avail     = MMC_VDD_32_33|MMC_VDD_33_34,
> +       .gpio_detect     = S3C2410_GPG(8),
> +       .gpio_wprotect   = S3C2410_GPH(8),
> +       .wprotect_invert = 1,
> +       .set_power       = NULL,
> +       .ocr_avail       = MMC_VDD_32_33|MMC_VDD_33_34,

This looks unexpected... after patch 1 there should be only one change
- one new line added. What happened here?

Best regards,
Krzysztof
