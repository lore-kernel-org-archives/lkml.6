Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934974AbeCEM4R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:56:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56450 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933973AbeCEM4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:56:16 -0500
Date: Mon, 5 Mar 2018 13:56:04 +0100
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        Stefan Chulski <stefanc@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next 1/5] net: mvpp2: use the same buffer pool for
 all ports
Message-ID: <20180305125604.GJ1156@kwain>
References: <20180302154044.25204-1-antoine.tenart@bootlin.com>
 <20180302154044.25204-2-antoine.tenart@bootlin.com>
 <20180302170159.258bcdbc@windsurf.lan>
 <20180305104813.GI1156@kwain>
 <20180305134148.3bbba514@windsurf.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180305134148.3bbba514@windsurf.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Mar 05, 2018 at 01:41:48PM +0100, Thomas Petazzoni wrote:
> On Mon, 5 Mar 2018 11:48:13 +0100, Antoine Tenart wrote:
> 
> > > > +static void mvpp2_setup_bm_pool(void)
> > > > +{
> > > > +	/* Short pool */
> > > > +	mvpp2_pools[MVPP2_BM_SHORT].buf_num  = MVPP2_BM_SHORT_BUF_NUM;
> > > > +	mvpp2_pools[MVPP2_BM_SHORT].pkt_size = MVPP2_BM_SHORT_PKT_SIZE;
> > > > +
> > > > +	/* Long pool */
> > > > +	mvpp2_pools[MVPP2_BM_LONG].buf_num  = MVPP2_BM_LONG_BUF_NUM;
> > > > +	mvpp2_pools[MVPP2_BM_LONG].pkt_size = MVPP2_BM_LONG_PKT_SIZE;
> > > > +}  
> > > 
> > >  ?  
> > 
> > I wanted to do this, but it's no possible as MVPP2_BM_SHORT_PKT_SIZE and
> > MVPP2_BM_LONG_PKT_SIZE use a core definition which expands at some point
> > to __max(...) which has to be called from within a function.
> 
> Hum, weird:
> 
> #define MVPP2_BM_LONG_PKT_SIZE	MVPP2_RX_MAX_PKT_SIZE(MVPP2_BM_LONG_FRAME_SIZE)
> #define MVPP2_BM_LONG_FRAME_SIZE		2048
> 
> #define MVPP2_RX_MAX_PKT_SIZE(total_size) \
>         ((total_size) - NET_SKB_PAD - MVPP2_SKB_SHINFO_SIZE)
> 
> #define MVPP2_SKB_SHINFO_SIZE \
>         SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
> 
> #define SKB_DATA_ALIGN(X)        ALIGN(X, SMP_CACHE_BYTES)
> 
> I don't really see a __max(...) call.

NET_SKB_PAD expends to __max(...).

> And if this value really expands depending on other values, then it
> isn't really a constant, and should be considered as a constant, no?

Well, the padding isn't truly a constant for some reasons, you can see
an explanation here:
https://elixir.bootlin.com/linux/latest/source/include/linux/skbuff.h#L2446

But this value can only change at compile time, so it really depends on
what is the definition of a constant is :)

Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
