Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C955C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0921C20A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k5VzXVnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0921C20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbeGJWmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:42:39 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46713 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732258AbeGJWmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:42:39 -0400
Received: by mail-lf0-f65.google.com with SMTP id l16-v6so19667089lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 15:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bl/OPW0Cbb9NhKnqwvj64bGfSynMjuNjZ3CBIRpObxU=;
        b=k5VzXVnfonZ6vncEd0K9nsffLSaYFDjLN6eztf9SW+RPHjf5OoFB0zCJk8L2rFgUx2
         hssfwv42PNkutkVeoB8rw0pRcRG3K3jF4wWz1ZpFruqMA0rUA16P4IwUD+vu31XOkeTS
         NfTI5tijoz78QogHcZZ2PQ+vwPS5kjUU9Flbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bl/OPW0Cbb9NhKnqwvj64bGfSynMjuNjZ3CBIRpObxU=;
        b=AsqTvXCg7A0UUECOsN2NZstZQeOWn5wHU2GyRLaSDKraodRSHdD5kdoyx65eu7BvBp
         s2OSjLOxKFOewJC9GMT9vybCAt0vVeqWalgWoR7WIcEM99jwP7f8TLId8AdwaBwM9num
         oJLWn8E6hlK4CS6aWkQpAGusi85yCI9YFndLLn56K6iZ6HtBpbJ5uqKzkmpq0N2Q5Syt
         VI/4lGIzzwuneQ92ck0pYlmOHGe6aANGaYLKoDiiYIWldWv0oIUYjuo1pDgVvnyKEmiA
         TIGJqv50KEGBNl5+tfoIcjjVT4rgmf9wOH1o59+azx58tg9qV0wjHJ8OyEjpMuwePfFX
         rGLg==
X-Gm-Message-State: APt69E35Ei08VEj5BucqTFLcTrOvOb3haOi6Vb8FUC3sLyFeHojiuNAf
        ubktl9SQ9zTdaUca8vOmxsmpGDg4cw0=
X-Google-Smtp-Source: AAOMgpf4CswjBOFXlN7MsuXkKt22I6Rdz4Jz9cC7XrTpVwiwffZbDqxTKhU81ehtQv3h0b+2F6q8Vw==
X-Received: by 2002:a19:6d11:: with SMTP id i17-v6mr4225285lfc.103.1531262484518;
        Tue, 10 Jul 2018 15:41:24 -0700 (PDT)
Received: from mail-lf0-f51.google.com (mail-lf0-f51.google.com. [209.85.215.51])
        by smtp.gmail.com with ESMTPSA id h40-v6sm92814lfi.84.2018.07.10.15.41.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 15:41:24 -0700 (PDT)
Received: by mail-lf0-f51.google.com with SMTP id g6-v6so8974270lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 15:41:24 -0700 (PDT)
X-Received: by 2002:a19:d754:: with SMTP id o81-v6mr3886562lfg.124.1531262115999;
 Tue, 10 Jul 2018 15:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180709155104.25528-1-georgi.djakov@linaro.org> <20180709155104.25528-7-georgi.djakov@linaro.org>
In-Reply-To: <20180709155104.25528-7-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 10 Jul 2018 15:34:39 -0700
X-Gmail-Original-Message-ID: <CAE=gft4YR27-ZyR5GXVxbiRbGycw=ydHu182LfwaLD=M+a8CNw@mail.gmail.com>
Message-ID: <CAE=gft4YR27-ZyR5GXVxbiRbGycw=ydHu182LfwaLD=M+a8CNw@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] interconnect: qcom: Add msm8916 interconnect
 provider driver
To:     georgi.djakov@linaro.org
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Alexandre Bailon <abailon@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mka@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, tfiga@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 8:51 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Add driver for the Qualcomm interconnect buses found in msm8916 based
> platforms.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/Kconfig        |   5 +
>  drivers/interconnect/Makefile       |   1 +
>  drivers/interconnect/qcom/Kconfig   |  10 +
>  drivers/interconnect/qcom/Makefile  |   2 +
>  drivers/interconnect/qcom/msm8916.c | 499 ++++++++++++++++++++++++++++
>  5 files changed, 517 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/msm8916.c
>
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index a261c7d41deb..07a8276fa35a 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -8,3 +8,8 @@ menuconfig INTERCONNECT
>
>           If unsure, say no.
>
> +if INTERCONNECT
> +
> +source "drivers/interconnect/qcom/Kconfig"
> +
> +endif
> diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
> index 97fca2e09d24..7944cbca0527 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_INTERCONNECT)             += core.o
> +obj-$(CONFIG_INTERCONNECT_QCOM)                += qcom/
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index b0c2ff928d88..a87afdef1bf7 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -2,6 +2,8 @@ config INTERCONNECT_QCOM
>         bool "Qualcomm Network-on-Chip interconnect drivers"
>         depends on INTERCONNECT
>         depends on ARCH_QCOM || COMPILE_TEST
> +       help
> +         Support for Qualcomm's Network-on-Chip interconnect hardware.
>
>  config INTERCONNECT_QCOM_SMD_RPM
>         tristate "Qualcomm SMD RPM interconnect driver"
> @@ -9,3 +11,11 @@ config INTERCONNECT_QCOM_SMD_RPM
>         help
>           This is a driver for communicating interconnect related configuration
>           details with a remote processor (RPM) on Qualcomm platforms.
> +
> +config INTERCONNECT_QCOM_MSM8916
> +       tristate "Qualcomm MSM8916 interconnect driver"
> +       depends on INTERCONNECT_QCOM
> +       select INTERCONNECT_QCOM_SMD_RPM

I'm not a kconfig expert, maybe someone else could chime in. I have
this impression that folks don't like select. Is there a way to do
this with depends instead? If I'm way off here, ignore me.
