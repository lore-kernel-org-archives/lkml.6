Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AIpwx49FLhtCwabXyB85WAaxoxzZxu1T0tY7K2Ug8DFiXMDsaH4ZN1/rDAcWyr3p+v331wAO6QSF
ARC-Seal: i=1; a=rsa-sha256; t=1524610488; cv=none;
        d=google.com; s=arc-20160816;
        b=lRiSxUbsg9/Qn4T5U6rmIwcofLfLKVh5lt7rr7tLyI99Ea0vvbhXJRuQGwcM7ccmpS
         2kIEwkDwgK87wcLw0/fD3TloIvmNzwvmemr16NLNQUx4GU2lxYunjzQgnKhgoIKgSVsf
         pFKQfyIfoeEn2UmsRaVMikXstZEKxamEJc/FH2VmngyEwyPIZJ618Tj0IBcZjR/31iAo
         HYqe/Kn0JXgyvMiQ/NVT6YOTnePklqT75A2OQPwPD6Vwlcs4ER6YUVQDsBf5wzQXMvxB
         DcsrU6q+hgE8kZ8pPFjUSfVXsqrQ620w5pTGaeaObYVDbtITXEJOB2ulWs6DBKRSh2Sx
         VBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=PaeKeEY/YiHjCDWqhpl9rDdf/x1i+w/gjdSNHmabwf4=;
        b=b5rR8qol0ZKIu7YeiKNKte3UUHHuFSTY3nECBHd0YccfROFpONeCllJdcIsyWfxfgw
         UUVI05Kft1mGo5QG8lx7xYLCdrYiLaF9pgg+xNWbXBflOmeva1WbW+4GGNFQD6HWWQFo
         XC2jmCVIcfKrT/vKTyWDcoobimSF4TMgoGaVkjB3b0w6h+XN+Xa7yWA+azvfmfGq/7mf
         ZKHl3zYYQlbKy7+MIf2XGo0AdjvVTYzXRCdWiytwHzofkmASFtRVy7Ps7i6PzVVHYMBY
         okMDzI4IW5+qJ0g/TuO4Ts0qgKWulE5Ls2biC0cyJHMYWUozoPrWV3y5qhFjU/bEtB68
         fEjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Wed, 25 Apr 2018 00:54:46 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
	ktkhai@virtuozzo.com, serge@hallyn.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next 1/2 v2] netns: restrict uevents
Message-ID: <20180424225445.GA30536@gmail.com>
References: <20180424204335.12904-1-christian.brauner@ubuntu.com>
 <20180424204335.12904-2-christian.brauner@ubuntu.com>
 <87po2oz0s8.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87po2oz0s8.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661751720131852?=
X-GMAIL-MSGID: =?utf-8?q?1598669968010496932?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 05:40:07PM -0500, Eric W. Biederman wrote:
> 
> Bah.  This code is obviously correct and probably wrong.
> 
> How do we deliver uevents for network devices that are outside of the
> initial user namespace?  The kernel still needs to deliver those.
> 
> The logic to figure out which network namespace a device needs to be
> delivered to is is present in kobj_bcast_filter.  That logic will almost
> certainly need to be turned inside out.  Sign not as easy as I would
> have hoped.

That's why my initial patch [1] added additional filtering logic to
kobj_bcast_filter(). But since we care about performance improvements as
well I can come up with a patch that moves this logic out of
kobj_bcast_filter().

Christian
[1]: https://www.spinics.net/lists/netdev/msg494487.html

