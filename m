Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbeBGNg0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:36:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42689 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753643AbeBGNgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:36:24 -0500
X-Google-Smtp-Source: AH8x227I2bNXRUKPTVRqOSbkJhbJU5cMGZeq+YvKmW7aNMxBSDYBWJ8xfz9cKnUBCsxCXEZ9KWBYBw==
Date: Wed, 7 Feb 2018 14:36:21 +0100
From: Christian Brauner <christian.brauner@canonical.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        netdev@vger.kernel.org, stephen@networkplumber.org,
        w.bumiller@proxmox.com, ebiederm@xmission.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, davem@davemloft.net
Subject: Re: [PATCH net 1/1 v4] rtnetlink: require unique netns identifier
Message-ID: <20180207133620.GA3589@gmail.com>
References: <20180207125320.9103-1-christian.brauner@ubuntu.com>
 <20180207125320.9103-2-christian.brauner@ubuntu.com>
 <942f99e9-086d-25dc-e008-8de2c5c721b1@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <942f99e9-086d-25dc-e008-8de2c5c721b1@virtuozzo.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 04:20:01PM +0300, Kirill Tkhai wrote:
> 
> 
> On 07.02.2018 15:53, Christian Brauner wrote:
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
> > 
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > ChangeLog v3->v4:
> > * Based on discussions with Eric and Jiri: disallow passing multiple network
> >   namespace identifying properties for all requests, i.e. always enforce
> >   uniqueness.
> > * disable passing IFLA_NET_NS_{FD,PID} for RTM_{DEL,GET}LINK completely since
> >   they never supported it
> > ChangeLog v2->v3:
> > * Specifying target network namespaces with pids or fds seems racy since the
> >   process might die and the pid get recycled or the process does a setns() in
> >   which case the tests would be invalid. So only check whether multiple
> >   properties are specified and report a helpful error in this case.
> > ChangeLog v1->v2:
> > * return errno when the specified network namespace id is invalid
> > * fill in struct netlink_ext_ack if the network namespace id is invalid
> > * rename rtnl_ensure_unique_netns_attr() to rtnl_ensure_unique_netns() to
> >   indicate that a request without any network namespace identifying attributes
> >   is also considered valid.
> > ChangeLog v0->v1:
> > * report a descriptive error to userspace via struct netlink_ext_ack
> > * do not fail when multiple properties specifiy the same network namespace
> > ---
> >  net/core/rtnetlink.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> > 
> > diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> > index 56af8e41abfc..bc290413a49d 100644
> > --- a/net/core/rtnetlink.c
> > +++ b/net/core/rtnetlink.c
> > @@ -1951,6 +1951,38 @@ static struct net *rtnl_link_get_net_capable(const struct sk_buff *skb,
> >  	return net;
> >  }
> >  
> > +/* Verify that rtnetlink requests do not pass additional properties
> > + * potentially referring to different network namespaces.
> > + */
> > +static int rtnl_ensure_unique_netns(struct nlattr *tb[],
> > +				    struct netlink_ext_ack *extack,
> > +				    bool netns_id_only)
> > +{
> > +
> > +	if (netns_id_only) {
> > +		if (!tb[IFLA_NET_NS_PID] && !tb[IFLA_NET_NS_FD])
> > +			return 0;
> > +
> > +		NL_SET_ERR_MSG(extack, "specified netns attribute not supported");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (tb[IFLA_IF_NETNSID] && (tb[IFLA_NET_NS_PID] || tb[IFLA_NET_NS_FD]))
> > +		goto invalid_attr;
> > +
> > +	if (tb[IFLA_NET_NS_PID] && (tb[IFLA_IF_NETNSID] || tb[IFLA_NET_NS_FD]))
> > +		goto invalid_attr;
> > +
> > +	if (tb[IFLA_NET_NS_FD] && (tb[IFLA_IF_NETNSID] || tb[IFLA_NET_NS_PID]))
> > +		goto invalid_attr;
> 
> Can't we write these 3 above branches more compact? Something like this:
> 
> 	if (!!tb[IFLA_NET_NS_FD] + !!tb[IFLA_IF_NETNSID] + !!tb[IFLA_NET_NS_PID] <= 1)
> 		return 0;

I always prefer for conditions to be separate and readable even if it
means additional code. But if others feel that there's value in avoiding
two additional conditions I'm happy to adapt the patch.

> 
> Also, do we really need two different error values and error messages?

Before I added support for netns ids for additional requests Jiri made
it so that all request that specified properties that they did not
support returned ENOTSUPP instead of EINVAL. This just keeps things
consistent. Users would now suddenly receive EINVAL. That's potentially
confusing.
As for the case of passing multiple netns identifying properties into
the same request EINVAL seems the perfect candidate and the error
message seems instructive to userspace programs.

Thanks!
Christian
