Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524724253; cv=none;
        d=google.com; s=arc-20160816;
        b=ODrDcROMGe6hIpJkWqB2WfqnMUprUMa0q5Ito2ZlgoKp0Wh8aLtWUeTr65v0LeckYA
         RxD2l5dPQzD1eeYI3zXfTjY95M+Ril7IR1/NWxE8yj/igt3T4Fopk6Au+nRzis4PvzGX
         Lty4DPfLLynrGY4uEsjVfjgFH553qNY6Fk9Sl9+7Q/Ij2yCJpkeOq7XhzafymfA3CUKN
         22hDvNKjif78f0gMlI874jEJbnhAE5Dvt0g98s56JfqjOjCPMn6TLrR0KVf6WbbGZcZt
         CPBzgGLpORdvhRAVmUfyh14mTpqNTsyHVMc1T4ISQHaxPGRQqcBDHYm25nBPKT+B0XVr
         92+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=gRMUb3fHy5ndCPal7DIFvBYiBOo1+uD1p46zT3gPNEU=;
        b=oldEoe4CdlepIAtb3qEC+GDItuFEgw6rG5ybKYAAXBJWvDmMRKAjULL2H9PT/YQ5V5
         Kecb1fLtIPFMDTzNkvxNjEImMU/VGXz4seEl5CHjs1ADA/dNWUTP3B9W1qCzi6pUqVpX
         IwL8i/O6AmC4lBI4HB2ggLPPBnSBsU+lSHTzhiSRKNY7ZY7FRRdOoGyLtXloG07W3uRT
         d1wmA4zp0waU2iH24Qz+yBQ01vwAxaNJDJDbiC0R2W8iiK5l5vJtY8okmYPJ5Z+GzmP1
         Fcov3n2aMLft3Te+RkjMYH3v0IYr3zxpxokOyeD/ClClG/OR8kxcFBUjEq/PXRQj/nsd
         P6hA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nmRUMwdL;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nmRUMwdL;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AIpwx4/5O3qKOTgkCigEZjjj6z4PNCAuRrshooMVxRmwmzHAPlKPMMz8MLn/t/c8Bt8Yjzx7OqcSZ1ZU/RxoPj6B/Uo=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <1524699630-30573-1-git-send-email-opendmb@gmail.com>
References: <1524699630-30573-1-git-send-email-opendmb@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Apr 2018 08:30:52 +0200
X-Google-Sender-Auth: t9_Qz-keUohAEAeJMo7x412aVaQ
Message-ID: <CAJZ5v0i8ACi_Vw0iFKKFTn0pe6gi-YV8aACp9TyRmP3ab8wxqg@mail.gmail.com>
Subject: Re: [PATCH] PM / Sleep: only update last time for active wakeup sources
To: Doug Berger <opendmb@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598763463471847580?=
X-GMAIL-MSGID: =?utf-8?q?1598789259228506843?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 1:40 AM, Doug Berger <opendmb@gmail.com> wrote:
> When wakelock support was added, the wakeup_source_add() function
> was updated to set the last_time value of the wakeup source. This
> has the unintended side effect of producing confusing output from
> pm_print_active_wakeup_sources() when a wakeup source is added
> prior to a sleep that is blocked by a different wakeup source.
>
> The function pm_print_active_wakeup_sources() will search for the
> most recently active wakeup source when no active source is found.
> If a wakeup source is added after a different wakeup source blocks
> the system from going to sleep it may have a later last_time value
> than the blocking source and be output as the last active wakeup
> source even if it has never actually been active.
>
> It looks to me like the change to wakeup_source_add() was made to
> prevent the wakelock garbage collection from accidentally dropping
> a wakelock during the narrow window between adding the wakelock to
> the wakelock list in wakelock_lookup_add() and the activation of
> the wakeup source in pm_wake_lock().
>
> This commit changes the behavior so that only the last_time of the
> wakeup source used by a wakelock is initialized prior to adding it
> to the wakeup source list. This preserves the meaning of the
> last_time value as the last time the wakeup source was active and
> allows a wakeup source that has never been active to have a
> last_time value of 0.
>
> Fixes: b86ff982 ("PM / Sleep: Add user space interface for manipulating wakeup sources, v3")
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>  drivers/base/power/wakeup.c | 1 -
>  kernel/power/wakelock.c     | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index ea01621..230160e 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -183,7 +183,6 @@ void wakeup_source_add(struct wakeup_source *ws)
>         spin_lock_init(&ws->lock);
>         timer_setup(&ws->timer, pm_wakeup_timer_fn, 0);
>         ws->active = false;
> -       ws->last_time = ktime_get();

If it is not initialized here, max_time may not be updated correctly later on.

If you don't want to initialize it to ktime_get() (to avoid the issue
you're trying to avoid), initialize it to something special and then
check for that explicitly in wakeup_source_deactivate() when computing
max_time.

>
>         spin_lock_irqsave(&events_lock, flags);
>         list_add_rcu(&ws->entry, &wakeup_sources);
> diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
> index dfba59b..4210152 100644
> --- a/kernel/power/wakelock.c
> +++ b/kernel/power/wakelock.c
> @@ -188,6 +188,7 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
>                 return ERR_PTR(-ENOMEM);
>         }
>         wl->ws.name = wl->name;
> +       wl->ws.last_time = ktime_get();
>         wakeup_source_add(&wl->ws);
>         rb_link_node(&wl->node, parent, node);
>         rb_insert_color(&wl->node, &wakelocks_tree);
> --
> 2.7.4
>
