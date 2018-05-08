Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755168AbeEHNUI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:20:08 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:42436 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754991AbeEHNUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:20:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Tue, 08 May 2018 15:20:03 +0200
From: Stefan Agner <stefan@agner.ch>
To: Jacky Bai <ping.bai@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
In-Reply-To: <HE1PR04MB311395765D3DC03D5960DBA3879A0@HE1PR04MB3113.eurprd04.prod.outlook.com>
References: <20180418124908.3079-1-stefan@agner.ch>
 <20180502073807.GE3443@dragon> <56a409cf76a3eaa713cb4f0bbe1e39b6@agner.ch>
 <HE1PR04MB311395765D3DC03D5960DBA3879A0@HE1PR04MB3113.eurprd04.prod.outlook.com>
Message-ID: <4188ee25bd5179b57d09e4624dcfbfbb@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         MID_RHS_MATCH_FROM(0.00)[];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         ARC_NA(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         DKIM_SIGNED(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         TO_DN_SOME(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.05.2018 09:32, Jacky Bai wrote:
>> Subject: Re: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
>>
>> Hi Jacky,
>>
>> On 02.05.2018 09:38, Shawn Guo wrote:
>> > Hi Jacky,
>> >
>> > Do you see this problem on i.MX6 ULL?  What's your take on Stefan's fix?
>>
>> Any comment to this?
>>
>> It is 4.17.0-rc4 is out and i.MX 6ULL is still broken :-(
>>
> Hi Stefan,
> 
> I have tried two 6ULL board, I don't meet such issue. System can boot
> up successfully with commit 6f9575e55632 included.
> Anyway, the change in this patch is ok for me. it is no harm to the
> BUS clock change flow.

Hm, that is interesting, maybe it is because we use a different SKU? Or
maybe bootloader?

I tested here with a 800 MHz clocked variant on a Colibri iMX6ULL using
U-Boot 2016.11.

--
Stefan

> 
> Jacky
>> --
>> Stefan
>>
>> >
>> > Shawn
>> >
>> > On Wed, Apr 18, 2018 at 02:49:08PM +0200, Stefan Agner wrote:
>> >> On i.MX6 ULL using PLL3 seems to cause a freeze when setting the
>> >> parent to IMX6UL_CLK_PLL3_USB_OTG. This only seems to appear since
>> >> commit 6f9575e55632 ("clk: imx: Add CLK_IS_CRITICAL flag for busy
>> >> divider and busy mux"), probably because the clock is now forced to
>> >> be on.
>> >>
>> >> Fixes: 6f9575e55632("clk: imx: Add CLK_IS_CRITICAL flag for busy
>> >> divider and busy mux")
>> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> >> ---
>> >> This addresses a regression ssen on v4.17-rc1 where the kernel boots
>> >> during clock initialization, see also:
>> >>
>> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpa
>> >>
>> tchwork.kernel.org%2Fpatch%2F10295927%2F&data=02%7C01%7Cping.bai%
>> 40nx
>> >>
>> p.com%7C023287ec65034c4db45f08d5b419effb%7C686ea1d3bc2b4c6fa92cd9
>> 9c5c
>> >>
>> 301635%7C0%7C0%7C636612945852594725&sdata=U0ZGid9ZBey0FXfId2dhZb
>> hVl8p
>> >> CcjTiexG3JHYwCA4%3D&reserved=0
>> >>
>> >>  drivers/clk/imx/clk-imx6ul.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/clk/imx/clk-imx6ul.c
>> >> b/drivers/clk/imx/clk-imx6ul.c index 114ecbb94ec5..12320118f8de
>> >> 100644
>> >> --- a/drivers/clk/imx/clk-imx6ul.c
>> >> +++ b/drivers/clk/imx/clk-imx6ul.c
>> >> @@ -464,7 +464,7 @@ static void __init imx6ul_clocks_init(struct
>> device_node *ccm_node)
>> >>  	clk_set_rate(clks[IMX6UL_CLK_AHB], 99000000);
>> >>
>> >>  	/* Change periph_pre clock to pll2_bus to adjust AXI rate to 264MHz
>> */
>> >> -	clk_set_parent(clks[IMX6UL_CLK_PERIPH_CLK2_SEL],
>> clks[IMX6UL_CLK_PLL3_USB_OTG]);
>> >> +	clk_set_parent(clks[IMX6UL_CLK_PERIPH_CLK2_SEL],
>> >> +clks[IMX6UL_CLK_OSC]);
>> >>  	clk_set_parent(clks[IMX6UL_CLK_PERIPH],
>> clks[IMX6UL_CLK_PERIPH_CLK2]);
>> >>  	clk_set_parent(clks[IMX6UL_CLK_PERIPH_PRE],
>> clks[IMX6UL_CLK_PLL2_BUS]);
>> >>  	clk_set_parent(clks[IMX6UL_CLK_PERIPH],
>> >> clks[IMX6UL_CLK_PERIPH_PRE]);
>> >> --
>> >> 2.17.0
>> >>
