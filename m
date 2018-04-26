Return-Path: <opendmb@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524781555; cv=none;
        d=google.com; s=arc-20160816;
        b=mUJZI1CorjF2bzGV+7KIyX7V4mpcsBGqiOJo6F8JCk6WXAMlnQ5tFEWduBEabZvsep
         UFo0bvRxx+J4O98fD8irv835iI9NdiJp9ud+bsrVMP6Um+/kOA/kHqPj3Sd3Xk2CALZy
         BOXBGitFEuWDaiN4BNqLuS772PClGDp9r8+f2nAVLvaF/4URyFy9+ctaUB7fvyer3wiw
         NnuXvzsdzLwVak7YT/Vo3PhDtFZYTa4mQPHkgPCws1DLmUX9oCU58bbENWySEQ2lPMEt
         SIkQg0S3xSVVQjJ9mEEzW8Hf9iRaDRhyVzVWHw8fBy2v2zB1cvGwMyddTaHdatjZGi2U
         2v+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=BfaXyYnQ+SqvoaMqHWs7OwpJ/d0yKjEZJyHZ/WU1UMM=;
        b=DMM27W48z1EonH8reVzePivqt+815tQ6WLX7YQDoh+5x4Zy4xjTtyVZtibsOnnYM4Q
         QfbBihGdai9WzkUjFvu65O3hMAPiThhhmyNe0IVF7aAAu7zeA1q0CvNJzfTW3GzTQErv
         91/5TxmZwYD8IYPHd8b1w5/D/TzsTBNTVuVvs8T244zug2uX42Mm+2GMNtkzZgturban
         LZst2sH1MKdetuPIQVTt7R6Z4rae/Qfo+Y2SsbDHhRVA06wpvkJwrgKv7z/Ff+TsbNDb
         TufxcpwVYT75bjhQ4FSZHIdDjo2e8Ro9kljLiAK84sQ7pT8ZhVr1OTlqm3a/idMxYI14
         lbJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DYscNhya;
       spf=pass (google.com: domain of opendmb@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opendmb@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DYscNhya;
       spf=pass (google.com: domain of opendmb@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opendmb@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48V+MAJZEujn7R5J3ehxUoFxp7fknB0YPuLKScCj52yJolTTR7/1jfxG2ZaI4zYMTxfks04sw==
Subject: Re: [PATCH] PM / Sleep: only update last time for active wakeup
 sources
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1524699630-30573-1-git-send-email-opendmb@gmail.com>
 <CAJZ5v0i8ACi_Vw0iFKKFTn0pe6gi-YV8aACp9TyRmP3ab8wxqg@mail.gmail.com>
From: Doug Berger <opendmb@gmail.com>
Message-ID: <bfada5a2-af05-38a9-448c-0cd042efb646@gmail.com>
Date: Thu, 26 Apr 2018 15:25:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i8ACi_Vw0iFKKFTn0pe6gi-YV8aACp9TyRmP3ab8wxqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598763463471847580?=
X-GMAIL-MSGID: =?utf-8?q?1598849344371190527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/25/2018 11:30 PM, Rafael J. Wysocki wrote:
> On Thu, Apr 26, 2018 at 1:40 AM, Doug Berger <opendmb@gmail.com> wrote:
>> When wakelock support was added, the wakeup_source_add() function
>> was updated to set the last_time value of the wakeup source. This
>> has the unintended side effect of producing confusing output from
>> pm_print_active_wakeup_sources() when a wakeup source is added
>> prior to a sleep that is blocked by a different wakeup source.
>>
>> The function pm_print_active_wakeup_sources() will search for the
>> most recently active wakeup source when no active source is found.
>> If a wakeup source is added after a different wakeup source blocks
>> the system from going to sleep it may have a later last_time value
>> than the blocking source and be output as the last active wakeup
>> source even if it has never actually been active.
>>
>> It looks to me like the change to wakeup_source_add() was made to
>> prevent the wakelock garbage collection from accidentally dropping
>> a wakelock during the narrow window between adding the wakelock to
>> the wakelock list in wakelock_lookup_add() and the activation of
>> the wakeup source in pm_wake_lock().
>>
>> This commit changes the behavior so that only the last_time of the
>> wakeup source used by a wakelock is initialized prior to adding it
>> to the wakeup source list. This preserves the meaning of the
>> last_time value as the last time the wakeup source was active and
>> allows a wakeup source that has never been active to have a
>> last_time value of 0.
>>
>> Fixes: b86ff982 ("PM / Sleep: Add user space interface for manipulating wakeup sources, v3")
>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>> ---
>>  drivers/base/power/wakeup.c | 1 -
>>  kernel/power/wakelock.c     | 1 +
>>  2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
>> index ea01621..230160e 100644
>> --- a/drivers/base/power/wakeup.c
>> +++ b/drivers/base/power/wakeup.c
>> @@ -183,7 +183,6 @@ void wakeup_source_add(struct wakeup_source *ws)
>>         spin_lock_init(&ws->lock);
>>         timer_setup(&ws->timer, pm_wakeup_timer_fn, 0);
>>         ws->active = false;
>> -       ws->last_time = ktime_get();
> 
> If it is not initialized here, max_time may not be updated correctly later on.
> 
> If you don't want to initialize it to ktime_get() (to avoid the issue
> you're trying to avoid), initialize it to something special and then
> check for that explicitly in wakeup_source_deactivate() when computing
> max_time.
> 

I'm a little confused by your meaning. If you are concerned that the
duration calculation in wakeup_source_deactivate() may be compromised by
not initializing last_time in wakeup_source_add() and that an incorrect
duration could find its way into the comparison and update of max_time
then I don't believe that is a realizable concern.

As far as I can see there are no execution paths to
wakeup_source_deactivate() that don't require a call to
wakeup_source_activate() earlier in the path. The call to
wakeup_source_activate() will set the last_time to its proper value for
use by wakeup_source_deactivate().

So it should be safe to leave last_time at its initial 0 value in
wakeup_source_add() without impacting wakeup_source_deactivate() or
print_wakeup_source_stats().

This is the behavior of your original implementation of wakeup sources.
It wasn't changed until the wakelock support was added and as I said it
only appears to be necessary to protect against the timing hazard with
the garbage collecting thread possibly finding the wakeup_source from
the wakelock list before the pm_wake_lock() function has the opportunity
to activate the associated wakeup source.

>>
>>         spin_lock_irqsave(&events_lock, flags);
>>         list_add_rcu(&ws->entry, &wakeup_sources);
>> diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
>> index dfba59b..4210152 100644
>> --- a/kernel/power/wakelock.c
>> +++ b/kernel/power/wakelock.c
>> @@ -188,6 +188,7 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
>>                 return ERR_PTR(-ENOMEM);
>>         }
>>         wl->ws.name = wl->name;
>> +       wl->ws.last_time = ktime_get();

This proposed change forces an early initialization of the last_time for
wakelocks only to protect against accidental garbage collection between
wakelock_lookup_add() and the subsequent call of __pm_wakeup_event() or
__pm_stay_awake() where last_time will be initialized again.


>>         wakeup_source_add(&wl->ws);
>>         rb_link_node(&wl->node, parent, node);
>>         rb_insert_color(&wl->node, &wakelocks_tree);
>> --
>> 2.7.4
>>

Thank you for your timely review and consideration of this patch,
    Doug
