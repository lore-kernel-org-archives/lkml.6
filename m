Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AIpwx48Gq5hCrNrgX8pEzEwHNxt13qiZo27g68ZbA71qrXKhGQ/vSCJkw6gsdRlCRxyOhc89YUz2
ARC-Seal: i=1; a=rsa-sha256; t=1523473039; cv=none;
        d=google.com; s=arc-20160816;
        b=cjrlpjO0diVchSuXbYE9MNvGVNxJraFCTNLbc8fRsVxV7JpaAqarw5Fq92cUznA1Q+
         iW39orNPEzWSWv7nbDBJel3Ps6Amd+XUn+VcxttQfToqvD9TkhR3Zl4MoGJFg7DJDpPV
         W4p16bwsZBpEi/Pv60Fpox6bSJ7OYfpYk9SC7TpKukgIDdLK/H6OQ97OLKuLWWKBNzHQ
         AtfJupmdrGRBF51GajeMALLxhah1F93hhw2x6xGXlv/feP8EJ8l+paS+gnfYZeENmA2W
         jHgj5/OOcy/dPbMqJmtblJv3cm0u0t1gnj/WldN3MoHTd0MKp0BqmHJnrytwVKdFriqv
         qVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=B9SaUXP3ECVbgB+C/ju/43ncI82OsWJ6d0WxiCT6OzQ=;
        b=qTBaEu86qCS0fzoHFZz92mwDHbKMymIXXz3f3m7B1v5kmzqY3IszNY1I/8iLPQ6PFk
         kXNjBbPxfEU2WI3DsnW5lUTiLDTq7uBXxG9zVlR8XXTjCUv+lKIJpyn2ClsL1VWzJlde
         bzj2+SUSdhq71ud7E9tP4rBZ8+PGacs4XrXHSpAvnomMcu/fpq+MTKljMic2N5VAlpaR
         3585lXhu2Jri7ANpvVlqFDbLm9fBMSK7/Air6TzqZTw5kbjKSSsX4Pr6Z2DWPlIIadWQ
         Y2uAxBkHGhCqA6V7D0e2t3wkNGnARqWTikeHXTKsCKyqKeKGkNgHs2kPrCf3GjGMKGdU
         2PbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Wed, 11 Apr 2018 20:57:16 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, davem@davemloft.net,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
	serge@hallyn.com
Subject: Re: [PATCH net-next] netns: filter uevents correctly
Message-ID: <20180411185715.GA15862@gmail.com>
References: <20180405144130.GB26043@gmail.com>
 <87in953ryi.fsf@xmission.com>
 <20180409154627.GA15157@gmail.com>
 <878t9wx8xw.fsf@xmission.com>
 <20180410143515.GA14186@gmail.com>
 <87in8zumpd.fsf@xmission.com>
 <20180411090907.GA20340@gmail.com>
 <87tvshlms1.fsf@xmission.com>
 <20180411170333.GA4319@gmail.com>
 <87efjllhcx.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87efjllhcx.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596846368169451603?=
X-GMAIL-MSGID: =?utf-8?q?1597477265878781816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 01:37:18PM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@canonical.com> writes:
> 
> > On Wed, Apr 11, 2018 at 11:40:14AM -0500, Eric W. Biederman wrote:
> >> Christian Brauner <christian.brauner@canonical.com> writes:
> >> > Yeah, agreed.
> >> > But I think the patch is not complete. To guarantee that no non-initial
> >> > user namespace actually receives uevents we need to:
> >> > 1. only sent uevents to uevent sockets that are located in network
> >> >    namespaces that are owned by init_user_ns
> >> > 2. filter uevents that are sent to sockets in mc_list that have opened a
> >> >    uevent socket that is owned by init_user_ns *from* a
> >> >    non-init_user_ns
> >> >
> >> > We account for 1. by only recording uevent sockets in the global uevent
> >> > socket list who are owned by init_user_ns.
> >> > But to account for 2. we need to filter by the user namespace who owns
> >> > the socket in mc_list. So in addition to that we also need to slightly
> >> > change the filter logic in kobj_bcast_filter() I think:
> >> >
> >> > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> >> > index 22a2c1a98b8f..064d7d29ace5 100644
> >> > --- a/lib/kobject_uevent.c
> >> > +++ b/lib/kobject_uevent.c
> >> > @@ -251,7 +251,8 @@ static int kobj_bcast_filter(struct sock *dsk, struct sk_buff *skb, void *data)
> >> >  		return sock_ns != ns;
> >> >  	}
> >> >  
> >> > -	return 0;
> >> > + 	/* Check if socket was opened from non-initial user namespace. */
> >> > + 	return sk_user_ns(dsk) != &init_user_ns;
> >> >  }
> >> >  #endif
> >> >  
> >> >
> >> > But correct me if I'm wrong.
> >> 
> >> You are worrying about NETLINK_LISTEN_ALL_NSID sockets.  That has
> >> permissions and an explicit opt-in to receiving packets from multiple
> >> network namespaces.
> >
> > I don't think that's what I'm talking about unless that is somehow the
> > default for NETLINK_KOBJECT_UEVENT sockets. What I'm worried about is
> > doing
> >
> > unshare -U --map-root
> >
> > then opening a NETLINK_KOBJECT_UEVENT socket and starting to listen to
> > uevents. Imho, this should not be possible because I'm in a
> > non-init_user_ns. But currently I'm able to - even with the patch to
> > come - since the uevent socket in the kernel was created when init_net
> > was created and hence is *owned* by the init_user_ns which means it is
> > in the list of uevent sockets. Here's a demo of what I mean:
> >
> > https://asciinema.org/a/175632
> 
> Why do you care about this case?

It's not so much that I care about this case since any workload that
wants to run a separate udevd will have to unshare the network namespace
and the user namespace for it to make complete sense.
What I do care about is that the two of us are absolutely in the clear
about what semantics we are going to expose to userspace and it seems
that we were talking past each other wrt to this "corner case".
For userspace, it needs to be very clear that the intention is to filter
by *owning user namespace of the network namespace a given task resides
in* and not by user namespace of the task per se. This is what this
corner case basically shows, I think.

Christian

> 
> Everyone is allowed to listen to the uevent netlink sockets with or
> without user namespaces.  So there are no permission issues, and
> this is not even a data information leak.
> 
> If you don't want programs in your user namespace to have access you
> will be able to unshare the network namespace.
> 
> Eric
