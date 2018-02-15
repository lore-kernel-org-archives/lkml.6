Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425512AbeBOQGo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:06:44 -0500
Received: from gloria.sntech.de ([95.129.55.99]:33780 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424571AbeBOQGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:06:21 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Brian Norris <briannorris@chromium.org>, dianders@chromium.org,
        Chris Zhong <zyw@rock-chips.com>, William wu <wulf@rock-chips.com>,
        hl@rock-chips.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 1/6] phy: rockchip-typec: deprecate some DT properties for various register fields.
Date: Thu, 15 Feb 2018 17:06:03 +0100
Message-ID: <2052597.3vIQ3VQ44p@phil>
In-Reply-To: <20180214165447.12181-1-enric.balletbo@collabora.com>
References: <20180214165447.12181-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Am Mittwoch, 14. Februar 2018, 17:54:42 CET schrieb Enric Balletbo i Serra:
> Adding properties for various register fields in the DT doesn't scale and
> this information should be in the driver instead.
> 
> Before this patch these registers (description below) were specified in
> the DT, every register node contained 3 sections: offset, enable bit,
> write mask bit.
> 
>  - rockchip,typec-conn-dir : the register of type-c connector direction,
>    for type-c phy0, it must be <0xe580 0 16>;
>    for type-c phy1, it must be <0xe58c 0 16>;
>  - rockchip,usb3tousb2-en : the register of type-c force usb3 to usb2 enable
>    control.
>    for type-c phy0, it must be <0xe580 3 19>;
>    for type-c phy1, it must be <0xe58c 3 19>;
>  - rockchip,external-psm : the register of type-c phy external psm clock
>    selection.
>    for type-c phy0, it must be <0xe588 14 30>;
>    for type-c phy1, it must be <0xe594 14 30>;
>  - rockchip,pipe-status : the register of type-c phy pipe status.
>    for type-c phy0, it must be <0xe5c0 0 0>;
>    for type-c phy1, it must be <0xe5c0 16 16>;
> 
> After this patch these register definitions are in the driver. So can be
> removed from the DT. Note that there are 2 type-c phys for RK3399 with
> different offsets, the driver checks the phy base address of the running
> instance and applies the right offsets.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Generally I really support moving that stuff back into the driver and
judging by the recent mail conversations with Rob and Brian, this also
seems to be a consensus of sorts.

The one but I see here is, that the newly added things represent
rk3399-specific values and should be prefixed accordingly and also
already be flexible enough for the next soc using it.

Examples below.


> @@ -349,6 +349,9 @@
>  #define MODE_DFP_USB			BIT(1)
>  #define MODE_DFP_DP			BIT(2)
>  
> +#define TYPEC_PHY0_BASE_ADDRESS		0xff7c0000
> +#define TYPEC_PHY1_BASE_ADDRESS		0xff800000

RK3399_TYPEC_PHY0_ADDRESS etc ?

> @@ -362,6 +365,20 @@ struct rockchip_usb3phy_port_cfg {
>  	struct usb3phy_reg pipe_status;
>  };
>  
> +static const struct rockchip_usb3phy_port_cfg tcphy0_port_cfg = {
> +	.typec_conn_dir	= { 0xe580, 0, 16 },
> +	.usb3tousb2_en	= { 0xe580, 3, 19 },
> +	.external_psm	= { 0xe588, 14, 30 },
> +	.pipe_status	= { 0xe5c0, 0, 0 },
> +};
> +
> +static const struct rockchip_usb3phy_port_cfg tcphy1_port_cfg = {
> +	.typec_conn_dir	= { 0xe58c, 0, 16 },
> +	.usb3tousb2_en	= { 0xe58c, 3, 19 },
> +	.external_psm	= { 0xe594, 14, 30 },
> +	.pipe_status	= { 0xe5c0, 16, 16 },
> +};

rk3399_tcphy1_port_cfg. Especially important as these are GRF-registers
(general register files = a dumping ground for random settings bits)
and nothing ever stays the same in the GRF between chips.


> @@ -1103,6 +1078,13 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
>  	if (IS_ERR(tcphy->base))
>  		return PTR_ERR(tcphy->base);
>  
> +	if (res->start == TYPEC_PHY0_BASE_ADDRESS)
> +		tcphy->port_cfgs = &tcphy0_port_cfg;
> +	else if (res->start == TYPEC_PHY1_BASE_ADDRESS)
> +		tcphy->port_cfgs = &tcphy1_port_cfg;
> +	else
> +		return -EINVAL;

should be selected according to the compatible.
Like just create a struct similar to things like the inno-usb2-phy.
That way you can also just write down the address itself in a reg
property and do not need specific constants like the ones at the top.


Heiko
