Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AH8x227uKlkVMnDf3pvlTkKj+ija/vIDVLsD7hyfW2hpev5+tP/oZBjs5Q+aWTkVFpjH6EWdGgd9
ARC-Seal: i=1; a=rsa-sha256; t=1518605845; cv=none;
        d=google.com; s=arc-20160816;
        b=KpBOD5fPGf+XQUOucZHLznwjTVI5pZL7p4dbuWh3x3ViSOX7cw52IAaaZkjSZqcHRU
         8ZfzyINgVJQGWfsA9SFRkr/sJHpzs0GZfIlZjxLxLGpsOrKlj//RBeTVzvVPB3bsCz/0
         UnrxHiFXA9Z3h4eR6uYC1VzZaXgcxfdQ/P3HMC6zA+r0On7re2WAZzj2jFI31B+YVF8b
         YCVfyd54/2rXQAv11ZVDZrLJAWV5GacUnqYBTDJvVVgIiY+dHIIqvu2C4a2zX4EdkALw
         dBnBqUB9WkuvfPtgRdlbYitwo1Wsz1eCMYkcZdX9zwmzi2u2w5IApDh7Ucqq1ek0czTl
         /WXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=m9X4LkZpyjeiA23havuWRMI65PE3nKQYWhIGNCG3cnk=;
        b=EesSnbienKzlsBP47oMLv9z5faUgaLqrgCyBYDSGW/hwamx6Jz5eGBcDxxNtQRmHhL
         76V0Pd2GiItHyGj75JXR188NNsBls6MkYoXbdCMyXQNL42OUIKaQnLm9u9Vj1wZwo0eu
         IvQYJ5kwDmEjWauUHkxEKJFtlOlgEBgpXKcU585vkuZIzCUTJAAPt2ZVbOdAdPfntuIS
         rPkvjzwaJtHAOYoWkw193GG4i610cclA4lhlgrFnseE30rf8NbTZGVjahz1ORGHoM0S7
         tNRoIAbUnCCiq/uhRBie3N+qtFwyUpAR9Rb8Q0bqZVQ6S6jxxDOQJZSVymdsFhqOeyZt
         3/uw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH] driver core: Count repeated addition of same device link
