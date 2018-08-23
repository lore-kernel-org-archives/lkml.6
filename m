Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D264C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2965F208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZxoAYnI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2965F208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeHXCt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:49:59 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:42488 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbeHXCt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:49:59 -0400
Received: by mail-yb0-f195.google.com with SMTP id z12-v6so2835765ybg.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LAES9gX+SQq3A9ke8uOhWLm+0UsOm6t3NtXOL5NYcnI=;
        b=ZxoAYnI3EGLzTUdoHMyRso57uRnVnLAPGhO299G5ht4gtpAL5E8ABAyOJCer6dMF45
         GB+7a9e1SvCd7UL4nxccrvruIgHP46Pv8aqMNR4G2V8ONGkTaH7L7BbKOm3nvmHK97DQ
         Jc7CtCN4jIaj6bBjKY9HN5Hm9lwVmVzj6nV1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LAES9gX+SQq3A9ke8uOhWLm+0UsOm6t3NtXOL5NYcnI=;
        b=NYRJR6wSlkx85DbfcFOY4//rSSsgPA09nvOOymUQJAvxwnWD1b0xeTGnjbs/ANVJ81
         g/Sm9i22Ybq6Vx9CWO4mx0x36As1O0lIt7YsGWrERwhL3ieaytgCxwZSdX1sw5Ln+2qt
         X1LvB2XJCPLE0sbQU01LcnF5rPRtQHgJVYTQsqYeEwrYT4pmYgFBDOkMQtOirSeUwenV
         ymhL7dnWjac6GECpXtHh3M8Q+NaWISSFfPT3TmXAVf0dMRCStR7TcN5G7Ic8efMjlQ5k
         G7GhbtWvxcP3D7O7RvS+plnCLVPcQbnVYtABTTFmvpjNiHUz+IOJuCP0+SkLe5DPyHD8
         uIKw==
X-Gm-Message-State: AOUpUlEVNvqAzQhjlMt/8TaD85Ym+8rhw2qZiFbT7ALDkrfKfPvE10z6
        iV9LFJ1LQTRYHHjguen8qjPw1qnQGtI=
X-Google-Smtp-Source: AA+uWPwx77NoVeqH+PoA9m8X+dlZSFYLKiRi0iHqG5AbglExJbfCPSYUTaAWm5O0w/EuMiKuq0d9dw==
X-Received: by 2002:a25:8b85:: with SMTP id j5-v6mr34213526ybl.174.1535066283091;
        Thu, 23 Aug 2018 16:18:03 -0700 (PDT)
Received: from mail-yb0-f169.google.com (mail-yb0-f169.google.com. [209.85.213.169])
        by smtp.gmail.com with ESMTPSA id w80-v6sm1406495ywd.55.2018.08.23.16.18.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 16:18:00 -0700 (PDT)
Received: by mail-yb0-f169.google.com with SMTP id o17-v6so2848774yba.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:18:00 -0700 (PDT)
X-Received: by 2002:a25:103:: with SMTP id 3-v6mr34452501ybb.421.1535066280062;
 Thu, 23 Aug 2018 16:18:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 16:17:59
 -0700 (PDT)
In-Reply-To: <20180823230654.GA11576@embeddedor.com>
References: <20180823230654.GA11576@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 23 Aug 2018 16:17:59 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK7VQSo=xsYVp5DPmUgULNt+wopyAXnK20z+LxZtyPfZA@mail.gmail.com>
Message-ID: <CAGXu5jK7VQSo=xsYVp5DPmUgULNt+wopyAXnK20z+LxZtyPfZA@mail.gmail.com>
Subject: Re: [PATCH] clk: npcm7xx: fix memory allocation
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, openbmc@lists.ozlabs.org,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 4:06 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>         int stuff;
>         void *entry[];
> };
>
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count,
> GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>
> Notice that, currently, there is a bug during the allocation:
>
> sizeof(npcm7xx_clk_data) should be sizeof(*npcm7xx_clk_data)
>
> Fix this bug by using struct_size() in kzalloc()
>
> This issue was detected with the help of Coccinelle.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/clk/clk-npcm7xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
> index 740af90..c5edf8f 100644
> --- a/drivers/clk/clk-npcm7xx.c
> +++ b/drivers/clk/clk-npcm7xx.c
> @@ -558,8 +558,8 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
>         if (!clk_base)
>                 goto npcm7xx_init_error;
>
> -       npcm7xx_clk_data = kzalloc(sizeof(*npcm7xx_clk_data->hws) *
> -               NPCM7XX_NUM_CLOCKS + sizeof(npcm7xx_clk_data), GFP_KERNEL);
> +       npcm7xx_clk_data = kzalloc(struct_size(npcm7xx_clk_data, hws,
> +                                  NPCM7XX_NUM_CLOCKS), GFP_KERNEL);
>         if (!npcm7xx_clk_data)
>                 goto npcm7xx_init_np_err;
>
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
