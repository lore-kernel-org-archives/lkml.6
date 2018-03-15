Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AG47ELuDgnJ+P8Rt0sn3nSeaOHxAMfJA8Emi7x/vrzSbTi92O+sNyYladOGlN0BGVyy6Z5taKBzC
ARC-Seal: i=1; a=rsa-sha256; t=1521157598; cv=none;
        d=google.com; s=arc-20160816;
        b=skgsHx+MbfPb5mxkJZddGcSMXic0kr6HwlbafbIT+VFpYYbLv90cvFqpS0J9So3WMG
         AZm8z1tVTJ6R0xxn/VhruXeamwXG/0CQJu5/7wZKdyAQs6R5wrkyHh0D5AtB2TjoRlTD
         4YIu/JJ0GQOdnL4cuNvrVjL0A1YSyCON4f7dicU8zkyyWol5JomrkM2wzY9LuI6eNkz2
         2TUoGitpHH1hV+KKveU7oux4cxUYrgvbwYxMjgjQQNibdHB0NLnaXhxfHSjK1HtlVtyU
         FnFOrxXgNwFBNjcdKCCVcefniOKRL0fI6znzjGIMWtzjZJL2Bec4Bm9x40TPbIScCRlD
         zJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=H4zlTQ5tiUW5DYOw3lLThRgvyww23bN5KhH4mWgb1UU=;
        b=jBKO3T8QB3gr6JTJRgGhMMPAqFSP6hEQGM9LWhnKDMOuIHwncuxU7F6oEEHforXRA4
         JpKCFPS5BuftDw6xM5LechOzXUQLZcqAUyyOY7F9af1K2e320WIC0DHtmW2GPS/9lkqV
         wSTt0MW6Z2anDbPPzQouB7wzVDf9eNy185aPLXx633mVyrMNMTha9cILr0MDLVNv+Skl
         BKWubSWyaxYyoH7zIHYrvrY9TvvUNOPXQdqQXI6ROCEypGG5p7WN9hZ7LV4SfHqYWo+M
         Cms3C40BoM1B5gNJV9T9Rc8exgMmG/mhhfsMo3mdHjBj6qRAlOhuRNO9HQiDPbJO5nW6
         Hk5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Date: Fri, 16 Mar 2018 00:46:35 +0100
From: Christian Brauner <christian.brauner@canonical.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>, ebiederm@xmission.com,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, serge@hallyn.com,
	avagin@virtuozzo.com
Subject: Re: netns: send uevent messages
Message-ID: <20180315234634.GA520@gmail.com>
References: <20180315001214.19462-1-christian.brauner@ubuntu.com>
 <cff34509-16ff-f12c-cd8c-9bcd91645d58@virtuozzo.com>
 <20180315133920.GA25733@gmail.com>
 <5779f3c6-7432-a3d5-1199-0b28df69ca90@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5779f3c6-7432-a3d5-1199-0b28df69ca90@virtuozzo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594960381230985208?=
