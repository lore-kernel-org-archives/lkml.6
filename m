Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFC3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905132086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BtSOfl6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905132086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbeKTBqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:46:40 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36659 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbeKTBqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:46:40 -0500
Received: by mail-qk1-f196.google.com with SMTP id o125so49127660qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 07:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7v9ifr9DKIZvKyNCR25kpbfcPqULn5218MHkC3ZE8TQ=;
        b=BtSOfl6+DQe3a8zRJFfZunn006Yb+kwzv6GSPNuPVmtboudZ93hAdHHtQ/OixteWcZ
         nueiRpKTh2JwXpoFERlhw5jvkBDPk63xcXq1h5c39WAhvH5lI6pPTNv5gSvs+Uo9jp58
         5GAdQ9KBR3uEVRh1HpItUbGsbFaZ/sZihddl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7v9ifr9DKIZvKyNCR25kpbfcPqULn5218MHkC3ZE8TQ=;
        b=S4gdtK+GRlGpPI6RcB61KCrzJbSyH/ieDgAvfmgMNrX5yBEvR8EioqFhuLXAPwz/0f
         R8M6U6wCHQcYNrn+Zq7Iseuf35TmOO3Ka5nsWBOc8NR3HRO3fidpaM1i1RIFpaqrxRQf
         f1Pxd4jxlRV2NrqpcIXWnnnaraJO6wKY6I7ROISEXnXZanqhOueUNg0ugyJS/wy9ZGeI
         ILM+lGjD+Kz6o8a9CQ0e9l2ufv73NVRpHamUbF2pxrMdpCbM3xJArDixWUAafdagNlsq
         X/90kUHZ/q8iGPPQ0eGySEAgeUydEL9qPLTsr9evC8eoPvN6w9XBUCbk2FmdYb9ewALE
         TJNw==
X-Gm-Message-State: AGRZ1gKFCbhRvvFiUmbI7x3dUWV0ORbILswgVLh6K2xTjCXrdxyCz3la
        HS9L9/fWlhg5/mInu3LrjPVfWgBjyYWxmKvPD0uz5w==
X-Google-Smtp-Source: AJdET5fYsY0R4TSVzY1V5mw0hlKZxjjy1LCuSpCXxopsnf5jLzTUih7EFYW8fOVPlE3n6IqkEtg+2DgoqQ/jTU8byFw=
X-Received: by 2002:ac8:203:: with SMTP id k3mr22035482qtg.64.1542640964256;
 Mon, 19 Nov 2018 07:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20181115174330.15224-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20181115174330.15224-1-srinivas.kandagatla@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 19 Nov 2018 20:52:33 +0530
Message-ID: <CAP245DXUVfMc--TwkGkd-kzeDwSnDtG62zfjYQnMJr5XVmVjNw@mail.gmail.com>
Subject: Re: [PATCH] thermal: tsens: qcom: do not create duplicate regmap
 debugfs entries
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:15 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Regmap would use device name to create debugfs entries. If the device
> has multiple regmaps it is recommended to use name field in regmap_config.
> Fix this by providing name to the regmap configs correctly.
>
> Without this patch we would see below error on DB820c.
>
> qcom-tsens 4a9000.thermal-sensor: Failed to create 4a9000.thermal-sensor
> debugfs directory

Good catch!

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Acked-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

after a minor fix below...

> ---
>  drivers/thermal/qcom/tsens-common.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 3be4be2e0465..78652cac7f3d 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -114,6 +114,14 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
>  }
>
>  static const struct regmap_config tsens_config = {

I suggest renaming this to tsens_tm_config and modifying the
corresponding devm_regmap_init_mmio below.

> +       .name           = "tm",
> +       .reg_bits       = 32,
> +       .val_bits       = 32,
> +       .reg_stride     = 4,
> +};
> +
> +static const struct regmap_config tsens_srot_config = {
> +       .name           = "srot",
>         .reg_bits       = 32,
>         .val_bits       = 32,
>         .reg_stride     = 4,
> @@ -139,8 +147,8 @@ int __init init_common(struct tsens_device *tmdev)
>                 if (IS_ERR(srot_base))
>                         return PTR_ERR(srot_base);
>
> -               tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev,
> -                                                       srot_base, &tsens_config);
> +               tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev, srot_base,
> +                                                       &tsens_srot_config);
>                 if (IS_ERR(tmdev->srot_map))
>                         return PTR_ERR(tmdev->srot_map);
>
> --
> 2.19.1
>
