Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753862AbeBGLTf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:19:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753693AbeBGLTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:19:33 -0500
Date: Wed, 7 Feb 2018 12:19:25 +0100
From: Jiri Benc <jbenc@redhat.com>
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: netdev@vger.kernel.org, ktkhai@virtuozzo.com,
        stephen@networkplumber.org, w.bumiller@proxmox.com,
        ebiederm@xmission.com, nicolas.dichtel@6wind.com,
        linux-kernel@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net
Subject: Re: [PATCH net 1/1 v3] rtnetlink: require unique netns identifier
Message-ID: <20180207121925.5fa1e534@redhat.com>
In-Reply-To: <20180206131902.31937-2-christian.brauner@ubuntu.com>
References: <20180206131902.31937-1-christian.brauner@ubuntu.com>
        <20180206131902.31937-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Feb 2018 14:19:02 +0100, Christian Brauner wrote:
> +/* Verify that rtnetlink requests supporting network namespace ids
> + * do not pass additional properties potentially referring to different
> + * network namespaces.
> + */
> +static int rtnl_ensure_unique_netns(struct nlattr *tb[],
> +				    struct netlink_ext_ack *extack)
> +{
> +	/* Requests without network namespace ids have been able to specify
> +	 * multiple properties referring to different network namespaces so
> +	 * don't regress them.
> +	 */
> +	if (!tb[IFLA_IF_NETNSID])
> +		return 0;

I agree with Eric that we should enforce this also for the existing
pid/fd attributes.

> +
> +	/* Caller operates on the current network namespace. */
> +	if (!tb[IFLA_NET_NS_PID] && !tb[IFLA_NET_NS_FD])
> +		return 0;
> +
> +	NL_SET_ERR_MSG(extack, "multiple netns identifying attributes specified");
> +	return -EINVAL;

But if we don't reach an agreement on that, this version is the next
best one. No reason to compare the namespaces whether they're the same,
a message with more than one such attribute is just invalid.

> @@ -2649,6 +2675,10 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	if (err < 0)
>  		return err;
>  
> +	err = rtnl_ensure_unique_netns(tb, extack);
> +	if (err < 0)
> +		return err;
> +
>  	if (tb[IFLA_IFNAME])
>  		nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
>  
> @@ -3045,6 +3079,10 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	if (err < 0)
>  		return err;
>  
> +	err = rtnl_ensure_unique_netns(tb, extack);
> +	if (err < 0)
> +		return err;
> +
>  	if (tb[IFLA_IF_NETNSID]) {
>  		netnsid = nla_get_s32(tb[IFLA_IF_NETNSID]);
>  		tgt_net = get_target_net(NETLINK_CB(skb).sk, netnsid);

dellink and getlink support only netnsid, we should just reject a
message with pid or fd set.

 Jiri
