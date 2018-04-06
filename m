Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AIpwx4/RaYM1XtEZMANoW7cH45fQYZgvAWJOXfZ1E9eoXIVR1SmGqIOuqgtJeD0HTcrKcgpXU63e
ARC-Seal: i=1; a=rsa-sha256; t=1523020028; cv=none;
        d=google.com; s=arc-20160816;
        b=zAVoeJKGvlb/avgS11kTQP6tqZlskKPeLeHnFIxNyk6f7k1PMmyYlKv800c6UsdFHS
         +yPFCv+16VWvGI43mj7w61xqR9eROC0w1g/K7z6d6D/CV9EhwA+pj9fhaMO8IxJJbfW+
         K9mIUexQZlTwtS+c79MGFMEF8pXCKMzIsyo8gwKx8IgUCgJ2DCocoU+ZXPtN+e7YhiIT
         o8+zuR6V106L8Ng3PVpOFNE4vaZQV95x1hYBvPW4P8IBf/FC+qyTFB3VwbxjogYyj/2C
         f6RlEcN6iBvraDTFScgXrSkTE/ohdPiJONttc0SxJ5fjnIpITBs3+F4zPIAEClxLEvxf
         En0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=Itq9PGXU6WRzRO5ik7vRDqaOAflq0vIFgYwMRrnYKtE=;
        b=uKXC4IdYD4BSB7otSfY2fQmN42gWEuRk7gAudTy696bZievSAmLhCqsP1RjpkIpN4o
         o3pq3U3B8hti9OFhagvEPFKzIkuPDYqT8xk/nYqJzdiOwYOMVt1CLdJif/GVBgaaf8I8
         MXwvz42pKfg4BN/RcJiHDVZumwnUjG1PVZLgAP68EgG0w0cxWpwgjyaikdB7sjx16Eec
         ev9S3ldzMRjnvuCmTCGdtNgq2zaRt0hjrrtj/ZGu6HApLI7cKnDseAKtUsMf/Q1S3z8y
         MIyXBNy73zybRENmwKQtAfJfSIKA977fjMTGUWWx1/3oZ9lw1Mdg9T9n4ez3HXMYdrna
         QfWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Fri, 6 Apr 2018 15:07:05 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, davem@davemloft.net,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
	serge@hallyn.com
Subject: Re: [PATCH net-next] netns: filter uevents correctly
Message-ID: <20180406130704.GB9263@gmail.com>
References: <20180404194857.29375-1-christian.brauner@ubuntu.com>
 <442e89b8-e947-6eeb-1bcb-fa28f22a25f0@virtuozzo.com>
 <20180405140709.GA1697@gmail.com>
 <941de2b9-332f-75fc-f8ac-4059a9b5426f@virtuozzo.com>
 <20180405144130.GB26043@gmail.com>
 <87in953ryi.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87in953ryi.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596846368169451603?=
