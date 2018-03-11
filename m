Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932256AbeCKQmC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 12:42:02 -0400
Received: from botnar.kaiser.cx ([176.28.20.183]:59290 "EHLO botnar.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932153AbeCKQl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 12:41:59 -0400
Date: Sun, 11 Mar 2018 17:39:46 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Fabio Estevam <festevam@gmail.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: imx25: set correct parents for ssi ipg clocks
Message-ID: <20180311163946.GA11507@botnar.kaiser.cx>
References: <1520373735-13699-1-git-send-email-martin@kaiser.cx>
 <CAOMZO5A7W4rbPbZB8ERs518obrg+6F6mDeojkwJaGComFAJB0A@mail.gmail.com>
 <20180308140851.GA25601@botnar.kaiser.cx>
 <CAOMZO5BdBWExt9FvPrfUG74Y62e4EUs6cqFyfVs5JuUtym00hQ@mail.gmail.com>
 <20180308164654.GA31199@botnar.kaiser.cx>
 <CAOMZO5Czv7Rj-wA9L42S9GJhufjw3br0d+iLcf070NWH4SjCbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5Czv7Rj-wA9L42S9GJhufjw3br0d+iLcf070NWH4SjCbA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio & Lothar,

Thus wrote Fabio Estevam (festevam@gmail.com):

> On Thu, Mar 8, 2018 at 1:46 PM, Martin Kaiser <martin@kaiser.cx> wrote:

> >> I can get audio to work fine without your patch on a mx25pdk.

> > this is surprising. How come the ssi1_ipg_per clock is not turned off by
> > clk_disable_unused()? Where is it used? Do you have

> > <&clks 55>

> > anywhere in your DT?

> No, I don't. imx25-pdk board operates SSI in slave mode.

> > (My codec chip does not use a dedicated clock line. It takes the bit clock that
> > is the output of SSI. Are you maybe using ssi1_ipg_per for your codec and
> > enable it there?)

> The difference between our boards is that you use SSI in master mode
> and mx25pdk in slave mode.

> > In my first mail, I was wondering about imx25 uart1, where we also have
> > uart1_ipg and uart_ipg_per and the clock seeting is

> >    clk[uart1_ipg] = imx_clk_gate("uart1_ipg", "ipg", ccm(CCM_CGCR2), 14);

> > In this case, both uart1 and uart_ipg_per are listed in the device tree

> >          uart1: serial@43f90000 {
> > ...
> >             clocks = <&clks 120>, <&clks 57>;
> >             clock-names = "ipg", "per";
> >          };

> > Documentation/devicetree/bindings/clock/imx25-clock.txt
> >    uart_ipg_per      57
> >    uart1_ipg      120

> > and the driver enables both clocks explicitly. So they are not unused.


> > Doing something like this is not an option for ssi, this will not work with
> > imx31, 35 etc.

> The solution to this is passing the "baud" clock as Lothar pointed out.

ok, I got your point now.

The ssi1_ipg clock does not depend on ssi1_ipg_per. This is in line with
the clock generation scheme in the reference manual.

And there's configurations where ssi1_ipg should be switched on, but not
ssi1_ipg_per.

I'll look into using the baud clock on my board.

Thanks to both of you for taking the time to explain this.

Best regards,

   Martin
