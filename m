Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753194AbeBCTRI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 14:17:08 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33515 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752701AbeBCTRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 14:17:05 -0500
X-Google-Smtp-Source: AH8x227NPkXz8vRHumbvf8vnknekaiscx6TJ1xUCQM8KmL9r5fl65FJMkPoCPjwYsv+n4kPL5eONCA==
Date: Sat, 3 Feb 2018 11:17:01 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: netdev@vger.kernel.org, ebiederm@xmission.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, davem@davemloft.net
Subject: Re: [PATCH net 1/1 v1] rtnetlink: require unique netns identifier
Message-ID: <20180203111701.2ff8d7a3@xeon-e3>
In-Reply-To: <20180203132904.11972-2-christian.brauner@ubuntu.com>
References: <20180203132904.11972-1-christian.brauner@ubuntu.com>
        <20180203132904.11972-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  3 Feb 2018 14:29:04 +0100
Christian Brauner <christian.brauner@ubuntu.com> wrote:

> +static int rtnl_ensure_unique_netns_attr(const struct sock *sk,
> +					 struct nlattr *tb[],
> +					 struct netlink_ext_ack *extack)
> +{
> +	int ret = -EINVAL;
> +	struct net *net = NULL, *unique_net = NULL;
> +
> +	/* Requests without network namespace ids have been able to specify
> +	 * multiple properties referring to different network namespaces so
> +	 * don't regress them.
> +	 */
> +	if (!tb[IFLA_IF_NETNSID])
> +		return 0;
> +
> +	if (!tb[IFLA_NET_NS_PID] && !tb[IFLA_NET_NS_FD])
> +		return 0;

Isn't this an error?

> +
> +	unique_net = get_net_ns_by_id(sock_net(sk), nla_get_s32(tb[IFLA_IF_NETNSID]));
> +	if (!unique_net)
> +		return -1;

Other paths are returning errno, so why -1 here?
