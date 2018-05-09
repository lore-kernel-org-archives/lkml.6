Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965492AbeEIQWZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:22:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47200 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965034AbeEIQWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:22:21 -0400
Subject: Re: [PATCH] ixgbe: fix memory leak on ipsec allocation
To: Colin King <colin.king@canonical.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180509135848.20530-1-colin.king@canonical.com>
From: Shannon Nelson <shannon.nelson@oracle.com>
Organization: Oracle Corporation
Message-ID: <4adefe2d-dcae-f310-18cd-5e3269b8b593@oracle.com>
Date: Wed, 9 May 2018 09:22:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509135848.20530-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8887 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805090153
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/2018 6:58 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The error clean up path kfree's adapter->ipsec and should be
> instead kfree'ing ipsec. Fix this.  Also, the err1 error exit path
> does not need to kfree ipsec because this failure path was for
> the failed allocation of ipsec.
> 
> Detected by CoverityScan, CID#146424 ("Resource Leak")
> 
> Fixes: 63a67fe229ea ("ixgbe: add ipsec offload add and remove SA")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Yep, thanks, good catch.

Acked-by: Shannon Nelson <shannon.nelson@oracle.com>


> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index 41af2b81e960..195c0b65eee2 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -919,8 +919,8 @@ void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
>   	kfree(ipsec->ip_tbl);
>   	kfree(ipsec->rx_tbl);
>   	kfree(ipsec->tx_tbl);
> +	kfree(ipsec);
>   err1:
> -	kfree(adapter->ipsec);
>   	netdev_err(adapter->netdev, "Unable to allocate memory for SA tables");
>   }
>   
> 
