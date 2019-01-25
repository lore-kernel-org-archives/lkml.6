Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48503C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA0B2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfAYIhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:37:24 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40383 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfAYIhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:37:23 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 250BA207B0; Fri, 25 Jan 2019 09:37:20 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id D79F220712;
        Fri, 25 Jan 2019 09:37:19 +0100 (CET)
Date:   Fri, 25 Jan 2019 09:37:20 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mvpp2: fix condition for setting up link
 interrupt
Message-ID: <20190125083720.GK3662@kwain>
References: <20190124131803.14038-1-tbogendoerfer@suse.de>
 <20190124155137.GD482@lunn.ch>
 <20190124160741.jady3r2e4dme7c4m@e5254000004ec.dyn.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190124160741.jady3r2e4dme7c4m@e5254000004ec.dyn.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 24, 2019 at 04:07:41PM +0000, Russell King - ARM Linux admin wrote:
> On Thu, Jan 24, 2019 at 04:51:37PM +0100, Andrew Lunn wrote:
> > On Thu, Jan 24, 2019 at 02:18:03PM +0100, Thomas Bogendoerfer wrote:
> > > 
> > > Fixes: 4bb043262878 ("net: mvpp2: phylink support")
> > > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > > ---
> > >  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > index 16066c2d5b3a..0fbfe1945a69 100644
> > > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > @@ -3405,7 +3405,7 @@ static int mvpp2_open(struct net_device *dev)
> > >  		valid = true;
> > >  	}
> > >  
> > > -	if (priv->hw_version == MVPP22 && port->link_irq && !port->phylink) {
> > > +	if (priv->hw_version == MVPP22 && port->link_irq && port->phylink) {
> > >  		err = request_irq(port->link_irq, mvpp2_link_status_isr, 0,
> > >  				  dev->name, port);
> > >  		if (err) {
> 
> This still looks fishy to me.  mvpp2_link_status_isr() has handling in
> it that is safe to be called for non-phylink cases, so presumably the
> right fix is to drop the "&& !port->phylink" completely?

That's right, mvpp2_link_status_isr() is safe to be called with or
without phylink being used. This IRQ is reporting the link status, and
is used when using in-band status or when phylink isn't used.

We do have a similar fix locally, which looks like:

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 2bcbf9caaf0d..6bab1824a1e4 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3406,7 +3406,8 @@ static int mvpp2_open(struct net_device *dev)
                valid = true;
        }

-       if (priv->hw_version == MVPP22 && port->link_irq && !port->phylink) {
+       if (priv->hw_version == MVPP22 && port->link_irq &&
+           (!port->phylink || !port->has_phy)) {
                err = request_irq(port->link_irq, mvpp2_link_status_isr, 0,
                                  dev->name, port);
                if (err) {

We haven't submitted it yet, as we saw several issues when a port has no
PHY and is using the XLG MAC (so, not on the mcbin). We currently are
working on them.

I don't like to ask this, as you submitted the fix first, but I do think
we should hold back a bit while we figure out proper solutions. If you
need in-band status to be working properly, we could share out current
local branch so you can test and validate it do solve your issue.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