X-GMAIL-MSGID: =?utf-8?q?1597002249792717923?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 10:59:49PM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@canonical.com> writes:
> 
> > On Thu, Apr 05, 2018 at 05:26:59PM +0300, Kirill Tkhai wrote:
> >> On 05.04.2018 17:07, Christian Brauner wrote:
> >> > On Thu, Apr 05, 2018 at 04:01:03PM +0300, Kirill Tkhai wrote:
> >> >> On 04.04.2018 22:48, Christian Brauner wrote:
> >> >>> commit 07e98962fa77 ("kobject: Send hotplug events in all network namespaces")
> >> >>>
> >> >>> enabled sending hotplug events into all network namespaces back in 2010.
> >> >>> Over time the set of uevents that get sent into all network namespaces has
> >> >>> shrunk. We have now reached the point where hotplug events for all devices
> >> >>> that carry a namespace tag are filtered according to that namespace.
> >> >>>
> >> >>> Specifically, they are filtered whenever the namespace tag of the kobject
> >> >>> does not match the namespace tag of the netlink socket. One example are
> >> >>> network devices. Uevents for network devices only show up in the network
> >> >>> namespaces these devices are moved to or created in.
> >> >>>
> >> >>> However, any uevent for a kobject that does not have a namespace tag
> >> >>> associated with it will not be filtered and we will *try* to broadcast it
> >> >>> into all network namespaces.
> >> >>>
> >> >>> The original patchset was written in 2010 before user namespaces were a
> >> >>> thing. With the introduction of user namespaces sending out uevents became
> >> >>> partially isolated as they were filtered by user namespaces:
> >> >>>
> >> >>> net/netlink/af_netlink.c:do_one_broadcast()
> >> >>>
> >> >>> if (!net_eq(sock_net(sk), p->net)) {
> >> >>>         if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
> >> >>>                 return;
> >> >>>
> >> >>>         if (!peernet_has_id(sock_net(sk), p->net))
> >> >>>                 return;
> >> >>>
> >> >>>         if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
> >> >>>                              CAP_NET_BROADCAST))
> >> >>>         j       return;
> >> >>> }
> >> >>>
> >> >>> The file_ns_capable() check will check whether the caller had
> >> >>> CAP_NET_BROADCAST at the time of opening the netlink socket in the user
> >> >>> namespace of interest. This check is fine in general but seems insufficient
> >> >>> to me when paired with uevents. The reason is that devices always belong to
> >> >>> the initial user namespace so uevents for kobjects that do not carry a
> >> >>> namespace tag should never be sent into another user namespace. This has
> >> >>> been the intention all along. But there's one case where this breaks,
> >> >>> namely if a new user namespace is created by root on the host and an
> >> >>> identity mapping is established between root on the host and root in the
> >> >>> new user namespace. Here's a reproducer:
> >> >>>
> >> >>>  sudo unshare -U --map-root
> >> >>>  udevadm monitor -k
> >> >>>  # Now change to initial user namespace and e.g. do
> >> >>>  modprobe kvm
> >> >>>  # or
> >> >>>  rmmod kvm
> >> >>>
> >> >>> will allow the non-initial user namespace to retrieve all uevents from the
> >> >>> host. This seems very anecdotal given that in the general case user
> >> >>> namespaces do not see any uevents and also can't really do anything useful
> >> >>> with them.
> >> >>>
> >> >>> Additionally, it is now possible to send uevents from userspace. As such we
> >> >>> can let a sufficiently privileged (CAP_SYS_ADMIN in the owning user
> >> >>> namespace of the network namespace of the netlink socket) userspace process
> >> >>> make a decision what uevents should be sent.
> >> >>>
> >> >>> This makes me think that we should simply ensure that uevents for kobjects
> >> >>> that do not carry a namespace tag are *always* filtered by user namespace
> >> >>> in kobj_bcast_filter(). Specifically:
> >> >>> - If the owning user namespace of the uevent socket is not init_user_ns the
> >> >>>   event will always be filtered.
> >> >>> - If the network namespace the uevent socket belongs to was created in the
> >> >>>   initial user namespace but was opened from a non-initial user namespace
> >> >>>   the event will be filtered as well.
> >> >>> Put another way, uevents for kobjects not carrying a namespace tag are now
> >> >>> always only sent to the initial user namespace. The regression potential
> >> >>> for this is near to non-existent since user namespaces can't really do
> >> >>> anything with interesting devices.
> >> >>>
> >> >>> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> >> >>> ---
> >> >>>  lib/kobject_uevent.c | 10 +++++++++-
> >> >>>  1 file changed, 9 insertions(+), 1 deletion(-)
> >> >>>
> >> >>> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> >> >>> index 15ea216a67ce..cb98cddb6e3b 100644
> >> >>> --- a/lib/kobject_uevent.c
> >> >>> +++ b/lib/kobject_uevent.c
> >> >>> @@ -251,7 +251,15 @@ static int kobj_bcast_filter(struct sock *dsk, struct sk_buff *skb, void *data)
> >> >>>  		return sock_ns != ns;
> >> >>>  	}
> >> >>>  
> >> >>> -	return 0;
> >> >>> +	/*
> >> >>> +	 * The kobject does not carry a namespace tag so filter by user
> >> >>> +	 * namespace below.
> >> >>> +	 */
> >> >>> +	if (sock_net(dsk)->user_ns != &init_user_ns)
> >> >>> +		return 1;
> >> >>> +
> >> >>> +	/* Check if socket was opened from non-initial user namespace. */
> >> >>> +	return sk_user_ns(dsk) != &init_user_ns;
> >> >>>  }
> >> >>>  #endif
> >> >>
> >> >> So, this prohibits to listen events of all devices except network-related
> >> >> in containers? If it's so, I don't think it's a good solution. Uevents is not
> >> > 
> >> > No, this is not correct: As it is right now *without my patch* no
> >> > non-initial user namespace is receiving *any uevents* but those
> >> > specifically namespaced such as those for network devices. This patch
> >> > doesn't change that at all. The commit message outlines this in detail
> >> > how this comes about.
> >> > There is only one case where this currently breaks and this is as I
> >> > outlined explicitly in my commit message when you create a new user
> >> > namespace and map container(0) -> host(0). This patch fixes this.
> >> 
> >> Could you please point the place, where non-initial user namespaces are filtered?
> >> I only see the kobj_bcast_filter() logic, and it used to return 0, which means "accepted".
> >> Now it will return 1 sometimes.
> >
> > Oh sure, it's in the commit message though. The callchain is
> > lib/kobject_uevent.c:kobject_uevent_net_broadcast() ->
> > nnet/netlink/af_netlink.c:netlink_broadcast_filtered() ->
> > net/netlink/af_netlink.c:do_one_broadcast():
> >
> > This codepiece will check whether the openened socket holds
> > CAP_NET_BROADCAST in the user namespace of the target network namespace
> > which it won't because we don't have device namespaces and all devices
> > belong to the initial set of namespaces.
> >
> >         if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
> >                              CAP_NET_BROADCAST))
> >         j       return;
> >
> 
> The above that only applies if someone has set NETLINK_F_LISTEN_ALL_NSID
> on their socket and has had someone with the appropriate privileges
> assign a peerrnetid.
> 
> All of which is to say that file_ns_capable is not nearly as applicable
> as it might be, and if you can pass the other two checks I think it is
> pointless (because the peernet attributes are not generated for
> kobj_uevents) but valid to receive events from outside your network
> namespace.
> 
> 
> I might be missing something but I don't see anything excluding network
> namespaces owned by !init_user_ns excluded from the kobject_uevent
> logic.
> 
> The uevent_sock_list has one entry per network namespace. And
> kobject_uevent_net_broacast appears to walk each one.

