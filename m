Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C569C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2ED20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2ED20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeJBNlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:41:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51302 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeJBNlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:41:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D30D92072B; Tue,  2 Oct 2018 08:59:36 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id A5F6D20703;
        Tue,  2 Oct 2018 08:59:36 +0200 (CEST)
Date:   Tue, 2 Oct 2018 08:59:37 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next] net: mscc: allow extracting the FCS into the skb
Message-ID: <20181002065937.GB3368@kwain>
References: <20181001095714.26024-1-antoine.tenart@bootlin.com>
 <25a88126-2397-a1fb-0c0d-06504bb348ca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25a88126-2397-a1fb-0c0d-06504bb348ca@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi FLorian,

On Mon, Oct 01, 2018 at 09:35:45AM -0700, Florian Fainelli wrote:
> On 10/01/2018 02:57 AM, Antoine Tenart wrote:
> >  
> >  	memcpy(dev->dev_addr, ocelot->base_mac, ETH_ALEN);
> > diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
> > index 3cdf63e35b53..245452a0f244 100644
> > --- a/drivers/net/ethernet/mscc/ocelot_board.c
> > +++ b/drivers/net/ethernet/mscc/ocelot_board.c
> > @@ -126,11 +126,16 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
> >  			len += sz;
> >  		} while (len < buf_len);
> >  
> > -		/* Read the FCS and discard it */
> > +		/* Read the FCS */
> >  		sz = ocelot_rx_frame_word(ocelot, grp, false, &val);
> >  		/* Update the statistics if part of the FCS was read before */
> >  		len -= ETH_FCS_LEN - sz;
> >  
> Don't this needs to be len -= sz;

No, part of the FCS could be read in the loop before. This subtraction
removes those bytes from the stats.

> > +		if (unlikely(dev->features & NETIF_F_RXFCS)) {
> > +			buf = (u32 *)skb_put(skb, ETH_FCS_LEN);
> > +			*buf = val;
> 
> and here len -= ETH_FCS_LEN

len doesn't contain the FCS len at this point, no need to remove it
again. The extraction logic is already designed to drop the FCS and to
not count it in the stats, this patch makes use of it depending on
NETIF_F_RXFCS.

> since "len" is later used for accounting how many bytes have been
> received by the network device?

The question could be "do we need len += ETH_FCS_LEN" to account for the
FCS when NETIF_F_RXFCS is used", but I looked at other drivers and it
seemed to me the FCS is not accounted in the stats. Should it be?

> I am bit confused by the use of "buf", but presumably if NETIF_F_RXCFS
> is turned on, the FCS needs to be part of the buffer passed to the
> network stack, so adjusting len accordingly is required anyway.

This is the way we extract the data to the skb, I'm following the same
logic (I could use buf++ as well, as it's done in the loop before).

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
