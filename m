Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EA8C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F14920831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKyM6dvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F14920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeKBRVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 13:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeKBRVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 13:21:51 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E873420854;
        Fri,  2 Nov 2018 08:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541146531;
        bh=EkvWRnn0Heptyyibu8w5GyDBooQmiwEveOHxIylk+gM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hKyM6dvmRnQm7cEmbua4CO0T6Uv5y4wuCTMhXPFRyiVrG+JgxUDODBoE8sXTod+o5
         LfW2XQ3lPSa0QYMc5HLJd22s5Jt0yi+PnyXriEcBkEL1Lig+6VYuR2i+6eiW4WCqLV
         QwAPdBUKC46ptWgod9+l0VW7CHAbOhD3zdio1enI=
Received: by mail-lj1-f176.google.com with SMTP id x85-v6so996241ljb.2;
        Fri, 02 Nov 2018 01:15:30 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKUGFLEfAsXMWlvNfTvz/X8EKKAdQyWR5+BKyEiM+6uxrEuvQuj
        j6d07h4shz1XLb4LgoqxQ4m5jDOssoewZxm+2pQ=
X-Google-Smtp-Source: AJdET5fdYFlrkf/tLEE46Lc3Hc8N/fAyxg9i9W9jlScPjH7+7uXnMQueyxWPD/lX1Q0K8IZW55ss3H8Ovium8d75Ng8=
X-Received: by 2002:a2e:85d3:: with SMTP id h19-v6mr2412555ljj.82.1541146528933;
 Fri, 02 Nov 2018 01:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1541054985.git.matti.vaittinen@fi.rohmeurope.com> <83e985f2f60a68f89fac777aa29c55b1edb8769f.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <83e985f2f60a68f89fac777aa29c55b1edb8769f.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 2 Nov 2018 09:15:17 +0100
X-Gmail-Original-Message-ID: <CAJKOXPd=E+S3j3XnpCVRs3JdStY2z+pHe0bh_HNzQTmJW_dH=Q@mail.gmail.com>
Message-ID: <CAJKOXPd=E+S3j3XnpCVRs3JdStY2z+pHe0bh_HNzQTmJW_dH=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] clk: clk-max77686: Clean clkdev lookup leak and
 use devm
To:     matti.vaittinen@fi.rohmeurope.com
Cc:     corbet@lwn.net, mturquette@baylibre.com, sboyd@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, kgene@kernel.org,
        s.nawrocki@samsung.com, Tomasz Figa <tomasz.figa@gmail.com>,
        andrew.smirnov@gmail.com, sre@kernel.org, linux@roeck-us.net,
        robh@kernel.org, sjhuang@iluvatar.ai, Akshu.Agrawal@amd.com,
        rafael.j.wysocki@intel.com, djkurtz@chromium.org,
        mazziesaccount@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018 at 08:19, Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
>
> clk-max77686 never clean clkdev lookup at remove. This can cause
> oops if clk-max77686 is removed and inserted again. Fix leak by
> using new devm clkdev lookup registration. Simplify also error
> path by using new devm_of_clk_add_parent_hw_provider.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/clk/clk-max77686.c | 25 ++++---------------------
>  1 file changed, 4 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
> index 02551fe4b87c..b1920c1d9b76 100644
> --- a/drivers/clk/clk-max77686.c
> +++ b/drivers/clk/clk-max77686.c
> @@ -235,7 +235,7 @@ static int max77686_clk_probe(struct platform_device *pdev)
>                         return ret;
>                 }
>
> -               ret = clk_hw_register_clkdev(&max_clk_data->hw,
> +               ret = devm_clk_hw_register_clkdev(dev, &max_clk_data->hw,
>                                              max_clk_data->clk_idata.name, NULL);

You need to re-align the next line.

>                 if (ret < 0) {
>                         dev_err(dev, "Failed to clkdev register: %d\n", ret);
> @@ -244,8 +244,8 @@ static int max77686_clk_probe(struct platform_device *pdev)
>         }
>
>         if (parent->of_node) {
> -               ret = of_clk_add_hw_provider(parent->of_node, of_clk_max77686_get,
> -                                            drv_data);
> +               ret = devm_of_clk_add_parent_hw_provider(dev,
> +                                               of_clk_max77686_get, drv_data);

The same, please.

Rest looks good, so with these changes:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
