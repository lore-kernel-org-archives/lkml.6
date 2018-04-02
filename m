Return-Path: <opensource.ganesh@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522632811; cv=none;
        d=google.com; s=arc-20160816;
        b=OvDiNIRBJEjLmXpv4/9I0P3fKB+rkU2zLwG/TEk2LoQ9TzHBYj48RdS5LgA/t8j1f3
         nrPeiDpgoaBGJdIW3rwX2RNcKDbRa+UNtoDsDFEoTJkK0FSdnAMKvVbUUiW43G6U+35p
         x5X1b6JiKQoPDNQrSn0e4Rdsj2g+utsAHO//h0CXAM6F7ZStqnne3pMUOYdtXwVxGEY9
         y7i8uOaRq4laCn6afw4hbw/JMLVvsHu70S6rh7FJGQT6ta9NLo6XMMciL5ar1QC/t9OS
         CLVwh5q3pd1jadUqL045gGLLhfb96z4vNmRJ5zVoJuYGmtAl9NefRSkx3zPMIV7KRI0n
         A1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=kJaKmEqDQKPsoM7E/Om/e2bzJ+CsVRZjz70758pCtow=;
        b=bIYt2WiSz1unMdflbM2QYBJWbrLPxr76FNPxlw0hBX2WvztqCEFK9RXUxEDPbzd5Ie
         XBvlcm+dQDCXM1DrFTK1fNsiT2jAJ26ACr4qpxabfhC9EZKlw9gx7HfhAqQYyZU73xa4
         /WPle5T83YzoAnPNcDqcJ5bFewRo9O5vIMlqvDpvGl+Dy+0b641AFrFU+TQ6gYCWUibX
         krEd5VdOwx5hszztnQzfhB7LKFfgG+iNx9AXmg7x/VCsAap/ZYcXvNmEbziVlIX3LMLi
         Z3dMZR6DXdXziSKv7n+kj6EwbYH1sE4JxTAtxLslpvBwjO6ka6M7GrCNmLWEEOAGvFvi
         0vvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=f0ax9Co2;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=f0ax9Co2;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+PNcafiN4CKsHJGOXGk2/bPq+f+YMqzYd4F+29AgVvftGB+HwF/FfejMKq8pyDdb5gcWDCyFUsTTIFxnnZyQM=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXqLmyJF6qhyzgnPeU=T0TyxDpsw1PD8BiYiSXCZeTz=g@mail.gmail.com>
References: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com>
 <2654052.UvzeiuBsVA@aspire.rjw.lan> <CAMuHMdXqLmyJF6qhyzgnPeU=T0TyxDpsw1PD8BiYiSXCZeTz=g@mail.gmail.com>
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Date: Mon, 2 Apr 2018 09:33:30 +0800
Message-ID: <CADAEsF89WyoBA2vEadOUL6qeEQtGGMm5XFNpXRJh7FpZpJUneQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM / wakeup: use seq_open() to show wakeup stats
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594086852232118519?=
X-GMAIL-MSGID: =?utf-8?q?1596596222667594585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-30 19:00 GMT+08:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> On Fri, Mar 30, 2018 at 12:25 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Monday, March 5, 2018 9:47:46 AM CEST Ganesh Mahendran wrote:
>>> single_open() interface requires that the whole output must
>>> fit into a single buffer. This will lead to timeout when
>>> system memory is not in a good situation.
>>>
>>> This patch use seq_open() to show wakeup stats. This method
>>> need only one page, so timeout will not be observed.
>>>
>>> Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
>>> ----
>>> v2: use srcu_read_lock instead of rcu_read_lock
>>> ---
>>>  drivers/base/power/wakeup.c | 77 +++++++++++++++++++++++++++++++++++----------
>>>  1 file changed, 61 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
>>> index ea01621..3bcab7d 100644
>>> --- a/drivers/base/power/wakeup.c
>>> +++ b/drivers/base/power/wakeup.c
>>> @@ -1029,32 +1029,77 @@ static int print_wakeup_source_stats(struct seq_file *m,
>>>       return 0;
>>>  }
>>>
>>> -/**
>>> - * wakeup_sources_stats_show - Print wakeup sources statistics information.
>>> - * @m: seq_file to print the statistics into.
>>> - */
>>> -static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
>>> +static void *wakeup_sources_stats_seq_start(struct seq_file *m,
>>> +                                     loff_t *pos)
>>>  {
>>>       struct wakeup_source *ws;
>>> -     int srcuidx;
>>> +     loff_t n = *pos;
>>> +     int *srcuidx = m->private;
>>>
>>> -     seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
>>> -             "expire_count\tactive_since\ttotal_time\tmax_time\t"
>>> -             "last_change\tprevent_suspend_time\n");
>>> +     if (n == 0) {
>>> +             seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
>>> +                     "expire_count\tactive_since\ttotal_time\tmax_time\t"
>>> +                     "last_change\tprevent_suspend_time\n");
>>> +     }
>>>
>>> -     srcuidx = srcu_read_lock(&wakeup_srcu);
>>> -     list_for_each_entry_rcu(ws, &wakeup_sources, entry)
>>> -             print_wakeup_source_stats(m, ws);
>>> -     srcu_read_unlock(&wakeup_srcu, srcuidx);
>>> +     *srcuidx = srcu_read_lock(&wakeup_srcu);
>>> +     list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
>>> +             if (n-- > 0)
>>> +                     continue;
>>> +             goto out;
>>> +     }
>>> +     ws = NULL;
>>> +out:
>>> +     return ws;
>>> +}
>>
>> Please clean up the above at least.
>>
>> If I'm not mistaken, you don't need the label and the goto here.
>
> The continue is also not needed, if the test condition is inverted.

Hi, Geert

We need to locate to the last read item. What is your suggestion here?

Thanks.

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
