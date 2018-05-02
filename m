Return-Path: <opensource.ganesh@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525228002; cv=none;
        d=google.com; s=arc-20160816;
        b=C495kSpBYuGL4rBZzdJV6i1WaCbmwwyWDNiBQdf69ynY2/uLmVS23r9t3PCMZcDCNS
         s1wBxsVo8dkCWDkYi+CkXEXHHZPc8nQkSB+iUD2p08DWbpzISNBJi+Mw3/GRWkdCQGTT
         R48MSCAIBGT8SSYhHhPaxcAz62UJ5csgjjbFyuTrimIXI/zczGBM80gbHpCC+YXFXrHK
         Qn/M+jINhWg1mY5r46EV/L33YIQmUAYmLarIAo9f6BKRIQCWasZj6g7XnfHjEQN/JXTj
         mxjcIonxBJJqiIi0A9kIpogszesakmVOnTC5cVdkTs+W5dm6PMEZK7BaX0bNV9BO97aD
         3Nag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=hG4HEbrQQTRCwwRkT1102Pvywfuo9VzJGaVZf0r/D98=;
        b=B4quVu/hHQICQDCxwsjvQoY4dnjIZENA+wsXrheM2DnFIeEpSmmX9m2Mj/NI3mQPfn
         6JDXF4FG6NSrX3c07rwtFoWX25RL/SPpxiELEVbzyVc6lu7ekFAGTSdk2d1CzmmVuuTo
         CCx0u2HWrdwbe6hq+PFlipDfspbWd5VfoHuUKRpmaOKfjyvan3QsAtjIdRn0NHBKnWv/
         XzFrKEbcc9EBOiRWxlrXpvO4G9lL2gd4vcTDcmDh9eRxQgERI2EexveVo0P2nc7LP2BD
         4P16vsq0Hv8QJ/QLWQtGyK6cIBNDTEEC7Yry+QJH0taQMQ4ndMhQy0SaBPpUGWxezXWv
         xt0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DzmTwxS1;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DzmTwxS1;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoJl0j3jaqoxESoSXacYYAHjHuP1XMbBY2Cj1mCuSKXfB3UZgAjz2iy5x34Ktlb0VlGShsVhFpKZEsYW9+rCrs=
MIME-Version: 1.0
In-Reply-To: <20180429143002.GC13475@amd>
References: <1524653971-10425-1-git-send-email-opensource.ganesh@gmail.com> <20180429143002.GC13475@amd>
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Date: Wed, 2 May 2018 10:26:41 +0800
Message-ID: <CADAEsF_onq=H65ZUi2kC7b_WmEpdvMLdLcBPn8bqDQP_DPyEjQ@mail.gmail.com>
Subject: Re: [PATCH v3] PM / wakeup: use seq_open() to show wakeup stats
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Linux PM <linux-pm@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598715584055641513?=
X-GMAIL-MSGID: =?utf-8?q?1599317477523043831?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi, Pavel

Thanks for your review.

2018-04-29 22:30 GMT+08:00 Pavel Machek <pavel@ucw.cz>:
> On Wed 2018-04-25 18:59:31, Ganesh Mahendran wrote:
>> single_open() interface requires that the whole output must
>> fit into a single buffer. This will lead to timeout when
>> system memory is not in a good situation.
>>
>> This patch use seq_open() to show wakeup stats. This method
>> need only one page, so timeout will not be observed.
>
> Sounds like magic.

I did not explain clearly here.

If we use single_open() to open the file, a single buffer(physical
continious) will be allocated
to store the whole data of file /sys/kernel/debug/wakeup_sources.
When memory situation is not good(fragments...), long time may be used
to allocate
such buffer which may cause android watchdog timeout.

>
>> -static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
>> +static void *wakeup_sources_stats_seq_start(struct seq_file *m,
>> +                                     loff_t *pos)
>>  {
> ...
>> -     srcuidx = srcu_read_lock(&wakeup_srcu);
>> -     list_for_each_entry_rcu(ws, &wakeup_sources, entry)
>> -             print_wakeup_source_stats(m, ws);
>> -     srcu_read_unlock(&wakeup_srcu, srcuidx);
>> +     *srcuidx = srcu_read_lock(&wakeup_srcu);
>> +     list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
>> +             if (n-- <= 0)
>> +                     return ws;
>> +     }
>> +
>> +     return NULL;
>> +}
> ...
>> +static void wakeup_sources_stats_seq_stop(struct seq_file *m, void *v)
>> +{
>> +     int *srcuidx = m->private;
>> +
>> +     srcu_read_unlock(&wakeup_srcu, *srcuidx);
>> +}
>
> But you are holding srcu_lock over return to userspace, and somehow I
> don't think that's permitted?

In seq_read(), the m->op->[start | stop] will be invoked as a pair.
So the srcu_lock will not be hold and return to userspace.

Thanks.

>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
