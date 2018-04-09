Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AIpwx4/83N01MKodvsoG2wFcf55v+KCqTT2VkS34f0OKY3ByJP74610uEuTVhfZEsXqLnZ56JkJ1
ARC-Seal: i=1; a=rsa-sha256; t=1523288790; cv=none;
        d=google.com; s=arc-20160816;
        b=QhNgEV8imkA+ZHl65Akgr7JTVQ1kypNpBjBBpAX7JqhptTdaCVPHz5BYU0yMhFHeUW
         3+D1ySunbwZQwYzkMmqUj6EgEwSalvAV3Y+JJLgdZYPGqG0CaZ5Mh7hGDNUsa9C8exZQ
         z1cgc+Qaet19lXYpRo9ESdXuGbWizj9jGWy6PBIu7b3C32QX6OLq8KnNVDo8uBkSXdAl
         VkDuzWZibs7DpuHcf1ZZLd07g76pzxuql7NsbKpgOa3NpeyU5/uaCIXUzsfeOEVg+/iw
         7WCtGPLe7saTHIw6vgmJ3RkaQUCqC5+4BtIROlgcU2PFNVtzDMXmMd+P6hkMGt/isyfN
         kBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=XJnRYAArSS/ZPhRNvDncLGUjiKcQn4FGxIw6NV0NAKg=;
        b=ijWCWKMNe4r4K6SxGMoR8xZjeJ1PLkLUJ3dQDYksjqMKk0uibHCUonNlc5BcG9OzzP
         2pXXy1bDko0Bm0fkW7GuHmhHgJayypGnTlMzo6w5f4xhQ6/+RUy1BH7XL93R2dmy3U+y
         rd0bf3qvl5jrMT1HKZdpohV23jbxqpbI4gjVcqTQu/qfrwbCXbTyD78UGRfvDK0Zwnty
         D7SiWDLK8sEfouo69WXrMdGrK5WVFHfs5COK5Lj57lU72Eim3SMS2y9a52kMEwoXH3S4
         86EjTisI3oELrohwFXqyIGqO4MibqmiwZWd7vySrwphPzs6P5GQf/OrlMT2EjRwAkGju
         ppBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Mon, 9 Apr 2018 17:46:28 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, davem@davemloft.net,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
	serge@hallyn.com
Subject: Re: [PATCH net-next] netns: filter uevents correctly
Message-ID: <20180409154627.GA15157@gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1597284066695308687?=
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
> 
> I had a memory of filtering uevent messages and I had a memory
> that the netlink_has_listeners had a per network namespace effect.
> Neither seems true from my inspection of the code tonight.
> 
> If we are not filtering ordinary uevents at least at the user namespace
> level that does seem to be at least a nuisance.
> 
> 
> Christian can you dig a little deeper into this.  I have a feeling that
> there are some real efficiency improvements that we could make to
> kobject_uevent_net_broadcast if nothing else.
> 
> Perhaps you could see where uevents are broadcast by poking
> the sysfs uevent of an existing device, and triggering a retransmit.

@Eric, so I did some intensive testing over the weekend and forget everything I
said before. Uevents are not filtered by the kernel at the moment. This is
currently - apart from network devices - a pure userspace thing. Specifically,
anyone  on the host can listen to all uevents from everywhere. It's neither
filtered by user nor by network namespace. The fact that I used

udevadm --debug monitor

to test my prior hypothesis was what led me to believe that uevents are already
correctly filtered.
Instead, what is actually happening is that every udev implementation out there
is discarding uevents that were send by uids != 0 in the CMSG_DATA.
Specifically,

- legacy standalone udevd:
  https://git.kernel.org/pub/scm/linux/hotplug/udev.git/snapshot/udev-062.tar.gz
- eudevd
  https://github.com/gentoo/eudev/blob/6f630d32bf494a457171b3f99e329592497bf271/src/libudev/libudev-monitor.c#L645
- systemd-udevd
  https://github.com/systemd/systemd/blob/e89ab7f219a399ab719c78cf43c07c0da60bd151/src/libudev/libudev-monitor.c#L656
- ueventd (Android)
  https://android.googlesource.com/platform/system/core.git/+/android-8.1.0_r22/libcutils/uevent.c#81

For all of those I could trace this behavior back to the first released
version. (To be precise, for legacy udevd that eventually became systemd-udevd
I could trace it back to the first version that is still available on
git.kernel.org which is 062. Since eudevd is a fork of systemd-udevd it is
trivially true that it has the same behavior from the beginning.)
Android filters uevents in the same way but removed that check on January 8
2018 for what I think is invalid reasoning. The good news is that this is only
in their master branch. It hasn't even made it into an rc release for Android 8
yet. I filed a bug against Android and offered them a fix if they agree.

In any case, userspace udev is not making use of uevents at all right now since
any uid != 0 events are **explicitly** discarded.
The fact that you receive uevents for

sudo unshare -U --map-root -n
udevadm --debug monitor

is simply explained by the fact that container(0) <=> host(0) at which point
the uid in CMSG_DATA will be 0 in the new user namespace and udev will not
discard it.
The use case for receiving uevents in containers/user namespaces is definitely
there but that's what the uevent injection patch series was for that we merged.
This is a much safer and saner solution.
The fact that all udev implementations filter uevents by uid != 0 very much
seems like a security mechanism in userspace that we probably should provide by
isolating uevents based on user and/or network namespaces.

Christian
