Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441E6C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97672085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrbbIpgn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfAUK5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:57:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51622 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfAUK5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:57:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so10326166wmj.1;
        Mon, 21 Jan 2019 02:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZSDxvu7OGZxb2NFhRhMaH/XAts7pX7D1Fxj/104KWmE=;
        b=OrbbIpgnLG6JJ33cY3lsu0K+hjtthTbAZJLFAMiwNELRdZzrXnhSBFboaq3RJjAHnQ
         QKQ4zj54hdmzQ4yaZlMZ29b6FFTDDRYzaBEbr8vT/FUzjmzcPx5vQb43JjbVorv17SCd
         /CelKnearVjLDtA9jpkRupwOil5BG8Ol+U1WLMUMWoJI3baK/eQsaIfkZbM75XHNeaP7
         uEj0iO87uwpGoIpz8ZU0I/5R9Mj+Lx4Mw+5+LaTf2RtM0vbDR8bhpaYFlJvnysKiLbNc
         SU5uRFmUO3k58Hde7myygKZaEos0DA9U046zUUJEKjWqOn7FUuhgUlG/2pOpF7fwoWnj
         JjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZSDxvu7OGZxb2NFhRhMaH/XAts7pX7D1Fxj/104KWmE=;
        b=gZw5IN99yB6vNfNAEixfaSmdVYVvuZQyBvI8CorhqFLipsiJ8smk8851CBK/UHTZB2
         kqqjJ0jrXns231W8GTWo/K70jc/KXe8O0D/ALfevYm7/5mJccN/cztmybWlzGU8na0mX
         glYR6AVqk9xf8hGxWx+JHpQFKwDg4r1M5sM0CLEr65h0LNuc/Ku5YFuwc9pQbIdztSYO
         wNP+1CD160M0nx9zkyFiofWcJbsLNbm9bS2vi0b8cTo6IgFLNiFXRihBPC2NYwdzCfuj
         quZ5fsf5DrYvsirgodeyHt1q7fpNDQdtQRAoIB+2Wug93wdS5Q4msYE80EvUumgIeUHB
         GvLw==
X-Gm-Message-State: AJcUukenI9r/BL8PuvrbVs6ms6Ggp1VhwrHFmr7eq3LXZ/7dcrNoWfdT
        l0efXJsI88ru4MgmAG1oSsA=
X-Google-Smtp-Source: ALg8bN40CvgoZrHmMLTi0ZS72ANEPfsKEK+2xo30UzRPrzItwp8PoB8grogJ0Q5Njhe/SP+TDDj5IQ==
X-Received: by 2002:a1c:410b:: with SMTP id o11mr24661594wma.109.1548068250262;
        Mon, 21 Jan 2019 02:57:30 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id u204sm79119728wmu.30.2019.01.21.02.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 02:57:29 -0800 (PST)
Date:   Mon, 21 Jan 2019 11:57:28 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, mkarthik@nvidia.com, smohammed@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V2] i2c: tegra: Add I2C interface timing support
Message-ID: <20190121105728.GG16756@ulmo>
References: <1547755847-27537-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Content-Disposition: inline
In-Reply-To: <1547755847-27537-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 12:10:47PM -0800, Sowjanya Komatineni wrote:
> This patch adds I2C interface timing registers support for
> proper bus rate configuration along with meeting the i2c spec

s/i2c/I2C/, s/spec/specification/

> setup and hold times based on the tuning performed on Tegra210,
> Tegra186 and Tegra194 platforms.
>=20
> I2C_INTERFACE_TIMING_0 register contains TLOW and THIGH field
> and Tegra I2C controller design uses them as a part of internal
> clock divisor.
>=20
> I2C_INTERFACE_TIMING_1 register contains the setup and hold times
> for start and stop conditions.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V2]: Updated patch to also configure timings to platform tuned
>        settings
>  [V1]: Uses fixed I2C interface timings which could violate bus
>        timing spec
>  =20
>  drivers/i2c/busses/i2c-tegra.c | 227 +++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 201 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegr=
a.c
> index e417ebf7628c..4cbf453fbd3b 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -118,6 +118,20 @@
>  #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
>  #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
> =20
> +#define I2C_INTERFACE_TIMING_0                  0x94
> +#define I2C_TLOW_MASK                           0x3F
> +#define I2C_THIGH_SHIFT                         8
> +#define I2C_THIGH_MASK                          (0x3F << I2C_THIGH_SHIFT)

