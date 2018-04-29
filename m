Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AB8JxZowKrY7fTWpcNsFtMPJCrIKILrwU+LiTT1KQA2hoCdHzv1Tyo6hvLwMB/M7x35Hb5bb1TwW
ARC-Seal: i=1; a=rsa-sha256; t=1524996001; cv=none;
        d=google.com; s=arc-20160816;
        b=rOf9qTapyp9XMh9+mJEmeJ3HIaFSnnG9AD0P9vbTIpIkCWlGtWAs1jGmhZtBnYn/JW
         nb9fN00/Y+Wrr2+wpHLCL/iq7A8Pf0ZXRh8QYIYbBaUbPHa9VWP1nCYfLIaeUVk9gWRu
         8Z5QfCyzPfVAPn2Ezg2kICWq8Skvr/Lk0nk1J75E/rFpH7GK0ZFKoClm0D4+OT4CyABJ
         LJ0x6LjOmJXhKOQXG3wEHl6i2ks0Xr7eUz5DTL+R3pdULlG2G/V7Hdx6GbXB1uQYBTN4
         kAvJRKuJD9F8QxPe13sRE5KdEp0g4P/7HxciZaQaRBwfN81AIum42DRCsPsExCrWBLFh
         pBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=LAWdnAEO/ZpMP4WUEnfdgeucHqG69OikG+InKFYKchg=;
        b=acBZHcsxv9+SSeN3BkACNbl66O9m5+yJ8gUKxISKk99jBwGL1ze0mdJiZPChiWL3vJ
         LbAXUbRSJpeeyyhui1SPy6LwIddnX7lDYtYDcWA/vucrkjjVlcOOAtujWtGen4rZBGAr
         nWFqRMWUygfrimdQ8Bqt7GiE/UOm7bxsuAZqYg3Mbma9YpV4rEGJB2a3dS8o2dOaPyyA
         2k6xnzn1k1jFDIkFhiK4mDXy0Xyu8z+KjDjW1j2iIW0ydG8OsPIzkUprRwck4Uqpq1jf
         BUQ39tSKACjkjzUO7VQqobi/rVIhpcKcv6EatDhTZhZ5giiC2SDSUf7y+XGei8XjblBm
         y7lQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Sun, 29 Apr 2018 11:59:58 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, avagin@virtuozzo.com,
	ktkhai@virtuozzo.com, serge@hallyn.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next 2/2 v4] netns: restrict uevents
Message-ID: <20180429095957.GA27296@gmail.com>
References: <20180428192025.2075-1-christian.brauner@ubuntu.com>
 <20180428192025.2075-3-christian.brauner@ubuntu.com>
 <87in8ad4ip.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87in8ad4ip.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599018883940568849?=
X-GMAIL-MSGID: =?utf-8?q?1599074206519468904?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 28, 2018 at 11:23:58PM -0500, Eric W. Biederman wrote:
> 
> > +	/* fix credentials */
> > +	if (owning_user_ns != &init_user_ns) {
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
> 
> One last nit:

Will add non-functional change and make it a v5 in a few.

Thanks!
Christian

> 
> 	You can only make the assignment if the uid is valid.
>         Leaving it GLBOAL_ROOT_UID if the composed uid is invalid.
>         AKA
> 
> 		/* fix uid */
> 		root_uid = make_kuid(owning_user_ns, 0);
> 		if (uid_valid(root_uid))
>                 	parms->creds.uid = root_uid;
> 
>                 /* fix gid */
> 		root_gid = make_kgid(owning_user_ns, 0);
>                 if (gid_valid(root_gid))
>                 	params->creds.gid = root_gid;
> 
> 
> One line shorter and I think a little clearer.  I suspect
> it even results in better code.
> 
> Eric
