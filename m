Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966078AbeEJOft (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:35:49 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:19011 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965892AbeEJOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:35:47 -0400
X-ME-Helo: [192.168.1.12]
X-ME-Date: Thu, 10 May 2018 16:35:46 +0200
X-ME-IP: 86.244.116.1
Subject: Re: [PATCH] net/mlx4_en: Fix an error handling path in
 'mlx4_en_init_netdev()'
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: davem@davemloft.net, tariqt@mellanox.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Newsgroups: gmane.linux.kernel,gmane.linux.network,gmane.linux.drivers.rdma,gmane.linux.kernel.janitors
References: <20180510070226.19575-1-christophe.jaillet@wanadoo.fr>
 <20180510133808.GA10943@lap1>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <b099afcb-c83b-8a11-4025-2008d56b5ef6@wanadoo.fr>
Date: Thu, 10 May 2018 16:35:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510133808.GA10943@lap1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/05/2018 à 15:38, Yuval Shaia a écrit :
> On Thu, May 10, 2018 at 09:02:26AM +0200, Christophe JAILLET wrote:
>> If an error occurs, 'mlx4_en_destroy_netdev()' is called.
>> It then calls 'mlx4_en_free_resources()' which does the needed resources
>> cleanup.
>>
>> So, doing some explicit kfree in the error handling path would lead to
>> some double kfree.
> Patch make sense but what's bothering me is that mlx4_en_free_resources
> loops on the entire array, assuming !priv->tx_ring[t] means entry is
> allocated but the existing code does not assume that, see [1]. So i looked
> to see where tx_ring array is zeroed and didn't find it.
>
> Am i missing something here.
My understanding is that the array is zeoed at line 3289, when the whole 
priv struct is memset(0)'ed (also done in alloc_etherdev_mqs but leaving 
an explicit memset help to remind that the struct is zeroed)
If speed matters here (and I don't think so), the memset could be saved 
(the mlx4_en_priv struct is quite big after all), but at least a comment 
should remind that it is initialized within alloc_etherdev_mqs.

CJ


>> Simplify code to avoid such a case.
>>
>> Fixes: 67f8b1dcb9ee ("net/mlx4_en: Refactor the XDP forwarding rings scheme")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
>> index e0adac4a9a19..9670b33fc9b1 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
>> +++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
>> @@ -3324,12 +3324,11 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
>>   					   MAX_TX_RINGS, GFP_KERNEL);
>>   		if (!priv->tx_ring[t]) {
>>   			err = -ENOMEM;
>> -			goto err_free_tx;
>> +			goto out;
>>   		}
>>   		priv->tx_cq[t] = kzalloc(sizeof(struct mlx4_en_cq *) *
>>   					 MAX_TX_RINGS, GFP_KERNEL);
>>   		if (!priv->tx_cq[t]) {
>> -			kfree(priv->tx_ring[t]);
>>   			err = -ENOMEM;
>>   			goto out;
>>   		}
>> @@ -3582,11 +3581,6 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
>>   
>>   	return 0;
>>   
>> -err_free_tx:
>> -	while (t--) {
> [1]
>
>> -		kfree(priv->tx_ring[t]);
>> -		kfree(priv->tx_cq[t]);
>> -	}
>>   out:
>>   	mlx4_en_destroy_netdev(dev);
>>   	return err;
>> -- 
>> 2.17.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
