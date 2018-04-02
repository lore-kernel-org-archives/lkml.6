Return-Path: <opensource.ganesh@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522632694; cv=none;
        d=google.com; s=arc-20160816;
        b=p6YeH5qBzOfmx8TjUhYql8We2OA3VVnhz+7ZaBXCSMz+KzpIXbMfxg6vsIUTtgNNVr
         AYXO88+npQ5TA7JbvirWRGF1EOrNiduGmiYFZXSEcVQW9yM+nN7PB5vYdjpN03WJ6hxJ
         fZZ+4+VD6BWKso2W4EzvwIEdq0PjaWldUy6MvvERUcs3tHumiBGBgYrQJKtJqbN3b1aN
         k7k6ci0O7zPuTLpFXzPcg4uh/rMy0AWZ9y7tdFEOU64RRdXRPTF/OuNU89ZbH/ptH/es
         69qH/2juI0ZX7ORngCM6GHLDQWG+MY9tAJkspwR+BQ49oJi5V2NHm+ro/e5qRTXSt+2t
         JgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Z07Ej/RJv2TkFSF/34Wuie37WHiLK/C2l9u4jCcyxYk=;
        b=gf3bLNYaxHLBJlLCDhAnvwX5Uo6NBe3MrNUPuvtqpKHeizhXTBwEPhmX5/j5/wCw7d
         VDgk8WvlRwY4bzBz0zkZT37HVJlVZyPY6ymiE+Hj1Jwg6TW4Kx7q0AR2v1p5AtPG7Y6I
         LQMvcy6uAm+vS5Ai53b8pStC0V8g1Ju3+G6XKjXsRXTtrkMRVwUaImBtu/shTNOC07VH
         NXhAbcK6i5+ntgg4k+932OOh/n4MXZeuKsZFg56ueixGOnu6FJohdVjIrj7sVqqES70I
         MHgIKaXkXJJTedcVLjtV5zms0yR/gHcAHIXpbvH2RGds6yA6s/g3mTlGluy3F1meobDK
         HODg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Zvnt2itK;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Zvnt2itK;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx490MnsGRWx2TEjZQJwuE7c1gtO/Q9XvMp9yw7Hhmz8/3OauAu+IBoMe3CpmE8/nN5M5673Vuu7CsihAvquoMq4=
MIME-Version: 1.0
In-Reply-To: <2654052.UvzeiuBsVA@aspire.rjw.lan>
References: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com> <2654052.UvzeiuBsVA@aspire.rjw.lan>
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Date: Mon, 2 Apr 2018 09:31:33 +0800
Message-ID: <CADAEsF-BCTYM5a2ywwHv1WkMbghKyw5z=y51Qu8DMCVeax9BwA@mail.gmail.com>
Subject: Re: [PATCH v2] PM / wakeup: use seq_open() to show wakeup stats
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	Linux PM <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594086852232118519?=
X-GMAIL-MSGID: =?utf-8?q?1596596099990856809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-30 18:25 GMT+08:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
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

Hi, Rafael

When length of file "wakeup_sources" is larger than 1 page,
wakeup_sources_stats_seq_start()
may be called more then 1 time if the user space wants to read all of the file.
So we need to locate to last read item, if it is not the first time to
read the file.

We can see the same logic in kmemleak_seq_start().

Thanks.

>
> If I'm not mistaken, you don't need the label and the goto here.
>
