Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B81C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F7C218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfAYPSS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:18:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:47462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbfAYPSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:18:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D933EAC4B;
        Fri, 25 Jan 2019 15:18:15 +0000 (UTC)
Date:   Fri, 25 Jan 2019 16:18:15 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, maxime.chevallier@bootlin.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mvpp2: fix condition for setting up link
 interrupt
Message-Id: <20190125161815.0527d5174fdfb680eee59372@suse.de>
In-Reply-To: <20190125083720.GK3662@kwain>
References: <20190124131803.14038-1-tbogendoerfer@suse.de>
        <20190124155137.GD482@lunn.ch>
        <20190124160741.jady3r2e4dme7c4m@e5254000004ec.dyn.armlinux.org.uk>
        <20190125083720.GK3662@kwain>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 09:37:20 +0100
Antoine Tenart <antoine.tenart@bootlin.com> wrote:

> Hi,
> 
> On Thu, Jan 24, 2019 at 04:07:41PM +0000, Russell King - ARM Linux admin wrote:
> > On Thu, Jan 24, 2019 at 04:51:37PM +0100, Andrew Lunn wrote:
> > > On Thu, Jan 24, 2019 at 02:18:03PM +0100, Thomas Bogendoerfer wrote:
> > > > 
> > > > Fixes: 4bb043262878 ("net: mvpp2: phylink support")
> > > > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > > > ---
> > > >  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > > index 16066c2d5b3a..0fbfe1945a69 100644
> > > > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > > @@ -3405,7 +3405,7 @@ static int mvpp2_open(struct net_device *dev)
> > > >  		valid = true;
> > > >  	}
> > > >  
> > > > -	if (priv->hw_version == MVPP22 && port->link_irq && !port->phylink) {
> > > > +	if (priv->hw_version == MVPP22 && port->link_irq && port->phylink) {
> > > >  		err = request_irq(port->link_irq, mvpp2_link_status_isr, 0,
> > > >  				  dev->name, port);
> > > >  		if (err) {
> > 
> > This still looks fishy to me.  mvpp2_link_status_isr() has handling in
> > it that is safe to be called for non-phylink cases, so presumably the
> > right fix is to drop the "&& !port->phylink" completely?
> 
> That's right, mvpp2_link_status_isr() is safe to be called with or
> without phylink being used. This IRQ is reporting the link status, and
> is used when using in-band status or when phylink isn't used.
> 
> We do have a similar fix locally, which looks like:
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 2bcbf9caaf0d..6bab1824a1e4 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -3406,7 +3406,8 @@ static int mvpp2_open(struct net_device *dev)
>                 valid = true;
>         }
> 
> -       if (priv->hw_version == MVPP22 && port->link_irq && !port->phylink) {
> +       if (priv->hw_version == MVPP22 && port->link_irq &&
> +           (!port->phylink || !port->has_phy)) {
>                 err = request_irq(port->link_irq, mvpp2_link_status_isr, 0,
>                                   dev->name, port);
>                 if (err) {
> 
> We haven't submitted it yet, as we saw several issues when a port has no
> PHY and is using the XLG MAC (so, not on the mcbin). We currently are
> working on them.
> 
> I don't like to ask this, as you submitted the fix first, but I do think
> we should hold back a bit while we figure out proper solutions. If you
> need in-band status to be working properly, we could share out current
> local branch so you can test and validate it do solve your issue.

I also thought about it, and your patch makes more sense. It's more about
having no ethernet phy and therefore looking at the serdes for link status.
The system I'm running on has a few internal nodes behind a switch. The
switch propagates the external link state to the nodes via serdes lines.

I've tested your patch and it works in my setup.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
