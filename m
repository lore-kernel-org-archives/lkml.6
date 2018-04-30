Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AB8JxZpvzpJgTZiuMd5UlCAUKzD4SiIxgoEHZ8gHF6KY34cVXTNEu/jm53TbhF8559r0cFQ3Uyw5
ARC-Seal: i=1; a=rsa-sha256; t=1525076526; cv=none;
        d=google.com; s=arc-20160816;
        b=DkESnq+fc7130Njy2gTo+lo32RJlplitzhtOeJSLI7b9DqRC3pRU0+IAyxRHq3CgMW
         yEKBykBpuPeTMlc1vwY7idVMFPH9T0GsT+yHseGxsWSJ0N13vb7262EnV8S5yRxes+qD
         DD6IsdJFt7hUiQKg50sHvFJPDkZl+ygC78eUyrQ+fukQaXNSw1Tm27NyWKMAi6KPK7gU
         dXnLOEbigO2aZ0WgoKWxgqdcGM9wEV6AJkp2Chjyets8YIp12KPyvXTyYe5K5w1r+usL
         qoIM+cigRMNv7TY0yD89+c/x84tSqBGepf2KBrQVFrttvYaU35JoSRY+TEcoRxGBeWBd
         pOmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=FeyvJgX5R/tE3l6910KNVmPwZx7tetqcxCxsw4LMEUM=;
        b=a2Xlg/4UPhn5WgGch4IlS4+D3+Hjjqt7pnl1BrIZkzPASQFJ4OaOqm0PSBb1krPgHZ
         blSFEfmufV82OZ/IhZNgTKpzaP8qLnMSq4Fu7SJdwnUa3l4/cmbx79l7s/2VGtpKaz2h
         WuPOCJZYpYTe095LsX0giLHlypoIozuYfbgH+uXJFUnnhBGte8OZZ7Wm2I4+Ym3YZHCn
         uThJoFq0uuwuCeLSFd0OidNiMCM3suZbvAOOU5Oc8i9XK1HJGJJWKsVOTAzL0kcEo0mn
         cSHCKJZuYF03PoYEk5JSEf0rp+uzKwFlM6tIn4zTOgIztfxyPH5lu6IVb2HZrChbQxbC
         dzLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Doug Berger <opendmb@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM / Sleep: only update last time for active wakeup sources
