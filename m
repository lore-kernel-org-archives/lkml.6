Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeCDJ2c (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 04:28:32 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37896 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbeCDJ2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 04:28:30 -0500
Date: Sun, 4 Mar 2018 10:28:28 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Stefan Chulski <stefanc@marvell.com>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Yan Markman <ymarkman@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: Re: [PATCH net-next 5/5] net: mvpp2: jumbo frames support
Message-ID: <20180304102828.1437fbc3@windsurf.home>
In-Reply-To: <31a2c6c988bd4d5190e1fb3332f3bc35@IL-EXCH01.marvell.com>
References: <20180302154044.25204-1-antoine.tenart@bootlin.com>
        <20180302154044.25204-6-antoine.tenart@bootlin.com>
        <20180302171713.54beaad0@windsurf.lan>
        <31a2c6c988bd4d5190e1fb3332f3bc35@IL-EXCH01.marvell.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, 4 Mar 2018 06:56:02 +0000, Stefan Chulski wrote:

> > > +	if (port->pool_long->id == MVPP2_BM_JUMBO && port->id != 0) {  
> > 
> > Again, all over the place we hardcode the fact that Jumbo frames can only be
> > used on port 0. I know port 0 is the only one that can do 10G, but are there
> > possibly some use cases where you may want Jumbo frame on another port
> > ?
> > 
> > This all really feels very hardcoded to me.
> >   
> 
> All ports support Jumbo frames.
> But only port 0 can do TX HW checksum offload(due to TX FIFO size).
> 
> Packet processor 2.2 has only 19KB TX FIFO size.
> So in TX FIFO config code assign for Port 0 - 10KB, Port 1 - 3KB and Port 1 - 3KB.

Yes, but I was also questioning whether hardcoding this configuration
was correct.

> To perform checksum in HW, HW obviously should work in store and forward mode. Store all frame in TX FIFO and then check checksum.
> If mtu 1500B, everything fine and all port can do this.
> 
> If mtu is 9KB and 9KB frame transmitted, Port 0 still can do HW checksum. But ports 1 and 2 doesn't has enough FIFO for this.
> So we cannot offload this feature and SW should perform checksum.

So perhaps the real check should not be "port 0", but whether the MTU
is higher or lower than the TX FIFO size assigned to the current port.
This would express in much better way the reason why HW checksum can be
used or not.

> > > +	/* 9704 == 9728 - 20 and rounding to 8 */
> > > +	dev->max_mtu = MVPP2_BM_JUMBO_PKT_SIZE;  
> > 
> > Is this correct for all ports ? Shouldn't the maximum MTU be different
> > between port 0 (that supports Jumbo frames) and the other ports ?  
> 
> This is correct for all ports. All ports can support Jumbo frames.

OK. With your explanation above, I understand better.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
