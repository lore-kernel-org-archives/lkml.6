Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8607EC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF3F21AA9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I70n5Ix0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF3F21AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbeHIARx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:17:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33767 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIARx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:17:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id s12-v6so2919613ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iek6DkXVV1eIr5wvCeVjtQoXGUpY9Eqyd2u7FjrTaz0=;
        b=I70n5Ix0ZMZdaWn8N4cHmaitciOXWrwXERvZd3GjPCRGG9rrRjRAwAA3t5CQP1Ib05
         giOeJWreAgFupmVW5EWFAlBvGFQdF1oCeVaM5HHC197MKDisiByCEYk65frhxBt8uhvq
         SFFKWGWuOZ9fFLi4sBK84bL1eug+goBwrXUKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iek6DkXVV1eIr5wvCeVjtQoXGUpY9Eqyd2u7FjrTaz0=;
        b=j0bik8xDipxOvIeAH91yrJu9qarZf79GO5aJ9oLBD9ibino/0pF+uTIbn7UqlEaK3T
         EvNfv/2LB0sugTcxvYw6juqUqF/1t/am0UNuX9RU5l5Lp868aVj9ueZ06F94tZbLWMET
         Emz46FcK2rW5riUV7j1ty5xPUaeLl85mexqmV1KaG+sWsC1ymzybUEBnv7iu3ExsF8X8
         NSK4vd/0Rn7fPI7V2f5pyGg1Q2Wbah7sNVYGqeY0QD3nnalBPtAH8sn3+GKTg0N3TjgM
         /b0fvz3rTzWSxcPCWMKWn437rczjzkEBja0ENGwgniMlHDbVQWHuMnarQrPAUFtFapul
         Q/xw==
X-Gm-Message-State: AOUpUlF/4lwVy9uzgeQOtRe72+SObuObOzRR6HZzgA5S+x66h/Q+A6RE
        dN9vZHC3C0G3SxxhhE/lt4gyR8oJSfk=
X-Google-Smtp-Source: AA+uWPyRJSXCbKKUReB65+514c7L5aSsdL9pWmgknefu+3oZhCushMX3UoOJFdtZGUnNXMCfMTypew==
X-Received: by 2002:a2e:21d5:: with SMTP id h82-v6mr3133181lji.46.1533765374725;
        Wed, 08 Aug 2018 14:56:14 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id d23-v6sm846572ljg.17.2018.08.08.14.56.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:56:12 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id n96-v6so2674893lfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:56:12 -0700 (PDT)
X-Received: by 2002:a19:cb44:: with SMTP id b65-v6mr3122894lfg.12.1533765372028;
 Wed, 08 Aug 2018 14:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180731100914.19856-1-cang@codeaurora.org> <20180731100914.19856-4-cang@codeaurora.org>
