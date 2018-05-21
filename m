Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbeEUIOe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 04:14:34 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54888 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeEUIOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 04:14:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 21 May 2018 10:14:23 +0200
From: Stefan Agner <stefan@agner.ch>
To: Anson Huang <anson.huang@nxp.com>
Cc: shawnguo@kernel.org, kernel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        Adriana Reus <adriana.reus@nxp.com>, rui.silva@linaro.org,
        dl-linux-imx <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH V2 2/3] clk: imx7d: correct enet clock CCGR registers
In-Reply-To: <AM3PR04MB1315417C51882B554AEBC617F5950@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
 <1526605266-18464-2-git-send-email-Anson.Huang@nxp.com>
 <c42c4274cfd06297d1699c96d3253125@agner.ch>
 <AM3PR04MB1315417C51882B554AEBC617F5950@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <bdaca652700a6f70aca14fd450bd4dab@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-0.31 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.21)[71.78%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.05.2018 04:35, Anson Huang wrote:
> Hi, Stefan
> 
> Anson Huang
> Best Regards!
> 
> 
>> -----Original Message-----
>> From: Stefan Agner [mailto:stefan@agner.ch]
>> Sent: Friday, May 18, 2018 9:02 PM
>> To: Anson Huang <anson.huang@nxp.com>
>> Cc: shawnguo@kernel.org; kernel@pengutronix.de; Fabio Estevam
>> <fabio.estevam@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
>> mturquette@baylibre.com; sboyd@kernel.org; Adriana Reus
>> <adriana.reus@nxp.com>; rui.silva@linaro.org; dl-linux-imx
>> <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>> linux-clk@vger.kernel.org
>> Subject: Re: [PATCH V2 2/3] clk: imx7d: correct enet clock CCGR registers
>>
>> On 18.05.2018 03:01, Anson Huang wrote:
>> > Correct enet clock gates as below:
>> >
>> > CCGR6: IMX7D_ENET_AXI_ROOT_CLK (enet1 and enet2 bus clocks)
>> > CCGR112: IMX7D_ENET1_TIME_ROOT_CLK, IMX7D_ENET1_IPG_ROOT_CLK
>> > CCGR113: IMX7D_ENET2_TIME_ROOT_CLK, IMX7D_ENET2_IPG_ROOT_CLK
>> >
>> > Just rename unused IMX7D_ENETx_REF_ROOT_CLK for
>> > IMX7D_ENETx_IPG_ROOT_CLK instead of adding new clocks.
>>
>> Are you sure that IMX7D_ENETx_REF_ROOT_CLK are not used?
>>
>> I understand that the reference manual does not a gate at 0x44e0...
>>
>> But in a earlier revision of our Colibri iMX7 we actually used clock out, and
>> referenced this clock to enable the reference clock (see also:
>> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
>> work.kernel.org%2Fpatch%2F9211371%2F&data=02%7C01%7CAnson.Huang%
>> 40nxp.com%7Cea0856a68d8e4b921ba608d5bcbf9c02%7C686ea1d3bc2b4c6fa
>> 92cd99c5c301635%7C0%7C1%7C636622453508888330&sdata=rEhwj0innLDc
>> AEgxJyqd5vtG3SNVS05r2hEFvSc%2BQQs%3D&reserved=0).
>>
>> I guess if the gate really does not exist, then we should/would have to set
>> IMX7D_ENET1_REF_ROOT_DIV to use the SoC provided ref clock.
>>
>> --
>> Stefan
>  
> I looked into the RTL and also checked with our design team, they confirm that
> there is no CCGR78(0x44e0) and CCGR80(0x4500) on i.MX7D, the register offset
> are there, but no hardware wire connection for them. That is why they did NOT
> list them in Reference Manual. So I think we can remove them. 
> 
> For your case of using them as clock input, maybe clock tree auto use its parent
> IMX7D_ENETx_REF_ROOT_DIV which is existing, so it works.

That make sense.

The change looks good to me.

Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> 
> Anson.
> 
>>
>> >
>> > Based on Andy Duan's patch from the NXP kernel tree.
>> >
>> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>> > ---
>> >  drivers/clk/imx/clk-imx7d.c             | 10 ++++++----
>> >  include/dt-bindings/clock/imx7d-clock.h |  4 ++--
>> >  2 files changed, 8 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
>> > index 23d5090a..d4936b9 100644
>> > --- a/drivers/clk/imx/clk-imx7d.c
>> > +++ b/drivers/clk/imx/clk-imx7d.c
>> > @@ -26,6 +26,8 @@ static u32 share_count_sai1;  static u32
>> > share_count_sai2;  static u32 share_count_sai3;  static u32
>> > share_count_nand;
>> > +static u32 share_count_enet1;
>> > +static u32 share_count_enet2;
>> >
>> >  static const struct clk_div_table test_div_table[] = {
>> >  	{ .val = 3, .div = 1, },
>> > @@ -805,6 +807,10 @@ static void __init imx7d_clocks_init(struct
>> > device_node *ccm_node)
>> >  	clks[IMX7D_MIPI_DSI_ROOT_CLK] = imx_clk_gate4("mipi_dsi_root_clk",
>> > "mipi_dsi_post_div", base + 0x4650, 0);
>> >  	clks[IMX7D_MIPI_CSI_ROOT_CLK] = imx_clk_gate4("mipi_csi_root_clk",
>> > "mipi_csi_post_div", base + 0x4640, 0);
>> >  	clks[IMX7D_MIPI_DPHY_ROOT_CLK] =
>> imx_clk_gate4("mipi_dphy_root_clk",
>> > "mipi_dphy_post_div", base + 0x4660, 0);
>> > +	clks[IMX7D_ENET1_IPG_ROOT_CLK] =
>> > imx_clk_gate2_shared2("enet1_ipg_root_clk", "enet_axi_post_div", base
>> > + 0x4700, 0, &share_count_enet1);
>> > +	clks[IMX7D_ENET1_TIME_ROOT_CLK] =
>> > imx_clk_gate2_shared2("enet1_time_root_clk", "enet1_time_post_div",
>> > base + 0x4700, 0, &share_count_enet1);
>> > +	clks[IMX7D_ENET2_IPG_ROOT_CLK] =
>> > imx_clk_gate2_shared2("enet2_ipg_root_clk", "enet_axi_post_div", base
>> > + 0x4710, 0, &share_count_enet2);
>> > +	clks[IMX7D_ENET2_TIME_ROOT_CLK] =
>> > imx_clk_gate2_shared2("enet2_time_root_clk", "enet2_time_post_div",
>> > base + 0x4710, 0, &share_count_enet2);
>> >  	clks[IMX7D_SAI1_ROOT_CLK] = imx_clk_gate2_shared2("sai1_root_clk",
>> > "sai1_post_div", base + 0x48c0, 0, &share_count_sai1);
>> >  	clks[IMX7D_SAI1_IPG_CLK]  = imx_clk_gate2_shared2("sai1_ipg_clk",
>> > "ipg_root_clk",  base + 0x48c0, 0, &share_count_sai1);
>> >  	clks[IMX7D_SAI2_ROOT_CLK] = imx_clk_gate2_shared2("sai2_root_clk",
>> > "sai2_post_div", base + 0x48d0, 0, &share_count_sai2); @@ -812,10
>> > +818,6 @@ static void __init imx7d_clocks_init(struct device_node
>> > *ccm_node)
>> >  	clks[IMX7D_SAI3_ROOT_CLK] = imx_clk_gate2_shared2("sai3_root_clk",
>> > "sai3_post_div", base + 0x48e0, 0, &share_count_sai3);
>> >  	clks[IMX7D_SAI3_IPG_CLK]  = imx_clk_gate2_shared2("sai3_ipg_clk",
>> > "ipg_root_clk",  base + 0x48e0, 0, &share_count_sai3);
>> >  	clks[IMX7D_SPDIF_ROOT_CLK] = imx_clk_gate4("spdif_root_clk",
>> > "spdif_post_div", base + 0x44d0, 0);
>> > -	clks[IMX7D_ENET1_REF_ROOT_CLK] =
>> imx_clk_gate4("enet1_ref_root_clk",
>> > "enet1_ref_post_div", base + 0x44e0, 0);
>> > -	clks[IMX7D_ENET1_TIME_ROOT_CLK] =
>> > imx_clk_gate4("enet1_time_root_clk", "enet1_time_post_div", base +
>> > 0x44f0, 0);
>> > -	clks[IMX7D_ENET2_REF_ROOT_CLK] =
>> imx_clk_gate4("enet2_ref_root_clk",
>> > "enet2_ref_post_div", base + 0x4500, 0);
>> > -	clks[IMX7D_ENET2_TIME_ROOT_CLK] =
>> > imx_clk_gate4("enet2_time_root_clk", "enet2_time_post_div", base +
>> > 0x4510, 0);
>> >  	clks[IMX7D_EIM_ROOT_CLK] = imx_clk_gate4("eim_root_clk",
>> > "eim_post_div", base + 0x4160, 0);
>> >  	clks[IMX7D_NAND_RAWNAND_CLK] =
>> > imx_clk_gate2_shared2("nand_rawnand_clk", "nand_root_clk", base +
>> > 0x4140, 0, &share_count_nand);
>> >  	clks[IMX7D_NAND_USDHC_BUS_RAWNAND_CLK] =
>> > imx_clk_gate2_shared2("nand_usdhc_rawnand_clk",
>> "nand_usdhc_root_clk",
>> > base + 0x4140, 0, &share_count_nand); diff --git
>> > a/include/dt-bindings/clock/imx7d-clock.h
>> > b/include/dt-bindings/clock/imx7d-clock.h
>> > index b2325d3e2..0d67f53 100644
>> > --- a/include/dt-bindings/clock/imx7d-clock.h
>> > +++ b/include/dt-bindings/clock/imx7d-clock.h
>> > @@ -168,7 +168,7 @@
>> >  #define IMX7D_SPDIF_ROOT_SRC		155
>> >  #define IMX7D_SPDIF_ROOT_CG		156
>> >  #define IMX7D_SPDIF_ROOT_DIV		157
>> > -#define IMX7D_ENET1_REF_ROOT_CLK	158
>> > +#define IMX7D_ENET1_IPG_ROOT_CLK        158
>> >  #define IMX7D_ENET1_REF_ROOT_SRC	159
>> >  #define IMX7D_ENET1_REF_ROOT_CG		160
>> >  #define IMX7D_ENET1_REF_ROOT_DIV	161
>> > @@ -176,7 +176,7 @@
>> >  #define IMX7D_ENET1_TIME_ROOT_SRC	163
>> >  #define IMX7D_ENET1_TIME_ROOT_CG	164
>> >  #define IMX7D_ENET1_TIME_ROOT_DIV	165
>> > -#define IMX7D_ENET2_REF_ROOT_CLK	166
>> > +#define IMX7D_ENET2_IPG_ROOT_CLK        166
>> >  #define IMX7D_ENET2_REF_ROOT_SRC	167
>> >  #define IMX7D_ENET2_REF_ROOT_CG		168
>> >  #define IMX7D_ENET2_REF_ROOT_DIV	169
