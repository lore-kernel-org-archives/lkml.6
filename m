Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AB8JxZogOJ5Jb9DcPG+8OPC4IEIkEBg0/qFrNsV5rnrRtha1MWxL540C+vAwkgm0akWt8BQzoGD2
ARC-Seal: i=1; a=rsa-sha256; t=1524759240; cv=none;
        d=google.com; s=arc-20160816;
        b=rfgucyakM0rkQZiYgAHphuRciKl+Ga4OSr6XF78uInmJbaIsab+w2nIC1WJrsUSsbH
         ztUKOT0h2l0IXshnDbqy6Ym7PHdKeihdRVhUE2HQl13OD3+p4Jo8JxK4ZTLawxRjQxhH
         5i8gh+CRnneVAAIE9qZGgr3LwB5kqKO2nvLM4DFFnyzuWwBzRPkJmv61tUDDnEu7fhq2
         AYcnST79spwELbDabWaP1ZWLqxhp9XslXgOriNdr/cnecy1voofxywfLsku3+IQZ5APW
         zjQqwDQZzBOYulTyEcjIbvpLwAWykJnIb2R4czBBhdSLqa3/hc4Vm54MrFdiz7yskUDE
         LLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=w6gly+E31e5RoiNzmMfaXIkDqVb6t5zZ7RFJ5EIpR8s=;
        b=LPgztYbC9HyNwdqYXAJ9aX7cwPXlHG4kOHZqaUWD2ebOzBkdMJxmCNgVeC6V5OCJve
         B5uedeweTr9KVjTtF9VswnGoLJR/8q93jYEsWU8bRuRcREYkoFDPkxKWn313k72SiYZ9
         t9k7HPfm/q1P0z/2QwMSgl8vW3yKzVStpHEv9Ib04+1LWINEPsLJDWSWf37yi9THdVFx
         N1KQnVAmmu/2g6I9YrOBm2e65oS8GkcMnYvgIZtdu1VvSn8Wj733uR+dEjMwCLBZ+dNm
         EnmbgNrqp45oYbIaLR6RWVf7UYgXRjYZpEpxOYtxZElvS2f5+XMIut1tsnqY+xoSmttS
         32DQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Thu, 26 Apr 2018 18:13:55 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
	ktkhai@virtuozzo.com, serge@hallyn.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next 1/2 v2] netns: restrict uevents
Message-ID: <20180426161353.GA2014@gmail.com>
References: <20180424204335.12904-1-christian.brauner@ubuntu.com>
 <20180424204335.12904-2-christian.brauner@ubuntu.com>
 <87po2oz0s8.fsf@xmission.com>
 <CAPP7u0WH9w26Y9ai-EQTTeq7Rz_=7u2-=t4nhHmjwh-UAiyqeQ@mail.gmail.com>
 <87wowww6p8.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wowww6p8.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661751720131852?=
X-GMAIL-MSGID: =?utf-8?q?1598825944621203466?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 06:00:35PM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@canonical.com> writes:
> 
> > On Wed, Apr 25, 2018, 00:41 Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> >  Bah. This code is obviously correct and probably wrong.
> >
> >  How do we deliver uevents for network devices that are outside of the
> >  initial user namespace? The kernel still needs to deliver those.
> >
> >  The logic to figure out which network namespace a device needs to be
> >  delivered to is is present in kobj_bcast_filter. That logic will almost
> >  certainly need to be turned inside out. Sign not as easy as I would
> >  have hoped.
> >
> > My first patch that we discussed put additional filtering logic into kobj_bcast_filter for that very reason. But I can move that logic
> > out and come up with a new patch.
> 
> I may have mis-understood.
> 
> I heard and am still hearing additional filtering to reduce the places
> the packet is delievered.
> 
> I am saying something needs to change to increase the number of places
> the packet is delivered.
> 
> For the special class of devices that kobj_bcast_filter would apply to
> those need to be delivered to netowrk namespaces  that are no longer on
> uevent_sock_list.
> 
> So the code fundamentally needs to split into two paths.  Ordinary
> devices that use uevent_sock_list.  Network devices that are just
> delivered in their own network namespace.
> 
> netlink_broadcast_filtered gets to go away completely.

