Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55715C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6552244E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9n5oLnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6552244E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754043AbeGELXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:23:16 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36633 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753777AbeGELXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:23:15 -0400
Received: by mail-io0-f194.google.com with SMTP id k3-v6so7401600iog.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 04:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CsMrl3/TaaMURsGvMufugAgwCIxU+5Al5jQAk0RE2YY=;
        b=V9n5oLnLYmZ+upPA6Qemfq/kwHfrlW7isnDv/b9PDinfM6bZcHGfAPkzkRctvtsLiS
         PRsTCeV1ox3lFffCOY11g/kGFwYQq5yj5pCzyTr3lOJInk+T4QFK9oECWPV60TTmWxte
         yKcZTOyfRAH3WXYIf4CFZkGjxUFLMggiUXoDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CsMrl3/TaaMURsGvMufugAgwCIxU+5Al5jQAk0RE2YY=;
        b=GhPJs1pw2zujCpePuyDculCWi0TQYziT3EBjLu8fJ4Tku/OytJxVX6vNA6Wu3hrsA1
         IZMzo5oUm6+VM7v9cBs6yI3uuB3hUk/M6DgLPW6Ckcsm3GZNfdm5wVYEe/PUErs1pPfx
         a4fSd1wQditYVpOgZSM+Rg3WyUMcwi9cQH+blds/UDWr6DtV8TYZsJPfZUG3ZVJFcNWG
         tRbymK7a/K1BrUBlmGCivat01R+3WSZnoadDlbQJyPjhxpfVS0eGSypD6qEQnDCd7xH0
         RkqP1fSdgLcbdY9PRW7DESuUwRGr3nobpfV1+RmuIEsQudJDC++ryv8HGxpXsQMDEy2/
         wXGw==
X-Gm-Message-State: APt69E1hTGspwBHQllYbgoPiuRwzF3J6LK6sl7R8Lvl08XJGDLaN6uVg
        ZDGNse8s2c/iIlvrlEBfB/yM4Pkvabrk/feVP+SXig==
X-Google-Smtp-Source: AAOMgpfCt1MHqAMborFUP1u23R1R7wvevYvqVFCdn/CvRnDnXzWfUoUurixGHyqC7SLH5GNH3/c6Asv99HYJNuMSzCs=
X-Received: by 2002:a6b:e403:: with SMTP id u3-v6mr4378144iog.131.1530789794451;
 Thu, 05 Jul 2018 04:23:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 04:23:13 -0700 (PDT)
In-Reply-To: <20180704150745.21003-1-stefan@agner.ch>
References: <20180704150745.21003-1-stefan@agner.ch>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Jul 2018 13:23:13 +0200
Message-ID: <CAPDyKFovmZxR=Bv0rogas+RTkzkSwbcyRyu1pD4m0LYvExbY8A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: allow 1.8V modes without
 100/200MHz pinctrl states
To:     Stefan Agner <stefan@agner.ch>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 July 2018 at 17:07, Stefan Agner <stefan@agner.ch> wrote:
> If pinctrl nodes for 100/200MHz are missing, the controller should
> not select any mode which need signal frequencies 100MHz or higher.
> To prevent such speed modes the driver currently uses the quirk flag
> SDHCI_QUIRK2_NO_1_8_V. This works nicely for SD cards since 1.8V
> signaling is required for all faster modes and slower modes use 3.3V
> signaling only.
>
> However, there are eMMC modes which use 1.8V signaling and run below
> 100MHz, e.g. DDR52 at 1.8V. With using SDHCI_QUIRK2_NO_1_8_V this
> mode is prevented. When using a fixed 1.8V regulator as vqmmc-supply
> the stack has no valid mode to use. In this tenuous situation the
> kernel continuously prints voltage switching errors:
>   mmc1: Switching to 3.3V signalling voltage failed
>
> Avoid using SDHCI_QUIRK2_NO_1_8_V and prevent faster modes by
> altering the SDHCI capability register. With that the stack is able
> to select 1.8V modes even if no faster pinctrl states are available:
>   # cat /sys/kernel/debug/mmc1/ios
>   ...
>   timing spec:    8 (mmc DDR52)
>   signal voltage: 1 (1.80 V)
>   ...
>
> Link: http://lkml.kernel.org/r/20180628081331.13051-1-stefan@agner.ch
> Signed-off-by: Stefan Agner <stefan@agner.ch>

I am fine with this. Do you want me to apply this for now, to get it tested?

I guess its also material for stable and as fix?

In regards to the printed warning, it sounds to me like a different
issue, which we can solve on top. Right?

[...]

Kind regards
Uffe