Yeah, it definitely does.

> 
> I had a memory of filtering uevent messages and I had a memory
> that the netlink_has_listeners had a per network namespace effect.
> Neither seems true from my inspection of the code tonight.

Yeah, I drew the same conclusion.

> 
> If we are not filtering ordinary uevents at least at the user namespace
> level that does seem to be at least a nuisance.

This patch would filter based on user namespace and bump it from "we're
accidently doing the right thing" to "we're doing the right on purpose"
and without accidently leaking uevents in some corner cases.
Using kobj_bcast_filter() for this seems like the right thing to do.
This sounds like you don't disagree with the approach I'm taking here?

On a sidenote, it also very much feels like we're leaking information if
we're not filtering based on user namespaces on purpose. Non-initial
user namespaces should not be able to receive information about device
attribues simply via netlink uevent messages. At least not *trivially*
[1] by opening a netlink uevent socket.

> 
> 
> Christian can you dig a little deeper into this.  I have a feeling that
> there are some real efficiency improvements that we could make to
> kobject_uevent_net_broadcast if nothing else.

Yeah, for sure! I already started doing this. This patch here is
basically a preparatory patch for that work which is on my todo.

Christian

> 
> Perhaps you could see where uevents are broadcast by poking
> the sysfs uevent of an existing device, and triggering a retransmit.
> 
> Eric
> 
>                                                      
[1]: I mean they technically could very likely still try to gather the
     same info by constantly parsing all of sysfs and try to detect new
     PCI paths/directories and so on but it shouldn't be as easy as
     opening a netlink uevent socket.
