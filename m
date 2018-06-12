Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B9F87C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65710208B5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IIipsKui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65710208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934190AbeFLQhK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:37:10 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59788 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933638AbeFLQhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=NAGGVcBPMvS05EZ2nRe1likAnCLqpWac5M+NiRMJlss=;
        b=IIipsKui9p7Ntkn98tlnwuc3vd8+DrKofCuxjwKp6ipZYyIXccpmf7LhWP4NvkpWJU68hjTIdB/EkaGr5JVdTr2MztPhZxqIsnE78qnQjRZsPL3XkKx/RxB6Y1ITqV5CcE8KfZXM8DACyUuDtmxl2WGQ4n27K97gewavRcClg3Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fSmHz-0003YT-05; Tue, 12 Jun 2018 18:36:59 +0200
Date:   Tue, 12 Jun 2018 18:36:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc:     grygorii.strashko@ti.com, davem@davemloft.net, corbet@lwn.net,
        akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com
Subject: Re: [PATCH net-next 3/6] net: ethernet: ti: cpsw: add MQPRIO Qdisc
 offload
Message-ID: <20180612163658.GC12251@lunn.ch>
References: <20180611133047.4818-1-ivan.khoronzhuk@linaro.org>
 <20180611133047.4818-4-ivan.khoronzhuk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180611133047.4818-4-ivan.khoronzhuk@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 04:30:44PM +0300, Ivan Khoronzhuk wrote:
> That's possible to offload vlan to tc priority mapping with
> assumption sk_prio == L2 prio.
> 
> Example:
> $ ethtool -L eth0 rx 1 tx 4
> 
> $ qdisc replace dev eth0 handle 100: parent root mqprio num_tc 3 \
> map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1@0 1@1 2@2 hw 1
> 
> $ tc -g class show dev eth0
> +---(100:ffe2) mqprio
> |    +---(100:3) mqprio
> |    +---(100:4) mqprio
> |    
> +---(100:ffe1) mqprio
> |    +---(100:2) mqprio
> |    
> +---(100:ffe0) mqprio
>      +---(100:1) mqprio
> 
> Here, 100:1 is txq0, 100:2 is txq1, 100:3 is txq2, 100:4 is txq3
> txq0 belongs to tc0, txq1 to tc1, txq2 and txq3 to tc2
> The offload part only maps L2 prio to classes of traffic, but not
> to transmit queues, so to direct traffic to traffic class vlan has
> to be created with appropriate egress map.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
>  drivers/net/ethernet/ti/cpsw.c | 82 ++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 406537d74ec1..fd967d2bce5d 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -39,6 +39,7 @@
>  #include <linux/sys_soc.h>
>  
>  #include <linux/pinctrl/consumer.h>
> +#include <net/pkt_cls.h>
>  
>  #include "cpsw.h"
>  #include "cpsw_ale.h"
> @@ -153,6 +154,8 @@ do {								\
>  #define IRQ_NUM			2
>  #define CPSW_MAX_QUEUES		8
>  #define CPSW_CPDMA_DESCS_POOL_SIZE_DEFAULT 256
> +#define CPSW_TC_NUM			4
> +#define CPSW_FIFO_SHAPERS_NUM		(CPSW_TC_NUM - 1)
>  
>  #define CPSW_RX_VLAN_ENCAP_HDR_PRIO_SHIFT	29
>  #define CPSW_RX_VLAN_ENCAP_HDR_PRIO_MSK		GENMASK(2, 0)
> @@ -453,6 +456,7 @@ struct cpsw_priv {
>  	u8				mac_addr[ETH_ALEN];
>  	bool				rx_pause;
>  	bool				tx_pause;
> +	bool				mqprio_hw;
>  	u32 emac_port;
>  	struct cpsw_common *cpsw;
>  };
> @@ -1577,6 +1581,14 @@ static void cpsw_slave_stop(struct cpsw_slave *slave, struct cpsw_common *cpsw)
>  	soft_reset_slave(slave);
>  }
>  
> +static int cpsw_tc_to_fifo(int tc, int num_tc)
> +{
> +	if (tc == num_tc - 1)
> +		return 0;
> +
> +	return CPSW_FIFO_SHAPERS_NUM - tc;
> +}
> +
>  static int cpsw_ndo_open(struct net_device *ndev)
>  {
>  	struct cpsw_priv *priv = netdev_priv(ndev);
> @@ -2190,6 +2202,75 @@ static int cpsw_ndo_set_tx_maxrate(struct net_device *ndev, int queue, u32 rate)
>  	return ret;
>  }
>  
> +static int cpsw_set_tc(struct net_device *ndev, void *type_data)
> +{

Hi Ivan

Maybe this is not the best of names. What if you add support for
another TC qdisc? So you have another case in the switch statement
below?

Maybe call it cpsw_set_mqprio?

> +static int cpsw_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
> +			     void *type_data)
> +{
> +	switch (type) {
> +	case TC_SETUP_QDISC_MQPRIO:
> +		return cpsw_set_tc(ndev, type_data);
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}

  Andrew
  
