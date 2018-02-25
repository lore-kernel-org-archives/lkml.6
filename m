Return-Path: <foo00@h08.hostsharing.net>
X-Google-Smtp-Source: AH8x226DGwQiUf/ub+edC+92Apu2ApVCmLz1XLVcNXwyZ+yZYeBci/jQqZpza3d1I1jdLGJLZXwh
ARC-Seal: i=1; a=rsa-sha256; t=1519550544; cv=none;
        d=google.com; s=arc-20160816;
        b=q/X7hIaZ/gHrmGbcTM9yB5jS7S2hfNfcU35XZkmG424O6gspSpDyZp9X3j8r4RmO+r
         xbjZ11xZivM49AKyP+x5I84/dnU+6yQQxx5pcyirfVFi4L0wBpbGyH1QvWHam6ci65++
         WlRze0gb7FVxR3cykZ4GwyTyaudwVKZx7SEdZ+mSdy8ewCG0eRQR8YRropfaaOoRPfE/
         sWh9+XgDNEb+pEgknLQ/c4BjhNkchCYpkjV2Gd1wqItz4JjRR7Qu1eEv1VDvulM0w+vp
         PGtGNkrZSOo0wqhlxY8O3perHRV+EoVUFxL6qVlD0MoDFePnqL0GcsNC2j52266Oop8O
         IcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=BnPLzD0HhrT8VACW5PpRZzVgilzSwoO+kIfF65OhxZs=;
        b=PbKHQxJUCSwziY31fQTC/bFKcGLxLPQ7D+fHbITwxzkibC+vEZgCw1b/btkvnxQn2O
         wwXHh6Z+XIvQ2GSXUneRonaocVksMawpJ6GGLWddsju4Lp0Z32QXJHOdRJBn5D+EKYcQ
         f/43WbcHbx2EzHHROYgWRro33YFc7LLh1gdzq6U8sachZlDM0c8CDwR1lW+v2Adw5vdc
         fYrp+AYGMzPTKlCyLp97KJIFqUyF4/7E/rEoYjBJPIsd3Hu9IOifXo/rjb1J7acUgaP8
         d2tJlr5lc3o/dR3VPgPdrxTL89fvRf/JniBAlptVLHa3LehJXjhR4JWReHW2oTPHh8fI
         IKog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.90.240 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.90.240 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Date: Sun, 25 Feb 2018 10:22:23 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jyri Sarha <jsarha@ti.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	tomi.valkeinen@ti.com, thierry.reding@gmail.com,
	gregkh@linuxfoundation.org,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH RFC] driver core: Reprobe consumer if it was unbound by
 dropped device_link
Message-ID: <20180225092223.GB923@wunner.de>
References: <cover.1519321145.git.jsarha@ti.com>
 <57c1d52a5a8f5985dc1dd53260d7d68795be8ea2.1519321145.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c1d52a5a8f5985dc1dd53260d7d68795be8ea2.1519321145.git.jsarha@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593123928219045407?=
X-GMAIL-MSGID: =?utf-8?q?1593364232001699278?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 07:42:46PM +0200, Jyri Sarha wrote:
> Put consumer device to deferred probe list if it is unbound due to a
> dropped link to a supplier.
> 
> When a device link supplier is unbound (either manually or because one
> of its own suppliers was unbound), its consumers are unbound as
> well. Currently if the supplier binds again after this the consumer
> does not automatically probe again. With this patch it does.

Yes I think this makes sense, based on the rationale that the consumer
was automatically unbound, so by symmetry it should also be automatically
rebound.

The only thing I don't understand is you wrote in an earlier e-mail of a
difference in behavior depending on whether driver_deferred_probe_add()
is called before or after device_release_driver_internal().
That's really odd, it shouldn't make a difference.

Thanks,

Lukas

> 
> If this patch is not acceptable as such, how about adding this
> behavior behind a new device link flag?
> 
> The idea to this patch was gotten from this post by Lucas Wunner:
> https://www.spinics.net/lists/dri-devel/msg166318.html
> 
> Part of the code and the description is borrowed from him.
> 
> cc: Lukas Wunner <lukas@wunner.de>
> cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  drivers/base/base.h | 1 +
>  drivers/base/core.c | 2 ++
>  drivers/base/dd.c   | 2 +-
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index d800de6..39370eb 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -114,6 +114,7 @@ extern void device_release_driver_internal(struct device *dev,
>  
>  extern void driver_detach(struct device_driver *drv);
>  extern int driver_probe_device(struct device_driver *drv, struct device *dev);
> +extern void driver_deferred_probe_add(struct device *dev);
>  extern void driver_deferred_probe_del(struct device *dev);
>  static inline int driver_match_device(struct device_driver *drv,
>  				      struct device *dev)
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b2261f9..0964ed5 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -570,6 +570,8 @@ void device_links_unbind_consumers(struct device *dev)
>  
>  			device_release_driver_internal(consumer, NULL,
>  						       consumer->parent);
> +			driver_deferred_probe_add(consumer);
> +
>  			put_device(consumer);
>  			goto start;
>  		}
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index de6fd09..846ae78 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -140,7 +140,7 @@ static void deferred_probe_work_func(struct work_struct *work)
>  }
>  static DECLARE_WORK(deferred_probe_work, deferred_probe_work_func);
>  
> -static void driver_deferred_probe_add(struct device *dev)
> +void driver_deferred_probe_add(struct device *dev)
>  {
>  	mutex_lock(&deferred_probe_mutex);
>  	if (list_empty(&dev->p->deferred_probe)) {