> 
> Eric
> 
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> > commit 07e98962fa77 ("kobject: Send hotplug events in all network namespaces")
> >
> > enabled sending hotplug events into all network namespaces back in 2010.
> > Over time the set of uevents that get sent into all network namespaces has
> > shrunk a little. We have now reached the point where hotplug events for all
> > devices that carry a namespace tag are filtered according to that
> > namespace. Specifically, they are filtered whenever the namespace tag of
> > the kobject does not match the namespace tag of the netlink socket. One
> > example are network devices. Uevents for network devices only show up in
> > the network namespaces these devices are moved to or created in.
> >
> > However, any uevent for a kobject that does not have a namespace tag
> > associated with it will not be filtered and we will broadcast it into all
> > network namespaces. This behavior stopped making sense when user namespaces
> > were introduced.
> >
> > This patch restricts uevents to the initial user namespace for a couple of
> > reasons that have been extensively discusses on the mailing list [1].
> > - Thundering herd:
> >   Broadcasting uevents into all network namespaces introduces significant
> >   overhead.
> >   All processes that listen to uevents running in non-initial user
> >   namespaces will end up responding to uevents that will be meaningless to
> >   them. Mainly, because non-initial user namespaces cannot easily manage
> >   devices unless they have a privileged host-process helping them out. This
> >   means that there will be a thundering herd of activity when there
> >   shouldn't be any.
> > - Uevents from non-root users are already filtered in userspace:
> >   Uevents are filtered by userspace in a user namespace because the
> >   received uid != 0. Instead the uid associated with the event will be
> >   65534 == "nobody" because the global root uid is not mapped.
> >   This means we can safely and without introducing regressions modify the
> >   kernel to not send uevents into all network namespaces whose owning user
> >   namespace is not the initial user namespace because we know that
> >   userspace will ignore the message because of the uid anyway. I have
> >   a) verified that is is true for every udev implementation out there b)
> >   that this behavior has been present in all udev implementations from the
> >   very beginning.
> > - Removing needless overhead/Increasing performance:
> >   Currently, the uevent socket for each network namespace is added to the
> >   global variable uevent_sock_list. The list itself needs to be protected
> >   by a mutex. So everytime a uevent is generated the mutex is taken on the
> >   list. The mutex is held *from the creation of the uevent (memory
> >   allocation, string creation etc. until all uevent sockets have been
> >   handled*. This is aggravated by the fact that for each uevent socket that
> >   has listeners the mc_list must be walked as well which means we're
> >   talking O(n^2) here. Given that a standard Linux workload usually has
> >   quite a lot of network namespaces and - in the face of containers - a lot
> >   of user namespaces this quickly becomes a performance problem (see
> >   "Thundering herd" above). By just recording uevent sockets of network
> >   namespaces that are owned by the initial user namespace we significantly
> >   increase performance in this codepath.
> > - Injecting uevents:
> >   There's a valid argument that containers might be interested in receiving
> >   device events especially if they are delegated to them by a privileged
> >   userspace process. One prime example are SR-IOV enabled devices that are
> >   explicitly designed to be handed of to other users such as VMs or
> >   containers.
> >   This use-case can now be correctly handled since
> >   commit 692ec06d7c92 ("netns: send uevent messages"). This commit
> >   introduced the ability to send uevents from userspace. As such we can let
> >   a sufficiently privileged (CAP_SYS_ADMIN in the owning user namespace of
> >   the network namespace of the netlink socket) userspace process make a
> >   decision what uevents should be sent. This removes the need to blindly
> >   broadcast uevents into all user namespaces and provides a performant and
> >   safe solution to this problem.
> > - Filtering logic:
> >   This patch filters by *owning user namespace of the network namespace a
> >   given task resides in* and not by user namespace of the task per se. This
> >   means if the user namespace of a given task is unshared but the network
> >   namespace is kept and is owned by the initial user namespace a listener
> >   that is opening the uevent socket in that network namespace can still
> >   listen to uevents.
> >
> > [1]: https://lkml.org/lkml/2018/4/4/739
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > Changelog v1->v2:
> > * patch unchanged
> > Changelog v0->v1:
> > * patch unchanged
> > ---
> >  lib/kobject_uevent.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> > index 15ea216a67ce..f5f5038787ac 100644
> > --- a/lib/kobject_uevent.c
> > +++ b/lib/kobject_uevent.c
> > @@ -703,9 +703,13 @@ static int uevent_net_init(struct net *net)
> >  
> >  	net->uevent_sock = ue_sk;
> >  
> > -	mutex_lock(&uevent_sock_mutex);
> > -	list_add_tail(&ue_sk->list, &uevent_sock_list);
> > -	mutex_unlock(&uevent_sock_mutex);
> > +	/* Restrict uevents to initial user namespace. */
> > +	if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
> > +		mutex_lock(&uevent_sock_mutex);
> > +		list_add_tail(&ue_sk->list, &uevent_sock_list);
> > +		mutex_unlock(&uevent_sock_mutex);
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > @@ -713,9 +717,11 @@ static void uevent_net_exit(struct net *net)
> >  {
> >  	struct uevent_sock *ue_sk = net->uevent_sock;
> >  
> > -	mutex_lock(&uevent_sock_mutex);
> > -	list_del(&ue_sk->list);
> > -	mutex_unlock(&uevent_sock_mutex);
> > +	if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
> > +		mutex_lock(&uevent_sock_mutex);
> > +		list_del(&ue_sk->list);
> > +		mutex_unlock(&uevent_sock_mutex);
> > +	}
> >  
> >  	netlink_kernel_release(ue_sk->sk);
> >  	kfree(ue_sk);
