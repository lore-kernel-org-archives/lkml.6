Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754011AbeBGLu4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:50:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40475 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbeBGLuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:50:54 -0500
X-Google-Smtp-Source: AH8x227RAx07COYM/Na7SQ9emk8RzEV+WVfL88jEsqbJ2od9j2UDmj3ScULpnkAldhdMEd5a5mnEhA==
Date: Wed, 7 Feb 2018 12:50:51 +0100
From: Christian Brauner <christian.brauner@canonical.com>
To: Jiri Benc <jbenc@redhat.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        netdev@vger.kernel.org, ktkhai@virtuozzo.com,
        stephen@networkplumber.org, w.bumiller@proxmox.com,
        ebiederm@xmission.com, nicolas.dichtel@6wind.com,
        linux-kernel@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net
Subject: Re: [PATCH net 1/1 v3] rtnetlink: require unique netns identifier
Message-ID: <20180207115050.GA29047@gmail.com>
References: <20180206131902.31937-1-christian.brauner@ubuntu.com>
 <20180206131902.31937-2-christian.brauner@ubuntu.com>
 <20180207121925.5fa1e534@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180207121925.5fa1e534@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 12:19:25PM +0100, Jiri Benc wrote:
> On Tue,  6 Feb 2018 14:19:02 +0100, Christian Brauner wrote:
> > +/* Verify that rtnetlink requests supporting network namespace ids
> > + * do not pass additional properties potentially referring to different
> > + * network namespaces.
> > + */
> > +static int rtnl_ensure_unique_netns(struct nlattr *tb[],
> > +				    struct netlink_ext_ack *extack)
> > +{
> > +	/* Requests without network namespace ids have been able to specify
> > +	 * multiple properties referring to different network namespaces so
> > +	 * don't regress them.
> > +	 */
> > +	if (!tb[IFLA_IF_NETNSID])
> > +		return 0;
> 
> I agree with Eric that we should enforce this also for the existing
> pid/fd attributes.

Yes, I would prefer this too but in the Linux spirit of never regressing
userspace I was afraid that there might already be userspace
applications that stick a pid and an fd at the same time into an
rtnetlink request. If we are ok with potentially breaking them then we
should just go for it. It is definitely the cleaner solution.

> 
> > +
> > +	/* Caller operates on the current network namespace. */
> > +	if (!tb[IFLA_NET_NS_PID] && !tb[IFLA_NET_NS_FD])
> > +		return 0;
> > +
> > +	NL_SET_ERR_MSG(extack, "multiple netns identifying attributes specified");
> > +	return -EINVAL;
> 
> But if we don't reach an agreement on that, this version is the next
> best one. No reason to compare the namespaces whether they're the same,
> a message with more than one such attribute is just invalid.
> 
> > @@ -2649,6 +2675,10 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
> >  	if (err < 0)
> >  		return err;
> >  
> > +	err = rtnl_ensure_unique_netns(tb, extack);
> > +	if (err < 0)
> > +		return err;
> > +
> >  	if (tb[IFLA_IFNAME])
> >  		nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
> >  
> > @@ -3045,6 +3079,10 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
> >  	if (err < 0)
> >  		return err;
> >  
> > +	err = rtnl_ensure_unique_netns(tb, extack);
> > +	if (err < 0)
> > +		return err;
> > +
> >  	if (tb[IFLA_IF_NETNSID]) {
> >  		netnsid = nla_get_s32(tb[IFLA_IF_NETNSID]);
> >  		tgt_net = get_target_net(NETLINK_CB(skb).sk, netnsid);
> 
> dellink and getlink support only netnsid, we should just reject a
> message with pid or fd set.

Thanks for the feedback, I'll adapt the patch with the requested
changes.
