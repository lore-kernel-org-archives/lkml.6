Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A59C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A59425A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dwvNWmjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A59425A2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966595AbeF0USO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:18:14 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44519 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966066AbeF0USM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:18:12 -0400
Received: by mail-ot0-f194.google.com with SMTP id w13-v6so3589851ote.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 13:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5FmMHTuRpNfh7/4e5lg7wRkDZXPFGm/TnnkhDSYG7I=;
        b=dwvNWmjhtlEGwIva3W7ngipx/83e7rZc/ozuizQwFqkaYPn5r5Usw74aoV6GDQMQdM
         tQXrUdUZetRoThDSyWAAnAhbaxvabg2wqyaLxgf7oh1eV/kAqM78EHzcDTd8wxA/c/Za
         spXGN/uGrlE6KlHEVjxbM5JE6GQHwicUth//Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5FmMHTuRpNfh7/4e5lg7wRkDZXPFGm/TnnkhDSYG7I=;
        b=MEL8mA8++PKJjopPFcPZWr+sdAYSjyq5+uACIDXKTZlsGVIW2JQ6jIAqaBL9JQ2kYj
         9m1zjEu15crgGoZN4pzYxabqndG00TQCkIiavcToFZ6SdEXXoq6obNJW85HR7y9FEq5D
         Zj9ExFObHbjuoJ8EyVwXITroCTWe+6NYZRylFJLUDXCMGAZYwe5hmhPC57G/OjL17UP9
         2yDX1Yv02tGh020rueVaf+sjoVjVs7WuFr+gVf4DKDaRF0WWq3YvAIn2Ly0YCcuR0tFB
         7usAONRZvipmygBrNyEb9stOE95evx4U9s47h69NFgRCTnUZva/fzv90fgcn1vu1+bRK
         yjgA==
X-Gm-Message-State: APt69E0g7yNUWp2F/wBRYIBwPmP8vKyKec31dzhyhunQPcB3QAS2dq/Q
        qawPy0kkyUbePU+uBiMZGp7zmTuMfrs=
X-Google-Smtp-Source: AAOMgpcAixl8FsC6rhMWYQYggX+Ja/liIVpsAazoy8kR5Z+TGwcK1UXok2/Gu+X2cIi6UKJUpv/XfA==
X-Received: by 2002:a9d:d7:: with SMTP id 23-v6mr1193004otk.372.1530130691160;
        Wed, 27 Jun 2018 13:18:11 -0700 (PDT)
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id b56-v6sm4526407ote.32.2018.06.27.13.18.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 13:18:09 -0700 (PDT)
Received: by mail-oi0-f48.google.com with SMTP id n84-v6so3047548oib.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 13:18:09 -0700 (PDT)
X-Received: by 2002:aca:61c5:: with SMTP id v188-v6mr4500584oib.28.1530130688906;
 Wed, 27 Jun 2018 13:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180619083647.10116-1-cang@codeaurora.org> <20180619083647.10116-4-cang@codeaurora.org>
In-Reply-To: <20180619083647.10116-4-cang@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 27 Jun 2018 13:17:32 -0700
X-Gmail-Original-Message-ID: <CAE=gft4153GviYtYuoREgyPkwxwnejHG+t+H8MB+Jv1TXTouSA@mail.gmail.com>
Message-ID: <CAE=gft4153GviYtYuoREgyPkwxwnejHG+t+H8MB+Jv1TXTouSA@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] phy: Add QMP phy based UFS phy support for sdm845
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

On Tue, Jun 19, 2018 at 1:38 AM Can Guo <cang@codeaurora.org> wrote:
>
> Add UFS PHY support to make SDM845 UFS work with common PHY framework.
>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 173 +++++++++++++++++++++++++++++++++++-
>  drivers/phy/qualcomm/phy-qcom-qmp.h |  15 ++++
>  2 files changed, 187 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 9be9754..852792d 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
...
>  static void qcom_qmp_phy_configure(void __iomem *base,
>                                    const unsigned int *regs,
>                                    const struct qmp_phy_init_tbl tbl[],
> @@ -1131,6 +1249,15 @@ static int qcom_qmp_phy_init(struct phy *phy)
>         qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
>
>         /*
> +        * UFS PHY requires the deassert of software reset before serdes start.
> +        * For UFS PHY that has not software reset control bits in its address

This line of the comment is unclear. Maybe:
"For UFS PHYs that do not have software reset control bits, defer
starting serdes until the power on callback"

> +        * space, it should skip starting serdes here. UFS PHY Serdes shall
> +        * start when UFS explicitly calls PHY power on.
> +        */
> +       if ((cfg->type == PHY_TYPE_UFS) && cfg->no_pcs_sw_reset)
> +               goto out;
> +
> +       /*
>          * Pull out PHY from POWER DOWN state.
>          * This is active low enable signal to power-down PHY.
>          */
> @@ -1159,6 +1286,7 @@ static int qcom_qmp_phy_init(struct phy *phy)
>         }
>         qmp->phy_initialized = true;
>
> +out:
>         return ret;
>
>  err_pcs_ready:
> @@ -1181,7 +1309,8 @@ static int qcom_qmp_phy_exit(struct phy *phy)
>         clk_disable_unprepare(qphy->pipe_clk);
>
>         /* PHY reset */
> -       qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
> +       if (!cfg->no_pcs_sw_reset)
> +               qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>
>         /* stop SerDes and Phy-Coding-Sublayer */
>         qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
> @@ -1199,6 +1328,44 @@ static int qcom_qmp_phy_exit(struct phy *phy)
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
> @@ -1428,6 +1595,7 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
>  static const struct phy_ops qcom_qmp_phy_gen_ops = {
>         .init           = qcom_qmp_phy_init,
>         .exit           = qcom_qmp_phy_exit,
> +       .power_on       = qcom_qmp_phy_poweron,

The USB pipe clk discussion earlier this year got me on the lookout
for asymmetric phy init functions. If we're flipping on START_CTRL in
phy_poweron, shouldn't we be flipping it back off in phy_poweroff?
From the comments, it seems like this was done so that some sort of
UFS reset step could happen. Would that sequencing still happen
correctly if the PHY did:

phy_init
phy_power_on
(phy_power_off)
phy_power_on

I'm unsure. Does suspend/resume work?

-Evan
