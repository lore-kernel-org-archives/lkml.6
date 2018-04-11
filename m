Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AIpwx48Q0pZfVLvifF7Ey6E5z/ZIErh6+C3avHqNWq/K9R5JYmeWxluO7OWyPGgshmQUz2PU9VZb
ARC-Seal: i=1; a=rsa-sha256; t=1523476665; cv=none;
        d=google.com; s=arc-20160816;
        b=LDAFyXW2qxUOi6KmGvNKsejBjRWGcxbJWH2bbCrUkiTuWcfJYWKwoM41jvn6uHa4MQ
         RRnEhZ1a/E25+UvQUrVIC1vnrYhIrxcrAuc1HljJRB5toJHbBhm1MmOuNdM9tf7aiaVy
         lOKXOmcPq1bqsr7mJGPGDWEoifPkYoFLp7+9MiJgDniZlR03aX6hty/iz6Vc+CDp+0pv
         qv5CAwgOHeE0GWsCTEQrJwPzIZ0gu1EqSXwfhGPbzN+sw4t3U/legSQlonpuCatJwiS/
         ucj3l01RcasScVB7DFjwAx6bS4eRFGbeXEjEoVpY6s8A3N2+CJruZzm0lyEQ/gnO0woX
         WJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=wCXQ1J00+gFoahzZK1D2eRo13l9bTTFwX4G8Mxxp0yo=;
        b=nocaNLqV+fFb6XZfCMv8Rx2k1ImQksaLkRGMxlUSpOliIqgmVbZiSYBOD7Se0h9+MT
         zrlY6F6rrmAdSuDWde/wjO0u3dWV6nsy5oFxLlZRhunO1UF1NvBe/IXx5Wpnj2m8qR3y
         e92lmdFUbgEKVVW3sDRJkZddK5BvehDeoz4qOtUChtweuT+rW8Xr5Jg/qpWm/dx7sG1V
         JK979Da0tyHtLAp67W37mpNKnekvY2euoMhZgkY8aNk86SAe/uKe2K3GGacboQNjxVYE
         qhcAZ9sFZFCH41NFwQj4JOoNFknnyDhR5RuC8sGMu4IJzw05885Zj8qq8zzJGQNkJ/0n
         i+MA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Wed, 11 Apr 2018 21:57:43 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, davem@davemloft.net,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
	serge@hallyn.com
Subject: Re: [PATCH net-next] netns: filter uevents correctly
Message-ID: <20180411195742.GA640@gmail.com>
References: <20180409154627.GA15157@gmail.com>
 <878t9wx8xw.fsf@xmission.com>
 <20180410143515.GA14186@gmail.com>
 <87in8zumpd.fsf@xmission.com>
 <20180411090907.GA20340@gmail.com>
 <87tvshlms1.fsf@xmission.com>
 <20180411170333.GA4319@gmail.com>
 <87efjllhcx.fsf@xmission.com>
 <20180411185715.GA15862@gmail.com>
 <871sflk0zc.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871sflk0zc.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596846368169451603?=