Date: Wed, 14 Feb 2018 11:55:36 +0100
Message-ID: <2231452.Jn9O5Q0yUW@aspire.rjw.lan>
In-Reply-To: <074bc916af5497f37cac6af2ba89d40cc74990dd.1518286789.git.lukas@wunner.de>
References: <074bc916af5497f37cac6af2ba89d40cc74990dd.1518286789.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592039556368644819?=
X-GMAIL-MSGID: =?utf-8?q?1592373642635956306?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Saturday, February 10, 2018 7:27:12 PM CET Lukas Wunner wrote:
> If device_link_add() is invoked multiple times with the same supplier
> and consumer combo, it will create the link on first addition and
> return a pointer to the already existing link on all subsequent
> additions.
> 
> The semantics for device_link_del() are quite different, it deletes
> the link unconditionally, so multiple invocations are not allowed.
> 
> In other words, this snippet ...
> 
>     struct device *dev1, *dev2;
>     struct device_link *link1, *link2;
> 
>     link1 = device_link_add(dev1, dev2, 0);
>     link2 = device_link_add(dev1, dev2, 0);
> 
>     device_link_del(link1);
>     device_link_del(link2);
> 
> ... causes the following crash:
> 
>     WARNING: CPU: 4 PID: 2686 at drivers/base/power/runtime.c:1611 pm_runtime_drop_link+0x40/0x50
>     [...]
>     list_del corruption, 0000000039b800a4->prev is LIST_POISON2 (00000000ecf79852)
>     kernel BUG at lib/list_debug.c:50!
> 
> The issue isn't as arbitrary as it may seem:  Imagine a device link
> which is added in both the supplier's and the consumer's ->probe hook.
> The two drivers can't just call device_link_del() in their ->remove hook
> without coordination.
> 
> Fix by counting multiple additions and dropping the device link only
> when the last addition is unwound.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> This issue doesn't break any use cases of mine, it's just something that
> I found surprising about the API and that might cause trouble for others.
> Hence submitting as RFC.
> 
>  drivers/base/core.c    | 25 +++++++++++++++++--------
>  include/linux/device.h |  2 ++
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5847364f25d9..b610816eb887 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -196,8 +196,10 @@ struct device_link *device_link_add(struct device *consumer,
>  	}
>  
>  	list_for_each_entry(link, &supplier->links.consumers, s_node)
> -		if (link->consumer == consumer)
> +		if (link->consumer == consumer) {
> +			kref_get(&link->kref);
>  			goto out;
> +		}
>  
>  	link = kzalloc(sizeof(*link), GFP_KERNEL);
>  	if (!link)
> @@ -222,6 +224,7 @@ struct device_link *device_link_add(struct device *consumer,
>  	link->consumer = consumer;
>  	INIT_LIST_HEAD(&link->c_node);
>  	link->flags = flags;
> +	kref_init(&link->kref);
>  
>  	/* Determine the initial link state. */
>  	if (flags & DL_FLAG_STATELESS) {
> @@ -292,8 +295,10 @@ static void __device_link_free_srcu(struct rcu_head *rhead)
>  	device_link_free(container_of(rhead, struct device_link, rcu_head));
>  }
>  
> -static void __device_link_del(struct device_link *link)
> +static void __device_link_del(struct kref *kref)
>  {
> +	struct device_link *link = container_of(kref, struct device_link, kref);
> +
>  	dev_info(link->consumer, "Dropping the link to %s\n",
>  		 dev_name(link->supplier));
>  
> @@ -305,8 +310,10 @@ static void __device_link_del(struct device_link *link)
>  	call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free_srcu);
>  }
>  #else /* !CONFIG_SRCU */
> -static void __device_link_del(struct device_link *link)
> +static void __device_link_del(struct kref *kref)
>  {
> +	struct device_link *link = container_of(kref, struct device_link, kref);
> +
>  	dev_info(link->consumer, "Dropping the link to %s\n",
>  		 dev_name(link->supplier));
>  
> @@ -324,13 +331,15 @@ static void __device_link_del(struct device_link *link)
>   * @link: Device link to delete.
>   *
>   * The caller must ensure proper synchronization of this function with runtime
> - * PM.
> + * PM.  If the link was added multiple times, it needs to be deleted as often.
> + * Care is required for hotplugged devices:  Their links are purged on removal
> + * and calling device_link_del() is then no longer allowed.
>   */
>  void device_link_del(struct device_link *link)
>  {
>  	device_links_write_lock();
>  	device_pm_lock();
> -	__device_link_del(link);
> +	kref_put(&link->kref, __device_link_del);
>  	device_pm_unlock();
>  	device_links_write_unlock();
>  }
> @@ -444,7 +453,7 @@ static void __device_links_no_driver(struct device *dev)
>  			continue;
>  
>  		if (link->flags & DL_FLAG_AUTOREMOVE)
> -			__device_link_del(link);
> +			kref_put(&link->kref, __device_link_del);
>  		else if (link->status != DL_STATE_SUPPLIER_UNBIND)
>  			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
>  	}
> @@ -597,13 +606,13 @@ static void device_links_purge(struct device *dev)
>  
>  	list_for_each_entry_safe_reverse(link, ln, &dev->links.suppliers, c_node) {
>  		WARN_ON(link->status == DL_STATE_ACTIVE);
> -		__device_link_del(link);
> +		__device_link_del(&link->kref);
>  	}
>  
>  	list_for_each_entry_safe_reverse(link, ln, &dev->links.consumers, s_node) {
>  		WARN_ON(link->status != DL_STATE_DORMANT &&
>  			link->status != DL_STATE_NONE);
> -		__device_link_del(link);
> +		__device_link_del(&link->kref);
>  	}
>  
>  	device_links_write_unlock();
> diff --git a/include/linux/device.h b/include/linux/device.h
> index b093405ed525..abf952c82c6d 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -769,6 +769,7 @@ enum device_link_state {
>   * @status: The state of the link (with respect to the presence of drivers).
>   * @flags: Link flags.
>   * @rpm_active: Whether or not the consumer device is runtime-PM-active.
> + * @kref: Count repeated addition of the same link.
>   * @rcu_head: An RCU head to use for deferred execution of SRCU callbacks.
>   */
>  struct device_link {
> @@ -779,6 +780,7 @@ struct device_link {
>  	enum device_link_state status;
>  	u32 flags;
>  	bool rpm_active;
> +	struct kref kref;
>  #ifdef CONFIG_SRCU
>  	struct rcu_head rcu_head;
>  #endif
> 

I kind of agree with this even though it adds overhead I originally wanted to
avoid.

If Greg doesn't object to that, I'll tentatively queue it up for 4.17.

Thanks,
Rafael
