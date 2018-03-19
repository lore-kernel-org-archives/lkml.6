Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AG47ELtdJtyYyh7P3KdHCD6NETXCHvniXBt/4Gnhx69OPUDc0LEVbl1kGg4uFBJYkAIyQ80YIe6X
ARC-Seal: i=1; a=rsa-sha256; t=1521460784; cv=none;
        d=google.com; s=arc-20160816;
        b=e1KyPeyDgtp4mMxsEgjf9K32gJWfi0E+77u7FljAH3e2nE7zkqJ5xoAZEQkN7zobvD
         yOqo7i1Ha4HrKNqkrEokjeD5fZvj4MwB46tX0uX8xFI0H/btRtBKcKePsnUj5MFsLTw4
         EftDvk7vJXuaRZwJ3L9KPsMjAKS+BQUk8ksPXoLq1QkxbX3xiZmCB41wpKV2BdVJudtc
         iR2puZI8SBuIf7bZiV7CAxSfhqvFFV/QD6myucz4OrJY+jAFKsFBWJBM1jMXtB05/8IN
         YH6U5MGwPPw9jjsl/bXyrlZYzph4Eo1Jpj/eSoAqnsL0aQUJ3eZLcOpru7BKBstgS90y
         If3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=oD6GA6I8QRsyDNCa2GkiNffF71MPc83qO3w3wo5Bad4=;
        b=v9vQbSCfpQDa9vBB8C3WiMg4f4uLj+NUoOVdH+5OomO0UG8DFv+sJprve0+aieN0mo
         ZqoHi00QyMfns6UV5NjgjQTT9q285M43cZpSVfF87utNMsjJQUTuvKwfhUmTAkHFzB35
         X8goO1cYlshOtYNYOMdlEaGVWahhpsJYoqOxoS4cs9+ENfLZPPYthm0TMVrpjY6gfMzb
         kbjHZAU/YhyemScwcNEmutiFJcPiVh7AT6Nf28ckFjHJc2ZEwNdGSlj8uIDSJzFGpQ5j
         +BQ/nN4IB6KgMQpC19NWCqZRAhRwBRsLvLm2fa1CavmuXow6dHI/0N17QliHNOFraHBt
         6Q0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Date: Mon, 19 Mar 2018 12:59:42 +0100
From: Christian Brauner <christian.brauner@canonical.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>, ebiederm@xmission.com,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, serge@hallyn.com,
	avagin@virtuozzo.com
Subject: Re: [PATCH 1/2 v3] net: add uevent socket member
Message-ID: <20180319115941.GA7257@gmail.com>
References: <20180317110826.1581-1-christian.brauner@ubuntu.com>
 <e2f7c92b-e9ba-14fc-3ec4-7da78ca4fa4d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2f7c92b-e9ba-14fc-3ec4-7da78ca4fa4d@virtuozzo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595182847034826440?=
X-GMAIL-MSGID: =?utf-8?q?1595367263376466058?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 02:53:09PM +0300, Kirill Tkhai wrote:
> Thanks for doing this. One small comment below.
> 
> On 17.03.2018 14:08, Christian Brauner wrote:
> > This commit adds struct uevent_sock to struct net. Since struct uevent_sock
> > records the position of the uevent socket in the uevent socket list we can
> > trivially remove it from the uevent socket list during cleanup. This speeds
> > up the old removal codepath.
> > Note, list_del() will hit __list_del_entry_valid() in its call chain which
> > will validate that the element is a member of the list. If it isn't it will
> > take care that the list is not modified.
> > 
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > Changelog v2->v3:
> > * patch added
> >   This patch was split out of the follow up patch
> >   Subject: [PATCH 2/2 v3] netns: send uevent messages
> > 
> > Changelog v1->v2:
> > * patch not present
> > 
> > Changelog v0->v1:
> > * patch not present
> > ---
> >  include/net/net_namespace.h |  4 +++-
> >  lib/kobject_uevent.c        | 19 +++++++++----------
> >  2 files changed, 12 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> > index f306b2aa15a4..abd7d91bffac 100644
> > --- a/include/net/net_namespace.h
> > +++ b/include/net/net_namespace.h
> > @@ -40,7 +40,7 @@ struct net_device;
> >  struct sock;
> >  struct ctl_table_header;
> >  struct net_generic;
> > -struct sock;
> > +struct uevent_sock;
> >  struct netns_ipvs;
> >  
> >  
> > @@ -79,6 +79,8 @@ struct net {
> >  	struct sock 		*rtnl;			/* rtnetlink socket */
> >  	struct sock		*genl_sock;
> >  
> > +	struct uevent_sock	*uevent_sock;		/* uevent socket */
> > +
> >  	struct list_head 	dev_base_head;
> >  	struct hlist_head 	*dev_name_head;
> >  	struct hlist_head	*dev_index_head;
> > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> > index 9fe6ec8fda28..cbdc60542cab 100644
> > --- a/lib/kobject_uevent.c
> > +++ b/lib/kobject_uevent.c
> > @@ -32,11 +32,13 @@ u64 uevent_seqnum;
> >  #ifdef CONFIG_UEVENT_HELPER
> >  char uevent_helper[UEVENT_HELPER_PATH_LEN] = CONFIG_UEVENT_HELPER_PATH;
> >  #endif
> > -#ifdef CONFIG_NET
> > +
> >  struct uevent_sock {
> >  	struct list_head list;
> >  	struct sock *sk;
> >  };
> > +
> > +#ifdef CONFIG_NET
> >  static LIST_HEAD(uevent_sock_list);
> >  #endif
> >  
> > @@ -621,6 +623,9 @@ static int uevent_net_init(struct net *net)
> >  		kfree(ue_sk);
> >  		return -ENODEV;
> >  	}
> > +
> > +	net->uevent_sock = ue_sk;
> > +
> >  	mutex_lock(&uevent_sock_mutex);
> >  	list_add_tail(&ue_sk->list, &uevent_sock_list);
> >  	mutex_unlock(&uevent_sock_mutex);
> > @@ -629,22 +634,16 @@ static int uevent_net_init(struct net *net)
> >  
> >  static void uevent_net_exit(struct net *net)
> >  {
> > -	struct uevent_sock *ue_sk;
> > +	struct uevent_sock *ue_sk = net->uevent_sock;
> >  
> >  	mutex_lock(&uevent_sock_mutex);
> > -	list_for_each_entry(ue_sk, &uevent_sock_list, list) {
> > -		if (sock_net(ue_sk->sk) == net)
> > -			goto found;
> > -	}
> > -	mutex_unlock(&uevent_sock_mutex);
> > -	return;
> > -
> > -found:
> >  	list_del(&ue_sk->list);
> >  	mutex_unlock(&uevent_sock_mutex);
> >  
> >  	netlink_kernel_release(ue_sk->sk);
> >  	kfree(ue_sk);
> > +
> > +	return;
> 
> There is end of function. Doesn't return is excess here?

Yeah, I can remove it and resend it now.

Christian

> 
> >  }
> >  
> >  static struct pernet_operations uevent_net_ops = {
> > 
> 
> Kirill
