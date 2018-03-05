Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934585AbeCEMmD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:42:03 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55840 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933014AbeCEMmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:42:01 -0500
Date: Mon, 5 Mar 2018 13:41:48 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: davem@davemloft.net, Stefan Chulski <stefanc@marvell.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 1/5] net: mvpp2: use the same buffer pool for
 all ports
Message-ID: <20180305134148.3bbba514@windsurf.home>
In-Reply-To: <20180305104813.GI1156@kwain>
References: <20180302154044.25204-1-antoine.tenart@bootlin.com>
        <20180302154044.25204-2-antoine.tenart@bootlin.com>
        <20180302170159.258bcdbc@windsurf.lan>
        <20180305104813.GI1156@kwain>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 5 Mar 2018 11:48:13 +0100, Antoine Tenart wrote:

> > > +static void mvpp2_setup_bm_pool(void)
> > > +{
> > > +	/* Short pool */
> > > +	mvpp2_pools[MVPP2_BM_SHORT].buf_num  = MVPP2_BM_SHORT_BUF_NUM;
> > > +	mvpp2_pools[MVPP2_BM_SHORT].pkt_size = MVPP2_BM_SHORT_PKT_SIZE;
> > > +
> > > +	/* Long pool */
> > > +	mvpp2_pools[MVPP2_BM_LONG].buf_num  = MVPP2_BM_LONG_BUF_NUM;
> > > +	mvpp2_pools[MVPP2_BM_LONG].pkt_size = MVPP2_BM_LONG_PKT_SIZE;
> > > +}  
> > 
> >  ?  
> 
> I wanted to do this, but it's no possible as MVPP2_BM_SHORT_PKT_SIZE and
> MVPP2_BM_LONG_PKT_SIZE use a core definition which expands at some point
> to __max(...) which has to be called from within a function.

Hum, weird:

#define MVPP2_BM_LONG_PKT_SIZE	MVPP2_RX_MAX_PKT_SIZE(MVPP2_BM_LONG_FRAME_SIZE)
#define MVPP2_BM_LONG_FRAME_SIZE		2048

#define MVPP2_RX_MAX_PKT_SIZE(total_size) \
        ((total_size) - NET_SKB_PAD - MVPP2_SKB_SHINFO_SIZE)

#define MVPP2_SKB_SHINFO_SIZE \
        SKB_DATA_ALIGN(sizeof(struct skb_shared_info))

#define SKB_DATA_ALIGN(X)        ALIGN(X, SMP_CACHE_BYTES)

I don't really see a __max(...) call.

And if this value really expands depending on other values, then it
isn't really a constant, and should be considered as a constant, no?

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
