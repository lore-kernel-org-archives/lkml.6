Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752931AbeENHjr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:39:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752732AbeENHjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:39:44 -0400
Message-ID: <1526283581.4411.2.camel@redhat.com>
Subject: Re: [PATCH] ipvlan: flush arp table when mac address changed
From: Paolo Abeni <pabeni@redhat.com>
To: liuqifa@huawei.com, davem@davemloft.net, dsahern@gmail.com,
        maheshb@google.com, weiyongjun1@huawei.com, maowenan@huawei.com,
        dingtianhong@huawei.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 14 May 2018 09:39:41 +0200
In-Reply-To: <20180512110037.9116-1-liuqifa@huawei.com>
References: <20180512110037.9116-1-liuqifa@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2018-05-12 at 19:00 +0800, liuqifa@huawei.com wrote:
> From: Keefe Liu <liuqifa@huawei.com>
> 
> When master device's mac has been changed, the
> commit <32c10bbfe914> "ipvlan: always use the current L2
> addr of the master" makes the IPVlan devices's mac changed
> also, but it doesn't flush the IPVlan's arp table.
> 
> Signed-off-by: Keefe Liu <liuqifa@huawei.com>
> ---
>  drivers/net/ipvlan/ipvlan_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
> index 450eec2..a1edfe1 100644
> --- a/drivers/net/ipvlan/ipvlan_main.c
> +++ b/drivers/net/ipvlan/ipvlan_main.c
> @@ -7,6 +7,8 @@
>   *
>   */
>  
> +#include <net/neighbour.h>
> +#include <net/arp.h>
>  #include "ipvlan.h"
>  
>  static unsigned int ipvlan_netid __read_mostly;
> @@ -792,8 +794,10 @@ static int ipvlan_device_event(struct notifier_block *unused,
>  		break;
>  
>  	case NETDEV_CHANGEADDR:
> -		list_for_each_entry(ipvlan, &port->ipvlans, pnode)
> +		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
>  			ether_addr_copy(ipvlan->dev->dev_addr, dev->dev_addr);
> +			neigh_changeaddr(&arp_tbl, ipvlan->dev);
> +		}

Why don't using:

 call_netdevice_notifiers(NETDEV_CHANGEADDR, ipvlan->dev);

instead?

that is what other stacked device - bridge and vlans - are currently
doing in the same scenario.

Thanks,

Paolo
