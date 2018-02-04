Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeBDMLQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 07:11:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34018 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeBDMLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 07:11:10 -0500
X-Google-Smtp-Source: AH8x226nrWUEhJZ8eP2QzBbYm7bB1dJiuD9AakVefxvQAENTsQD7V72WKgvIJhCycfevEPW+WK4yHA==
Date: Sun, 4 Feb 2018 13:11:02 +0100
From: Christian Brauner <christian.brauner@canonical.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        netdev@vger.kernel.org, ebiederm@xmission.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, davem@davemloft.net
Subject: Re: [PATCH net 1/1 v1] rtnetlink: require unique netns identifier
Message-ID: <20180204121100.GA1344@gmail.com>
References: <20180203132904.11972-1-christian.brauner@ubuntu.com>
 <20180203132904.11972-2-christian.brauner@ubuntu.com>
 <20180203111701.2ff8d7a3@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180203111701.2ff8d7a3@xeon-e3>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 11:17:01AM -0800, Stephen Hemminger wrote:
> On Sat,  3 Feb 2018 14:29:04 +0100
> Christian Brauner <christian.brauner@ubuntu.com> wrote:
> 
> > +static int rtnl_ensure_unique_netns_attr(const struct sock *sk,
> > +					 struct nlattr *tb[],
> > +					 struct netlink_ext_ack *extack)
> > +{
> > +	int ret = -EINVAL;
> > +	struct net *net = NULL, *unique_net = NULL;
> > +
> > +	/* Requests without network namespace ids have been able to specify
> > +	 * multiple properties referring to different network namespaces so
> > +	 * don't regress them.
> > +	 */
> > +	if (!tb[IFLA_IF_NETNSID])
> > +		return 0;
> > +
> > +	if (!tb[IFLA_NET_NS_PID] && !tb[IFLA_NET_NS_FD])
> > +		return 0;
> 
> Isn't this an error?

My reasoning was that having no explicit network namespace identifying
attributes the caller operates on the current network namespace which is
uniquely identified.

> 
> > +
> > +	unique_net = get_net_ns_by_id(sock_net(sk), nla_get_s32(tb[IFLA_IF_NETNSID]));
> > +	if (!unique_net)
> > +		return -1;
> 
> Other paths are returning errno, so why -1 here?

Yes, this should be -EINVAL as well.

Thanks!
Christian
