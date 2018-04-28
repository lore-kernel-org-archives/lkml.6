Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AB8JxZrJrxdVSR4RWqw6f15RzSuFfDOcgoXsXAn73dbc0flSa88GyQJja/2SSTHFUWMEHIIOSrAk
ARC-Seal: i=1; a=rsa-sha256; t=1524942607; cv=none;
        d=google.com; s=arc-20160816;
        b=hiz2jJRdAWFAbn5VAKxc1yEqEMOykGMQLQdxD1VzAtoM3Cdd2J5uhPD1TGfTlq/Uv0
         7sd4wgdRF8G/TCmLYgxlhUysTau2/zJmDiGNt4ZH8gqTFUXc82EDaSUv7wFD3FMYCa+z
         vfOSTV499o3Fll2qDS+NbbUBTu6jI0BdDrZMZwB85ZXW7BBnHG9AOVJTvsLO3j5QzRs5
         2DzbGWQSSLewWe6B5RdwGqosvE6J5MeaExyaAQXQCjpwJpDUWWSq2ATpzJ4QhW31x3SU
         C/oGGly2NPlrbkQSScgCab7a/BPZQtX0CpG8HvXsNsyF5Hn9k2WGrWjfH/oqJIvea5FP
         AroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=fo371AXKKp7GqxP3RtDuAM/cqaBQtYWe60cwNyckDhI=;
        b=TMq2ayLKNSmFKTMTeB/DbdDTgHaGTRkQHiBIZWTu7H11NENHocVu5DM4EP/Uj9ALgn
         +A55ZX+7svopz9ycyqqHd1hQluqtPXigflS+kD4LBXOorHauQ0YP6R7tK6YVgL8Dkgx8
         W/kJ3W3q2kAMJcshZUlxflYd1DkfnR6fTyaaI7GTXWcYUNLcLK7zk5qnbO299UhgBm/f
         JvY6JxrA34LRIR7cupDzI3xMot/Lsq+VwHDWHJadzQEGFSO6cFQIBe/vSZKcjDdrpw7/
         zJEsk/PtmeaxaMLbNqoDLG1cpBGNXjlq+R8IcnfLvTSpYuNOOqyb/o5VW9a5yEV53BxH
         6zVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Sat, 28 Apr 2018 21:09:45 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
	ktkhai@virtuozzo.com, serge@hallyn.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next 1/2 v3] uevent: add alloc_uevent_skb() helper
Message-ID: <20180428190944.GA13787@gmail.com>
References: <20180427102306.8617-1-christian.brauner@ubuntu.com>
 <20180427102306.8617-2-christian.brauner@ubuntu.com>
 <878t987gdr.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878t987gdr.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894615374917391?=
X-GMAIL-MSGID: =?utf-8?q?1599018219083010113?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 11:39:44AM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
> > This patch adds alloc_uevent_skb() in preparation for follow up patches.
> >
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >  lib/kobject_uevent.c | 39 ++++++++++++++++++++++++++-------------
> >  1 file changed, 26 insertions(+), 13 deletions(-)
> >
> > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> > index 15ea216a67ce..c3cb110f663b 100644
> > --- a/lib/kobject_uevent.c
> > +++ b/lib/kobject_uevent.c
> > @@ -296,6 +296,31 @@ static void cleanup_uevent_env(struct subprocess_info *info)
> >  }
> >  #endif
> >  
> > +static struct sk_buff *alloc_uevent_skb(struct kobj_uevent_env *env,
> > +					const char *action_string,
> > +					const char *devpath)
> > +{
> > +	struct sk_buff *skb = NULL;
> > +	char *scratch;
> > +	size_t len;
> > +
> > +	/* allocate message with maximum possible size */
> > +	len = strlen(action_string) + strlen(devpath) + 2;
> > +	skb = alloc_skb(len + env->buflen, GFP_KERNEL);
> > +	if (!skb)
> > +		return NULL;
> > +
> > +	/* add header */
> > +	scratch = skb_put(skb, len);
> > +	sprintf(scratch, "%s@%s", action_string, devpath);
> > +
> > +	skb_put_data(skb, env->buf, env->buflen);
> > +
> > +	NETLINK_CB(skb).dst_group = 1;
> 
> nit:
>      We might want to explicitly set NETLINK_CB(skb).portid to 0 and
>      NETLINK_CB(skb).creds.uid to GLOBAL_ROOT_UID and
>      NETLINK_CB(skb).creds.gid to GLOBAL_ROOT_GID here
>      just to make it clear this is happening.
> 
>      It is not a problem because they __alloc_skb memsets to 0 the
>      fields of struct sk_buff that it does not initialize.  And these
>      are the zero values.
> 
>      Still it would be nice to be able to look at the code and quickly
>      see these are the values being set.

Don't really mind adding it. Ok, non-functional changes added to the new
version. But then let's set "portid" too:

	parms = &NETLINK_CB(skb);
	parms->creds.uid = GLOBAL_ROOT_UID;
	parms->creds.gid = GLOBAL_ROOT_GID;
	parms->dst_group = 1;
	parms->portid = 0;

Christian
