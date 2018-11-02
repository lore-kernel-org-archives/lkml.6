Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAE3C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC92420831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kQNofNIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC92420831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeKCFwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:52:16 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33619 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeKCFwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:52:15 -0400
Received: by mail-ua1-f67.google.com with SMTP id s26so1124955uao.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEkftHbFMlT6lmaDi20qQGWIgbCeGoyx39pfkLRVDic=;
        b=kQNofNINxzsiUR2zXc4Y66SY1BvzoRNcMrbIIAgVb43tIz564DTb+OU4+aLhxqWem9
         ilzW3/F/TXcPta1Pj2ylmJVXcHjusEocrnZmq9hKB/MIFX4rJzoIfUf4tFuP+F4+XEW8
         3gQ+cXik5TA/nAiKnBya+frfEvWX7XzTz8ylo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEkftHbFMlT6lmaDi20qQGWIgbCeGoyx39pfkLRVDic=;
        b=LGH1wmO1DcnHSuoiTpLWc9ztXYX4zsHmGAFpYHWRAsMrJCh+qRMHreAB1GlVrF8Q3F
         SI30momvQ5B2Q2SOnlXwWkt5MAAx2ddq0MwHaTm5pWTlyY+KFZf0W5L+RTmlit+KwGOa
         Ge3UOVGR4+EsyagjmJsbwtZHM9Q/QCTYH/u+Ui4CTxXvQU+5KMKweKLc18bB4CuA4HEB
         vcICuZnEO1IarS7gxRuINa27UAUCzW+yHmjCoQmgAhchHHr4eCr/EwYPvSlq9bTzPZs2
         hi/ejTe857hVkFyamEXOPa6ON7mXdrs0KWLeJZgaekvZKt8hhZzL9FfpWa+mJUjwWo8b
         mv3A==
X-Gm-Message-State: AGRZ1gJHKaFtLxiZh7Fpk29+hCv7OtA/D3XH6v5DUlW+n9s/7yK2BrjX
        OJG1K3bHbovqz/ikKTjL4H1KiLbULNc=
X-Google-Smtp-Source: AJdET5f0CYGOSqLjsZSJqU4C9PVv3AobZNRGOI4xACC5jElej/jH5b8K+YMpczPGYWRzF1qeRn1zew==
X-Received: by 2002:ab0:7544:: with SMTP id k4mr5915707uaq.66.1541191417930;
        Fri, 02 Nov 2018 13:43:37 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id z10sm7264553uao.10.2018.11.02.13.43.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 13:43:37 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id b18so723343vke.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 13:43:36 -0700 (PDT)
X-Received: by 2002:a1f:9352:: with SMTP id v79mr5664670vkd.73.1541191416496;
 Fri, 02 Nov 2018 13:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181102183537.72334-1-swboyd@chromium.org>
In-Reply-To: <20181102183537.72334-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 2 Nov 2018 13:43:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V7JDAP+riAFSt_CUUFvphEN1jTbkJW_+b-2gubUrCoVg@mail.gmail.com>
Message-ID: <CAD=FV=V7JDAP+riAFSt_CUUFvphEN1jTbkJW_+b-2gubUrCoVg@mail.gmail.com>
Subject: Re: [PATCH] i2c: i2c-qcom-geni: Fix runtime PM mismatch with child devices
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-i2c@vger.kernel.org, alokc@codeaurora.org,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 2, 2018 at 11:35 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We need to enable runtime PM on this i2c controller before populating
> child devices with i2c_add_adapter(). Otherwise, if a child device uses
> runtime PM and stays runtime PM enabled we'll get the following warning
> at boot.
>
>  Enabling runtime PM for inactive device (a98000.i2c) with active children
>  WARNING: CPU: 4 PID: 1 at drivers/base/power/runtime.c:1300 pm_runtime_enable+0xd8/0xf8
>  Modules linked in:
>  CPU: 4 PID: 1 Comm: swapper/0 Not tainted 4.19.0 #6
>  elants_i2c 14-0010: 14-0010 supply vccio not found, using dummy regulator
>  pstate: 60c00089 (nZCv daIf +PAN +UAO)
>  pc : pm_runtime_enable+0xd8/0xf8
>  lr : pm_runtime_enable+0xd8/0xf8
>  sp : ffffffc0de257a30
>  x29: ffffffc0de257a30 x28: 0000000000061a80
>  x27: ffffff9008ea7118
>  x26: ffffffc0d718b058
>  x25: ffffff9008ea7000 x24: ffffffc0d718a8dc
>  x23: ffffffc0d718a8b0 x22: ffffffc0d823dd58
>  x21: 0000000000000000 x20: ffffffc0d823dbc8
>  x19: ffffffc0d823da90 x18: 000000007f743d9a
>  x17: 0000000000000080 x16: 0000000000000003
>  x15: 000000000000003f x14: 0720072007200720
>  x13: 0720072007200720 x12: 0720072007200720
>  x11: 0720072007200720 x10: 0720072007200720
>  x9 : 0720072007200720 x8 : 0720072007200720
>  x7 : ffffff900816da30 x6 : 0000000000000000
>  x5 : 0000000000000080 x4 : 0000000000000003
>  x3 : ffffff900816f304 x2 : ffffffc0de248050
>  x1 : 25045a74f48a7400 x0 : 25045a74f48a7400
>  Call trace:
>   pm_runtime_enable+0xd8/0xf8
>   geni_i2c_probe+0x440/0x460
>   platform_drv_probe+0x74/0xc8
>   really_probe+0x1ac/0x35c
>   driver_probe_device+0xd4/0x118
>   __driver_attach+0xc8/0x118
>   bus_for_each_dev+0xac/0xe8
>   driver_attach+0x38/0x44
>   bus_add_driver+0x15c/0x294
>   driver_register+0x13c/0x198
>   __platform_driver_register+0x88/0x94
>   geni_i2c_driver_init+0x20/0x28
>   do_one_initcall+0x250/0x4ec
>   kernel_init_freeable+0x6f0/0x7c4
>   kernel_init+0x18/0x120
>   ret_from_fork+0x10/0x18
>
> Let's move the runtime PM enabling and setup to before we add the
> adapter, so that this device can respond to runtime PM requests from
> children.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Fixes: 37692de5d523 ("i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C controller")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 527f55c8c4c7..145eb98ac8b4 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -571,18 +571,19 @@ static int geni_i2c_probe(struct platform_device *pdev)
>
>         dev_dbg(&pdev->dev, "i2c fifo/se-dma mode. fifo depth:%d\n", tx_depth);
>
> -       ret = i2c_add_adapter(&gi2c->adap);
> -       if (ret) {
> -               dev_err(&pdev->dev, "Error adding i2c adapter %d\n", ret);
> -               return ret;
> -       }
> -
>         gi2c->suspended = 1;
>         pm_runtime_set_suspended(gi2c->se.dev);
>         pm_runtime_set_autosuspend_delay(gi2c->se.dev, I2C_AUTO_SUSPEND_DELAY);
>         pm_runtime_use_autosuspend(gi2c->se.dev);
>         pm_runtime_enable(gi2c->se.dev);
>
> +       ret = i2c_add_adapter(&gi2c->adap);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Error adding i2c adapter %d\n", ret);
> +               pm_runtime_disable(gi2c->se.dev);
> +               return ret;
> +       }
> +

Thanks for the fix.  It looks good, but can you also swap the
pm_runtime_disable() and i2c_del_adapter() calls in geni_i2c_remove()
to match?

-Doug
