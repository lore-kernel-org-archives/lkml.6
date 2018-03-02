Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519982146; cv=none;
        d=google.com; s=arc-20160816;
        b=JndZP/IIEafJMnUYkM/O0PjoN/uRfOQ9p+7smY0n4nV2P0z+ABW/5+udPP7bp4YIEr
         UVy0va6d4UqMguCJAoKXsPZdsDl1xYiMHIeruryq4riU499RA3yCm61Swft87rlbhbHC
         ppDSYqUdfnep/gJstAMJxjJmgRMh/24NtXaADUilWYE/PBkVkqjROlT9V0r2XzV4PI/6
         +oQbFuxvEk5RSezn6/cE9PmziGxcAyzYT4EgSn1cM+1cVUVBHpc4V87s7Wqfqkn7ggIb
         eFyZGRlERI5iWjm1Sm1eR4ATyx3bQvvDzusC8Vni8706Y00L6d+iwJzj0WA8d8i9BEvD
         4j8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Cq77KwqiuQq41gPTATyz48LLIIouWXaSgG5J87TmqVk=;
        b=qVyGzBrAu+Xxa+n+utHEqSG7NyWQXvUeadq82apQtVd1mGYGyttlJRjBDzZEPoeg9N
         nigT3lTr/vqxS8fOHIfULVWP4R0hkXuY0tHx62B+N+GXR2jXhRYhyuJpiQDfWXn2/Mn2
         choG/Vapg10ei+7xqiHQSELJzK902plNKAQO/Fd98UkJBlZ6aCS/TfLuItChSNCx12hf
         qSPemtISAGoa/q5fpji2ySAwIp01fie77dwElq2E6RrUzseQP4vnWN0SxBWqz1ThKdJB
         tl1J84GOX0CWGdKfXA9it1yzgB67CG7R9810fjemwTRc4C1GCXDhocgziZjfZjkFjqCg
         nbSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lxhugijL;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lxhugijL;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AG47ELu5+XRnbN9KunDtJt71EB3/CA38Juj8c9nCkA8pEddudk0xrM0iKCmKZeR+E9Z8F6WtKAwbNW0DUgX6+g+vSuA=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <CAJZ5v0hmj873=2qXtV_PzGEv-dRp-1KVuoC0mYO0AcOVt0e3hg@mail.gmail.com>
References: <1519966860-32519-1-git-send-email-opensource.ganesh@gmail.com> <CAJZ5v0hmj873=2qXtV_PzGEv-dRp-1KVuoC0mYO0AcOVt0e3hg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Mar 2018 10:15:45 +0100
X-Google-Sender-Auth: 7QFZwPL0rqkuN8n5ltuqjROuIRo
Message-ID: <CAJZ5v0i4nkg2mQ+8AejNavJmGVYZn3cbif3D5LW8VYpffvW73A@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: use seq_open() to show wakeup stats
To: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593800783059204124?=
X-GMAIL-MSGID: =?utf-8?q?1593816799309307816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 2, 2018 at 9:58 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Mar 2, 2018 at 6:01 AM, Ganesh Mahendran
> <opensource.ganesh@gmail.com> wrote:
>> single_open() interface requires that the whole output must
>> fit into a single buffer. This will lead to timeout when
>> system memory is not in a good situation.
>
> Did you actually see this problem with this particular file or is it
> theoretical?
>
>> This patch use seq_open() to show wakeup stats. This method
>> need only one page, so timeout will not be observed.
>>
>> Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
>> ---
>>  drivers/base/power/wakeup.c | 71 +++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 56 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
>> index ea01621..c64609a 100644
>> --- a/drivers/base/power/wakeup.c
>> +++ b/drivers/base/power/wakeup.c
>> @@ -1029,32 +1029,73 @@ static int print_wakeup_source_stats(struct seq_file *m,
>>         return 0;
>>  }
>>
>> +static void *wakeup_sources_stats_seq_start(struct seq_file *m,
>> +                                       loff_t *pos)
>> +{
>> +       struct wakeup_source *ws;
>> +       loff_t n = *pos;
>> +
>> +       if (n == 0) {
>> +               seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
>> +                       "expire_count\tactive_since\ttotal_time\tmax_time\t"
>> +                       "last_change\tprevent_suspend_time\n");
>> +       }
>> +
>> +       rcu_read_lock();
>
> The code running after this cannot sleep.  Use
> srcu_read_lock(&wakeup_srcu) instead.

But generally, as Pavel points it out, even under srcu_read_lock()
things cannot be delayed indefinitely (at least for actions other than
freeing up more memory), so the entire approach appears to be flawed.
