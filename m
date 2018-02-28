Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935262AbeB1WCP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:02:15 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:56830 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935105AbeB1WCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:02:14 -0500
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: wens@csie.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 01/16] clk: sunxi-ng: Add check for minimal rate to NM PLLs
Date: Wed, 28 Feb 2018 22:55:03 +0100
Message-ID: <3220888.aQMeRaSCkl@jernej-laptop>
In-Reply-To: <20180228073440.6ejo3wjdqag6h4nl@flea>
References: <20180227222701.9716-1-jernej.skrabec@siol.net> <20180227222701.9716-2-jernej.skrabec@siol.net> <20180228073440.6ejo3wjdqag6h4nl@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dne sreda, 28. februar 2018 ob 08:34:40 CET je Maxime Ripard napisal(a):
> Hi,
> 
> On Tue, Feb 27, 2018 at 11:26:46PM +0100, Jernej Skrabec wrote:
> > Some NM PLLs doesn't work well when their output clock rate is set below
> > certain rate.
> > 
> > Add support for that constrain.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/clk/sunxi-ng/ccu_nm.c | 11 +++++++----
> >  drivers/clk/sunxi-ng/ccu_nm.h | 27 +++++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
> > index a16de092bf94..7fc743c78c1b 100644
> > --- a/drivers/clk/sunxi-ng/ccu_nm.c
> > +++ b/drivers/clk/sunxi-ng/ccu_nm.c
> > @@ -20,7 +20,7 @@ struct _ccu_nm {
> > 
> >  };
> >  
> >  static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
> > 
> > -			     struct _ccu_nm *nm)
> > +			     unsigned long min_rate, struct _ccu_nm *nm)
> > 
> >  {
> >  
> >  	unsigned long best_rate = 0;
> >  	unsigned long best_n = 0, best_m = 0;
> > 
> > @@ -30,7 +30,7 @@ static void ccu_nm_find_best(unsigned long parent,
> > unsigned long rate,> 
> >  		for (_m = nm->min_m; _m <= nm->max_m; _m++) {
> >  		
> >  			unsigned long tmp_rate = parent * _n  / _m;
> > 
> > -			if (tmp_rate > rate)
> > +			if (tmp_rate > rate || tmp_rate < min_rate)
> > 
> >  				continue;
> >  			
> >  			if ((rate - tmp_rate) < (rate - best_rate)) {
> > 
> > @@ -117,6 +117,9 @@ static long ccu_nm_round_rate(struct clk_hw *hw,
> > unsigned long rate,> 
> >  	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
> >  	
> >  		rate *= nm->fixed_post_div;
> > 
> > +	if (rate < nm->min_rate)
> > +		rate = nm->min_rate;
> > +
> 
> I guess you can just return there. There's no point in trying to find
> the factors at this point, since the minimum should be a value that
> can be reached.
> 

Right, I already tested it and it works.

Best regards,
Jernej

> >  	if (ccu_frac_helper_has_rate(&nm->common, &nm->frac, rate)) {
> >  	
> >  		if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
> >  		
> >  			rate /= nm->fixed_post_div;
> > 
> > @@ -134,7 +137,7 @@ static long ccu_nm_round_rate(struct clk_hw *hw,
> > unsigned long rate,> 
> >  	_nm.min_m = 1;
> >  	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
> > 
> > -	ccu_nm_find_best(*parent_rate, rate, &_nm);
> > +	ccu_nm_find_best(*parent_rate, rate, nm->min_rate, &_nm);
> 
> Therefore, you don't need to change the prototype there either.
> 
> Maxime
> 
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
