Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AB8JxZpyPXy/1ksjxVw5Q9UOe4rBHjmKbEHgF7sNtz5idqQZH6JPloJRyA+dq18k9dw/PLONC18Q
ARC-Seal: i=1; a=rsa-sha256; t=1524942967; cv=none;
        d=google.com; s=arc-20160816;
        b=AuH6SmMsCfJQnkPMfBZVBlHWXOKxQuBICppWfbFHiLEGFaosuDSsPNIXhB9cK1iPwt
         YJ7J7AoyJvbcyuSq5Ag7kW3Y63yauz4uKV6VspJnaYXyUHCB/PHkyk4olJIHy4Egi7k7
         Jb+OrIz0IckJsbG4rAj1WsOZRQ4CEdQJgog7ogauY0UJ0S5Q+b6GoFAQLtAbGaR6iqZ0
         eYnluJ9aqNvIeD3tGvzI0ZOgA7Eeeb7dO3Q6bPgDyGodch/lc+f747iVhxCkCTnz8JE/
         rx8t79FGcEiJ+TdizDS4O/kjpCtegB9X4MZnZRtupn9eD2o8U8p+KWalWgODypvS2Fqi
         Nctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=9r9jzMhr4tRJH7vRwNzRXkZ3hTIPdxlIg8l6tCCWdXM=;
        b=qAmtNSuu9VtmgLhxmSTyVSCqJFp1Gfg8biZm2rakbxv1FfyWT5HzvLykmiM+jWmMy4
         8QCTtvbOJu5UWVm8puMUHm/em/TaMZ6C0spbkg+e5eyT8Zb3TbhiM7UkCQBYY82BsGiW
         IMJCphxk6BV4yAMKx/79cZWnVKy6KjsCpvkg1JMdLgQSmrMdW36CcfLKBNd6OnmFOo75
         p879U9VJpIvO/jejAORQVFC92HHIZnfVUulxA5rEb0npP/f/pcnIqywxi0OLXVc3q3Qr
         ygEUldFWW0nXPL7fujGCayHqnV+Bul9H6yVLjPk7C1ZsROgoIt/qhaGhrGo9xUhnIou0
         OxrA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Sat, 28 Apr 2018 21:13:05 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
	ktkhai@virtuozzo.com, serge@hallyn.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next 2/2 v3] netns: restrict uevents
Message-ID: <20180428191304.GB13787@gmail.com>
References: <20180427102306.8617-1-christian.brauner@ubuntu.com>
 <20180427102306.8617-3-christian.brauner@ubuntu.com>
 <87po2k7gt9.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87po2k7gt9.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894617083131162?=
X-GMAIL-MSGID: =?utf-8?q?1599018597314403747?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 11:30:26AM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> > ---
> >  lib/kobject_uevent.c | 140 ++++++++++++++++++++++++++++++-------------
> >  1 file changed, 99 insertions(+), 41 deletions(-)
> >
> > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> > index c3cb110f663b..d8ce5e6d83af 100644
> > --- a/lib/kobject_uevent.c
> > +++ b/lib/kobject_uevent.c
> >  
> > +static int uevent_net_broadcast_tagged(struct sock *usk,
> > +				       struct kobj_uevent_env *env,
> > +				       const char *action_string,
> > +				       const char *devpath)
> > +{
> > +	struct user_namespace *owning_user_ns = sock_net(usk)->user_ns;
> > +	struct sk_buff *skb = NULL;
> > +	int ret;
> > +
> > +	skb = alloc_uevent_skb(env, action_string, devpath);
> > +	if (!skb)
> > +		return -ENOMEM;
> > +
> > +	/* fix credentials */
> > +	if (owning_user_ns != &init_user_ns) {
> 
> Nit: This test is just a performance optimization as such is not
>       necessary.  That is we can safely unconditionally set the
>       credentials this way.

alloc_uevent_skb() will now set

	parms = &NETLINK_CB(skb);
	parms->creds.uid = GLOBAL_ROOT_UID;
	parms->creds.gid = GLOBAL_ROOT_GID;
	parms->dst_group = 1;
	parms->portid = 0;

explicitly. So repeating that initialization unconditionally here does
not make sense to me. Also, this hits map_uid_down() in user_namespace.c
which is a known-hotpath (Remember the extensive testing we did back for
uidmap limit bumping from 5 to 340.). And even though it might not
matter much in this case there's no need to hit this code. The condition
also make it obvious that only non-initial user namespace uevent sockets
need fixing.

Christian

> 
> > +		struct netlink_skb_parms *parms = &NETLINK_CB(skb);
> > +		kuid_t root_uid;
> > +		kgid_t root_gid;
> > +
> > +		/* fix uid */
> > +		root_uid = make_kuid(owning_user_ns, 0);
> > +		if (!uid_valid(root_uid))
> > +			root_uid = GLOBAL_ROOT_UID;
> > +		parms->creds.uid = root_uid;
> > +
> > +		/* fix gid */
> > +		root_gid = make_kgid(owning_user_ns, 0);
> > +		if (!gid_valid(root_gid))
> > +			root_gid = GLOBAL_ROOT_GID;
> > +		parms->creds.gid = root_gid;
> > +	}
> > +
> > +	ret = netlink_broadcast(usk, skb, 0, 1, GFP_KERNEL);
> > +	/* ENOBUFS should be handled in userspace */
> > +	if (ret == -ENOBUFS || ret == -ESRCH)
> > +		ret = 0;
> > +
> > +	return ret;
> > +}
> > +#endif
