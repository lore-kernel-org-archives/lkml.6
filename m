Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F77C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAAB206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAOH3jzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAAB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbeLDTYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:24:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbeLDTYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:24:17 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B93206B7;
        Tue,  4 Dec 2018 19:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543951455;
        bh=5GODkIgf96KMCm6VJGzqZOn84X+97gZoRudYSmei+Q4=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=UAOH3jzmhHt7ow5pygSESO5Y0BpXxm2vdJDtjkK8Kzbyu2kgf9OYe1olnEXGGS+Vw
         Ze8eB7tpzRxqU5/3K/4U5YOYdOb2HOwUgILCB0jNUSyfCgB5zamg/vCeGikJ0boNT+
         sGOEf782euxfACXKBOI1GAzpJqYg+z0me0eGiX7k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     David Dai <daidavid1@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1543895413-1553-2-git-send-email-daidavid1@codeaurora.org>
Cc:     David Dai <daidavid1@codeaurora.org>, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        tdas@codeaurora.org, elder@linaro.org
References: <1543895413-1553-1-git-send-email-daidavid1@codeaurora.org>
 <1543895413-1553-2-git-send-email-daidavid1@codeaurora.org>
Message-ID: <154395145491.88331.1174781210192403998@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC PATCH] clk: qcom: clk-rpmh: Add IPA clock support
Date:   Tue, 04 Dec 2018 11:24:14 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Dai (2018-12-03 19:50:13)
> Add IPA clock support by extending the current clk rpmh driver to support
> clocks that are managed by a different type of RPMh resource known as
> Bus Clock Manager(BCM).

Yes, but why? Does the IPA driver need to set clk rates and that somehow
doesn't work as a bandwidth request?

> =

> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> ---
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index 9f4fc77..42e2cd2 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -18,6 +18,32 @@
>  #define CLK_RPMH_ARC_EN_OFFSET         0
>  #define CLK_RPMH_VRM_EN_OFFSET         4
>  =

