Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935644AbeEJNiW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 09:38:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36314 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935499AbeEJNiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 09:38:20 -0400
Date: Thu, 10 May 2018 16:38:08 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: davem@davemloft.net, tariqt@mellanox.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net/mlx4_en: Fix an error handling path in
 'mlx4_en_init_netdev()'
Message-ID: <20180510133808.GA10943@lap1>
References: <20180510070226.19575-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510070226.19575-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8888 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=9 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=993
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805100132
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 09:02:26AM +0200, Christophe JAILLET wrote:
> If an error occurs, 'mlx4_en_destroy_netdev()' is called.
> It then calls 'mlx4_en_free_resources()' which does the needed resources
> cleanup.
> 
> So, doing some explicit kfree in the error handling path would lead to
> some double kfree.

Patch make sense but what's bothering me is that mlx4_en_free_resources
loops on the entire array, assuming !priv->tx_ring[t] means entry is
allocated but the existing code does not assume that, see [1]. So i looked
to see where tx_ring array is zeroed and didn't find it.

Am i missing something here.

> 
> Simplify code to avoid such a case.
> 
> Fixes: 67f8b1dcb9ee ("net/mlx4_en: Refactor the XDP forwarding rings scheme")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> index e0adac4a9a19..9670b33fc9b1 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> @@ -3324,12 +3324,11 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
>  					   MAX_TX_RINGS, GFP_KERNEL);
>  		if (!priv->tx_ring[t]) {
>  			err = -ENOMEM;
> -			goto err_free_tx;
> +			goto out;
>  		}
>  		priv->tx_cq[t] = kzalloc(sizeof(struct mlx4_en_cq *) *
>  					 MAX_TX_RINGS, GFP_KERNEL);
>  		if (!priv->tx_cq[t]) {
> -			kfree(priv->tx_ring[t]);
>  			err = -ENOMEM;
>  			goto out;
>  		}
> @@ -3582,11 +3581,6 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
>  
>  	return 0;
>  
> -err_free_tx:
> -	while (t--) {

[1]

> -		kfree(priv->tx_ring[t]);
> -		kfree(priv->tx_cq[t]);
> -	}
>  out:
>  	mlx4_en_destroy_netdev(dev);
>  	return err;
> -- 
> 2.17.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
