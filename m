Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A35C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861F520659
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PrTm4SzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861F520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbeJKGBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:01:21 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39414 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbeJKGBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:01:21 -0400
Received: by mail-vs1-f66.google.com with SMTP id m5so6667984vsk.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 15:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=STsx/ruzhjXY3q2El0kDKs3Wx7Kd6yVFAyh71U1Acw8=;
        b=PrTm4SzGiBqMr0/y7u/6Zs7/P3z6VMTevpd7uJW1ab/S8dQ7u/bFAm2wqxfV17vJBz
         vjoQHSVENOLM3exMHh2CizXGhRDPPJUsJ1pb6sO3AsaJY0oI7G+PxhQCAkzNb9KnMtck
         cxtoUw/oOYlSQJ8DuP4bZNadHUPYJHwyg+Mw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=STsx/ruzhjXY3q2El0kDKs3Wx7Kd6yVFAyh71U1Acw8=;
        b=jusBUgJhH82qy95oAGaW8jc4XUIhPrMYNSQatA8a1XEh6MIid2KVaOsDIQ2p61Dbbi
         ApxHUvDXAEJfcNsPUjdaerg+Pqr923kaGRCBP/HEnR7oKLlIIn4UzFaQxm4jMGgHCbzx
         hOmmBr/37++VVAUnz30jHjuPwFfEaiH62LkSSOigT9RbIfQBbRTbTza7K+0qXZmKAXdO
         zlDp8lae9SqkYT/neFy2M56/qXUL4wtrzQHGEU2HhysAG+o40SSZRajXfa0wcvZQTh9k
         aM+3mnxxkluCwICRYOfaC5CaBNPla/WeWibS17bF2ny7tyfiyMlmRVO0qLdhuxMORQF1
         GYkg==
X-Gm-Message-State: ABuFfohL76WXtZIEdl+E9Jc+y33D8tMUB1qKCckuWItRWtPGQP2oFJWX
        cLsHNyaG/vjcH/dIT9A81e8MREWyb9Q=
X-Google-Smtp-Source: ACcGV61pTyrEIrJy7xsR3Lox3cKVBypyAJtjwflUHVxJTy6BkJAekEe77eo9/P8xzm7LHXlEGndDWQ==
X-Received: by 2002:a9f:3048:: with SMTP id i8mr6442365uab.9.1539211025847;
        Wed, 10 Oct 2018 15:37:05 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id p82sm4994823vsc.18.2018.10.10.15.37.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 15:37:04 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id e126so6675908vsc.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 15:37:04 -0700 (PDT)
X-Received: by 2002:a67:8316:: with SMTP id f22mr9601470vsd.6.1539211024414;
 Wed, 10 Oct 2018 15:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181005090920.26108-1-mgautam@codeaurora.org>
In-Reply-To: <20181005090920.26108-1-mgautam@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 10 Oct 2018 15:36:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UgFBzUzjqakJp2OCoKVcbEksrv-QrQ5-303ZqTCfv=hw@mail.gmail.com>
Message-ID: <CAD=FV=UgFBzUzjqakJp2OCoKVcbEksrv-QrQ5-303ZqTCfv=hw@mail.gmail.com>
Subject: Re: [PATCH v1] phy: qcom-qusb2: Fix HSTX_TRIM tuning with fused value
 for SDM845
To:     Manu Gautam <mgautam@codeaurora.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 5, 2018 at 2:09 AM Manu Gautam <mgautam@codeaurora.org> wrote:
>
> Tune1 register on sdm845 is used to update HSTX_TRIM with fused
> setting. Enable same by specifying update_tune1_with_efuse flag
> for sdm845, otherwise driver ends up programming tune2 register.
> While at it, also fix HSTX_TRIM tuning logic which instead of
> using fused value as HSTX_TRIM, incorrectly performs bitwise OR
> operation with existing default value.
>
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qusb2.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

It's a little weird that the old code wasn't causing more problems.
Any idea why?  On SDM845 it looks like the old code was clobbering the
"fstx slew rate control" bits.

In any case, this looks like it fixes several commits:

1. The bitwise OR vs. setting the bits w/ mask fixes the original
driver at commit ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2
PHY on Qcom chips").  It'll be slightly annoying to backport past
commit c71dabf27c3a ("phy: qcom-qusb2: Add support for different
register layouts") but you should still tag "Fixes" with the original
commit in case anyone wants to do it.

2. On sdm845 it was updating the wrong register (tune2 instead of
tune1).  This fixes commit ef17f6e212ca ("phy: qcom-qusb2: Add QUSB2
PHYs support for sdm845").

...because of the above I'd suggest splitting this into two commits:
one that fixes the qusb2_write_mask() and one that fixes sdm845.  Then
add the "Fixes:" tag.  This will really help in the backports to
linux-stable.


> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> index e70e425f26f5..defeb0b7cfa0 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> @@ -231,6 +231,7 @@ static const struct qusb2_phy_cfg sdm845_phy_cfg = {
>         .mask_core_ready = CORE_READY_STATUS,
>         .has_pll_override = true,
>         .autoresume_en    = BIT(0),
> +       .update_tune1_with_efuse = true,
>  };
>
>  static const char * const qusb2_phy_vreg_names[] = {
> @@ -415,12 +416,13 @@ static void qusb2_phy_set_tune2_param(struct qusb2_phy *qphy)
>
>         /* Fused TUNE1/2 value is the higher nibble only */
>         if (cfg->update_tune1_with_efuse)
> -               qusb2_setbits(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE1],
> -                             val[0] << 0x4);
> +               qusb2_write_mask(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE1],
> +                                val[0] << HSTX_TRIM_SHIFT,
> +                                HSTX_TRIM_MASK);
>         else
> -               qusb2_setbits(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE2],
> -                             val[0] << 0x4);
> -
> +               qusb2_write_mask(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE2],
> +                                val[0] << HSTX_TRIM_SHIFT,
> +                                HSTX_TRIM_MASK);

In general your patch seems like something we should take.  ...but it
made me look a bit more at the code and I think your patch will tickle
another bug that we probably need to fix first.

Specifically there are two ways to set HSTX_TRIM.  One is in
qusb2_phy_set_tune2_param() and the other is in
qusb2_phy_override_phy_params().  At the moment we first call
qusb2_phy_override_phy_params() and then we call
qusb2_phy_set_tune2_param().  That means that (now that we've fixed
qusb2_phy_set_tune2_param()) we'll _always_ set the tuning based on
qusb2_phy_set_tune2_param() assuming that the nvmem is specified (and
non-zero).  ...and it's specified in sdm845.dtsi so that means that on
SDM845 it's _always_ specified.

Said another way: the 'qcom,hstx-trim-value' in sdm845-mtp.dts is
totally useless because it will always be overridden by the fuse which
is specified in sdm845.dtsi.

I have no idea how the fused value vs. the device tree value are
supposed to interact, but that doesn't seem right.  ...or is the fused
value really supposed to override and it'll be 0 if it's not supposed
to?

-Doug
