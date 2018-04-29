Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753685AbeD2PWu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 11:22:50 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21495 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753318AbeD2PWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 11:22:49 -0400
Date: Sun, 29 Apr 2018 11:22:25 -0400
From: Marcin Ziemianowicz <marcin@ziemianowicz.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] clk: at91: PLL recalc_rate() now using cached MUL+DIV
 values
Message-ID: <20180429152225.GA742@hak8or>
References: <20180427175609.GA83298@hak8or>
 <20180429151710.4ca68978@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180429151710.4ca68978@bbrezillon>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 03:17:10PM +0200, Boris Brezillon wrote:
> Hi Marcin,
> 
> On Fri, 27 Apr 2018 13:56:09 -0400
> Marcin Ziemianowicz <marcin@ziemianowicz.com> wrote:
> 
> > Stephen Boyd <sboyd@kernel.org>,
> > linux-clk@vger.kernel.org,
> > linux-arm-kernel@lists.infradead.org,
> > linux-kernel@vger.kernel.org
> > Bcc: 
> > Subject: [PATCH v3] clk: at91: PLL recalc_rate() now using cached MUL and DIV
> >  values
> > Reply-To:
> 
> Hm, I don't know how you prepared and sent your patch, but you shouldn't
> have these fields in the body of your email. Please use git format-patch
> to prepare the patch and then git send-email to send it.

I have been using Mutt this entire time with the idea of being able to use
Mutt for both sending the patch and replying to emails, but I am still
fumbling around with this (as you can see). I used git format-patch HEAD^
and I think I additionally bungled something when using Mutt. I will try
git send-email instead since it seems less error prone on my end.

>  
> > 
> > When a USB device is connected to the USB host port on the SAM9N12 then
> > you get "-62" error which seems to indicate USB replies from the device
> > are timing out. Based on a logic sniffer, I saw the USB bus was running
> > at half speed.
> > 
> > The PLL code uses cached MUL and DIV values which get set in set_rate()
> > and applied in prepare(), but the recalc_rate() function instead
> > queries the hardware instead of using these cached values. Therefore,
> > if recalc_rate() is called between a set_rate() and prepare(), the
> > wrong frequency is calculated and later the USB clock divider for the
> > SAM9N12 SOC will be configured for an incorrect clock.
> > 
> > In my case, the PLL hardware was set to 96 Mhz before the OHCI
> > driver loads, and therefore the usb clock divider was being set
> > to /2 even though the OHCI driver set the PLL to 48 Mhz.
> > 
> > As an alternative explanation, I noticed this was fixed in the past:
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283502.html
> > but was later changed back via a large patch (maybe by mistake?):
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1bdf02326b71eae7e9b4b335b881856aaf9d1af6
> 
> Yep, probably by mistake. I started this rework long before it has been
> submitted to the ML, so I probably messed something up when rebasing.
> 

Ah, it happens I guess. 99 little bugs in the code, 99 litle bugs. Take
one down, patch it around, 117 little bugs in the code. ;)

> Also, prefer commit IDs to links to the ML archive. The above would
> sentence would give:
> 
> "
> As an alternative explanation, I noticed this was fixed in the past by
> 87e2ed338f1b ("clk: at91: fix recalc_rate implementation of PLL
> driver") but the bug was later re-introduced by 1bdf02326b71 ("clk:
> at91: make use of syscon/regmap internally").
> "
> 

Ah, I was wondering what the best way is to reference old commits.
Thank you, will do!

> 
> The following comment and the changelog should be placed after the
> '---' line, so that it's not part of the commit message.
> 
> > Thank you for bearing with me about this Boris.
> > 
> > Changes since V2:
> >   Removed all logging/debug messages I added
> >   > Comment by Boris Brezillon about my fix being wrong addressed  
> > Changes since V1:
> >   Added patch set cover letter
> >   Shortened lines which were over >80 characters long
> >   > Comment by Greg Kroah-Hartman about "from" field in email addressed
> >   > Comment by Alan Stern about redundant debug lines addressed  
> > 
> 
> You should add Fixes and Cc-stable tags so that the fix is backported
> to stable branches:
> 
> Fixes: 1bdf02326b71 ("clk: at91: make use of syscon/regmap internally)
> Cc: <stable@vger.kernel.org>
> 
> > Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>
> > ---
> >  drivers/clk/at91/clk-pll.c | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> > 
> > diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
> > index 7d3223fc..cc6e0364 100644
> > --- a/drivers/clk/at91/clk-pll.c
> > +++ b/drivers/clk/at91/clk-pll.c
> > @@ -132,19 +132,8 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
> >  					 unsigned long parent_rate)
> >  {
> >  	struct clk_pll *pll = to_clk_pll(hw);
> > -	unsigned int pllr;
> > -	u16 mul;
> > -	u8 div;
> > -
> > -	regmap_read(pll->regmap, PLL_REG(pll->id), &pllr);
> > -
> > -	div = PLL_DIV(pllr);
> > -	mul = PLL_MUL(pllr, pll->layout);
> > -
> > -	if (!div || !mul)
> > -		return 0;
> >  
> > -	return (parent_rate / div) * (mul + 1);
> > +	return return (parent_rate / pll->div) * (pll->mul + 1);
> 
> The fix looks good. Let me know if you struggle with git
> format-patch/send-email and I'll try to help you (or send the patch for
> you if you don't care learning the process, but I think it's better if
> you learn how to submit patches).
> 

I definitely do want to learn how to do this myself, but thank you for the
offer! I just hope I am not taking up too much of your and others time with
me bumbling around like this.

> Thanks,
> 
> Boris
> 
> >  }
> >  
> >  static long clk_pll_get_best_div_mul(struct clk_pll *pll, unsigned long rate,
> 