The split *might* make sense but I think you're wrong about removing the
kobj_bcast_filter. The current filter doesn't operate on the uevent
socket in uevent_sock_list itself it rather operates on the sockets in
mc_list. And if socket in mc_list can have a different network namespace
then the uevent_socket itself then your way won't work. That's why my
original patch added additional filtering in there. The way I see it we
need something like:

init_user_ns_broadcast_filtered(uevent_sock_list, kobj_bcast_filter);
user_ns_broadcast_filtered(uevent_sock_list,kobj_bcast_filter);

The question that remains is whether we can rely on the network
namespace information we can gather from the kobject_ns_type_operations
to decide where we want to broadcast that event to. So something *like*:

	ops = kobj_ns_ops(kobj);
	if (!ops && kobj->kset) {
		struct kobject *ksobj = &kobj->kset->kobj;
		if (ksobj->parent != NULL)
			ops = kobj_ns_ops(ksobj->parent);
	}

	if (ops && ops->netlink_ns && kobj->ktype->namespace)
		if (ops->type == KOBJ_NS_TYPE_NET)
			net = kobj->ktype->namespace(kobj);

	if (!net || net->user_ns == &init_user_ns)
		ret = init_user_ns_broadcast(env, action_string, devpath);
	else
		ret = user_ns_broadcast(net->uevent_sock->sk, env,
					action_string, devpath);

Christian

