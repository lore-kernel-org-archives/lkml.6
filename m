Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbeBBX1Y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 18:27:24 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34961 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbeBBX1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 18:27:16 -0500
X-Google-Smtp-Source: AH8x224OPXCrkRUI8xpLs2rJrDeHYtfmiXjRsg09iyZ/GqGUwSbc7uTf1fhj8+xZGZ7bgWEVNnwg9w==
Subject: Re: [RFC net 1/1] rtnetlink: require unique netns identifier
To: Christian Brauner <christian.brauner@ubuntu.com>,
        netdev@vger.kernel.org
Cc: ebiederm@xmission.com, jbenc@redhat.com, nicolas.dichtel@6wind.com,
        linux-kernel@vger.kernel.org
References: <20180202085115.17229-1-christian.brauner@ubuntu.com>
 <20180202085115.17229-2-christian.brauner@ubuntu.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <e65ad155-3888-3691-dd74-acf4d5d852bb@gmail.com>
Date: Fri, 2 Feb 2018 16:27:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180202085115.17229-2-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/18 1:51 AM, Christian Brauner wrote:
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 56af8e41abfc..d0b7ab22eff4 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -1951,6 +1951,18 @@ static struct net *rtnl_link_get_net_capable(const struct sk_buff *skb,
>  	return net;
>  }
>  
> +/* Verify that rtnetlink requests that support network namespace ids do not pass
> + * additional properties that allow to identify a network namespace as they
> + * might conflict.
> + */
> +static int rtnl_ensure_unique_netns_attr(struct nlattr *tb[])
> +{
> +	if (tb[IFLA_IF_NETNSID] && (tb[IFLA_NET_NS_PID] || tb[IFLA_NET_NS_FD]))
> +		return -EINVAL;

The days of just returning EINVAL are over; please plumb extack arg to
this message and add a string describing the problem. There are plenty
of examples in rtnetlink.c

Also, what if those NSID's all point to the same namespace? That should
not fail right?
