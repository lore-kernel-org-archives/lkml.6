Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969107AbeEXUet convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:34:49 -0400
Received: from mailoutvs25.siol.net ([185.57.226.216]:38267 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S969085AbeEXUer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:34:47 -0400
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: linux-sunxi@googlegroups.com, maxime.ripard@bootlin.com
Cc: wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH 05/15] drm/sun4i: Add TCON TOP driver
Date: Thu, 24 May 2018 22:33:58 +0200
Message-ID: <2523764.1gMShBa1ZC@jernej-laptop>
In-Reply-To: <20180524084351.x4ugbbsz3mqv6fh7@flea>
References: <20180519183127.2718-1-jernej.skrabec@siol.net> <5965231.6ucpJrPIQ5@jernej-laptop> <20180524084351.x4ugbbsz3mqv6fh7@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dne četrtek, 24. maj 2018 ob 10:43:51 CEST je Maxime Ripard napisal(a):
> Hi,
> 
> On Mon, May 21, 2018 at 05:15:15PM +0200, Jernej Škrabec wrote:
> > > > +	/*
> > > > +	 * Default register values might have some reserved bits set, 
which
> > > > +	 * prevents TCON TOP from working properly. Set them to 0 here.
> > > > +	 */
> > > > +	writel(0, tcon_top->regs + TCON_TOP_PORT_SEL_REG);
> > > > +	writel(0, tcon_top->regs + TCON_TOP_GATE_SRC_REG);
> > > > +
> > > > +	for (i = 0; i < CLK_NUM; i++) {
> > > > +		const char *parent_name = "bus-tcon-top";
> > > 
> > > I guess retrieving the parent's clock name at runtime would be more
> > > flexible.
> > 
> > It is, but will it ever be anything else?
> 
> Probably not, but when the complexity is exactly the same (using
> __clk_get_name), we'd better use the more appropriate solution. If we
> ever need to change that clock name, or to use the driver with an SoC
> that wouldn't have the same clock name for whatever reason, it will
> just work.
> 
> > > > +		struct clk_init_data init;
> > > > +		struct clk_gate *gate;
> > > > +
> > > > +		gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
> > > > +		if (!gate) {
> > > > +			ret = -ENOMEM;
> > > > +			goto err_disable_clock;
> > > > +		}
> > > > +
> > > > +		init.name = gates[i].name;
> > > > +		init.ops = &clk_gate_ops;
> > > > +		init.flags = CLK_IS_BASIC;
> > > > +		init.parent_names = &parent_name;
> > > > +		init.num_parents = 1;
> > > > +
> > > > +		gate->reg = tcon_top->regs + TCON_TOP_GATE_SRC_REG;
> > > > +		gate->bit_idx = gates[i].bit;
> > > > +		gate->lock = &tcon_top->reg_lock;
> > > > +		gate->hw.init = &init;
> > > > +
> > > > +		ret = devm_clk_hw_register(dev, &gate->hw);
> > > > +		if (ret)
> > > > +			goto err_disable_clock;
> > > 
> > > Isn't it what clk_hw_register_gate is doing?
> > 
> > Almost, but not exactly. My goal was to use devm_* functions, so there is
> > no need to do any special cleanup.
> 
> Is it the only difference? If so, you can just create a
> devm_clk_hw_register gate.

I checked around and it seems that in clk core there are only non devm_* 
helpers like clk_hw_register_gate() for some reason. I guess I'll just use 
that and manually unregister all the clocks in cleanup function.

Best regards,
Jernej
