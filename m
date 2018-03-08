Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933796AbeCHQsS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:48:18 -0500
Received: from botnar.kaiser.cx ([176.28.20.183]:56376 "EHLO botnar.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752132AbeCHQsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:48:16 -0500
Date: Thu, 8 Mar 2018 17:46:54 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: imx25: set correct parents for ssi ipg clocks
Message-ID: <20180308164654.GA31199@botnar.kaiser.cx>
References: <1520373735-13699-1-git-send-email-martin@kaiser.cx>
 <CAOMZO5A7W4rbPbZB8ERs518obrg+6F6mDeojkwJaGComFAJB0A@mail.gmail.com>
 <20180308140851.GA25601@botnar.kaiser.cx>
 <CAOMZO5BdBWExt9FvPrfUG74Y62e4EUs6cqFyfVs5JuUtym00hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5BdBWExt9FvPrfUG74Y62e4EUs6cqFyfVs5JuUtym00hQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

thanks for the quick response.

Thus wrote Fabio Estevam (festevam@gmail.com):

> Hi Martin,

> On Thu, Mar 8, 2018 at 11:08 AM, Martin Kaiser <martin@kaiser.cx> wrote:
> > Hi Fabio,

> > Thus wrote Fabio Estevam (festevam@gmail.com):

> >> I get audio working from SSI1, but I guess this is due to the fact
> >> that the bootloader enables the SSI clock:

> >> I have the following in U-Boot:

> >> /* Enable the clocks */
> >> DATA 4 0x53f8000c 0x1fffffff
> >> DATA 4 0x53f80010 0xffffffff
> >> DATA 4 0x53f80014 0xfdfff

> > I'm using the same initial settings.

> > Nevertheless, ssi1_ipg_per is disbled after loading the kernel.

> > Digging into this a bit more, it turned out that without my patch,
> > clk_disable_unused() recognizes ssi1_ipg_per as unused and disables it.

> > If my patch is applied and ssi1_ipg_per is declared as parent of
> > ssi1_ipg, clk_disable_unused() will not disable it and fsl_ssi_startup()
> > will enable both ssi1_ipg_per and ssi1_ipg before playing sound.

> I can get audio to work fine without your patch on a mx25pdk.

this is surprising. How come the ssi1_ipg_per clock is not turned off by
clk_disable_unused()? Where is it used? Do you have

<&clks 55>

anywhere in your DT?

> In the other i.MX clock drivers we have this same pattern:

> clks[IMX6SL_CLK_SSI1_IPG]     = imx_clk_gate2_shared("ssi1_ipg",     "ipg",

It seems to the that imx25 uses a different clock hierarchy for ssi than other
imx chips.

Documentation/devicetree/bindings/clock/imx25-clock.txt: ssi1_ipg_per      55
Documentation/devicetree/bindings/clock/imx25-clock.txt: ssi2_ipg_per      56
Documentation/devicetree/bindings/clock/imx25-clock.txt: ssi1_ipg    117
Documentation/devicetree/bindings/clock/imx25-clock.txt: ssi2_ipg    118
Documentation/devicetree/bindings/clock/imx31-clock.txt: ssi1_gate            32
Documentation/devicetree/bindings/clock/imx31-clock.txt: ssi2_gate            52
Documentation/devicetree/bindings/clock/imx35-clock.txt: ssi_sel        22
Documentation/devicetree/bindings/clock/imx35-clock.txt: ssi1_div_pre      23
Documentation/devicetree/bindings/clock/imx35-clock.txt: ssi1_div_post     24
Documentation/devicetree/bindings/clock/imx35-clock.txt: ssi2_div_pre      25
Documentation/devicetree/bindings/clock/imx35-clock.txt: ssi2_div_post     26
Documentation/devicetree/bindings/clock/imx35-clock.txt: ssi1_gate      68
Documentation/devicetree/bindings/clock/imx35-clock.txt: ssi2_gate      69

Others don't have ssiX_ipg_per.

> It is not clear to me what is the real issue this patch is trying to fix.

True. This needs clarification.

I found that, in oder to get a tx clock out of the SSI, both ssi1_ipg_per and
ssi1_ipg clocks must be active.

The fsl_ssi driver only activates ssi1_ipg.

If I activate ssi1_ipg_per in the bootloader, clk_disable_unused() deactivates it.

(My codec chip does not use a dedicated clock line. It takes the bit clock that
is the output of SSI. Are you maybe using ssi1_ipg_per for your codec and
enable it there?)

In my first mail, I was wondering about imx25 uart1, where we also have
uart1_ipg and uart_ipg_per and the clock seeting is

   clk[uart1_ipg] = imx_clk_gate("uart1_ipg", "ipg", ccm(CCM_CGCR2), 14);

In this case, both uart1 and uart_ipg_per are listed in the device tree

         uart1: serial@43f90000 {                                                                                                      
...
            clocks = <&clks 120>, <&clks 57>;                                                                                          
            clock-names = "ipg", "per";                                                                                                
         };                                                                                                                            

Documentation/devicetree/bindings/clock/imx25-clock.txt
   uart_ipg_per      57
   uart1_ipg      120

and the driver enables both clocks explicitly. So they are not unused.


Doing something like this is not an option for ssi, this will not work with
imx31, 35 etc.

Therefore, I suggest setting ssi1_ipg_per as parent of ssi1_ipg.


Best regards,

   Martin
