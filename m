Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeCVScy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:32:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37980 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeCVScw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:32:52 -0400
Date: Thu, 22 Mar 2018 20:32:26 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Ilan Tayari <ilant@mellanox.com>, Boris Pismenny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Matan Barak <matanb@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5/core/fpga/ipsec: Fix use-after-free
Message-ID: <20180322183225.GA24009@yuvallap>
References: <20180322180342.GA18505@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322180342.GA18505@embeddedgus>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8840 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=9 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=960
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 01:03:42PM -0500, Gustavo A. R. Silva wrote:
> _rule_ is being freed and then dereferenced by accessing rule->ctx
> 
> Fix this by copying the value returned by PTR_ERR(rule->ctx) into a local
> variable for its safe use after freeing _rule_
> 
> Addresses-Coverity-ID: 1466041 ("Read from pointer after free")
> Fixes: 05564d0ae075 ("net/mlx5: Add flow-steering commands for FPGA IPSec implementation")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Prefix should not be that long, a short one as this is enough.

net/mlx5: Fix use-after-free

Besides that - lgtm.

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
> index 4f15685..0f5da49 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
> @@ -1061,8 +1061,9 @@ static int fpga_ipsec_fs_create_fte(struct mlx5_core_dev *dev,
>  
>  	rule->ctx = mlx5_fpga_ipsec_fs_create_sa_ctx(dev, fte, is_egress);
>  	if (IS_ERR(rule->ctx)) {
> +		int err = PTR_ERR(rule->ctx);
>  		kfree(rule);
> -		return PTR_ERR(rule->ctx);
> +		return err;
>  	}
>  
>  	rule->fte = fte;
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
