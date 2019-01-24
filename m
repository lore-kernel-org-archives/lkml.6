Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3FCC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F3E218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfAXJYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:24:02 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57864 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfAXJYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:24:01 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 90C43207B6; Thu, 24 Jan 2019 10:23:59 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 622A120746;
        Thu, 24 Jan 2019 10:23:49 +0100 (CET)
Date:   Thu, 24 Jan 2019 10:23:49 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        sd@queasysnail.net, andrew@lunn.ch, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next 06/10] net: introduce a net_device_ops macsec
 helper
Message-ID: <20190124092349.GE3662@kwain>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
 <20190123155638.13852-7-antoine.tenart@bootlin.com>
 <6ebf0541-0830-3df9-121f-ac560822bf1c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ebf0541-0830-3df9-121f-ac560822bf1c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Wed, Jan 23, 2019 at 12:16:08PM -0800, Florian Fainelli wrote:
> On 1/23/19 7:56 AM, Antoine Tenart wrote:
> > This patch introduces a net_device_ops MACsec helper to allow net device
> > drivers to implement a MACsec offloading solution.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> > ---
> >  include/linux/netdevice.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index e675ef97a426..ee2f40dca515 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -53,6 +53,10 @@
> >  #include <uapi/linux/pkt_cls.h>
> >  #include <linux/hashtable.h>
> >  
> > +#ifdef CONFIG_MACSEC
> > +#include <net/macsec.h>
> > +#endif
> 
> You can provide a forward declaration for struct netdev_macsec and not
> have to include that header file.

OK.

> > +
> >  struct netpoll_info;
> >  struct device;
> >  struct phy_device;
> > @@ -1441,6 +1445,10 @@ struct net_device_ops {
> >  						u32 flags);
> >  	int			(*ndo_xsk_async_xmit)(struct net_device *dev,
> >  						      u32 queue_id);
> > +#ifdef CONFIG_MACSEC
> > +	int			(*ndo_macsec)(struct net_device *dev,
> > +					      struct netdev_macsec *macsec);
> 
> You would really want to define an API which is more oriented towards
> configuring/deconfiguring a MACsec association here, e.g.: similar to
> what the IPsec offload ndos offer.

This means mostly moving from a single function using a command field to
multiple specialized functions to add/remove each element of MACsec
configuration.

I don't have strong opinion on the single helper vs a structure
containing pointers to specialized ones, but out of curiosity what's the
benefit of such a move? Future additions and maintainability?

> It is not clear to me whether after your patch series we still need to
> create a macsec virtual device, and that gets offloaded onto its real
> device/PHY device, or if we don't need that all?

After this series, we will still need the virtual MACsec interface. When
using hardware offloading this interface isn't doing much, but it's the
interface used to configure all the MACsec connexions.

This is because, and that's specific to MACsec (vs IPsec), a software
implementation is already supported and it's using a virtual interface
to perform all the MACsec related operations (vs hooks in the Rx/Tx
paths). I really wanted to avoid having two interfaces and ways of
configuring MACsec depending on if the offloading is used.

This should also allow in the future to disable at run-time the
offloading on a given interface, and to still have MACsec working in
software (or the opposite, with extra work). For this to work, the
virtual interface still has to provide an Rx and a Tx functions so that
programs can bind onto the same interface, regardless of if the
offloading is enabled.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
