Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeBEXYv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 18:24:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35557 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeBEXYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 18:24:43 -0500
X-Google-Smtp-Source: AH8x224Cqux57f3RQH0WWsedVd1Ln108rIDFZJbOJ7d/6JNsWOAjq5ZWGMwA9cB9bVBeU6Se2rmBog==
Date: Tue, 6 Feb 2018 00:24:39 +0100
From: Christian Brauner <christian.brauner@canonical.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        netdev@vger.kernel.org, stephen@networkplumber.org,
        w.bumiller@proxmox.com, ebiederm@xmission.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, davem@davemloft.net
Subject: Re: [PATCH net 1/1 v2] rtnetlink: require unique netns identifier
Message-ID: <20180205232438.GA8695@gmail.com>
References: <20180205155550.21432-1-christian.brauner@ubuntu.com>
 <20180205155550.21432-2-christian.brauner@ubuntu.com>
 <2eac607b-e847-1b21-b3cb-6a45130138ee@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2eac607b-e847-1b21-b3cb-6a45130138ee@virtuozzo.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 12:47:46AM +0300, Kirill Tkhai wrote:
> On 05.02.2018 18:55, Christian Brauner wrote:
> > Since we've added support for IFLA_IF_NETNSID for RTM_{DEL,GET,SET,NEW}LINK
> > it is possible for userspace to send us requests with three different
> > properties to identify a target network namespace. This affects at least
> > RTM_{NEW,SET}LINK. Each of them could potentially refer to a different
> > network namespace which is confusing. For legacy reasons the kernel will
> > pick the IFLA_NET_NS_PID property first and then look for the
> > IFLA_NET_NS_FD property but there is no reason to extend this type of
> > behavior to network namespace ids. The regression potential is quite
> > minimal since the rtnetlink requests in question either won't allow
> > IFLA_IF_NETNSID requests before 4.16 is out (RTM_{NEW,SET}LINK) or don't
> > support IFLA_NET_NS_{PID,FD} (RTM_{DEL,GET}LINK) in the first place.
> >> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > ChangeLog v1->v2:
> > * return errno when the specified network namespace id is invalid
> > * fill in struct netlink_ext_ack if the network namespace id is invalid
> > * rename rtnl_ensure_unique_netns_attr() to rtnl_ensure_unique_netns() to
> >   indicate that a request without any network namespace identifying attributes
> >   is also considered valid.
> > 
> > ChangeLog v0->v1:
> > * report a descriptive error to userspace via struct netlink_ext_ack
> > * do not fail when multiple properties specifiy the same network namespace
> > ---
> >  net/core/rtnetlink.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> > 
> > diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> > index 56af8e41abfc..c096c4ff9a00 100644
> > --- a/net/core/rtnetlink.c
> > +++ b/net/core/rtnetlink.c
> > @@ -1951,6 +1951,59 @@ static struct net *rtnl_link_get_net_capable(const struct sk_buff *skb,
> >  	return net;
> >  }
> >  
> > +/* Verify that rtnetlink requests supporting network namespace ids
> > + * do not pass additional properties referring to different network
> > + * namespaces.
> > + */
> > +static int rtnl_ensure_unique_netns(const struct sock *sk, struct nlattr *tb[],
> > +				    struct netlink_ext_ack *extack)
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
> > +	/* Caller operates on the current network namespace. */
> > +	if (!tb[IFLA_NET_NS_PID] && !tb[IFLA_NET_NS_FD])
> > +		return 0;
> > +
> > +	unique_net = get_net_ns_by_id(sock_net(sk), nla_get_s32(tb[IFLA_IF_NETNSID]));
> > +	if (!unique_net) {
> > +		NL_SET_ERR_MSG(extack, "invalid network namespace id");
> > +		return ret;
> > +	}
> > +
> > +	if (tb[IFLA_NET_NS_PID]) {
> > +		net = get_net_ns_by_pid(nla_get_u32(tb[IFLA_NET_NS_PID]));
> > +		if (net != unique_net)
> > +			goto on_error;
> > +	}
> > +
> > +	if (tb[IFLA_NET_NS_FD]) {
> > +		net = get_net_ns_by_fd(nla_get_u32(tb[IFLA_NET_NS_FD]));
> > +		if (net != unique_net)
> > +			goto on_error;
> > +	}
> > +
> > +	ret = 0;
> > +
> > +on_error:
> > +	put_net(unique_net);
> > +
> > +	if (net && !IS_ERR(net))
> > +		put_net(net);
> 
> 1)When we have tb[IFLA_NET_NS_PID and tb[IFLA_NET_NS_FD] both set and pointing
> to the same net, this function increments net::count in get_net_ns_by_pid() and
> in get_net_ns_by_fd(), i.e. twice. But only single put_net(net) will be called.
> So, after this function net::count will be incremented by 1, and it never will
> die.

Thanks for spotting this, Kirill.

> 
> 2)The whole approach does not seem good for me. The first reason is it's racy.
> Even if rtnl_ensure_unique_netns() returns 0, this does not guarantees that
> tb[IFLA_IF_NETNSID] and tb[IFLA_NET_NS_PID] will be point the same net later,
> as the pid may die or do setns(). Racy check is worse than no check at all.
> 
> The second reason is after this patch get_net_ns_by_id/get_net_ns_by_pid()/
> get_net_ns_by_fd() will be called twice: the first time is in your check
> and the second time is where they are actually used. This is not good for
> performance.

If this is really a performance problem we can simply fix this by
performing the check when the target network namespace is retrieved in
each request. The intention for doing it in one function at the
beginning of each request was to make it generic and easily
understandable.

> 
> What is the problem people pass several different tb[xxx] in one call? We
> may just describe the order of tb[xxx] in man page and their priorities,
> and ignore the rest after the first not zero tb[xxx] is found, and do that
> in the place, where net from tb[xxx] in actually used. This is the thing
> we already do.
> 
> Comparing to classic Linux interface such as syscalls, it's usual behavior
> for them to ignore one argument, when another is set. Nobody confuses.

>From what I gather from recent discussions I had here using pids and
fds to perform operations on network namespaces in netlink requests is
not the future. Specifically, using pids and fds will not be extended to
existing or future requests that do not already support it.

It also very much smells like a security liability if what you've
outlined above is true: a user sends a request with a pid and the task
dies and the pid gets recycled. Now, we can't easily fix this by simply
ignoring pids and fds from here on since this would likely break a bunch
of userspace programs but we can ensure that if a network namespace
identifier is passed that no other way of retrieving the target network
namespace is passed. Especially with requests that already support pids
and fds. It's either that or reversing the order meaning that if a
network namespace identifier is passed then it should take precedence
over the other identifiers. Furthermore, this would also clearly
indicate that netns ids are the preferred way to perform operations on
network namespaces via netlink requests.

I also do not think that your suggestion of making guarantees in what
order additional netlink properties are evaluated is a good one. I don't
think we want to give userspace the impression that sticking a pid, fd,
and netnsid into the same netlink request is something that we actively
support.

What is certainly a good point is that if pids and fds are as you said
inherently racy then we shouldn't perform the check but do what my
original patch did and simply refuse to combine netns ids with pids
and/or fds.

Thanks for the comments!
Christian
