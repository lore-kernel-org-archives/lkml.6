Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753260AbeEGUo5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:44:57 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33716 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752918AbeEGUoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:44:55 -0400
X-Google-Smtp-Source: AB8JxZrYw4Q4KNDoA/MKA86xXir+z7+1KOKV7hBooUxCOqay+m0r+ZJg/QoQ8d91lh6LFtSE2kr7qA==
Subject: Re: [ovs-dev] [PATCH] openvswitch: make vport_ops:send()'s return
 type consistent
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org
Cc: dev@openvswitch.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
References: <20180424131953.6474-1-luc.vanoostenryck@gmail.com>
From: Gregory Rose <gvrose8192@gmail.com>
Message-ID: <b1b45047-7730-a6b1-c80c-4443339ac20d@gmail.com>
Date: Mon, 7 May 2018 13:44:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424131953.6474-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/2018 6:19 AM, Luc Van Oostenryck wrote:
> The method struct vport_ops:send() is defined as returning an
> 'netdev_tx_t', which is defined as a typedef for a bitwise type
> and otherwise used for the start_xmit() methods.
> However, most openvswitch drivers use for this method dev_queue_xmit()
> which returns an 'int' and the return value of vport_ops:send() is
> in fact never used.
>
> Make things typewise consistent and use 'int' for vport_ops:send()
> as well for internal_dev_recv() (which is the only proper send method)
> as using 'netdev_tx_t' doesn't offer any advantages and in fact seems,
> if not wrong at least, inadequate.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>   net/openvswitch/vport-internal_dev.c | 6 +++---
>   net/openvswitch/vport.h              | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
> index 3ea55618e..2fd68c2fb 100644
> --- a/net/openvswitch/vport-internal_dev.c
> +++ b/net/openvswitch/vport-internal_dev.c
> @@ -231,7 +231,7 @@ static void internal_dev_destroy(struct vport *vport)
>   	rtnl_unlock();
>   }
>   
> -static netdev_tx_t internal_dev_recv(struct sk_buff *skb)
> +static int internal_dev_recv(struct sk_buff *skb)
>   {
>   	struct net_device *netdev = skb->dev;
>   	struct pcpu_sw_netstats *stats;
> @@ -239,7 +239,7 @@ static netdev_tx_t internal_dev_recv(struct sk_buff *skb)
>   	if (unlikely(!(netdev->flags & IFF_UP))) {
>   		kfree_skb(skb);
>   		netdev->stats.rx_dropped++;
> -		return NETDEV_TX_OK;
> +		return 0;
>   	}
>   
>   	skb_dst_drop(skb);
> @@ -257,7 +257,7 @@ static netdev_tx_t internal_dev_recv(struct sk_buff *skb)
>   	u64_stats_update_end(&stats->syncp);
>   
>   	netif_rx(skb);
> -	return NETDEV_TX_OK;
> +	return 0;
>   }
>   
>   static struct vport_ops ovs_internal_vport_ops = {
> diff --git a/net/openvswitch/vport.h b/net/openvswitch/vport.h
> index cda66c26a..8dcb48fe8 100644
> --- a/net/openvswitch/vport.h
> +++ b/net/openvswitch/vport.h
> @@ -141,7 +141,7 @@ struct vport_ops {
>   	int (*set_options)(struct vport *, struct nlattr *);
>   	int (*get_options)(const struct vport *, struct sk_buff *);
>   
> -	netdev_tx_t (*send) (struct sk_buff *skb);
> +	int (*send) (struct sk_buff *skb);
>   	struct module *owner;
>   	struct list_head list;
>   };

Yes, it does seem odd to use a tx return type for receive.  Nice fixup.

Reviewed-by: Greg Rose <gvrose8192@gmail.com>
