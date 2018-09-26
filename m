Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8415FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277712152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277712152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeIZXbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:31:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57300 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbeIZXba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:31:30 -0400
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1AE44144A09DD;
        Wed, 26 Sep 2018 10:17:34 -0700 (PDT)
Date:   Wed, 26 Sep 2018 10:17:33 -0700 (PDT)
Message-Id: <20180926.101733.2070254569725987062.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     f.fainelli@gmail.com, grygorii.strashko@ti.com, w-kwok2@ti.com,
        m-karicheri2@ti.com, lukas@wunner.de, bgolaszewski@baylibre.com,
        ivan.khoronzhuk@linaro.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next] net: ti: fix return type of ndo_start_xmit
 function
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180926090951.25544-1-yuehaibing@huawei.com>
References: <20180926090951.25544-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Sep 2018 10:17:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 26 Sep 2018 17:09:51 +0800

> @@ -1290,7 +1291,7 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  			dev_warn(netcp->ndev_dev, "padding failed (%d), packet dropped\n",
>  				 ret);
>  			tx_stats->tx_dropped++;
> -			return ret;
> +			return NETDEV_TX_BUSY;
>  		}
>  		skb->len = NETCP_MIN_PACKET_SIZE;
>  	}
> @@ -1298,7 +1299,6 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	desc = netcp_tx_map_skb(skb, netcp);
>  	if (unlikely(!desc)) {
>  		netif_stop_subqueue(ndev, subqueue);
> -		ret = -ENOBUFS;
>  		goto drop;
>  	}
>  
> @@ -1319,7 +1319,7 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	if (desc)
>  		netcp_free_tx_desc_chain(netcp, desc, sizeof(*desc));
>  	dev_kfree_skb(skb);
> -	return ret;
> +	return NETDEV_TX_BUSY;
>  }

These conversions are not correct.

If the driver frees the SKB you must not return NETDEV_TX_BUSY.

NETDEV_TX_BUSY tells the caller that the driver could not process the
packet and that it should reqeueu up the SKB and try again later when
there is more TX queue room.