In-Reply-To: <20180731100914.19856-4-cang@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 8 Aug 2018 14:55:35 -0700
X-Gmail-Original-Message-ID: <CAE=gft6cdE+oMYf779VGrQHfYQ5Xb1v+Qr6cAznTtAovehCOxw@mail.gmail.com>
Message-ID: <CAE=gft6cdE+oMYf779VGrQHfYQ5Xb1v+Qr6cAznTtAovehCOxw@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] phy: Add QMP phy based UFS phy support for sdm845
To:     cang@codeaurora.org
Cc:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, Manu Gautam <mgautam@codeaurora.org>,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 3:09 AM Can Guo <cang@codeaurora.org> wrote:
>
> Add UFS PHY support to make SDM845 UFS work with common PHY framework.
>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 172 +++++++++++++++++++++++++++++++++++-
>  drivers/phy/qualcomm/phy-qcom-qmp.h |  15 ++++
>  2 files changed, 186 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 9be9754..de7ff18 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
...
>  static void qcom_qmp_phy_configure(void __iomem *base,
>                                    const unsigned int *regs,
>                                    const struct qmp_phy_init_tbl tbl[],
> @@ -1131,6 +1249,14 @@ static int qcom_qmp_phy_init(struct phy *phy)
>         qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
>
>         /*
> +        * UFS PHY requires the deassert of software reset before serdes start.
> +        * For UFS PHYs that do not have software reset control bits, defer
> +        * starting serdes until the power on callback.
> +        */

I'm relatively thick when it comes to PHYs, but I'm a little confused.
The sequence of code right below this (not shown) looks like it is
deasserting reset before starting serdes, seemingly doing what the
comment wants. I guess the problem is the lack of SW reset? So then
you defer serdes start until UFS does... something. Can you explain
how deferring to after UFS HC init actually helps? Is it the UFS HC
that releases reset on the PHY?

I was hoping the next patch would help, but I'm still confused. It
looks like you've added a call to phy_power_on in
ufs_qcom_setup_clocks, but there's also one still in
ufs_qcom_power_up_sequence. What does the original phy_power_on in
ufs_qcom_power_up_sequence do now? It seems like that one would do the
power on too early, and then your new added call in
ufs_qcom_setup_clocks would do nothing.


> +       if ((cfg->type == PHY_TYPE_UFS) && cfg->no_pcs_sw_reset)
> +               goto out;
> +
> +       /*
>          * Pull out PHY from POWER DOWN state.
>          * This is active low enable signal to power-down PHY.
>          */
> @@ -1159,6 +1285,7 @@ static int qcom_qmp_phy_init(struct phy *phy)
>         }
>         qmp->phy_initialized = true;
>
> +out:
>         return ret;
>
>  err_pcs_ready:
> @@ -1181,7 +1308,8 @@ static int qcom_qmp_phy_exit(struct phy *phy)
>         clk_disable_unprepare(qphy->pipe_clk);
>
>         /* PHY reset */
> -       qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
> +       if (!cfg->no_pcs_sw_reset)
> +               qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>
>         /* stop SerDes and Phy-Coding-Sublayer */
>         qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
> @@ -1199,6 +1327,44 @@ static int qcom_qmp_phy_exit(struct phy *phy)
>         return 0;
>  }
>
> +static int qcom_qmp_phy_poweron(struct phy *phy)
> +{
> +       struct qmp_phy *qphy = phy_get_drvdata(phy);
> +       struct qcom_qmp *qmp = qphy->qmp;
> +       const struct qmp_phy_cfg *cfg = qmp->cfg;
> +       void __iomem *pcs = qphy->pcs;
> +       void __iomem *status;
> +       unsigned int mask, val;
> +       int ret = 0;
> +
> +       if (cfg->type != PHY_TYPE_UFS)
> +               return 0;
> +
> +       /*
> +        * For UFS PHY that has not software reset control, serdes start
> +        * should only happen when UFS driver explicitly calls phy_power_on
> +        * after it deasserts software reset.
> +        */
> +       if (cfg->no_pcs_sw_reset && !qmp->phy_initialized &&
> +           (qmp->init_count != 0)) {
> +               /* start SerDes and Phy-Coding-Sublayer */
> +               qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
> +
> +               status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
> +               mask = cfg->mask_pcs_ready;
> +
> +               ret = readl_poll_timeout(status, val, !(val & mask), 1,
> +                                        PHY_INIT_COMPLETE_TIMEOUT);
> +               if (ret) {
> +                       dev_err(qmp->dev, "phy initialization timed-out\n");
> +                       return ret;
> +               }
> +               qmp->phy_initialized = true;
> +       }
> +
> +       return ret;
> +}
> +
>  static int qcom_qmp_phy_set_mode(struct phy *phy, enum phy_mode mode)
>  {
>         struct qmp_phy *qphy = phy_get_drvdata(phy);
> @@ -1428,6 +1594,7 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
>  static const struct phy_ops qcom_qmp_phy_gen_ops = {
>         .init           = qcom_qmp_phy_init,
>         .exit           = qcom_qmp_phy_exit,
> +       .power_on       = qcom_qmp_phy_poweron,

The power_on function without corresponding power_off still makes me
nervous. But with phy_initialized and init_count members, I guess this
works.

>         .set_mode       = qcom_qmp_phy_set_mode,
>         .owner          = THIS_MODULE,
>  };
> @@ -1533,6 +1700,9 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
>         }, {
>                 .compatible = "qcom,sdm845-qmp-usb3-uni-phy",
>                 .data = &qmp_v3_usb3_uniphy_cfg,
> +       }, {
> +               .compatible = "qcom,sdm845-qmp-ufs-phy",
> +               .data = &sdm845_ufsphy_cfg,
>         },
>         { },
>  };
