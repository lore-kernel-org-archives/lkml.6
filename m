Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9580C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEBE20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="eBNRXAiC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qph38rXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEBE20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeH3X1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:27:31 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43935 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeH3X1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:27:31 -0400
Received: by mail-oi0-f65.google.com with SMTP id b15-v6so17452767oib.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NsjwPVAhkGtscPoeWBCXZhjt1C6RujmI90oD6SCCW8k=;
        b=eBNRXAiChv7EpjdSShgIJqQAAhyVlw1bak5oszScSLln5hfoLTq3YOb3vXmAkU8mHs
         ymLECYs3HmECI0iaoa4J3sK/5JI8H0IKyQGBCc2khF3VKZrSQVP3B1jUR3D9Z0lVO1bV
         p1bCD4DMSAt2/nLxkaGPCBkioJHfN2piBFvAqO2/Nb9eD5crvk2Qmy8fHr58vqvgNY/X
         f0zaSg5j1vVe3ut0TBD40BSTUONOmBPywjhYXtJsXlmAraXmaPWr07bBb4XJD8ezrgcT
         wdDEDZlTDmW/1ebw69lspPXVBHaYCfpDteRyDW+dgJT5BTg3FitmJ3QiiuIOil8BJEox
         rcDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NsjwPVAhkGtscPoeWBCXZhjt1C6RujmI90oD6SCCW8k=;
        b=Qph38rXBNKAUDoAEqy71FOoAOAUD1Fvu+mFhu3hm1wdv1W+CQXrybOZVJ3zUF7JhQ6
         ObKh+2j7rQbjskckPiQ0NzbLnM7VpNTIcYJwnviunDyvPdI/ywK0YnLnomMDD9mFdpEi
         fg2JeJiJoPIFLaX+QlEbqYjFkGyPQVuSnrTeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NsjwPVAhkGtscPoeWBCXZhjt1C6RujmI90oD6SCCW8k=;
        b=BcR4an7TdpMO+1KvCzIKEeanjrLxWS35fiHjOxUChDIz16VnhyhxqNo8SGqCUkKVz6
         9oE1gQM6BJCPabCBO1rwk1UHZr2/9AONHHhywAzs9F76kaBTM2iI6IE6+zDVgnK7KWzl
         019Kgtl2L/TlCqHocCTk/f4u3CJl1vCSccnhWyTHQUhztSWpeRCuvycn3nbx21rImaqv
         AOpUpBSBdxGa/2F/Zfo03QjazpDFHgORgsRIsk+Njy2t3oal4K7tYMvYxugOJgtYu8wi
         ++UiVFQvDLxGTjtAOLGAn0nlEztz3+M4z+IWPLIUaBwe9eqv+L4DpvICCra0kV9GW+R/
         mlWw==
X-Gm-Message-State: APzg51CyT0Q9cm+OTFkcYmK5zxdeAA5c+qXrutVYWtjOp0JPfg2SZ2/t
        nACpTxS+AkQAhZDCKB7KObyo9/0SQiNivfKn4Lp406qfZsw=
X-Google-Smtp-Source: ANB0Vdb8cdys2vYTxWKiqvCBw13xINl3paDxBSBcCCPd/bHeXsedAk4F/DLmQ6E36g1wMNbAWkkG3dDp/vVzY633Y5Q=
X-Received: by 2002:aca:b904:: with SMTP id j4-v6mr4166735oif.89.1535657029373;
 Thu, 30 Aug 2018 12:23:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8eca:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 12:23:48
 -0700 (PDT)
In-Reply-To: <35c332750fe1eddfa2eb53750b810256310866bd.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org> <35c332750fe1eddfa2eb53750b810256310866bd.1535462942.git.amit.kucheria@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 31 Aug 2018 00:53:48 +0530
X-Google-Sender-Auth: Duhi_sTyISg_1aIHsPZvq_3jLeI
Message-ID: <CAHLCerPF0U22XZ8kEBkXZYJHkL73K8_RFkArs9gXvc0Qmufr-g@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] thermal: tsens: Check if the IP is correctly
 enabled by firmware
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 7:08 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> The SROT registers are initialised by the secure firmware at boot. We
> don't have write access to the registers. Check if the block is enabled
> before continuing.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/thermal/qcom/tsens-common.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 0b8a793f15f4..d250b757d1f0 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -12,6 +12,11 @@
>  #include <linux/regmap.h>
>  #include "tsens.h"
>
> +/* SROT */
> +#define CTRL_OFFSET            0x4

This OFFSET is not constant across the TSENS family and breaks atleast
one platform in the test below. I have a patch to fix this for all
platforms, will post it after a bit more testing.


> +#define TSENS_EN               BIT(0)
> +
> +/* TM */
>  #define STATUS_OFFSET          0x30
>  #define SN_ADDR_OFFSET         0x4
>  #define SN_ST_TEMP_MASK                0x3ff
> @@ -119,6 +124,8 @@ int __init init_common(struct tsens_device *tmdev)
>  {
>         void __iomem *tm_base, *srot_base;
>         struct resource *res;
> +       u32 code;
> +       int ret;
>         struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
>
>         if (!op)
> @@ -151,5 +158,15 @@ int __init init_common(struct tsens_device *tmdev)
>         if (IS_ERR(tmdev->tm_map))
>                 return PTR_ERR(tmdev->tm_map);
>
> +       if (tmdev->srot_map) {
> +               ret = regmap_read(tmdev->srot_map, CTRL_OFFSET, &code);
> +               if (ret)
> +                       return ret;
> +               if (!(code & TSENS_EN)) {
> +                       dev_err(tmdev->dev, "tsens device is not enabled\n");
> +                       return -ENODEV;
> +               }
> +       }
> +
>         return 0;
>  }
> --
> 2.17.1
>