> The logic of figuring out the network namespace though becomes trickier.
> 
> Now it may make sense to have all of that as an additional patch on top
> of this one or perhaps a precursor patch that addresses the problem.  We
> will unfortunately drop those uevents today because their uids are not
> valid.  But they are not delivered anywhere else so to allow them to be
> received we need to fix them.
> 
> Eric
> 
> >
> >  Christian Brauner <christian.brauner@ubuntu.com> writes:
> >  > commit 07e98962fa77 ("kobject: Send hotplug events in all network namespaces")
> >  >
> >  > enabled sending hotplug events into all network namespaces back in 2010.
> >  > Over time the set of uevents that get sent into all network namespaces has
> >  > shrunk a little. We have now reached the point where hotplug events for all
> >  > devices that carry a namespace tag are filtered according to that
> >  > namespace. Specifically, they are filtered whenever the namespace tag of
> >  > the kobject does not match the namespace tag of the netlink socket. One
> >  > example are network devices. Uevents for network devices only show up in
> >  > the network namespaces these devices are moved to or created in.
> >  >
> >  > However, any uevent for a kobject that does not have a namespace tag
> >  > associated with it will not be filtered and we will broadcast it into all
> >  > network namespaces. This behavior stopped making sense when user namespaces
> >  > were introduced.
> >  >
> >  > This patch restricts uevents to the initial user namespace for a couple of
> >  > reasons that have been extensively discusses on the mailing list [1].
> >  > - Thundering herd:
> >  > Broadcasting uevents into all network namespaces introduces significant
> >  > overhead.
> >  > All processes that listen to uevents running in non-initial user
> >  > namespaces will end up responding to uevents that will be meaningless to
> >  > them. Mainly, because non-initial user namespaces cannot easily manage
> >  > devices unless they have a privileged host-process helping them out. This
> >  > means that there will be a thundering herd of activity when there
> >  > shouldn't be any.
> >  > - Uevents from non-root users are already filtered in userspace:
> >  > Uevents are filtered by userspace in a user namespace because the
> >  > received uid != 0. Instead the uid associated with the event will be
> >  > 65534 == "nobody" because the global root uid is not mapped.
> >  > This means we can safely and without introducing regressions modify the
> >  > kernel to not send uevents into all network namespaces whose owning user
> >  > namespace is not the initial user namespace because we know that
> >  > userspace will ignore the message because of the uid anyway. I have
> >  > a) verified that is is true for every udev implementation out there b)
> >  > that this behavior has been present in all udev implementations from the
> >  > very beginning.
> >  > - Removing needless overhead/Increasing performance:
> >  > Currently, the uevent socket for each network namespace is added to the
> >  > global variable uevent_sock_list. The list itself needs to be protected
> >  > by a mutex. So everytime a uevent is generated the mutex is taken on the
> >  > list. The mutex is held *from the creation of the uevent (memory
> >  > allocation, string creation etc. until all uevent sockets have been
> >  > handled*. This is aggravated by the fact that for each uevent socket that
> >  > has listeners the mc_list must be walked as well which means we're
> >  > talking O(n^2) here. Given that a standard Linux workload usually has
> >  > quite a lot of network namespaces and - in the face of containers - a lot
> >  > of user namespaces this quickly becomes a performance problem (see
> >  > "Thundering herd" above). By just recording uevent sockets of network
> >  > namespaces that are owned by the initial user namespace we significantly
> >  > increase performance in this codepath.
> >  > - Injecting uevents:
> >  > There's a valid argument that containers might be interested in receiving
> >  > device events especially if they are delegated to them by a privileged
> >  > userspace process. One prime example are SR-IOV enabled devices that are
> >  > explicitly designed to be handed of to other users such as VMs or
> >  > containers.
> >  > This use-case can now be correctly handled since
> >  > commit 692ec06d7c92 ("netns: send uevent messages"). This commit
> >  > introduced the ability to send uevents from userspace. As such we can let
> >  > a sufficiently privileged (CAP_SYS_ADMIN in the owning user namespace of
> >  > the network namespace of the netlink socket) userspace process make a
> >  > decision what uevents should be sent. This removes the need to blindly
> >  > broadcast uevents into all user namespaces and provides a performant and
> >  > safe solution to this problem.
> >  > - Filtering logic:
> >  > This patch filters by *owning user namespace of the network namespace a
> >  > given task resides in* and not by user namespace of the task per se. This
> >  > means if the user namespace of a given task is unshared but the network
> >  > namespace is kept and is owned by the initial user namespace a listener
> >  > that is opening the uevent socket in that network namespace can still
> >  > listen to uevents.
> >  >
> >  > [1]: https://lkml.org/lkml/2018/4/4/739
> >  > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> >  > ---
> >  > Changelog v1->v2:
> >  > * patch unchanged
> >  > Changelog v0->v1:
> >  > * patch unchanged
> >  > ---
> >  > lib/kobject_uevent.c | 18 ++++++++++++------
> >  > 1 file changed, 12 insertions(+), 6 deletions(-)
> >  >
> >  > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> >  > index 15ea216a67ce..f5f5038787ac 100644
> >  > --- a/lib/kobject_uevent.c
> >  > +++ b/lib/kobject_uevent.c
> >  > @@ -703,9 +703,13 @@ static int uevent_net_init(struct net *net)
> >  > 
> >  > net->uevent_sock = ue_sk;
> >  > 
> >  > - mutex_lock(&uevent_sock_mutex);
> >  > - list_add_tail(&ue_sk->list, &uevent_sock_list);
> >  > - mutex_unlock(&uevent_sock_mutex);
> >  > + /* Restrict uevents to initial user namespace. */
> >  > + if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
> >  > + mutex_lock(&uevent_sock_mutex);
> >  > + list_add_tail(&ue_sk->list, &uevent_sock_list);
> >  > + mutex_unlock(&uevent_sock_mutex);
> >  > + }
> >  > +
> >  > return 0;
> >  > }
> >  > 
> >  > @@ -713,9 +717,11 @@ static void uevent_net_exit(struct net *net)
> >  > {
> >  > struct uevent_sock *ue_sk = net->uevent_sock;
> >  > 
> >  > - mutex_lock(&uevent_sock_mutex);
> >  > - list_del(&ue_sk->list);
> >  > - mutex_unlock(&uevent_sock_mutex);
> >  > + if (sock_net(ue_sk->sk)->user_ns == &init_user_ns) {
> >  > + mutex_lock(&uevent_sock_mutex);
> >  > + list_del(&ue_sk->list);
> >  > + mutex_unlock(&uevent_sock_mutex);
> >  > + }
> >  > 
> >  > netlink_kernel_release(ue_sk->sk);
> >  > kfree(ue_sk);
