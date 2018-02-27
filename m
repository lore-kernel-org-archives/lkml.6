Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeB0QNM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:13:12 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:57730 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbeB0QNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:13:08 -0500
Date: Tue, 27 Feb 2018 11:13:06 -0500 (EST)
Message-Id: <20180227.111306.790069240486489244.davem@davemloft.net>
To: antoine.tenart@bootlin.com
Cc: ymarkman@marvell.com, mw@semihalf.com, stefanc@marvell.com,
        thomas.petazzoni@free-electrons.com,
        gregory.clement@free-electrons.com, miquel.raynal@free-electrons.com,
        nadavh@marvell.com, maxime.chevallier@bootlin.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: mvpp2: adjust gso stop wake
 thresholds
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180226141427.31536-2-antoine.tenart@bootlin.com>
References: <20180226141427.31536-1-antoine.tenart@bootlin.com>
        <20180226141427.31536-2-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Mon, 26 Feb 2018 15:14:26 +0100

> From: Yan Markman <ymarkman@marvell.com>
> 
> Adjust MVPP2_MAX_TSO_SEGS and stop_threshold/wake_threshold
> for better TXQ utilization and performance.
> 
> Signed-off-by: Yan Markman <ymarkman@marvell.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
> index 55300b1fe6c0..1a893ef70eab 100644
> --- a/drivers/net/ethernet/marvell/mvpp2.c
> +++ b/drivers/net/ethernet/marvell/mvpp2.c
> @@ -498,7 +498,7 @@
>   * skb. As we need a maxium of two descriptors per fragments (1 header, 1 data),
>   * multiply this value by two to count the maximum number of skb descs needed.
>   */
> -#define MVPP2_MAX_TSO_SEGS		300
> +#define MVPP2_MAX_TSO_SEGS		100
>  #define MVPP2_MAX_SKB_DESCS		(MVPP2_MAX_TSO_SEGS * 2 + MAX_SKB_FRAGS)
>  
>  /* Dfault number of RXQs in use */
> @@ -5810,7 +5810,7 @@ static int mvpp2_txq_init(struct mvpp2_port *port,
>  		txq_pcpu->tso_headers = NULL;
>  
>  		txq_pcpu->stop_threshold = txq->size - MVPP2_MAX_SKB_DESCS;
> -		txq_pcpu->wake_threshold = txq_pcpu->stop_threshold / 2;
> +		txq_pcpu->wake_threshold = txq_pcpu->stop_threshold - 100;
>  

This number 100 is a magic constant.  If it is related to
MVPP2_MAX_TSO_SEGS, please use that define.  Otherwise
define a new one which is descriptive.

Thank you.
