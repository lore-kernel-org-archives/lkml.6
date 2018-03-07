Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933706AbeCGSJt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:09:49 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:56903 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933251AbeCGSJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:09:45 -0500
Date: Wed, 7 Mar 2018 19:09:41 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: David Miller <davem@davemloft.net>
Cc: pavel@ucw.cz, peppe.cavallaro@st.com, alexandre.torgue@st.com,
        Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: stmmac: use correct barrier between
 coherent memory and MMIO
Message-ID: <20180307180941.GA29447@axis.com>
References: <20180302232853.GA11108@axis.com>
 <20180307.103226.1538176953286317879.davem@davemloft.net>
 <20180307172157.GA22658@axis.com>
 <20180307.124249.619165601144161535.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307.124249.619165601144161535.davem@davemloft.net>
User-Agent: Mutt/1.9.1+16 (8a41d1c2f267) (2017-09-22)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 12:42:49PM -0500, David Miller wrote:
> From: Niklas Cassel <niklas.cassel@axis.com>
> Date: Wed, 7 Mar 2018 18:21:57 +0100
> 
> > Considering this, you can drop/revert:
> > 95eb930a40a0 ("net: stmmac: use correct barrier between coherent memory and MMIO")
> > or perhaps you want me to send a revert?
> 
> You must submit explicit patches to do a revert or any other change.
> 
> > After reverting 95eb930a40a0, we will still have a dma_wmb() _after_ the
> > last descriptor word write. You just explained that nothing else is needed
> > after the last descriptor word write, so I actually think that this last
> > barrier is superfluous.
> 
> You don't need one after the last descriptor write.
> 
> Look, you're only concerned with ordering within the descriptor writes.
> 
> So it's only about:
> 
> 	desc->a = x;
> 
> 	/* Write to 'a' must be visible to the hardware before 'b'. */
> 	dma_wmb();
> 	desc->b = y;
> 
> 	writel();
> 
> That's all that you need.

It seems like the first commit that added a wmb()
after set_tx_owner() on first desc (which is be the absolute last mem write)
was the following commit:

commit 8e83989106562326bfd6aaf92174fe138efd026b
Author: Deepak Sikri <deepak.sikri@st.com>
Date:   Sun Jul 8 21:14:45 2012 +0000

    stmmac: Fix for nfs hang on multiple reboot
    
    It was observed that during multiple reboots nfs hangs. The status of
    receive descriptors shows that all the descriptors were in control of
    CPU, and none were assigned to DMA.
    Also the DMA status register confirmed that the Rx buffer is
    unavailable.
    
    This patch adds the fix for the same by adding the memory barriers to
    ascertain that the all instructions before enabling the Rx or Tx DMA are
    completed which involves the proper setting of the ownership bit in DMA
    descriptors.
    
    Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 51b3b68528ee..ea3003edde18 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1212,6 +1212,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
                priv->hw->desc->prepare_tx_desc(desc, 0, len, csum_insertion);
                wmb();
                priv->hw->desc->set_tx_owner(desc);
+               wmb();
        }
 
        /* Interrupt on completition only for the latest segment */
@@ -1227,6 +1228,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
        /* To avoid raise condition */
        priv->hw->desc->set_tx_owner(first);
+       wmb();
 
        priv->cur_tx++;
 
@@ -1290,6 +1292,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv)
                }
                wmb();
                priv->hw->desc->set_rx_owner(p + entry);
+               wmb();
        }
 }


The first wmb() is bogus, since we don't need any wmb() before
or after setting the own bit on fragments.

The second wmb() is performed after setting the own bit on the first desc
(something that is always done last). This also seems bogus, since there
already was a wmb() just before set_tx_owner(first), and a writel() is
performed shortly after.

The last wmb(), after set_rx_owner(), might actually be needed,
since the commit message refered to problems with RX, and I don't
see any writel() being performed after this.

It is worth noting that the last barrier was changed to a dma_wmb()
by Pavel in: ad688cdbb076 ("stmmac: fix memory barriers").


TL;DL:
I will send a patch that removes the barriers performed after the
last descriptor write for TX, since a writel() is performed
shortly after.

However for RX, since this barrier is performed after setting
the own bit, and there is no writel() performed shortly after,
I don't know if this should be a dma_wmb() or has to be a wmb().


Best regards,
Niklas
