Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F5CC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1542D20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1542D20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389291AbeG0Uo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:44:27 -0400
Received: from smtprelay0135.hostedemail.com ([216.40.44.135]:56892 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389064AbeG0Uo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:44:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 1B46A837F252;
        Fri, 27 Jul 2018 19:21:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: debt16_27242af689920
X-Filterd-Recvd-Size: 4183
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 27 Jul 2018 19:21:08 +0000 (UTC)
Message-ID: <98a6d1cd4d313512d66ced3fc25f438449b3c310.camel@perches.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: replace unnecessarily
 macroses on functions
From:   Joe Perches <joe@perches.com>
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 12:21:07 -0700
In-Reply-To: <20180727191318.18698-1-ivan.khoronzhuk@linaro.org>
References: <20180727191318.18698-1-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-27 at 22:13 +0300, Ivan Khoronzhuk wrote:
> Replace ugly macroses on functions.

Careful, see below.

> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
[]
> @@ -565,40 +565,40 @@ static const struct cpsw_stats cpsw_gstrings_ch_stats[] = {
>  				(func)(slave++, ##arg);			\
>  	} while (0)
>  
> -#define cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb)		\
> -	do {								\
> -		if (!cpsw->data.dual_emac)				\
> -			break;						\
> -		if (CPDMA_RX_SOURCE_PORT(status) == 1) {		\
> -			ndev = cpsw->slaves[0].ndev;			\
> -			skb->dev = ndev;				\
> -		} else if (CPDMA_RX_SOURCE_PORT(status) == 2) {		\
> -			ndev = cpsw->slaves[1].ndev;			\
> -			skb->dev = ndev;				\
> -		}							\
> -	} while (0)
> -#define cpsw_add_mcast(cpsw, priv, addr)				\
> -	do {								\
> -		if (cpsw->data.dual_emac) {				\
> -			struct cpsw_slave *slave = cpsw->slaves +	\
> -						priv->emac_port;	\
> -			int slave_port = cpsw_get_slave_port(		\
> -						slave->slave_num);	\
> -			cpsw_ale_add_mcast(cpsw->ale, addr,		\
> -				1 << slave_port | ALE_PORT_HOST,	\
> -				ALE_VLAN, slave->port_vlan, 0);		\
> -		} else {						\
> -			cpsw_ale_add_mcast(cpsw->ale, addr,		\
> -				ALE_ALL_PORTS,				\
> -				0, 0, 0);				\
> -		}							\
> -	} while (0)
> -
>  static inline int cpsw_get_slave_port(u32 slave_num)
>  {
>  	return slave_num + 1;
>  }
>  
> +static inline void cpsw_src_port_detect(struct cpsw_common *cpsw, int status,
> +					struct sk_buff *skb)
> +{
> +	if (!cpsw->data.dual_emac)
> +		return;
> +
> +	if (CPDMA_RX_SOURCE_PORT(status) == 1)
> +		skb->dev = cpsw->slaves[0].ndev;
> +	else if (CPDMA_RX_SOURCE_PORT(status) == 2)
> +		skb->dev = cpsw->slaves[1].ndev;
> +}

perhaps better as a switch/case

> +
> +static void cpsw_add_mcast(struct cpsw_priv *priv, u8 *addr)
> +{
> +	struct cpsw_common *cpsw = priv->cpsw;
> +
> +	if (cpsw->data.dual_emac) {
> +		struct cpsw_slave *slave = cpsw->slaves + priv->emac_port;
> +		int slave_port = cpsw_get_slave_port(slave->slave_num);
> +
> +		cpsw_ale_add_mcast(cpsw->ale, addr,
> +				   1 << slave_port | ALE_PORT_HOST,
> +				   ALE_VLAN, slave->port_vlan, 0);
> +		return;
> +	}
> +
> +	cpsw_ale_add_mcast(cpsw->ale, addr, ALE_ALL_PORTS, 0, 0, 0);
> +}
> +
>  static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
>  {
>  	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
> @@ -706,7 +706,7 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
>  
>  		/* program multicast address list into ALE register */
>  		netdev_for_each_mc_addr(ha, ndev) {
> -			cpsw_add_mcast(cpsw, priv, (u8 *)ha->addr);
> +			cpsw_add_mcast(priv, (u8 *)ha->addr);
>  		}
>  	}
>  }
> @@ -801,7 +801,8 @@ static void cpsw_rx_handler(void *token, int len, int status)
>  	int			ret = 0;
>  	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
>  
> -	cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb);
> +	cpsw_src_port_detect(cpsw, status, skb);
> +	ndev = skb->dev;

This is not the same code as the new function
is not guaranteed to succeed or set skb->dev.

>  	if (unlikely(status < 0) || unlikely(!netif_running(ndev))) {
>  		/* In dual emac mode check for all interfaces */
