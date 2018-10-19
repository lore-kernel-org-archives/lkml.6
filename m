Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40843ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF6C2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFC1Wury"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF6C2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeJSVSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:18:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37321 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbeJSVSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:18:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id d14-v6so38151850qto.4;
        Fri, 19 Oct 2018 06:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IIBE9mDhd3lrnK8Cwm5e9ABSQ72L1zpw3IkzJjDEJF8=;
        b=QFC1WuryauHnVMG0dzbu0AhpoBjV/u4IXgdx2OdMm/kTauyyFpga2THYvkUTYTEWRg
         DFOL5O75IZgLTpqmoF38zqGDxfFAHXIWLsgCsVf+zKenqg2P7tb1hMu5b/uXBJ2emNMn
         whJBqziJocDuPUbtWpRNnKzlyVobied1D/WnIMiwdq+GisqqlhW8cIt/hypeNEpASipD
         p/P33gW5dU+tGQOJE7u0IFFv81ykIbrMoJvR/GZXbY2maSDp0YBAinMj3F/ml9OoIrSt
         QYOnyiwrmu8YFOqM9DDiCr9oNy8pRogxXjwtPwojYFtBPR/yML2XVfZsNadrvkuTcS9p
         wy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IIBE9mDhd3lrnK8Cwm5e9ABSQ72L1zpw3IkzJjDEJF8=;
        b=qixddFhuAiThYcILIKtx02KCNf571gXHO+YKq+jtTDLin2fkhg0xrvMcuAzQ2H48TD
         R39QMa6W9zXzgQHJekvkGO4Swh362uv/XBQrgwEkzUJxOVuaF8l6ffEyuDHtIIytm3wz
         9KPG4ESx/5Knb5jQDA5+ECOqcsmbHVLhZsC/7aObLx1RQx3ZSLoggHqm3BH7lCeynClz
         ztiR2yCXngKNlD8gRw9VfgYJ2k1L3nLBy/4vy83jIUKeE9d3c6beLXkr087H08mi2F48
         Mo709xx3/MuD56wikF8aVgJL9onmFTrWsgQYgks/sCXEa7dSkKU8QLP8XeJ7c5xRm39t
         UYhw==
X-Gm-Message-State: ABuFfoi+qlyTixhz2A8lMBOrhYyXPudfyJkmtM5PmID2cVMALwaUQszX
        yVRtywNzjwrgAJWLAv4pxwgYtKt+MvGS7FVPwys=
X-Google-Smtp-Source: ACcGV61HDdldJipHCkbMyECHm+sOZYNopzsS7KHwwdlL0yFGLLmXh1y8gkImfuYLPN+n9Ax/DPT8sRGnigssj+4lKfk=
X-Received: by 2002:a0c:aa06:: with SMTP id d6-v6mr34293812qvb.26.1539954721789;
 Fri, 19 Oct 2018 06:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181010172300.317643-1-lkundrak@v3.sk> <20181010172300.317643-8-lkundrak@v3.sk>
In-Reply-To: <20181010172300.317643-8-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 16:11:50 +0300
Message-ID: <CAHp75Ve7v0xL-qd5Ri82W1z7jku_Mbxg531J_261-EW0dxsouQ@mail.gmail.com>
Subject: Re: [PATCH 07/15] Platform: OLPC: Avoid a warning if the EC didn't
 register yet
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Just return ENODEV, so that whoever attempted to use the EC call can
> defer their work.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/platform/olpc/olpc-ec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
> index 35a21c66cd0d..342f5bb7f7a8 100644
> --- a/drivers/platform/olpc/olpc-ec.c
> +++ b/drivers/platform/olpc/olpc-ec.c
> @@ -116,8 +116,11 @@ int olpc_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *outbuf, size_t outlen)
>         struct olpc_ec_priv *ec = ec_priv;
>         struct ec_cmd_desc desc;
>
> -       /* Ensure a driver and ec hook have been registered */
> -       if (WARN_ON(!ec_driver || !ec_driver->ec_cmd))
> +       /* Driver not yet registered. */
> +       if (!ec_driver)
> +               return -ENODEV;

Why -ENODEV is preferred over -EPROBE_DEFER?

> +
> +       if (WARN_ON(!ec_driver->ec_cmd))
>                 return -ENODEV;
>
>         if (!ec)
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
