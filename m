Return-Path: <opensource.ganesh@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522309784; cv=none;
        d=google.com; s=arc-20160816;
        b=vmSuSlgBsVdl5rrCUzbZze8kYxor9J7eBw5sRe6eqBYZpL0LmYv3uAT2OBjJa8ifg7
         YOOIYnjbJZta7z6mSJ9WkaDdGJaNBcePpYnRBD17MCDT1/HQUrb5m+u1NRfUaIdJnh+J
         q6XcvQH573gos7plcX/i7z2/KBylgxuuRVpOo6EweyKtVzRbdnupdNU5AzwrVo1Gd3ta
         QA3y3PpU7Q5HrbDNr3rr1w85OaVyuyYb2O+lktgqA5ni29BUJCIEAMWDxidlQ2CXGNwd
         QfmG4T/RvGfiZGFevKn6t9FNP+M/qrdQhIaLlyEVz8XiO2InMCgy5+qutg4XroHSP8vA
         pfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=kvOtzOYt/tilGXTpXb58c46ymOiqWn/Z81SdBptJL3Q=;
        b=q39ZH5Li5syOn3P2vOMedurTRQyLY9ouoBj64VMwTPBM1GnQ09JtRU4m+jbmMAAaiI
         IG1I7lhVBZdUwcAaj4uhV3Ao+Q5P1mdRykEUPvjIvJHspQ9K5T4r3vMM8RsEAXVE5Via
         OMzJf/ICPQgzlCuZa4Qxul5bQEPvucktnanhYUAJz+sHwCP9F6TeYlgZZAhKIx+xnuqj
         +W7jh9iTRAnwxVfQwc8l2etZ15D8YWgLIAw597uSSZQLeXI6Rz8CQ80XX5RwJubs80uf
         KQ8oHi6fpshH5CcJ2DIFijRlL6iPQ8DkRDKH6IZRWqaQjvMccYCrZN0gWLLrKV3Qo54J
         vULA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O1x9mTIm;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O1x9mTIm;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49PwlTUskCofIs/pxvW4R97NrRWDaWuAhOWXUs3fVAuYPCHLfV/T0bi3DYue+heaJnhWoKgQ3pMeSsgOAaGH8A=
MIME-Version: 1.0
In-Reply-To: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com>
References: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com>
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Date: Thu, 29 Mar 2018 15:49:43 +0800
Message-ID: <CADAEsF8j4yfuzDSfyO4VtqSP6rGY2r6L_AEn6MEhhhAUdo+7dA@mail.gmail.com>
Subject: Re: [PATCH v2] PM / wakeup: use seq_open() to show wakeup stats
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Ganesh Mahendran <opensource.ganesh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594086852232118519?=
X-GMAIL-MSGID: =?utf-8?q?1596257504169833366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ping.

2018-03-05 16:47 GMT+08:00 Ganesh Mahendran <opensource.ganesh@gmail.com>:
> single_open() interface requires that the whole output must
> fit into a single buffer. This will lead to timeout when
> system memory is not in a good situation.
>
> This patch use seq_open() to show wakeup stats. This method
> need only one page, so timeout will not be observed.

We have resolved the watchdog timeout issue by this patch.
Please help to review.

Thanks.

>
> Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
> ----
> v2: use srcu_read_lock instead of rcu_read_lock
> ---
>  drivers/base/power/wakeup.c | 77 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 61 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index ea01621..3bcab7d 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -1029,32 +1029,77 @@ static int print_wakeup_source_stats(struct seq_file *m,
>         return 0;
>  }
>
> -/**
> - * wakeup_sources_stats_show - Print wakeup sources statistics information.
> - * @m: seq_file to print the statistics into.
> - */
> -static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
> +static void *wakeup_sources_stats_seq_start(struct seq_file *m,
> +                                       loff_t *pos)
>  {
>         struct wakeup_source *ws;
> -       int srcuidx;
> +       loff_t n = *pos;
> +       int *srcuidx = m->private;
>
> -       seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
> -               "expire_count\tactive_since\ttotal_time\tmax_time\t"
> -               "last_change\tprevent_suspend_time\n");
> +       if (n == 0) {
> +               seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
> +                       "expire_count\tactive_since\ttotal_time\tmax_time\t"
> +                       "last_change\tprevent_suspend_time\n");
> +       }
>
> -       srcuidx = srcu_read_lock(&wakeup_srcu);
> -       list_for_each_entry_rcu(ws, &wakeup_sources, entry)
> -               print_wakeup_source_stats(m, ws);
> -       srcu_read_unlock(&wakeup_srcu, srcuidx);
> +       *srcuidx = srcu_read_lock(&wakeup_srcu);
> +       list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
> +               if (n-- > 0)
> +                       continue;
> +               goto out;
> +       }
> +       ws = NULL;
> +out:
> +       return ws;
> +}
> +
> +static void *wakeup_sources_stats_seq_next(struct seq_file *m,
> +                                       void *v, loff_t *pos)
> +{
> +       struct wakeup_source *ws = v;
> +       struct wakeup_source *next_ws = NULL;
> +
> +       ++(*pos);
>
> -       print_wakeup_source_stats(m, &deleted_ws);
> +       list_for_each_entry_continue_rcu(ws, &wakeup_sources, entry) {
> +               next_ws = ws;
> +               break;
> +       }
> +
> +       return next_ws;
> +}
> +
> +static void wakeup_sources_stats_seq_stop(struct seq_file *m, void *v)
> +{
> +       int *srcuidx = m->private;
> +
> +       srcu_read_unlock(&wakeup_srcu, *srcuidx);
> +}
> +
> +/**
> + * wakeup_sources_stats_seq_show - Print wakeup sources statistics information.
> + * @m: seq_file to print the statistics into.
> + * @v: wakeup_source of each iteration
> + */
> +static int wakeup_sources_stats_seq_show(struct seq_file *m, void *v)
> +{
> +       struct wakeup_source *ws = v;
> +
> +       print_wakeup_source_stats(m, ws);
>
>         return 0;
>  }
>
> +static const struct seq_operations wakeup_sources_stats_seq_ops = {
> +       .start = wakeup_sources_stats_seq_start,
> +       .next  = wakeup_sources_stats_seq_next,
> +       .stop  = wakeup_sources_stats_seq_stop,
> +       .show  = wakeup_sources_stats_seq_show,
> +};
> +
>  static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
>  {
> -       return single_open(file, wakeup_sources_stats_show, NULL);
> +       return seq_open_private(file, &wakeup_sources_stats_seq_ops, sizeof(int));
>  }
>
>  static const struct file_operations wakeup_sources_stats_fops = {
> @@ -1062,7 +1107,7 @@ static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
>         .open = wakeup_sources_stats_open,
>         .read = seq_read,
>         .llseek = seq_lseek,
> -       .release = single_release,
> +       .release = seq_release_private,
>  };
>
>  static int __init wakeup_sources_debugfs_init(void)
> --
> 1.9.1
>