These look inconsistently indented. Use tabs to indent.

> +#define I2C_TLOW_NEW_MASK			0xFF
> +#define I2C_THIGH_NEW_MASK			(0xFF << I2C_THIGH_SHIFT)
> +
> +#define I2C_INTERFACE_TIMING_1                  0x98

Same here.

> +
> +#define I2C_STANDARD_MODE			100000
> +#define I2C_FAST_MODE				400000
> +#define I2C_FAST_PLUS_MODE			1000000
> +#define I2C_HS_MODE				3500000
> +
>  /*
>   * msg_end_type: The bus control which need to be send at end of transfe=
r.
>   * @MSG_END_STOP: Send stop pulse at end of transfer.
> @@ -142,7 +156,10 @@ enum msg_end_type {
>   * @has_config_load_reg: Has the config load register to load the new
>   *		configuration.
>   * @clk_divisor_hs_mode: Clock divisor in HS mode.
> - * @clk_divisor_std_fast_mode: Clock divisor in standard/fast mode. It is
> + * @clk_divisor_std_mode: Clock divisor in standard mode. It is
> + *		applicable if there is no fast clock source i.e. single clock
> + *		source.
> + * @clk_divisor_fast_mode: Clock divisor in fast mode. It is
>   *		applicable if there is no fast clock source i.e. single clock
>   *		source.
>   * @clk_divisor_fast_plus_mode: Clock divisor in fast mode plus. It is
> @@ -155,6 +172,19 @@ enum msg_end_type {
>   * @has_mst_fifo: The I2C controller contains the new MST FIFO interface=
 that
>   *		provides additional features and allows for longer messages to
>   *		be transferred in one go.
> + * @interface_timing_enhancement: Interface Timing bit fields increased =
in
> + *		Tegra194 compared to Prior Tegra chips for more tuning to meet
> + *		I2C Timing requirements for various data rates.
> + * @tlow_std_mode: Low period of the clock in standard mode.
> + * @thigh_std_mode: High period of the clock in standard mode.
> + * @tlow_fast_fastplus_mode: Low period of the clock in fast/fast-plus m=
odes.
> + * @thigh_fast_fastplus_mode: High period of the clock in fast/fast-plus=
 modes.
> + * @setup_hold_time_std_mode: Setup and hold time for start and stop con=
ditions
> +		in standard mode.

It looks like you're breaking the block style here. Every line should
start with a *.

> + * @setup_hold_time_fast_fast_plus_mode: Setup and hold time for start a=
nd stop
> +		conditions in fast/fast-plus modes.
> + * @setup_hold_time_hs_mode: Setup and hold time for start and stop cond=
itions
> +		in HS mode.
>   */
>  struct tegra_i2c_hw_feature {
>  	bool has_continue_xfer_support;
> @@ -162,11 +192,20 @@ struct tegra_i2c_hw_feature {
>  	bool has_single_clk_source;
>  	bool has_config_load_reg;
>  	int clk_divisor_hs_mode;
> -	int clk_divisor_std_fast_mode;
> +	int clk_divisor_std_mode;
> +	int clk_divisor_fast_mode;
>  	u16 clk_divisor_fast_plus_mode;
>  	bool has_multi_master_mode;
>  	bool has_slcg_override_reg;
>  	bool has_mst_fifo;
> +	bool interface_timing_enhancement;
> +	u8 tlow_std_mode;
> +	u8 thigh_std_mode;
> +	u8 tlow_fast_fastplus_mode;
> +	u8 thigh_fast_fastplus_mode;
> +	u32 setup_hold_time_std_mode;
> +	u32 setup_hold_time_fast_fast_plus_mode;
> +	u32 setup_hold_time_hs_mode;
>  };
> =20
>  /**
> @@ -515,7 +554,62 @@ static int tegra_i2c_wait_for_config_load(struct teg=
ra_i2c_dev *i2c_dev)
>  	return 0;
>  }
> =20
> -static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
> +static void tegra_i2c_set_timing(struct tegra_i2c_dev *i2c_dev)
> +{
> +	u32 val;
> +	u32 tsu_thd =3D 0;
> +	u8 tlow =3D 0;
> +	u8 thigh =3D 0;
> +
> +	if ((i2c_dev->bus_clk_rate > I2C_STANDARD_MODE) &&
> +			(i2c_dev->bus_clk_rate <=3D I2C_FAST_PLUS_MODE)) {
> +		tlow =3D i2c_dev->hw->tlow_fast_fastplus_mode;
> +		thigh =3D i2c_dev->hw->thigh_fast_fastplus_mode;
> +		tsu_thd =3D i2c_dev->hw->setup_hold_time_fast_fast_plus_mode;
> +	} else {
> +		tlow =3D i2c_dev->hw->tlow_std_mode;
> +		thigh =3D i2c_dev->hw->thigh_std_mode;
> +		tsu_thd =3D i2c_dev->hw->setup_hold_time_std_mode;
> +	}
> +
> +	val =3D (thigh << I2C_THIGH_SHIFT) | tlow;
> +	if (val)
> +		i2c_writel(i2c_dev, val, I2C_INTERFACE_TIMING_0);
> +
> +	if (tsu_thd)
> +		i2c_writel(i2c_dev, tsu_thd, I2C_INTERFACE_TIMING_1);
> +}
> +
> +static int tegra_i2c_set_clk_rate(struct tegra_i2c_dev *i2c_dev)
> +{
> +	u32 clk_multiplier =3D I2C_CLK_MULTIPLIER_STD_FAST_MODE;
> +	u32 val;
> +	u8 low_clk_period, high_clk_period;
> +	int ret =3D 0;
> +
> +	val =3D i2c_readl(i2c_dev, I2C_INTERFACE_TIMING_0);
> +
> +	if (i2c_dev->hw->interface_timing_enhancement) {
> +		low_clk_period =3D val & I2C_TLOW_NEW_MASK;
> +		high_clk_period =3D (val & I2C_THIGH_NEW_MASK) >>
> +							I2C_THIGH_SHIFT;
> +	} else {
> +		low_clk_period =3D val & I2C_TLOW_MASK;
> +		high_clk_period =3D (val & I2C_THIGH_MASK) >> I2C_THIGH_SHIFT;
> +	}
> +
> +	clk_multiplier =3D (low_clk_period + high_clk_period + 2);
> +	clk_multiplier *=3D (i2c_dev->clk_divisor_non_hs_mode + 1);
> +
> +	ret =3D clk_set_rate(i2c_dev->div_clk,
> +			   i2c_dev->bus_clk_rate * clk_multiplier);
> +	if (ret)
> +		dev_err(i2c_dev->dev, "Clock rate change failed %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev, bool is_reinit)
>  {
>  	u32 val;
>  	int err;
> @@ -534,6 +628,8 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_d=
ev)
>  	if (i2c_dev->is_dvc)
>  		tegra_dvc_init(i2c_dev);
> =20
> +	tegra_i2c_set_timing(i2c_dev);
> +
>  	val =3D I2C_CNFG_NEW_MASTER_FSM | I2C_CNFG_PACKET_MODE_EN |
>  		(0x2 << I2C_CNFG_DEBOUNCE_CNT_SHIFT);
> =20
> @@ -549,6 +645,12 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_=
dev)
>  					I2C_CLK_DIVISOR_STD_FAST_MODE_SHIFT;
>  	i2c_writel(i2c_dev, clk_divisor, I2C_CLK_DIVISOR);
> =20
> +	if (!is_reinit) {
> +		err =3D tegra_i2c_set_clk_rate(i2c_dev);
> +		if (err < 0)
> +			goto err;
> +	}
> +
>  	if (!i2c_dev->is_dvc) {
>  		u32 sl_cfg =3D i2c_readl(i2c_dev, I2C_SL_CNFG);
> =20
> @@ -747,7 +849,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i=
2c_dev,
>  	if (time_left =3D=3D 0) {
>  		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
> =20
> -		tegra_i2c_init(i2c_dev);
> +		tegra_i2c_init(i2c_dev, true);
>  		return -ETIMEDOUT;
>  	}
> =20
> @@ -758,7 +860,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i=
2c_dev,
>  	if (likely(i2c_dev->msg_err =3D=3D I2C_ERR_NONE))
>  		return 0;
> =20
> -	tegra_i2c_init(i2c_dev);
> +	tegra_i2c_init(i2c_dev, true);
>  	if (i2c_dev->msg_err =3D=3D I2C_ERR_NO_ACK) {
>  		if (msg->flags & I2C_M_IGNORE_NAK)
>  			return 0;
> @@ -842,12 +944,21 @@ static const struct tegra_i2c_hw_feature tegra20_i2=
c_hw =3D {
>  	.has_per_pkt_xfer_complete_irq =3D false,
>  	.has_single_clk_source =3D false,
>  	.clk_divisor_hs_mode =3D 3,
> -	.clk_divisor_std_fast_mode =3D 0,
> +	.clk_divisor_std_mode =3D 0,
> +	.clk_divisor_fast_mode =3D 0,
>  	.clk_divisor_fast_plus_mode =3D 0,
>  	.has_config_load_reg =3D false,
>  	.has_multi_master_mode =3D false,
>  	.has_slcg_override_reg =3D false,
>  	.has_mst_fifo =3D false,
> +	.interface_timing_enhancement =3D false,
> +	.tlow_std_mode =3D 0x4,
> +	.thigh_std_mode =3D 0x2,
> +	.tlow_fast_fastplus_mode =3D 0x4,
> +	.thigh_fast_fastplus_mode =3D 0x2,
> +	.setup_hold_time_std_mode =3D 0x0,
> +	.setup_hold_time_fast_fast_plus_mode =3D 0x0,
> +	.setup_hold_time_hs_mode =3D 0x0,
>  };
> =20
>  static const struct tegra_i2c_hw_feature tegra30_i2c_hw =3D {
> @@ -855,12 +966,21 @@ static const struct tegra_i2c_hw_feature tegra30_i2=
c_hw =3D {
>  	.has_per_pkt_xfer_complete_irq =3D false,
>  	.has_single_clk_source =3D false,
>  	.clk_divisor_hs_mode =3D 3,
> -	.clk_divisor_std_fast_mode =3D 0,
> +	.clk_divisor_std_mode =3D 0,
> +	.clk_divisor_fast_mode =3D 0,
>  	.clk_divisor_fast_plus_mode =3D 0,
>  	.has_config_load_reg =3D false,
>  	.has_multi_master_mode =3D false,
>  	.has_slcg_override_reg =3D false,
>  	.has_mst_fifo =3D false,
> +	.interface_timing_enhancement =3D false,
> +	.tlow_std_mode =3D 0x4,
> +	.thigh_std_mode =3D 0x2,
> +	.tlow_fast_fastplus_mode =3D 0x4,
> +	.thigh_fast_fastplus_mode =3D 0x2,
> +	.setup_hold_time_std_mode =3D 0x0,
> +	.setup_hold_time_fast_fast_plus_mode =3D 0x0,
> +	.setup_hold_time_hs_mode =3D 0x0,
>  };
> =20
>  static const struct tegra_i2c_hw_feature tegra114_i2c_hw =3D {
> @@ -868,12 +988,21 @@ static const struct tegra_i2c_hw_feature tegra114_i=
2c_hw =3D {
>  	.has_per_pkt_xfer_complete_irq =3D true,
>  	.has_single_clk_source =3D true,
>  	.clk_divisor_hs_mode =3D 1,
> -	.clk_divisor_std_fast_mode =3D 0x19,
> +	.clk_divisor_std_mode =3D 0x19,
> +	.clk_divisor_fast_mode =3D 0x19,
>  	.clk_divisor_fast_plus_mode =3D 0x10,
>  	.has_config_load_reg =3D false,
>  	.has_multi_master_mode =3D false,
>  	.has_slcg_override_reg =3D false,
>  	.has_mst_fifo =3D false,
> +	.interface_timing_enhancement =3D false,
> +	.tlow_std_mode =3D 0x4,
> +	.thigh_std_mode =3D 0x2,
> +	.tlow_fast_fastplus_mode =3D 0x4,
> +	.thigh_fast_fastplus_mode =3D 0x2,
> +	.setup_hold_time_std_mode =3D 0x0,
> +	.setup_hold_time_fast_fast_plus_mode =3D 0x0,
> +	.setup_hold_time_hs_mode =3D 0x0,
>  };
> =20
>  static const struct tegra_i2c_hw_feature tegra124_i2c_hw =3D {
> @@ -881,12 +1010,21 @@ static const struct tegra_i2c_hw_feature tegra124_=
i2c_hw =3D {
>  	.has_per_pkt_xfer_complete_irq =3D true,
>  	.has_single_clk_source =3D true,
>  	.clk_divisor_hs_mode =3D 1,
> -	.clk_divisor_std_fast_mode =3D 0x19,
> +	.clk_divisor_std_mode =3D 0x19,
> +	.clk_divisor_fast_mode =3D 0x19,
>  	.clk_divisor_fast_plus_mode =3D 0x10,
>  	.has_config_load_reg =3D true,
>  	.has_multi_master_mode =3D false,
>  	.has_slcg_override_reg =3D true,
>  	.has_mst_fifo =3D false,
> +	.interface_timing_enhancement =3D false,
> +	.tlow_std_mode =3D 0x4,
> +	.thigh_std_mode =3D 0x2,
> +	.tlow_fast_fastplus_mode =3D 0x4,
> +	.thigh_fast_fastplus_mode =3D 0x2,
> +	.setup_hold_time_std_mode =3D 0x0,
> +	.setup_hold_time_fast_fast_plus_mode =3D 0x0,
> +	.setup_hold_time_hs_mode =3D 0x0,
>  };
> =20
>  static const struct tegra_i2c_hw_feature tegra210_i2c_hw =3D {
> @@ -894,30 +1032,71 @@ static const struct tegra_i2c_hw_feature tegra210_=
i2c_hw =3D {
>  	.has_per_pkt_xfer_complete_irq =3D true,
>  	.has_single_clk_source =3D true,
>  	.clk_divisor_hs_mode =3D 1,
> -	.clk_divisor_std_fast_mode =3D 0x19,
> +	.clk_divisor_std_mode =3D 0x19,
> +	.clk_divisor_fast_mode =3D 0x19,
>  	.clk_divisor_fast_plus_mode =3D 0x10,
>  	.has_config_load_reg =3D true,
>  	.has_multi_master_mode =3D true,
>  	.has_slcg_override_reg =3D true,
>  	.has_mst_fifo =3D false,
> +	.interface_timing_enhancement =3D false,
> +	.tlow_std_mode =3D 0x4,
> +	.thigh_std_mode =3D 0x2,
> +	.tlow_fast_fastplus_mode =3D 0x4,
> +	.thigh_fast_fastplus_mode =3D 0x2,
> +	.setup_hold_time_std_mode =3D 0,
> +	.setup_hold_time_fast_fast_plus_mode =3D 0,
> +	.setup_hold_time_hs_mode =3D 0,
>  };
> =20
> -static const struct tegra_i2c_hw_feature tegra194_i2c_hw =3D {
> +static const struct tegra_i2c_hw_feature tegra186_i2c_hw =3D {
>  	.has_continue_xfer_support =3D true,
>  	.has_per_pkt_xfer_complete_irq =3D true,
>  	.has_single_clk_source =3D true,
>  	.clk_divisor_hs_mode =3D 1,
> -	.clk_divisor_std_fast_mode =3D 0x19,
> +	.clk_divisor_std_mode =3D 0x16,
> +	.clk_divisor_fast_mode =3D 0x19,
>  	.clk_divisor_fast_plus_mode =3D 0x10,
>  	.has_config_load_reg =3D true,
>  	.has_multi_master_mode =3D true,
>  	.has_slcg_override_reg =3D true,
> +	.has_mst_fifo =3D false,
> +	.interface_timing_enhancement =3D false,
> +	.tlow_std_mode =3D 0x4,
> +	.thigh_std_mode =3D 0x3,
> +	.tlow_fast_fastplus_mode =3D 0x4,
> +	.thigh_fast_fastplus_mode =3D 0x2,
> +	.setup_hold_time_std_mode =3D 0,
> +	.setup_hold_time_fast_fast_plus_mode =3D 0,
> +	.setup_hold_time_hs_mode =3D 0,
> +};
> +
> +static const struct tegra_i2c_hw_feature tegra194_i2c_hw =3D {
> +	.has_continue_xfer_support =3D true,
> +	.has_per_pkt_xfer_complete_irq =3D true,
> +	.has_single_clk_source =3D true,
> +	.clk_divisor_hs_mode =3D 2,
> +	.clk_divisor_std_mode =3D 0x4f,
> +	.clk_divisor_fast_mode =3D 0x3c,
> +	.clk_divisor_fast_plus_mode =3D 0x16,
> +	.has_config_load_reg =3D true,
> +	.has_multi_master_mode =3D true,
> +	.has_slcg_override_reg =3D true,
>  	.has_mst_fifo =3D true,
> +	.interface_timing_enhancement =3D true,
> +	.tlow_std_mode =3D 0x8,
> +	.thigh_std_mode =3D 0x7,
> +	.tlow_fast_fastplus_mode =3D 0x2,
> +	.thigh_fast_fastplus_mode =3D 0x2,
> +	.setup_hold_time_std_mode =3D 0x08080808,
> +	.setup_hold_time_fast_fast_plus_mode =3D 0x02020202,
> +	.setup_hold_time_hs_mode =3D 0x090909,
>  };
> =20
>  /* Match table for of_platform binding */
>  static const struct of_device_id tegra_i2c_of_match[] =3D {
>  	{ .compatible =3D "nvidia,tegra194-i2c", .data =3D &tegra194_i2c_hw, },
> +	{ .compatible =3D "nvidia,tegra186-i2c", .data =3D &tegra186_i2c_hw, },
>  	{ .compatible =3D "nvidia,tegra210-i2c", .data =3D &tegra210_i2c_hw, },
>  	{ .compatible =3D "nvidia,tegra124-i2c", .data =3D &tegra124_i2c_hw, },
>  	{ .compatible =3D "nvidia,tegra114-i2c", .data =3D &tegra114_i2c_hw, },
> @@ -937,7 +1116,6 @@ static int tegra_i2c_probe(struct platform_device *p=
dev)
>  	void __iomem *base;
>  	int irq;
>  	int ret =3D 0;
> -	int clk_multiplier =3D I2C_CLK_MULTIPLIER_STD_FAST_MODE;
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	base =3D devm_ioremap_resource(&pdev->dev, res);
> @@ -1002,20 +1180,17 @@ static int tegra_i2c_probe(struct platform_device=
 *pdev)
>  		}
>  	}
> =20
> -	i2c_dev->clk_divisor_non_hs_mode =3D
> -			i2c_dev->hw->clk_divisor_std_fast_mode;
> -	if (i2c_dev->hw->clk_divisor_fast_plus_mode &&
> -		(i2c_dev->bus_clk_rate =3D=3D 1000000))
> +	if ((i2c_dev->bus_clk_rate > I2C_FAST_MODE) &&
> +			(i2c_dev->bus_clk_rate <=3D I2C_FAST_PLUS_MODE))