> +#define BCM_TCS_CMD_COMMIT_MASK                0x40000000
> +#define BCM_TCS_CMD_VALID_SHIFT                29
> +#define BCM_TCS_CMD_VOTE_MASK          0x3fff
> +#define BCM_TCS_CMD_VOTE_SHIFT         0
> +
> +#define BCM_TCS_CMD(valid, vote) \
> +       (BCM_TCS_CMD_COMMIT_MASK |\

Nitpick: Add space before the \ and align them all up on the right side
of the page.

> +       ((valid) << BCM_TCS_CMD_VALID_SHIFT) |\
> +       ((cpu_to_le32(vote) &\
> +       BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_SHIFT))
> +
> +/**
> + * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager(B=
CM)
> + * @unit: divisor used to convert Hz value to an RPMh msg
> + * @width: multiplier used to convert Hz value to an RPMh msg
> + * @vcd: virtual clock domain that this bcm belongs to
> + * @reserved: reserved to pad the struct
> + */
> +

Nitpick: Please remove the newline between comment and struct.

> +struct bcm_db {
> +       u32 unit;
> +       u16 width;
> +       u8 vcd;
> +       u8 reserved;

These would need __le32 and __le16 for the byte swap.

> +};
> +
>  /**
>   * struct clk_rpmh - individual rpmh clock data structure
>   * @hw:                        handle between common and hardware-specif=
ic interfaces
> @@ -210,6 +249,91 @@ static unsigned long clk_rpmh_recalc_rate(struct clk=
_hw *hw,
>         .recalc_rate    =3D clk_rpmh_recalc_rate,
>  };
>  =

> +static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
> +{
> +       struct tcs_cmd cmd =3D { 0 };
> +       u32 cmd_state;
> +       int ret;
> +
> +       cmd_state =3D enable ? (c->aggr_state ? c->aggr_state : 1) : 0;
> +
> +       if (c->last_sent_aggr_state =3D=3D cmd_state)
> +               return 0;
> +
> +       cmd.addr =3D c->res_addr;
> +       cmd.data =3D BCM_TCS_CMD(enable, cmd_state);
> +
> +       ret =3D rpmh_write_async(c->dev, RPMH_ACTIVE_ONLY_STATE, &cmd, 1);
> +       if (ret) {
> +               dev_err(c->dev, "set active state of %s failed: (%d)\n",
> +                       c->res_name, ret);
> +               return ret;
> +       }
> +
> +       c->last_sent_aggr_state =3D cmd_state;
> +
> +       return 0;
> +}
> +
> +static int clk_rpmh_bcm_prepare(struct clk_hw *hw)
> +{
> +       struct clk_rpmh *c =3D to_clk_rpmh(hw);
> +       int ret =3D 0;

Don't initialize variables and then reassign them right after.

> +
> +       mutex_lock(&rpmh_clk_lock);
> +       ret =3D clk_rpmh_bcm_send_cmd(c, true);
> +       mutex_unlock(&rpmh_clk_lock);
> +
> +       return ret;
> +};
> +
> +static void clk_rpmh_bcm_unprepare(struct clk_hw *hw)
> +{
> +       struct clk_rpmh *c =3D to_clk_rpmh(hw);
> +
> +       mutex_lock(&rpmh_clk_lock);
> +       clk_rpmh_bcm_send_cmd(c, false);
> +       mutex_unlock(&rpmh_clk_lock);
> +};
> +
> +static int clk_rpmh_bcm_set_rate(struct clk_hw *hw, unsigned long rate,
> +                                unsigned long parent_rate)
> +{
> +       struct clk_rpmh *c =3D to_clk_rpmh(hw);
> +
> +       c->aggr_state =3D rate / (c->aux_data.unit * 1000);
> +
> +       if (clk_hw_is_prepared(hw)) {

Why do we need to check is_prepared? Add a comment indicating we can't
send the request when the clk is disabled?

> +               mutex_lock(&rpmh_clk_lock);
> +               clk_rpmh_bcm_send_cmd(c, true);

This function is always inside mutex_lock()/unlock() pair, so push the
lock into the function?

> +               mutex_unlock(&rpmh_clk_lock);
> +       }
> +
> +       return 0;
> +};
> +
> +static long clk_rpmh_round_rate(struct clk_hw *hw, unsigned long rate,
> +                               unsigned long *parent_rate)
> +{
> +       return rate;
> +}
> +
> +static unsigned long clk_rpmh_bcm_recalc_rate(struct clk_hw *hw,
> +                                       unsigned long prate)
> +{
> +       struct clk_rpmh *c =3D to_clk_rpmh(hw);
> +
> +       return c->aggr_state * c->aux_data.unit * 1000;

What is 1000 for?

> +}
> +
> +static const struct clk_ops clk_rpmh_bcm_ops =3D {
> +       .prepare        =3D clk_rpmh_bcm_prepare,
> +       .unprepare      =3D clk_rpmh_bcm_unprepare,
> +       .set_rate       =3D clk_rpmh_bcm_set_rate,
> +       .round_rate     =3D clk_rpmh_round_rate,
> +       .recalc_rate    =3D clk_rpmh_bcm_recalc_rate,
> +};
> +
>  /* Resource name must match resource id present in cmd-db. */
>  DEFINE_CLK_RPMH_ARC(sdm845, bi_tcxo, bi_tcxo_ao, "xo.lvl", 0x3, 2);
>  DEFINE_CLK_RPMH_VRM(sdm845, ln_bb_clk2, ln_bb_clk2_ao, "lnbclka2", 2);
> @@ -275,6 +402,21 @@ static int clk_rpmh_probe(struct platform_device *pd=
ev)
>                                 rpmh_clk->res_name);
>                         return -ENODEV;
>                 }

Nitpick: Please add newline here.

> +               aux_data_len =3D cmd_db_read_aux_data_len(rpmh_clk->res_n=
ame);
> +               if (aux_data_len =3D=3D sizeof(struct bcm_db)) {
> +                       ret =3D cmd_db_read_aux_data(rpmh_clk->res_name,
> +                                                  (u8 *)&rpmh_clk->aux_d=
ata,

Is the cast necessary? And I would just pick out the data you need from
the aux_data instead of storing it forever (with the padding) in the
rpmh_clk structure.

> +                                                  sizeof(struct bcm_db));
> +                       if (ret < 0) {
> +                               dev_err(&pdev->dev, "aux data read failur=
e for %s (%d)\n",
> +                               rpmh_clk->res_name, ret);
> +                               return ret;
> +                       }
> +                       rpmh_clk->aux_data.unit =3D
> +                                       le32_to_cpu(rpmh_clk->aux_data.un=
it);
> +                       rpmh_clk->aux_data.width =3D
> +                                       le16_to_cpu(rpmh_clk->aux_data.wi=
dth);
> +               }

Nitpick: Newline here too.

>                 rpmh_clk->res_addr +=3D res_addr;
>                 rpmh_clk->dev =3D &pdev->dev;
> =20
