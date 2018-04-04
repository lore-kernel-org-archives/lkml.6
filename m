Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AIpwx4+gQVSj+4xAgggh4toMkSXhxQ8yo7rKL8x8FLrPeeTgPLh7SO1VGbZ8+eHO+r7qKF00xMvy
ARC-Seal: i=1; a=rsa-sha256; t=1522873854; cv=none;
        d=google.com; s=arc-20160816;
        b=RL98C57y2FMn5BNVamoUSNqKAvluXuDqN0TxlAvoMjVX2P+9zeiM9ybVRaaYghl4Ey
         1Bd7Jw0FMBvGg8KVIM2EhigNMV1HJLV5v34kTFw9wlv72X3cDGV8diCVhyKVi1qLN5qn
         abnmiPMjJ5mWw1YDBLI+JWSV0Jfm8OFoDnGKBskOrpbhDHPQUNeM0avjoQl+J/yBdZaV
         ETUZDtJixnenrxqaFZHnw9F2gD6gOWJUgITbzaZfFreZCR24Vyn15qJEO46Giouk+pqI
         pQU7yYCicvR79K/cVgXDoentEHJq34X/ROHwWlx8MMWsOYlHKHWP+wa/mnkiXu4wnscy
         6RGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=4GnNlBgR6OfNCBbe73oz+r4FITLhgrfDW70F4NsF01Q=;
        b=qtFaRQXq2OEBrOQiGAMfKlX2FPd1bGANF8wDQh1kHYRZppoIyH0cPVBvupHzZ2gqc1
         lQAFowWV2cHsUS8OLA4OGRRX7ML6xUtUfYk2OIC6UhZtO1+u2S2EFG1vkPxesSEqgr8Z
         4sdwLoYbQPVRBzsoCISkLWnu3lMBXsimDyHx7dc8s6HwJD35Bco/cUlnAljM2zmVinvJ
         A42tYmlY2cHzXp5PKbx3RpA6F59PfG0VLMfhCjqw3W5QkDdVWv40M3eHpgkQYF3Hz4Ll
         UPXgGwPJNsEvTJ6V8VFtcxAnR6NTe37u90b8vTJhByQw2Q36LFDhSmZx7XUnnkb5b7+j
         rEdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Wed, 4 Apr 2018 22:30:49 +0200
To: ebiederm@xmission.com, davem@davemloft.net, gregkh@linuxfoundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: avagin@virtuozzo.com, ktkhai@virtuozzo.com, serge@hallyn.com
Subject: Re: [PATCH net] netns: filter uevents correctly
Message-ID: <20180404203048.GA21118@gmail.com>
References: <20180404194857.29375-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180404194857.29375-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596846368169451603?=
X-GMAIL-MSGID: =?utf-8?q?1596848974946652807?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 09:48:57PM +0200, Christian Brauner wrote:
> commit 07e98962fa77 ("kobject: Send hotplug events in all network namespaces")
> 
> enabled sending hotplug events into all network namespaces back in 2010.
> Over time the set of uevents that get sent into all network namespaces has
> shrunk. We have now reached the point where hotplug events for all devices
> that carry a namespace tag are filtered according to that namespace.
> 
> Specifically, they are filtered whenever the namespace tag of the kobject
> does not match the namespace tag of the netlink socket. One example are
> network devices. Uevents for network devices only show up in the network
> namespaces these devices are moved to or created in.
> 
> However, any uevent for a kobject that does not have a namespace tag
> associated with it will not be filtered and we will *try* to broadcast it
> into all network namespaces.
> 
> The original patchset was written in 2010 before user namespaces were a
> thing. With the introduction of user namespaces sending out uevents became
> partially isolated as they were filtered by user namespaces:
> 
> net/netlink/af_netlink.c:do_one_broadcast()
> 
> if (!net_eq(sock_net(sk), p->net)) {
>         if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
>                 return;
> 
>         if (!peernet_has_id(sock_net(sk), p->net))
>                 return;
> 
>         if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
>                              CAP_NET_BROADCAST))
>         j       return;
> }
> 
> The file_ns_capable() check will check whether the caller had
> CAP_NET_BROADCAST at the time of opening the netlink socket in the user
> namespace of interest. This check is fine in general but seems insufficient
> to me when paired with uevents. The reason is that devices always belong to
> the initial user namespace so uevents for kobjects that do not carry a
> namespace tag should never be sent into another user namespace. This has
> been the intention all along. But there's one case where this breaks,
> namely if a new user namespace is created by root on the host and an
> identity mapping is established between root on the host and root in the
> new user namespace. Here's a reproducer:
> 
>  sudo unshare -U --map-root
>  udevadm monitor -k
>  # Now change to initial user namespace and e.g. do
>  modprobe kvm
>  # or
>  rmmod kvm
> 
> will allow the non-initial user namespace to retrieve all uevents from the
> host. This seems very anecdotal given that in the general case user
> namespaces do not see any uevents and also can't really do anything useful
> with them.
> 
> Additionally, it is now possible to send uevents from userspace. As such we
> can let a sufficiently privileged (CAP_SYS_ADMIN in the owning user
> namespace of the network namespace of the netlink socket) userspace process
> make a decision what uevents should be sent.
> 
> This makes me think that we should simply ensure that uevents for kobjects
> that do not carry a namespace tag are *always* filtered by user namespace
> in kobj_bcast_filter(). Specifically:
> - If the owning user namespace of the uevent socket is not init_user_ns the
>   event will always be filtered.
> - If the network namespace the uevent socket belongs to was created in the
>   initial user namespace but was opened from a non-initial user namespace
>   the event will be filtered as well.
> Put another way, uevents for kobjects not carrying a namespace tag are now
> always only sent to the initial user namespace. The regression potential
> for this is near to non-existent since user namespaces can't really do
> anything with interesting devices.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

That was supposed to be [PATCH net] not [PATCH net-next] which is
obviously closed. Sorry about that.

Christian

> ---
>  lib/kobject_uevent.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 15ea216a67ce..cb98cddb6e3b 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -251,7 +251,15 @@ static int kobj_bcast_filter(struct sock *dsk, struct sk_buff *skb, void *data)
>  		return sock_ns != ns;
>  	}
>  
> -	return 0;
> +	/*
> +	 * The kobject does not carry a namespace tag so filter by user
> +	 * namespace below.
> +	 */
> +	if (sock_net(dsk)->user_ns != &init_user_ns)
> +		return 1;
> +
> +	/* Check if socket was opened from non-initial user namespace. */
> +	return sk_user_ns(dsk) != &init_user_ns;
>  }
>  #endif
>  
> -- 
> 2.15.1
> 
