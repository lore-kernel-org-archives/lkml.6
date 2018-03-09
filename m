Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeCIK0T (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:26:19 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:41472 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbeCIK0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:26:17 -0500
Subject: Re: [PATCH net-next] net: stmmac: remove superfluous wmb() memory
 barriers
To: Niklas Cassel <niklas.cassel@axis.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
References: <20180308103006.1197-1-niklas.cassel@axis.com>
CC: <Jose.Abreu@synopsys.com>, <pavel@ucw.cz>,
        Niklas Cassel <niklass@axis.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Jose Abreu <Jose.Abreu@synopsys.com>
Message-ID: <f245ba4f-9c08-3f04-b0db-97582cc06153@synopsys.com>
Date: Fri, 9 Mar 2018 10:26:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180308103006.1197-1-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.87]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On 08-03-2018 10:30, Niklas Cassel wrote:
> These wmb() memory barriers are performed after the last descriptor write,
> and they are followed by enable_dma_transmission()/set_tx_tail_ptr(),
> i.e. a writel() to MMIO register space.
> Since writel() itself performs the equivalent of a wmb() 

Sorry but I know at least two architectures which don't do a
wmb() upon an writel [1] [2]. This can be critical if if we are
accessing the device through some slow or filled bus which will
delay accesses to the device IO. Notice that writel and then
readl to the same address will force CPU to wait for writel
completion before readl, but in this case we are using DMA and
then writel so I think a wmb() before the writel is a safe measure.

Thanks and Best Regards,
Jose Miguel Abreu

[1]
https://elixir.bootlin.com/linux/latest/source/arch/arc/include/asm/io.h#L147,
with "CONFIG_ISA_ARCV2=n"
[2]
https://elixir.bootlin.com/linux/latest/source/arch/arm/include/asm/io.h#L314,
with "CONFIG_ARM_DMA_MEM_BUFFERABLE=n"

> before doing the
> actual write, these barriers are superfluous, and removing them should
> thus not change any existing behavior.
>
> Ordering within the descriptor writes is already ensured with dma_wmb()
> barriers inside prepare_tx_desc(first, ..)/prepare_tso_tx_desc(first, ..).
>
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a9856a8bf8ad..005fb45ace30 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2998,12 +2998,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  		priv->hw->desc->set_tx_owner(mss_desc);
>  	}
>  
> -	/* The own bit must be the latest setting done when prepare the
> -	 * descriptor and then barrier is needed to make sure that
> -	 * all is coherent before granting the DMA engine.
> -	 */
> -	wmb();
> -
>  	if (netif_msg_pktdata(priv)) {
>  		pr_info("%s: curr=%d dirty=%d f=%d, e=%d, f_p=%p, nfrags %d\n",
>  			__func__, tx_q->cur_tx, tx_q->dirty_tx, first_entry,
> @@ -3221,12 +3215,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  		priv->hw->desc->prepare_tx_desc(first, 1, nopaged_len,
>  						csum_insertion, priv->mode, 1,
>  						last_segment, skb->len);
> -
> -		/* The own bit must be the latest setting done when prepare the
> -		 * descriptor and then barrier is needed to make sure that
> -		 * all is coherent before granting the DMA engine.
> -		 */
> -		wmb();
>  	}
>  
>  	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
