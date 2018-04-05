Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AIpwx48jLrHzxOUd/qrwsQEia52LmHlWvsgqJjjVqqiy7hmlIifWQl0CN9Uy4o9wrCxC+Y5pTkfg
ARC-Seal: i=1; a=rsa-sha256; t=1522892122; cv=none;
        d=google.com; s=arc-20160816;
        b=Tr8R4+WXoFmCcGf3pOmY3VlujpZnO2cjEmLfD5VNZFfZYX7kAgm+t9RYjKRiUduzsD
         m3svx01iEBV0VLHuVYzAifOKtRqdPSDFxQzVMo48WwiyxFcWDNUe6IL7WG1Na2G/hiP5
         LscevGF/TXGWHqxZA+eaFZV7sf5M5hXdGTu/nuGNvrO9t9NEMRTEFf6ZUrbLnD1EXRj1
         YRBc6c2xbeKaPJu2vNdlfPnlf3v3r0h3Erfg3mLrAMoB3nhfPq1LBFDKGVxo4mW5vUq/
         nIFzYVjmrUk/4Syup+IHFVxP50FZPh/ns3lvuUpMhqfnOlyZZV7Q8Lib3GScXhsbjf5J
         Xewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=zzj66VHatLk+ujZCbGMRqwa989zEG0BUPUCoSD8AXKg=;
        b=OKJux9P1svhdBFM2uNqnt3obxVEE0XuhC4ZGpyWVmWdr+60g8EuUAf9L9QHdfCpuoJ
         XD+B5FYiRM0aN3mrXcEQlR8PEluQz80P7ac5WTTVY7aHj7vbBSVZ0E0XpYPYegm6oF3q
         30QJZ2VLwcuNucCG8+rKqa4osiU2m6rPX0QoXZnW2Kvi4G1VIFPTblBunjWWNEojiIdF
         ICn8ro1Q61IOHrkkb7GGC5Rjo2wV+LAVyiAmCAK6Sl7axtVaC5GuVVrgNed9Uh7XxWy6
         iHFRNMJhrVx2iWDPtSgduPiQXOEIR2x507lwv5cS3+nomuRV169vut+radMZcL8dBUc/
         sCmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Thu, 5 Apr 2018 03:35:20 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>, davem@davemloft.net
Cc: Christian Brauner <christian.brauner@canonical.com>,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
	ktkhai@virtuozzo.com, serge@hallyn.com
Subject: Re: [PATCH net] netns: filter uevents correctly
Message-ID: <20180405013519.GA15319@gmail.com>
References: <20180404194857.29375-1-christian.brauner@ubuntu.com>
 <20180404203048.GA21118@gmail.com>
 <871sfuha2d.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871sfuha2d.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596846368169451603?=
X-GMAIL-MSGID: =?utf-8?q?1596868130600527802?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 05:38:02PM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@canonical.com> writes:
> 
> > On Wed, Apr 04, 2018 at 09:48:57PM +0200, Christian Brauner wrote:
> >> commit 07e98962fa77 ("kobject: Send hotplug events in all network namespaces")
> >> 
> >> enabled sending hotplug events into all network namespaces back in 2010.
> >> Over time the set of uevents that get sent into all network namespaces has
> >> shrunk. We have now reached the point where hotplug events for all devices
> >> that carry a namespace tag are filtered according to that namespace.
> >> 
> >> Specifically, they are filtered whenever the namespace tag of the kobject
> >> does not match the namespace tag of the netlink socket. One example are
> >> network devices. Uevents for network devices only show up in the network
> >> namespaces these devices are moved to or created in.
> >> 
> >> However, any uevent for a kobject that does not have a namespace tag
> >> associated with it will not be filtered and we will *try* to broadcast it
> >> into all network namespaces.
> >> 
> >> The original patchset was written in 2010 before user namespaces were a
> >> thing. With the introduction of user namespaces sending out uevents became
> >> partially isolated as they were filtered by user namespaces:
> >> 
> >> net/netlink/af_netlink.c:do_one_broadcast()
> >> 
> >> if (!net_eq(sock_net(sk), p->net)) {
> >>         if (!(nlk->flags & NETLINK_F_LISTEN_ALL_NSID))
> >>                 return;
> >> 
> >>         if (!peernet_has_id(sock_net(sk), p->net))
> >>                 return;
> >> 
> >>         if (!file_ns_capable(sk->sk_socket->file, p->net->user_ns,
> >>                              CAP_NET_BROADCAST))
> >>         j       return;
> >> }
> >> 
> >> The file_ns_capable() check will check whether the caller had
> >> CAP_NET_BROADCAST at the time of opening the netlink socket in the user
> >> namespace of interest. This check is fine in general but seems insufficient
> >> to me when paired with uevents. The reason is that devices always belong to
> >> the initial user namespace so uevents for kobjects that do not carry a
> >> namespace tag should never be sent into another user namespace. This has
> >> been the intention all along. But there's one case where this breaks,
> >> namely if a new user namespace is created by root on the host and an
> >> identity mapping is established between root on the host and root in the
> >> new user namespace. Here's a reproducer:
> >> 
> >>  sudo unshare -U --map-root
> >>  udevadm monitor -k
> >>  # Now change to initial user namespace and e.g. do
> >>  modprobe kvm
> >>  # or
> >>  rmmod kvm
> >> 
> >> will allow the non-initial user namespace to retrieve all uevents from the
> >> host. This seems very anecdotal given that in the general case user
> >> namespaces do not see any uevents and also can't really do anything useful
> >> with them.
> >> 
> >> Additionally, it is now possible to send uevents from userspace. As such we
> >> can let a sufficiently privileged (CAP_SYS_ADMIN in the owning user
> >> namespace of the network namespace of the netlink socket) userspace process
> >> make a decision what uevents should be sent.
> >> 
> >> This makes me think that we should simply ensure that uevents for kobjects
> >> that do not carry a namespace tag are *always* filtered by user namespace
> >> in kobj_bcast_filter(). Specifically:
> >> - If the owning user namespace of the uevent socket is not init_user_ns the
> >>   event will always be filtered.
> >> - If the network namespace the uevent socket belongs to was created in the
> >>   initial user namespace but was opened from a non-initial user namespace
> >>   the event will be filtered as well.
> >> Put another way, uevents for kobjects not carrying a namespace tag are now
> >> always only sent to the initial user namespace. The regression potential
> >> for this is near to non-existent since user namespaces can't really do
> >> anything with interesting devices.
> >> 
> >> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> >
> > That was supposed to be [PATCH net] not [PATCH net-next] which is
> > obviously closed. Sorry about that.
> 
> This does not appear to be a fix.
> This looks like feature work.
> The motivation appears to be that looks wrong let's change it.

Hm, it looked like an oversight an therefore seems like a bug which is
why I thought would be a good candidate for net. Recent patches to the
semantics here just make it more obvious and provide a better argument
to fix it in the current release rather then defer it to the next one.
But I'm happy to leave this for net-next. I don't want to rush things if
this change in semantics is not trivial enough. For the record, I'm
merely fixing/expanding on the current status quo.

David, is it ok to queue this or would you prefer I resend when net-next
reopens?

> 
> So let's please leave this for when net-next opens again so we can
> have time to fully consider a change in semantics.

Sure, if we agree that this is the way to go I'm happy too.
Is your issue just with when we merge it and you disagree from a
technical perspective? That wasn't entirely obvious from your previous
mail. :)

Thanks!
Christian

> 
> Thank you,
> Eric
