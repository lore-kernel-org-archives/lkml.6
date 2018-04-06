Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeDFLgn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 07:36:43 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.46]:13937 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752262AbeDFLgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 07:36:41 -0400
Subject: Re: [PATCH v2] net: thunderx: rework mac addresses list to u64 array
To: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>,
        sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Cc: dnelson@redhat.com, Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
References: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180406111425.14636-1-Vadim.Lomovtsev@caviumnetworks.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <18c48972-ef34-5b14-f91b-0ceffc286769@embeddedor.com>
Date: Fri, 6 Apr 2018 06:36:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180406111425.14636-1-Vadim.Lomovtsev@caviumnetworks.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f4Pfb-003TSo-QJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.145.54.187]:34818
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vadim,

On 04/06/2018 06:14 AM, Vadim Lomovtsev wrote:
> From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> 
> It is too expensive to pass u64 values via linked list, instead
> allocate array for them by overall number of mac addresses from netdev.
> 
> This eventually removes multiple kmalloc() calls, aviod memory
> fragmentation and allow to put single null check on kmalloc
> return value in order to prevent a potential null pointer dereference.
> 
> Addresses-Coverity-ID: 1467429 ("Dereference null return value")
> Fixes: 37c3347eb247 ("net: thunderx: add ndo_set_rx_mode callback implementation for VF")

It'd be nice if you add:

Reported-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks
--
Gustavo

> Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> ---
> Changes from v1 to v2:
>   - C99 syntax: update xcast_addr_list struct field mc[0] -> mc[];
> 
> ---
>   drivers/net/ethernet/cavium/thunder/nic.h        |  7 +-----
>   drivers/net/ethernet/cavium/thunder/nicvf_main.c | 28 +++++++++---------------
>   2 files changed, 11 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
> index 5fc46c5a4f36..448d1fafc827 100644
> --- a/drivers/net/ethernet/cavium/thunder/nic.h
> +++ b/drivers/net/ethernet/cavium/thunder/nic.h
> @@ -265,14 +265,9 @@ struct nicvf_drv_stats {
>   
>   struct cavium_ptp;
>   
> -struct xcast_addr {
> -	struct list_head list;
> -	u64              addr;
> -};
> -
>   struct xcast_addr_list {
> -	struct list_head list;
>   	int              count;
> +	u64              mc[];
>   };
>   
>   struct nicvf_work {
> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> index 1e9a31fef729..a26d8bc92e01 100644
> --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> @@ -1929,7 +1929,7 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
>   						  work.work);
>   	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
>   	union nic_mbx mbx = {};
> -	struct xcast_addr *xaddr, *next;
> +	u8 idx = 0;
>   
>   	if (!vf_work)
>   		return;
> @@ -1956,16 +1956,10 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
>   	/* check if we have any specific MACs to be added to PF DMAC filter */
>   	if (vf_work->mc) {
>   		/* now go through kernel list of MACs and add them one by one */
> -		list_for_each_entry_safe(xaddr, next,
> -					 &vf_work->mc->list, list) {
> +		for (idx = 0; idx < vf_work->mc->count; idx++) {
>   			mbx.xcast.msg = NIC_MBOX_MSG_ADD_MCAST;
> -			mbx.xcast.data.mac = xaddr->addr;
> +			mbx.xcast.data.mac = vf_work->mc->mc[idx];
>   			nicvf_send_msg_to_pf(nic, &mbx);
> -
> -			/* after receiving ACK from PF release memory */
> -			list_del(&xaddr->list);
> -			kfree(xaddr);
> -			vf_work->mc->count--;
>   		}
>   		kfree(vf_work->mc);
>   	}
> @@ -1996,17 +1990,15 @@ static void nicvf_set_rx_mode(struct net_device *netdev)
>   			mode |= BGX_XCAST_MCAST_FILTER;
>   			/* here we need to copy mc addrs */
>   			if (netdev_mc_count(netdev)) {
> -				struct xcast_addr *xaddr;
> -
> -				mc_list = kmalloc(sizeof(*mc_list), GFP_ATOMIC);
> -				INIT_LIST_HEAD(&mc_list->list);
> +				mc_list = kmalloc(sizeof(*mc_list) +
> +						  sizeof(u64) * netdev_mc_count(netdev),
> +						  GFP_ATOMIC);
> +				if (unlikely(!mc_list))
> +					return;
> +				mc_list->count = 0;
>   				netdev_hw_addr_list_for_each(ha, &netdev->mc) {
> -					xaddr = kmalloc(sizeof(*xaddr),
> -							GFP_ATOMIC);
> -					xaddr->addr =
> +					mc_list->mc[mc_list->count] =
>   						ether_addr_to_u64(ha->addr);
> -					list_add_tail(&xaddr->list,
> -						      &mc_list->list);
>   					mc_list->count++;
>   				}
>   			}
> 
