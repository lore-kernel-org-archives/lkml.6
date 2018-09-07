Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31C1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4702086D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvVFSalk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4702086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbeIGRSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:18:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbeIGRSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:18:52 -0400
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1865C2083D;
        Fri,  7 Sep 2018 12:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536323887;
        bh=fMLVIyZVlyTnxuWX/3+iSkluK7NEGEACHU+2YIj9zmA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RvVFSalkZ32FgYkgN74h+qbt5pr4eRCXBV4F5Q2HVO0qZ8Bpq71bJWwaLl1qodtJo
         EORWfbpTyAXVmuVJeNweiRLx6BrlRviZfvve0YUA8dPnNFka68aXQVFIdBZDXt5B4h
         02UWQPmzb1f6kYgLtArpHhbHyomaxPyErB10bBt8=
Received: by mail-wm0-f49.google.com with SMTP id f21-v6so14588765wmc.5;
        Fri, 07 Sep 2018 05:38:07 -0700 (PDT)
X-Gm-Message-State: APzg51Dyn86sNPhC8N1BZw+mgC6lR0aYZVktYFlIniN0YDgYSsPlCBBr
        XtT/tzPh/VhuOexbq6Ygbp5QMlNwFmwBB38rJeo=
X-Google-Smtp-Source: ANB0VdbnhRHYZWpVxR4EanOz07SN7yuPdHpSQYXmQkgU1GuDVPc0CvId61TCS5jKqWFNIeZ2rYQJl310DQKOQZd7LcU=
X-Received: by 2002:a1c:9550:: with SMTP id x77-v6mr4803154wmd.135.1536323885502;
 Fri, 07 Sep 2018 05:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <96fe9889-2649-7a1e-23bf-b4d16713d212@free.fr>
In-Reply-To: <96fe9889-2649-7a1e-23bf-b4d16713d212@free.fr>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 7 Sep 2018 14:37:54 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc5UTG2viu8KcbthJmdZW06_yAt+JttNBnbMuW4YU8hSQ@mail.gmail.com>
Message-ID: <CAJKOXPc5UTG2viu8KcbthJmdZW06_yAt+JttNBnbMuW4YU8hSQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: s3c24xx: Correct SD card write protect detection
 on Mini2440
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

On Thu, 6 Sep 2018 at 23:27, Cedric Roux <sed@free.fr> wrote:
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
> index 95753e0..4cd8d45 100644
> --- a/arch/arm/mach-s3c24xx/mach-mini2440.c
> +++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
> @@ -232,10 +232,11 @@ static struct s3c2410fb_mach_info mini2440_fb_info __initdata = {
>  /* MMC/SD  */
>
>  static struct s3c24xx_mci_pdata mini2440_mmc_cfg __initdata = {
> -   .gpio_detect   = S3C2410_GPG(8),
> -   .gpio_wprotect = S3C2410_GPH(8),
> -   .set_power     = NULL,
> -   .ocr_avail     = MMC_VDD_32_33|MMC_VDD_33_34,
> +       .wprotect_invert = 1,
> +       .gpio_detect   = S3C2410_GPG(8),
> +       .gpio_wprotect = S3C2410_GPH(8),
> +       .set_power     = NULL,
> +       .ocr_avail     = MMC_VDD_32_33|MMC_VDD_33_34,

I see that entire struct has wrong indentation. In such case can you
send a separate patch cleaning it up, prior to introducing new
feature? First patch would be cleanup and second new feature.

While at cleanup you can also get rid of other checkpatch errors, like:
ERROR: Macros with complex values should be enclosed in parentheses
ERROR: space required after that ',' (ctx:VxV)
WARNING: please, no space before tabs
ERROR: trailing whitespace
WARNING: Avoid unnecessary line continuations
ERROR: "foo * bar" should be "foo *bar"
ERROR: space prohibited before that close parenthesis ')'
WARNING: quoted string split across lines
WARNING: printk() should include KERN_<LEVEL> facility level

Best regards,
Krzysztof