X-GMAIL-MSGID: =?utf-8?q?1595049350283047458?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 05:14:13PM +0300, Kirill Tkhai wrote:
> On 15.03.2018 16:39, Christian Brauner wrote:
> > On Thu, Mar 15, 2018 at 12:47:30PM +0300, Kirill Tkhai wrote:
> >> CC Andrey Vagin
> > 
> > Hey Kirill,
> > 
> > Thanks for CCing Andrey.
> > 
> >>
> >> On 15.03.2018 03:12, Christian Brauner wrote:
> >>> This patch adds a receive method to NETLINK_KOBJECT_UEVENT netlink sockets
> >>> to allow sending uevent messages into the network namespace the socket
> >>> belongs to.
> >>>
> >>> Currently non-initial network namespaces are already isolated and don't
> >>> receive uevents. There are a number of cases where it is beneficial for a
> >>> sufficiently privileged userspace process to send a uevent into a network
> >>> namespace.
> >>>
> >>> One such use case would be debugging and fuzzing of a piece of software
> >>> which listens and reacts to uevents. By running a copy of that software
> >>> inside a network namespace, specific uevents could then be presented to it.
> >>> More concretely, this would allow for easy testing of udevd/ueventd.
> >>>
> >>> This will also allow some piece of software to run components inside a
> >>> separate network namespace and then effectively filter what that software
> >>> can receive. Some examples of software that do directly listen to uevents
> >>> and that we have in the past attempted to run inside a network namespace
> >>> are rbd (CEPH client) or the X server.
> >>>
> >>> Implementation:
> >>> The implementation has been kept as simple as possible from the kernel's
> >>> perspective. Specifically, a simple input method uevent_net_rcv() is added
> >>> to NETLINK_KOBJECT_UEVENT sockets which completely reuses existing
> >>> af_netlink infrastructure and does neither add an additional netlink family
> >>> nor requires any user-visible changes.
> >>>
> >>> For example, by using netlink_rcv_skb() we can make use of existing netlink
> >>> infrastructure to report back informative error messages to userspace.
> >>>
> >>> Furthermore, this implementation does not introduce any overhead for
> >>> existing uevent generating codepaths. The struct netns gets a new uevent
> >>> socket member that records the uevent socket associated with that network
> >>> namespace. Since we record the uevent socket for each network namespace in
> >>> struct net we don't have to walk the whole uevent socket list.
> >>> Instead we can directly retrieve the relevant uevent socket and send the
> >>> message. This keeps the codepath very performant without introducing
> >>> needless overhead.
> >>>
> >>> Uevent sequence numbers are kept global. When a uevent message is sent to
> >>> another network namespace the implementation will simply increment the
> >>> global uevent sequence number and append it to the received uevent. This
> >>> has the advantage that the kernel will never need to parse the received
> >>> uevent message to replace any existing uevent sequence numbers. Instead it
> >>> is up to the userspace process to remove any existing uevent sequence
> >>> numbers in case the uevent message to be sent contains any.
> >>>
> >>> Security:
> >>> In order for a caller to send uevent messages to a target network namespace
> >>> the caller must have CAP_SYS_ADMIN in the owning user namespace of the
> >>> target network namespace. Additionally, any received uevent message is
> >>> verified to not exceed size UEVENT_BUFFER_SIZE. This includes the space
> >>> needed to append the uevent sequence number.
> >>>
> >>> Testing:
> >>> This patch has been tested and verified to work with the following udev
> >>> implementations:
> >>> 1. CentOS 6 with udevd version 147
> >>> 2. Debian Sid with systemd-udevd version 237
> >>> 3. Android 7.1.1 with ueventd
> >>>
> >>> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> >>> ---
> >>>  include/net/net_namespace.h |  1 +
> >>>  lib/kobject_uevent.c        | 88 ++++++++++++++++++++++++++++++++++++++++++++-
> >>>  2 files changed, 88 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> >>> index f306b2aa15a4..467bde763a9b 100644
> >>> --- a/include/net/net_namespace.h
> >>> +++ b/include/net/net_namespace.h
> >>> @@ -78,6 +78,7 @@ struct net {
> >>>  
> >>>  	struct sock 		*rtnl;			/* rtnetlink socket */
> >>>  	struct sock		*genl_sock;
> >>> +	struct sock		*uevent_sock;		/* uevent socket */
> >>
> >> Since you add this per-net uevent_sock pointer, currently existing iterations in uevent_net_exit()
> >> become to look confusing. There are:
> >>
> >>         mutex_lock(&uevent_sock_mutex);
> >>         list_for_each_entry(ue_sk, &uevent_sock_list, list) {
> >>                 if (sock_net(ue_sk->sk) == net)
> >>                         goto found;
> >>         }
> >>
> >> Can't we make a small cleanup in lib/kobject_uevent.c after this change
> >> and before the main part of the patch goes?
> > 
> > Hm, not sure. It seems it makes sense to maintain them in a separate
> > list. Looks like this lets us keep the locking simpler. Otherwise we
> > would have to do something like for_each_net() and it seems that this
> > would force us to use rntl_{un}lock().
> 
> I'm about:
> 
> mutex_lock();
> list_del(net->ue_sk->list);
> mutex_unlock();
> kfree();
> 
> Thus we avoid iterations in uevent_net_exit().

Ah right, but I only added struct sock *uevent_sock to struct net, not
struct uevent_sock. Thus there's no list member in there. I mainly only
added struct sock to keep it clean an aligned with the other sock
member. We can revisit this later though.

> 
> >>
> >>>  
> >>>  	struct list_head 	dev_base_head;
> >>>  	struct hlist_head 	*dev_name_head;
> >>> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> >>> index 9fe6ec8fda28..10b2144b9fc3 100644
> >>> --- a/lib/kobject_uevent.c
> >>> +++ b/lib/kobject_uevent.c
> >>> @@ -25,6 +25,7 @@
> >>>  #include <linux/uuid.h>
> >>>  #include <linux/ctype.h>
> >>>  #include <net/sock.h>
> >>> +#include <net/netlink.h>
> >>>  #include <net/net_namespace.h>
> >>>  
> >>>  
> >>> @@ -602,12 +603,94 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
> >>>  EXPORT_SYMBOL_GPL(add_uevent_var);
> >>>  
> >>>  #if defined(CONFIG_NET)
> >>> +static int uevent_net_send(struct sock *usk, struct sk_buff *skb,
> >>> +			   struct netlink_ext_ack *extack)
> >>> +{
> >>> +	int ret;
> >>> +	u64 seqnum;
> >>> +	/* u64 to chars: 2^64 - 1 = 21 chars */
> >>
> >> 18446744073709551615 -- 20 chars (+1 '\0'). Comment makes me think
> >> we forgot +1 in buf declaration.
> > 
> > sizeof("SEQNUM=") will include the '\0' pointer in contrast to
> > strlen("SEQNUM=") so this is correct if I'm not completely mistaken.
> 
> The code is OK, I'm worrying about comment. But I've missed this sizeof().
> So, there is only 1 bytes excess allocated as 0xFFFFFFFFFFFFFFFF=18446744073709551615
> Not so important...
> 
> >>
> >>> +	char buf[sizeof("SEQNUM=") + 21];
> >>> +	struct sk_buff *skbc;
> >>> +
> >>> +	/* bump sequence number */
> >>> +	mutex_lock(&uevent_sock_mutex);
> >>> +	seqnum = ++uevent_seqnum;
> >>> +	mutex_unlock(&uevent_sock_mutex);
> >>
> >> Commit 7b60a18da393 from Andrew Vagin says:
> >>
> >>     uevent: send events in correct order according to seqnum (v3)
> >>     
> >>     The queue handling in the udev daemon assumes that the events are
> >>     ordered.
> >>     
> >>     Before this patch uevent_seqnum is incremented under sequence_lock,
> >>     than an event is send uner uevent_sock_mutex. I want to say that code
> >>     contained a window between incrementing seqnum and sending an event.
> >>     
> >>     This patch locks uevent_sock_mutex before incrementing uevent_seqnum.
> >>     Signed-off-by: Andrew Vagin <avagin@openvz.org>
> >>
> >> After this change the order will be lost. Also the rest of namespaces
> >> will have holes in uevent numbers, as they won't receive a number sent
> >> to specific namespace.
> > 
> > Afaict from looking into udevd when I wrote the patch it only cares
> > about numbers being ordered (which is also what Andrey's patch states)
> > not that they are sequential so holes should be fine. udevd will use
> > the DEVPATH to determine whether the sequence number of the current
> > uevent should be used as "even->delaying_seqnum" number. All that
> > matters is that it is greater than the previous one. About the ordering,
> > if that's an issue then we should simply do what Andrey has been doing
> > for kobject_uevent_env() and extend the lock being held until after we
> > sent out the uevent. Since we're not serving all listeners but only
> > ever one this is also way more lightweight then kobject_uevent_env().
> 
> Yes, extending the lock to netlink_broadcast() should fix the problem.

Yep, send another version of the patch but forgot to CC you, sorry:
https://lkml.org/lkml/2018/3/15/1098

Thanks!
Christian

> 
> >>
> >> It seems we should made uevent_seqnum per-net to solve this problem.
> > 
> > Yes, Eric and I have been discussing this already. The idea was to do
> > this in a follow-up patch to keep this patch as simple as possible. If
> > we agree that it would make sense right away then I will dig out the
> > corresponding patch.
> > It would basically just involve giving each struct net a uevent_seqnum
> > member.
> 
> pernet seqnum may have a sense if we introduce per-net locks to protect it.
> If there is single mutex, it does not matter either they are pernet or not.
> Per-net mutex may be useful only if we have many single-net messages like
> you introduce in this patch, or if we are going to filter net in existing
> kobject_uevent_net_broadcast() (by user_ns?!) in the future.
> 
> Kirill
