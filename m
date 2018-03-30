Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522407623; cv=none;
        d=google.com; s=arc-20160816;
        b=icepX7HLcSt5FU4KdsMnJMmiK9HavkBO7IC34SSMil6K/bmTegGeQz7kMPpKZ7L5Mb
         rdoXTR5ZCo5NL/mRRVJ8L1Snt/hFQCv4sdeC/9W8f3uNW0hsKc5eGkGhURelQCkoGOdt
         zLxNJ7pPdjivifRvC1l8KDkXxWR4jKsqGRR4fF6tJhUzeoftOnekKF2ZgwNwG1YPRpfK
         NQ2708KTmOkQC+Y8kcR54lKmmbKWkYchHRbFAaXkHSIyyUR4dCXz7FNQygqCZXF8aiCC
         2jVH+WMA0llmzyIJrkJbW1Yxy60xUWXZlBH9VatN5MV08w9tndv1kRFafu/vW57g/D5J
         IgXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=AmiR6Qy69CjjEl/LBxnYLJg40k1yVE7wk9EyK6oCDyA=;
        b=NCyaMXpLAKxUYQ+/xhgGVcGJ9A92Fc/Ex6vKSIqTz2F5EiTDKhU0b+7dL8w9U+iV3M
         +tPv2fVtWetguBby4xoPKz71Up+FehKWkeS0quZgr8XKnqeWoc6dcWdK9iw7qK0+FANb
         mmhRd5jYtgBQWitMI9Ra69Wk54CYaHHuZspLuRChVKW6tAFV0HbTqp3odKb8pytOfgm1
         VkmyRR8Adu2k2C5PyszCzvb62XiuiegUGJyLCrJY+TSbU/e6kZwpt48gbnbvpD8UtaeO
         gHDmEZoXqpd5lLy+Pqr8zeTMxNxaQ9mP1NtoZbhvMN01RLpZhr23tHC7uyrcy3nnkXPx
         vyGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BsZwp+zF;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BsZwp+zF;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AIpwx48Ax97Ry8wX/HALt7TmVly2Kusu/KUGxcrVBTp6t4XolkyiZzzF+cVMC09lNkpovodq3FSH09o0SdbwIwqJork=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <2654052.UvzeiuBsVA@aspire.rjw.lan>
References: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com> <2654052.UvzeiuBsVA@aspire.rjw.lan>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Mar 2018 13:00:21 +0200
X-Google-Sender-Auth: naRNO-1I-TMK2sud33ONW2RoBnI
Message-ID: <CAMuHMdXqLmyJF6qhyzgnPeU=T0TyxDpsw1PD8BiYiSXCZeTz=g@mail.gmail.com>
Subject: Re: [PATCH v2] PM / wakeup: use seq_open() to show wakeup stats
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ganesh Mahendran <opensource.ganesh@gmail.com>, Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594086852232118519?=
X-GMAIL-MSGID: =?utf-8?q?1596360096233141441?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 12:25 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, March 5, 2018 9:47:46 AM CEST Ganesh Mahendran wrote:
>> single_open() interface requires that the whole output must
>> fit into a single buffer. This will lead to timeout when
>> system memory is not in a good situation.
>>
>> This patch use seq_open() to show wakeup stats. This method
>> need only one page, so timeout will not be observed.
>>
>> Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
>> ----
>> v2: use srcu_read_lock instead of rcu_read_lock
>> ---
>>  drivers/base/power/wakeup.c | 77 +++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 61 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
>> index ea01621..3bcab7d 100644
>> --- a/drivers/base/power/wakeup.c
>> +++ b/drivers/base/power/wakeup.c
>> @@ -1029,32 +1029,77 @@ static int print_wakeup_source_stats(struct seq_file *m,
>>       return 0;
>>  }
>>
>> -/**
>> - * wakeup_sources_stats_show - Print wakeup sources statistics information.
>> - * @m: seq_file to print the statistics into.
>> - */
>> -static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
>> +static void *wakeup_sources_stats_seq_start(struct seq_file *m,
>> +                                     loff_t *pos)
>>  {
>>       struct wakeup_source *ws;
>> -     int srcuidx;
>> +     loff_t n = *pos;
>> +     int *srcuidx = m->private;
>>
>> -     seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
>> -             "expire_count\tactive_since\ttotal_time\tmax_time\t"
>> -             "last_change\tprevent_suspend_time\n");
>> +     if (n == 0) {
>> +             seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
>> +                     "expire_count\tactive_since\ttotal_time\tmax_time\t"
>> +                     "last_change\tprevent_suspend_time\n");
>> +     }
>>
>> -     srcuidx = srcu_read_lock(&wakeup_srcu);
>> -     list_for_each_entry_rcu(ws, &wakeup_sources, entry)
>> -             print_wakeup_source_stats(m, ws);
>> -     srcu_read_unlock(&wakeup_srcu, srcuidx);
>> +     *srcuidx = srcu_read_lock(&wakeup_srcu);
>> +     list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
>> +             if (n-- > 0)
>> +                     continue;
>> +             goto out;
>> +     }
>> +     ws = NULL;
>> +out:
>> +     return ws;
>> +}
>
> Please clean up the above at least.
>
> If I'm not mistaken, you don't need the label and the goto here.

The continue is also not needed, if the test condition is inverted.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