This was wrong before, but might as well fix the alignment of the
conditions while at it.

>  		i2c_dev->clk_divisor_non_hs_mode =3D
>  			i2c_dev->hw->clk_divisor_fast_plus_mode;
> -
> -	clk_multiplier *=3D (i2c_dev->clk_divisor_non_hs_mode + 1);
> -	ret =3D clk_set_rate(i2c_dev->div_clk,
> -			   i2c_dev->bus_clk_rate * clk_multiplier);
> -	if (ret) {
> -		dev_err(i2c_dev->dev, "Clock rate change failed %d\n", ret);
> -		goto unprepare_fast_clk;
> -	}
> +	else if ((i2c_dev->bus_clk_rate > I2C_STANDARD_MODE) &&
> +			(i2c_dev->bus_clk_rate <=3D I2C_FAST_MODE))

Same here.

Thierry

> +		i2c_dev->clk_divisor_non_hs_mode =3D
> +			i2c_dev->hw->clk_divisor_fast_mode;
> +	else
> +		i2c_dev->clk_divisor_non_hs_mode =3D
> +			i2c_dev->hw->clk_divisor_std_mode;
> =20
>  	ret =3D clk_prepare(i2c_dev->div_clk);
>  	if (ret < 0) {
> @@ -1041,7 +1216,7 @@ static int tegra_i2c_probe(struct platform_device *=
pdev)
>  		}
>  	}
> =20
> -	ret =3D tegra_i2c_init(i2c_dev);
> +	ret =3D tegra_i2c_init(i2c_dev, false);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to initialize i2c controller\n");
>  		goto disable_div_clk;
> --=20
> 2.7.4
>=20

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxFpZgACgkQ3SOs138+
s6ERrhAAkYIJaEg1LPbGnbK/VhjMB3XvECwHUZvxpafNdbUfJcg1SuaZzLQYk3IT
a8eGL1z0PbK8Cq34O+oOQtr/scHXrniigT5+B+z/A1RMPVGQk6FSqjHauT8OX6nq
Ek5NjVLaa9K0pjEeCFYCKHpIMJIA51dBm2C3TCGDJ81ma3mG6scgDMzKVRg2iYVy
w7eZ9vDRfkvdPTJZ03cM227R35ZQQR6jTmf8cdYlVsTZ6EtI/uzIy69ibcTjtxds
V6rSYrzDWS4r7zYNQNlFlajnMYIhUJ0pqEF9Vtor4+bsuYXX6UaCecOOaYn1WUF7
c+dFk9EkM5ov9JRR5qMh6sMjiNDc6LAhJpn7+Uhs3xz5oi62/MgWW6PVvhkdS38r
xL1/10DYHjbkWdpL14jFWpaiC9RHX6m+zPeP5vaqj2DrVPw3+jqrBKqu4WT96tVc
YLhLsU5M4GuHJdbIiZwTzX1A3FQHbi1af31AH7yBcB2xDknmLAebbYjiPjeg+bf2
iAUwnD6hkiB2JLNUaI4W7Ujx3sFn87y51zkD3DoDO2LtY0y9dgd/8T5JbLJROsuZ
Xcx+WBiNYvOAgcNEPSrzdT4Is7SkTWTtNX05nRtgxVxjoecSslhmN2CwXfrqfd/G
7pyAB9g/9dc3jP+Pu/DNu+DHBVsGqdTjCTL3++HrM3tB+/U6k0k=
=2tkC
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
