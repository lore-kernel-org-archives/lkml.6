Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AIpwx4+q2sXrPdqIXNoIUsqnYIBbihy5IYZW5VtfbJNBIFrIQCYYnGHMtUct7eMdJ/nU714SK8ow
ARC-Seal: i=1; a=rsa-sha256; t=1522937232; cv=none;
        d=google.com; s=arc-20160816;
        b=xChk8j3lAJjD0dsa1+PJ05tVFiR82YRavUnwDOxWO/FzaZs94NwxrgXSCDtTw6wcnl
         U7TkfCNRzE7s4Wmh2QSn/M9WMQNZt+/8iDozeG6B6Ol7i/marOAS4KoVjvzmOWk6L8cM
         lJq1mD27TZP6hOWc/Wv2R/95Lt7BxuMfln8FInn+pac+XSdhby3i/kWfJ+d2NRh/1Lek
         nEwly1YTVgepvGUhzNXo135t8LnXHhLHgWfOimBqzM5yAEyyikcSxynzu/qRJQwWQm52
         6tUG0aMsNtPiGzhubY8j5JiJ89H/qSU+cvPRHOjuNV4oAANlzycj04w1R8MIf6PU59I1
         s7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=Ha5+F9Bs6hYYPIeEmvtthy+yteduGWjJbFzKyTFTAd8=;
        b=Ssho8U6r2ylNq+DOodQSNC6Ws5Il9iM68EPsh5fIiT44JJaDqBXNKwBL5mRMwH0PIE
         wkgJiczB9H0r1Y/3w577jvGr0s1MUpYB776VKKdNI8W4VmE9wtEWF/L5bJTwTfd2tSjp
         nOc4SQPdy2Ejej2CATypMtFWLu5YnUPNM9MU9mmKunStyyFSEBPZWKQb57K7rghrzHwG
         cz3Q6p+kn0r60B2r0sy8ld2InYN9x/Yksih9DarH0d7i+14DhVtd3taCHPHf3GYFbNAq
         4OCkbWqk+P19qgm26MNEWh6flCCqWMF2WhE78hxrMJYCrrSn3TZcQ8Ymuw+pGdrkQsPc
         13Bg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Thu, 5 Apr 2018 16:07:10 +0200
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: ebiederm@xmission.com, davem@davemloft.net, gregkh@linuxfoundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	avagin@virtuozzo.com, serge@hallyn.com
Subject: Re: [PATCH net-next] netns: filter uevents correctly
Message-ID: <20180405140709.GA1697@gmail.com>
References: <20180404194857.29375-1-christian.brauner@ubuntu.com>
 <442e89b8-e947-6eeb-1bcb-fa28f22a25f0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <442e89b8-e947-6eeb-1bcb-fa28f22a25f0@virtuozzo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596846368169451603?=
