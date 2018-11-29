Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4B3C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB732145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB732145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbeK3DJZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:09:25 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50350 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728583AbeK3DJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:09:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 14D1E207BC; Thu, 29 Nov 2018 17:03:33 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id B3E46206FF;
        Thu, 29 Nov 2018 17:03:32 +0100 (CET)
Date:   Thu, 29 Nov 2018 17:03:32 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] clk: core: link consumer with clock driver
Message-ID: <20181129170332.76971464@xps13>
In-Reply-To: <20181127123858.3v344nonsuyqskrt@flea>
References: <20181122212212.16039-1-miquel.raynal@bootlin.com>
 <20181122212212.16039-3-miquel.raynal@bootlin.com>
 <20181127123858.3v344nonsuyqskrt@flea>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Maxime Ripard <maxime.ripard@bootlin.com> wrote on Tue, 27 Nov 2018
13:38:58 +0100:

> Hi Miquel,
> 
> On Thu, Nov 22, 2018 at 10:22:12PM +0100, Miquel Raynal wrote:
> > One major concern when, for instance, suspending/resuming a platform
> > is to never access registers before the underlying clock has been
> > resumed, otherwise most of the time the kernel will just crash. One
> > solution is to use syscore operations when registering clock drivers
> > suspend/resume callbacks. One problem of using syscore_ops is that the
> > suspend/resume scheduling will depend on the order of the
> > registrations, which brings (unacceptable) randomness in the process.
> > 
> > A feature called device links has been introduced to handle such
> > situation. It creates dependencies between consumers and providers,
> > enforcing e.g. the suspend/resume order when needed. Such feature is
> > already in use for regulators.
> > 
> > Add device links support in the clock subsystem by creating/deleting
> > the links at get/put time.
> > 
> > Example of a boot (ESPRESSObin, A3700 SoC) with devices linked to clocks:
> > ahci-mvebu d00e0000.sata: Linked as a consumer to d0013000.nb-periph-clk
> > mvneta d0030000.ethernet: Linked as a consumer to d0018000.sb-periph-clk
> > xhci-hcd d0058000.usb: Linked as a consumer to d0018000.sb-periph-clk
> > xenon-sdhci d00d0000.sdhci: Linked as a consumer to d0013000.nb-periph-clk
> > xenon-sdhci d00d0000.sdhci: Dropping the link to d0013000.nb-periph-clk
> > advk-pcie d0070000.pcie: Linked as a consumer to d0018000.sb-periph-clk
> > xenon-sdhci d00d0000.sdhci: Linked as a consumer to d0013000.nb-periph-clk
> > xenon-sdhci d00d0000.sdhci: Linked as a consumer to regulator.1
> > cpu cpu0: Linked as a consumer to d0013000.nb-periph-clk
> > cpu cpu0: Dropping the link to d0013000.nb-periph-clk
> > cpu cpu0: Linked as a consumer to d0013000.nb-periph-clk
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/clk/clk.c            | 20 ++++++++++++++++++++
> >  drivers/clk/clkdev.c         | 13 ++++++++++---
> >  include/linux/clk-provider.h |  2 ++
> >  3 files changed, 32 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index b799347c5fd6..33a0f2b0533a 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -90,6 +90,7 @@ struct clk {
> >  	unsigned long max_rate;
> >  	unsigned int exclusive_count;
> >  	struct hlist_node clks_node;
> > +	struct device_link *link;
> >  };
> >  
> >  /***           runtime pm          ***/
> > @@ -262,6 +263,25 @@ struct clk_hw *__clk_get_hw(struct clk *clk)
> >  }
> >  EXPORT_SYMBOL_GPL(__clk_get_hw);
> >  
> > +void __clk_device_link(struct device *consumer, struct clk *clk)
> > +{
> > +	if (!consumer || !clk || !clk->core)
> > +		return;
> > +
> > +	clk->link = device_link_add(consumer, clk->core->dev,
> > +				    DL_FLAG_STATELESS);
> > +}
> > +EXPORT_SYMBOL_GPL(__clk_device_link);
> > +
> > +void __clk_device_unlink(struct clk *clk)
> > +{
> > +	if (!clk || !clk->link)
> > +		return;
> > +
> > +	device_link_del(clk->link);
> > +}
> > +EXPORT_SYMBOL_GPL(__clk_device_unlink);
> > +
> >  unsigned int clk_hw_get_num_parents(const struct clk_hw *hw)
> >  {
> >  	return hw->core->num_parents;
> > diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> > index 9ab3db8b3988..fccfd4c01457 100644
> > --- a/drivers/clk/clkdev.c
> > +++ b/drivers/clk/clkdev.c
> > @@ -194,20 +194,27 @@ EXPORT_SYMBOL(clk_get_sys);
> >  struct clk *clk_get(struct device *dev, const char *con_id)
> >  {
> >  	const char *dev_id = dev ? dev_name(dev) : NULL;
> > -	struct clk *clk;
> > +	struct clk *clk = NULL;
> >  
> >  	if (dev && dev->of_node) {
> >  		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
> > -		if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
> > +		if (PTR_ERR(clk) == -EPROBE_DEFER)
> >  			return clk;
> >  	}
> >  
> > -	return clk_get_sys(dev_id, con_id);
> > +	if (IS_ERR_OR_NULL(clk))
> > +		clk = clk_get_sys(dev_id, con_id);
> > +
> > +	if (!IS_ERR(clk))
> > +		__clk_device_link(dev, clk);
> > +
> > +	return clk;  
> 
> I think this doesn't address all the cases. In your case, where you
> have one consumer that is not a clock, and one provider that is a
> clock, it works just fine.
> 
> However, if you have clocks providers chained, for example with one
> oscillator, a clock controller, and a device, the link will be created
> between the device and the controller, but there will be no link
> between the controller and the oscillator.

Indeed, there is not clock_get() in this case so you are right, a link
is missing if we want to track dependencies between clocks.

> 
> Adding a link in __clk_init_parent looks like it would address that
> case.

I will add one, thanks for the pointer.

> 
> Maxime
> 

I think device links must be managed in the following situations:
* A device gets a clock -> add a link between the device and the clock,
  save it in 'struct clk'.
* A device puts a clock -> remove the above link.
* A clock gets registered -> link the core clock with the parent core
  clock.
* A clock gets reparentized -> remove the above link and if there is a
  new parent, link the core clock to the parent core clock.
* A clock gets deregistered -> remove the link with the parent core
  clock if any and remove the link with each child clock if any (this
  will be done automatically because each child will get reparentized
  first).

I assume that a clock getting deregistered is not an input source for
any device anymore and thus there is already no more link to destroy on
this regard.


Thanks,
Miquèl
