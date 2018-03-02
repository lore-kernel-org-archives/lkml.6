Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519981103; cv=none;
        d=google.com; s=arc-20160816;
        b=OGpyKciFSzHPW5CkeNiC0R3CX4WbsGsuS8qHUDH71B1QPMK6OrxMUc1/qpKF26aM0r
         XDQHCjv5P/3ZxEI81oZDrRi6/UvhhojnDkSoi0wfCn68v3wUFaHw6ri3+nZhsFc2f84b
         prD9QTO3s7zZQtVyDYCv2SFCpYhBfxvGKfI/Ziwpnzy51FPoT2rDC9SJCfSu9Cokwst+
         1uVZywxGtKgj3nQzdef0e/4GWuch2whdYjWmrQ2tAxyY+BjrtdyQZp11ZUxA70T8lXXb
         V3obuA2MXvsP7SR2JW2iKJiUNufkRh3WgvIFyH2aSyd8GUj8AUGjVvRaNzcwKcySDRm2
         BeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Mn6hhv9JYdsM27vJ8ldVWfpoKHtD89xCOOszSrwSK0c=;
        b=UVV79eV4bzi+6vfjo8fi4BVRNQz1YHwoW8b904q+AUvM8vzr1o2vz06xVb374pXjip
         0gp8FCYs4gDgO2MEWB1svdTI7iEBUwqRCIAVUsZm+h8JGe8Ea/68gMTspCU81ZS8o7iA
         JEW49XirnbE9w04dMCPteZ9Pe2m2PdwTVeHf2PRYWCIa8cRQpV4URPJEwBKAiLekqLnJ
         qObcSsKvwVeBApwsxMhPMgimdUzrdrcwzVplmFmYffgsIQ/BBE5/4ag9LjH90Z78a5C+
         FspPASxPmk8mEVpFzv5pHX4UQdNTS9bHCd5tKGnycMrAxnHHMHt8YqPF+ub0/ICFdhER
         pJEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jB0Gsy92;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jB0Gsy92;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AG47ELtD3OcQcpaBK8uuFzs3rvBHZytMbZzqPM468m369csQ+v8K2h9glvMokukNXscfg4fenSkKXZPnzu8WnmOZ9ks=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <1519966860-32519-1-git-send-email-opensource.ganesh@gmail.com>
References: <1519966860-32519-1-git-send-email-opensource.ganesh@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Mar 2018 09:58:22 +0100
X-Google-Sender-Auth: wnbVNDkAopPGRUZOAmu2KdCCizI
Message-ID: <CAJZ5v0hmj873=2qXtV_PzGEv-dRp-1KVuoC0mYO0AcOVt0e3hg@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: use seq_open() to show wakeup stats
To: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593800783059204124?=
X-GMAIL-MSGID: =?utf-8?q?1593815705802678985?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 2, 2018 at 6:01 AM, Ganesh Mahendran
<opensource.ganesh@gmail.com> wrote:
> single_open() interface requires that the whole output must
> fit into a single buffer. This will lead to timeout when
> system memory is not in a good situation.

Did you actually see this problem with this particular file or is it
theoretical?

> This patch use seq_open() to show wakeup stats. This method
> need only one page, so timeout will not be observed.
>
> Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
> ---
>  drivers/base/power/wakeup.c | 71 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 56 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index ea01621..c64609a 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -1029,32 +1029,73 @@ static int print_wakeup_source_stats(struct seq_file *m,
>         return 0;
>  }
>
> +static void *wakeup_sources_stats_seq_start(struct seq_file *m,
> +                                       loff_t *pos)
> +{
> +       struct wakeup_source *ws;
> +       loff_t n = *pos;
> +
> +       if (n == 0) {
> +               seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
> +                       "expire_count\tactive_since\ttotal_time\tmax_time\t"
> +                       "last_change\tprevent_suspend_time\n");
> +       }
> +
> +       rcu_read_lock();

The code running after this cannot sleep.  Use
srcu_read_lock(&wakeup_srcu) instead.

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
> +
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
> +       rcu_read_unlock();
> +}
> +
>  /**
>   * wakeup_sources_stats_show - Print wakeup sources statistics information.
>   * @m: seq_file to print the statistics into.
>   */
> -static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
> +static int wakeup_sources_stats_seq_show(struct seq_file *m, void *v)
>  {
> -       struct wakeup_source *ws;
> -       int srcuidx;
> +       struct wakeup_source *ws = v;
>
> -       seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
> -               "expire_count\tactive_since\ttotal_time\tmax_time\t"
> -               "last_change\tprevent_suspend_time\n");
> -
> -       srcuidx = srcu_read_lock(&wakeup_srcu);
> -       list_for_each_entry_rcu(ws, &wakeup_sources, entry)
> -               print_wakeup_source_stats(m, ws);
> -       srcu_read_unlock(&wakeup_srcu, srcuidx);
> -
> -       print_wakeup_source_stats(m, &deleted_ws);
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
> +       return seq_open(file, &wakeup_sources_stats_seq_ops);
>  }
>
>  static const struct file_operations wakeup_sources_stats_fops = {
> @@ -1062,7 +1103,7 @@ static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
>         .open = wakeup_sources_stats_open,
>         .read = seq_read,
>         .llseek = seq_lseek,
> -       .release = single_release,
> +       .release = seq_release,
>  };
>
>  static int __init wakeup_sources_debugfs_init(void)
> --
> 1.9.1
>