X-GMAIL-MSGID: =?utf-8?q?1596915431504587871?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 04:01:03PM +0300, Kirill Tkhai wrote:
> On 04.04.2018 22:48, Christian Brauner wrote:
> > commit 07e98962fa77 ("kobject: Send hotplug events in all network namespaces")
> > 
> > enabled sending hotplug events into all network namespaces back in 2010.
> > Over time the set of uevents that get sent into all network namespaces has
> > shrunk. We have now reached the point where hotplug events for all devices
> > that carry a namespace tag are filtered according to that namespace.
> > 
> > Specifically, they are filtered whenever the namespace tag of the kobject
> > does not match the namespace tag of the netlink socket. One example are
> > network devices. Uevents for network devices only show up in the network
> > namespaces these devices are moved to or created in.
> > 
> > However, any uevent for a kobject that does not have a namespace tag
> > associated with it will not be filtered and we will *try* to broadcast it
> > into all network namespaces.
> > 
> > The original patchset was written in 2010 before user namespaces were a
> > thing. With the introduction of user namespaces sending out uevents became
> > partially isolated as they were filtered by user namespaces:
> > 
> > net/netlink/af_netlink.c:do_one_broadcast()
> > 
> > if (!net_eq(sock_net(sk), p->net)) {
> >         if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
> >                 return;
> > 
> >         if (!peernet_has_id(sock_net(sk), p->net))
> >                 return;
> > 
> >         if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
> >                              CAP_NET_BROADCAST))
> >         j       return;
> > }
> > 
> > The file_ns_capable() check will check whether the caller had
> > CAP_NET_BROADCAST at the time of opening the netlink socket in the user
> > namespace of interest. This check is fine in general but seems insufficient
> > to me when paired with uevents. The reason is that devices always belong to
> > the initial user namespace so uevents for kobjects that do not carry a
> > namespace tag should never be sent into another user namespace. This has
> > been the intention all along. But there's one case where this breaks,
> > namely if a new user namespace is created by root on the host and an
> > identity mapping is established between root on the host and root in the
> > new user namespace. Here's a reproducer:
> > 
> >  sudo unshare -U --map-root
> >  udevadm monitor -k
> >  # Now change to initial user namespace and e.g. do
> >  modprobe kvm
> >  # or
> >  rmmod kvm
> > 
> > will allow the non-initial user namespace to retrieve all uevents from the
> > host. This seems very anecdotal given that in the general case user
> > namespaces do not see any uevents and also can't really do anything useful
> > with them.
> > 
> > Additionally, it is now possible to send uevents from userspace. As such we
> > can let a sufficiently privileged (CAP_SYS_ADMIN in the owning user
> > namespace of the network namespace of the netlink socket) userspace process
> > make a decision what uevents should be sent.
> > 
> > This makes me think that we should simply ensure that uevents for kobjects
> > that do not carry a namespace tag are *always* filtered by user namespace
> > in kobj_bcast_filter(). Specifically:
> > - If the owning user namespace of the uevent socket is not init_user_ns the
> >   event will always be filtered.
> > - If the network namespace the uevent socket belongs to was created in the
> >   initial user namespace but was opened from a non-initial user namespace
> >   the event will be filtered as well.
> > Put another way, uevents for kobjects not carrying a namespace tag are now
> > always only sent to the initial user namespace. The regression potential
> > for this is near to non-existent since user namespaces can't really do
> > anything with interesting devices.
> > 
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >  lib/kobject_uevent.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> > index 15ea216a67ce..cb98cddb6e3b 100644
> > --- a/lib/kobject_uevent.c
> > +++ b/lib/kobject_uevent.c
> > @@ -251,7 +251,15 @@ static int kobj_bcast_filter(struct sock *dsk, struct sk_buff *skb, void *data)
> >  		return sock_ns != ns;
> >  	}
> >  
> > -	return 0;
> > +	/*
> > +	 * The kobject does not carry a namespace tag so filter by user
> > +	 * namespace below.
> > +	 */
> > +	if (sock_net(dsk)->user_ns != &init_user_ns)
> > +		return 1;
> > +
> > +	/* Check if socket was opened from non-initial user namespace. */
> > +	return sk_user_ns(dsk) != &init_user_ns;
> >  }
> >  #endif
> 
> So, this prohibits to listen events of all devices except network-related
> in containers? If it's so, I don't think it's a good solution. Uevents is not

No, this is not correct: As it is right now *without my patch* no
non-initial user namespace is receiving *any uevents* but those
specifically namespaced such as those for network devices. This patch
doesn't change that at all. The commit message outlines this in detail
how this comes about.
There is only one case where this currently breaks and this is as I
outlined explicitly in my commit message when you create a new user
namespace and map container(0) -> host(0). This patch fixes this.

> net-devices-only related interface and it's used for all devices in system.
> People may want to delegate block devices to nested user_ns, for example.

That's fine but that's why I added uevent injection in a previous patch
series: I repeat no non-initial user namespace will by default receive
uevents.

Thanks!
Christian
