Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFFCC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5599A25E4C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRPQT3LE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5599A25E4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbeGBOGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:06:17 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39782 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeGBOGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:06:14 -0400
Received: by mail-it0-f67.google.com with SMTP id p185-v6so12136830itp.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8jv4Wha2tU56as4dMWNkjv2EJVPnNyWuolzhLfV79c=;
        b=GRPQT3LE4QgiFvfGNtt1WyrCXGHonhADl3sQz5MH9qDPcoIXSJsAdw7/DccCv91+So
         puKSA3JcktEtpUd9U7S1e4w/wRwo5/II6DEIWZdxcN+v6Abe9Ihfi2N9LOS3lwRtdXAA
         CPZC2b0RF0W9P/f77XV5HjQvP/KODbPRq0m3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8jv4Wha2tU56as4dMWNkjv2EJVPnNyWuolzhLfV79c=;
        b=PVgKRM47xPpNpF8jYCz3hjZD2zNEB+nt2GxhZYCACeadiPeIrQwq1euQEwbi3qgLBo
         GbOkxtyq/FWppWihe6/BARYRQEYyeP5Cwc9VOQTaJqEBCw32FO1kMZ9aeXZjMZGtWTxG
         fPAdY+kyJ9kB//xgtUeOv02bB0UJvF0x/zI/oXA+lg20S8sxsUYCCrGXWF/Y+6BczYve
         R9o9QbsSpJOPcKq2dorl1lJAN3t0xFOkFWEkIS3v6XtKjUtGWL7+3oqZ5hx+NfSstrIS
         Qku3zP8umChUxQdLgAS66++AgS34hr5ar66EUKqvd53XU5yjhOs19GL7yeqqU9WFVMvF
         r1Bw==
X-Gm-Message-State: APt69E0vcD7n5D2SeFy+G3GkFfkB68lr29vwc0oOkC0bwIbQSwa5Wtv2
        ez9SUaHVrtOj2+bmu176n/eQVkB5cVG71TTy3mxbGg==
X-Google-Smtp-Source: AAOMgpcERG5dfbXo/BnIvvg6jgisUfZOnmz2sCWBWW9UnwKQjb+V2zNJSdJX+5lOWg6deR0atD+W/9PSt2WJlkT/zpI=
X-Received: by 2002:a02:e84:: with SMTP id 126-v6mr20067440jae.113.1530540374106;
 Mon, 02 Jul 2018 07:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180702124708.7295-1-colin.king@canonical.com>
In-Reply-To: <20180702124708.7295-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 2 Jul 2018 16:06:02 +0200
Message-ID: <CACRpkda2CkPFRPcpHSukBNjH+m6szCxq6Cfs+uK5fLHthQmZkg@mail.gmail.com>
Subject: Re: [PATCH][V2] pinctrl: actions: fix unsigned less than zero comparison
To:     Colin King <colin.king@canonical.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 2:47 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> The check to see if platform_get_irq failed is performed on the
> unsigned value of pctrl->irq[i] and the check is never true because
> an unsigned cannot be less than zero.  Fix this by assinging the
> signed int ret to the return of platform_get_irq and checking ret
> instead.
>
> Detected by CoverityScan, CID#1470247 ("Unsigned comparison against 0")
>
> Fixes: 6c5d0736e9c0 ("pinctrl: actions: Add interrupt support for OWL S900 SoC")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>
> V2: move pctrl->irq[i] = ret assignment below the check on ret, thanks
> to Manivannan Sadhasivam for suggesting this change.

Patch applied with Manivannan's ACK!

(Hope it's the right version now.)

Yours,
Linus Walleij