X-GMAIL-MSGID: =?utf-8?q?1597481068106748445?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 02:16:23PM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@canonical.com> writes:
> 
> > On Wed, Apr 11, 2018 at 01:37:18PM -0500, Eric W. Biederman wrote:
> >> Christian Brauner <christian.brauner@canonical.com> writes:
> >> 
> >> > On Wed, Apr 11, 2018 at 11:40:14AM -0500, Eric W. Biederman wrote:
> >> >> Christian Brauner <christian.brauner@canonical.com> writes:
> >> >> > Yeah, agreed.
> >> >> > But I think the patch is not complete. To guarantee that no non-initial
> >> >> > user namespace actually receives uevents we need to:
> >> >> > 1. only sent uevents to uevent sockets that are located in network
> >> >> >    namespaces that are owned by init_user_ns
> >> >> > 2. filter uevents that are sent to sockets in mc_list that have opened a
> >> >> >    uevent socket that is owned by init_user_ns *from* a
> >> >> >    non-init_user_ns
> >> >> >
> >> >> > We account for 1. by only recording uevent sockets in the global uevent
> >> >> > socket list who are owned by init_user_ns.
> >> >> > But to account for 2. we need to filter by the user namespace who owns
> >> >> > the socket in mc_list. So in addition to that we also need to slightly
> >> >> > change the filter logic in kobj_bcast_filter() I think:
> >> >> >
> >> >> > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> >> >> > index 22a2c1a98b8f..064d7d29ace5 100644
> >> >> > --- a/lib/kobject_uevent.c
> >> >> > +++ b/lib/kobject_uevent.c
> >> >> > @@ -251,7 +251,8 @@ static int kobj_bcast_filter(struct sock *dsk, struct sk_buff *skb, void *data)
> >> >> >  		return sock_ns != ns;
> >> >> >  	}
> >> >> >  
> >> >> > -	return 0;
> >> >> > + 	/* Check if socket was opened from non-initial user namespace. */
> >> >> > + 	return sk_user_ns(dsk) != &init_user_ns;
> >> >> >  }
> >> >> >  #endif
> >> >> >  
> >> >> >
> >> >> > But correct me if I'm wrong.
> >> >> 
> >> >> You are worrying about NETLINK_LISTEN_ALL_NSID sockets.  That has
> >> >> permissions and an explicit opt-in to receiving packets from multiple
> >> >> network namespaces.
> >> >
> >> > I don't think that's what I'm talking about unless that is somehow the
> >> > default for NETLINK_KOBJECT_UEVENT sockets. What I'm worried about is
> >> > doing
> >> >
> >> > unshare -U --map-root
> >> >
> >> > then opening a NETLINK_KOBJECT_UEVENT socket and starting to listen to
> >> > uevents. Imho, this should not be possible because I'm in a
> >> > non-init_user_ns. But currently I'm able to - even with the patch to
> >> > come - since the uevent socket in the kernel was created when init_net
> >> > was created and hence is *owned* by the init_user_ns which means it is
> >> > in the list of uevent sockets. Here's a demo of what I mean:
> >> >
> >> > https://asciinema.org/a/175632
> >> 
> >> Why do you care about this case?
> >
> > It's not so much that I care about this case since any workload that
> > wants to run a separate udevd will have to unshare the network namespace
> > and the user namespace for it to make complete sense.
> > What I do care about is that the two of us are absolutely in the clear
> > about what semantics we are going to expose to userspace and it seems
> > that we were talking past each other wrt to this "corner case".
> > For userspace, it needs to be very clear that the intention is to filter
> > by *owning user namespace of the network namespace a given task resides
> > in* and not by user namespace of the task per se. This is what this
> > corner case basically shows, I think.
> 
> If this is just a clarification of semantics then yes this is a
> productive question.  I almost agree with your definition above.
> 
> I would make the definition very simple.  Uevents will not be broadcast
> via netlink in a network namespace where net->user_ns != &init_user_ns,
> with the exception of uevents for network devices in that network
> namespace.

Well, for the sake of posterity :) I should add that I'd prefer we'd add
what I suggested above:

-	return 0;
+ 	/* Check if socket was opened from non-initial user namespace. */
+ 	return sk_user_ns(dsk) != &init_user_ns;
 }

to slam the door shut once and for all for all non-init_user_ns
namespaces because it *seems* like the cleanest solution: uevents are
owned by init_user_ns; period. Because it is the only user namespace
that can do anything interesting with them *by default*.
But what we have now right now with my upcoming patch is at least
sufficient and safe.

Christian

> 
> The existing filtering by the sending uid and verifying that it is uid 0
> gives a little more room to filter if we want (as udev & friends will
> ignore the uevent), but I don't see the point.
> 
> Eric