Date: Mon, 30 Apr 2018 10:21:51 +0200
Message-ID: <2282827.jE04r9cy6F@aspire.rjw.lan>
In-Reply-To: <bfada5a2-af05-38a9-448c-0cd042efb646@gmail.com>
References: <1524699630-30573-1-git-send-email-opendmb@gmail.com> <CAJZ5v0i8ACi_Vw0iFKKFTn0pe6gi-YV8aACp9TyRmP3ab8wxqg@mail.gmail.com> <bfada5a2-af05-38a9-448c-0cd042efb646@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598763463471847580?=
X-GMAIL-MSGID: =?utf-8?q?1599158643821306454?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Friday, April 27, 2018 12:25:53 AM CEST Doug Berger wrote:
> On 04/25/2018 11:30 PM, Rafael J. Wysocki wrote:
> > On Thu, Apr 26, 2018 at 1:40 AM, Doug Berger <opendmb@gmail.com> wrote:
> >> When wakelock support was added, the wakeup_source_add() function
> >> was updated to set the last_time value of the wakeup source. This
> >> has the unintended side effect of producing confusing output from
> >> pm_print_active_wakeup_sources() when a wakeup source is added
> >> prior to a sleep that is blocked by a different wakeup source.
> >>
> >> The function pm_print_active_wakeup_sources() will search for the
> >> most recently active wakeup source when no active source is found.
> >> If a wakeup source is added after a different wakeup source blocks
> >> the system from going to sleep it may have a later last_time value
> >> than the blocking source and be output as the last active wakeup
> >> source even if it has never actually been active.
> >>
> >> It looks to me like the change to wakeup_source_add() was made to
> >> prevent the wakelock garbage collection from accidentally dropping
> >> a wakelock during the narrow window between adding the wakelock to
> >> the wakelock list in wakelock_lookup_add() and the activation of
> >> the wakeup source in pm_wake_lock().
> >>
> >> This commit changes the behavior so that only the last_time of the
> >> wakeup source used by a wakelock is initialized prior to adding it
> >> to the wakeup source list. This preserves the meaning of the
> >> last_time value as the last time the wakeup source was active and
> >> allows a wakeup source that has never been active to have a
> >> last_time value of 0.
> >>
> >> Fixes: b86ff982 ("PM / Sleep: Add user space interface for manipulating wakeup sources, v3")
> >> Signed-off-by: Doug Berger <opendmb@gmail.com>
> >> ---
> >>  drivers/base/power/wakeup.c | 1 -
> >>  kernel/power/wakelock.c     | 1 +
> >>  2 files changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> >> index ea01621..230160e 100644
> >> --- a/drivers/base/power/wakeup.c
> >> +++ b/drivers/base/power/wakeup.c
> >> @@ -183,7 +183,6 @@ void wakeup_source_add(struct wakeup_source *ws)
> >>         spin_lock_init(&ws->lock);
> >>         timer_setup(&ws->timer, pm_wakeup_timer_fn, 0);
> >>         ws->active = false;
> >> -       ws->last_time = ktime_get();
> > 
> > If it is not initialized here, max_time may not be updated correctly later on.
> > 
> > If you don't want to initialize it to ktime_get() (to avoid the issue
> > you're trying to avoid), initialize it to something special and then
> > check for that explicitly in wakeup_source_deactivate() when computing
> > max_time.
> > 
> 
> I'm a little confused by your meaning. If you are concerned that the
> duration calculation in wakeup_source_deactivate() may be compromised by
> not initializing last_time in wakeup_source_add() and that an incorrect
> duration could find its way into the comparison and update of max_time
> then I don't believe that is a realizable concern.
> 
> As far as I can see there are no execution paths to
> wakeup_source_deactivate() that don't require a call to
> wakeup_source_activate() earlier in the path. The call to
> wakeup_source_activate() will set the last_time to its proper value for
> use by wakeup_source_deactivate().

You're right, so this isn't a concern.

> So it should be safe to leave last_time at its initial 0 value in
> wakeup_source_add() without impacting wakeup_source_deactivate() or
> print_wakeup_source_stats().
> 
> This is the behavior of your original implementation of wakeup sources.
> It wasn't changed until the wakelock support was added and as I said it
> only appears to be necessary to protect against the timing hazard with
> the garbage collecting thread possibly finding the wakeup_source from
> the wakelock list before the pm_wake_lock() function has the opportunity
> to activate the associated wakeup source.
> 
> >>
> >>         spin_lock_irqsave(&events_lock, flags);
> >>         list_add_rcu(&ws->entry, &wakeup_sources);
> >> diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
> >> index dfba59b..4210152 100644
> >> --- a/kernel/power/wakelock.c
> >> +++ b/kernel/power/wakelock.c
> >> @@ -188,6 +188,7 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
> >>                 return ERR_PTR(-ENOMEM);
> >>         }
> >>         wl->ws.name = wl->name;
> >> +       wl->ws.last_time = ktime_get();
> 
> This proposed change forces an early initialization of the last_time for
> wakelocks only to protect against accidental garbage collection between
> wakelock_lookup_add() and the subsequent call of __pm_wakeup_event() or
> __pm_stay_awake() where last_time will be initialized again.
> 
> 
> >>         wakeup_source_add(&wl->ws);
> >>         rb_link_node(&wl->node, parent, node);
> >>         rb_insert_color(&wl->node, &wakelocks_tree);
> >> --
> >> 2.7.4
> >>
> 
> Thank you for your timely review and consideration of this patch,

You're welcome.

I'll queue up the patch for 4.18, thanks!
