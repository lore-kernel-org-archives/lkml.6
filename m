Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5332C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1A0206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbfBROtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:49:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729835AbfBROtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:49:10 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 319E83B4FEC9959CEB04;
        Mon, 18 Feb 2019 22:49:07 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Feb 2019
 22:48:58 +0800
Subject: Re: [PATCH -next] staging: rtl8192e: Remove set but not used
 variables 'broad_addr, stype'
To:     Dan Carpenter <dan.carpenter@oracle.com>
References: <20190218123359.83746-1-yuehaibing@huawei.com>
 <20190218143114.GD17104@kadam>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Himadri Pandya <himadri18.07@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Colin Ian King" <colin.king@canonical.com>,
        <devel@driverdev.osuosl.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <6c44529e-4d40-8bc0-b8b6-75904ef426e1@huawei.com>
Date:   Mon, 18 Feb 2019 22:48:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190218143114.GD17104@kadam>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/18 22:31, Dan Carpenter wrote:
> On Mon, Feb 18, 2019 at 12:33:59PM +0000, YueHaibing wrote:
>> @@ -1747,11 +1747,10 @@ static short _rtl92e_tx(struct net_device *dev, struct sk_buff *skb)
>>  	header = (struct rtllib_hdr_1addr *)(((u8 *)skb->data) + fwinfo_size);
>>  	fc = le16_to_cpu(header->frame_ctl);
>>  	type = WLAN_FC_GET_TYPE(fc);
>> -	stype = WLAN_FC_GET_STYPE(fc);
>>  	pda_addr = header->addr1;
>>  
>>  	if (is_broadcast_ether_addr(pda_addr))
>> -		broad_addr = true;
>> +		;
>>  	else if (is_multicast_ether_addr(pda_addr))
>>  		multi_addr = true;
>>  	else
>>
> 
> This is ugly.  Please do it like this:

Thank you for correct me.

> 
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> index c145b689175c..29b53e2246b4 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> @@ -1729,7 +1729,6 @@ static short _rtl92e_tx(struct net_device *dev, struct sk_buff *skb)
>  	struct tx_desc *pdesc = NULL;
>  	struct rtllib_hdr_1addr *header = NULL;
>  	u16 fc = 0, type = 0, stype = 0;
> -	bool  multi_addr = false, broad_addr = false, uni_addr = false;
>  	u8 *pda_addr = NULL;
>  	int   idx;
>  	u32 fwinfo_size = 0;
> @@ -1751,18 +1750,11 @@ static short _rtl92e_tx(struct net_device *dev, struct sk_buff *skb)
>  	pda_addr = header->addr1;
>  
>  	if (is_broadcast_ether_addr(pda_addr))
> -		broad_addr = true;
> +		priv->stats.txbytesbroadcast += skb->len - fwinfo_size;
>  	else if (is_multicast_ether_addr(pda_addr))
> -		multi_addr = true;
> -	else
> -		uni_addr = true;
> -
> -	if (uni_addr)
> -		priv->stats.txbytesunicast += skb->len - fwinfo_size;
> -	else if (multi_addr)
>  		priv->stats.txbytesmulticast += skb->len - fwinfo_size;
>  	else
> -		priv->stats.txbytesbroadcast += skb->len - fwinfo_size;
> +		priv->stats.txbytesunicast += skb->len - fwinfo_size;
>  
>  	spin_lock_irqsave(&priv->irq_th_lock, flags);
>  	ring = &priv->tx_ring[tcb_desc->queue_index];
> 
> .
> 

