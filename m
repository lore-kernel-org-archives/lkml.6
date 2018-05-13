Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AB8JxZoqgCqG93s9G0aJXPRDyO+04oNZJgQtShgTN2eQFcvxIMoqaUptnsfuib2jeMot3vG8Htjm
ARC-Seal: i=1; a=rsa-sha256; t=1526201246; cv=none;
        d=google.com; s=arc-20160816;
        b=W2Igr6cHo5KPoAwSnRZBvEwc0svP8fzAKxBYruAYOHHKGAXSVdhcpaz+CfW+6WEi/O
         fXBE5U3W/3jMAZvBt2WrGX1yu+UNPH+oHQlHLloQ5mgg0RX2xfPMO3cA1tr1CS9Q9Koi
         y/e/I5NOpm/RUPmvuox/j77/kGOPbtWiKJPvDYEsHgWhDv35Sh5geZfhWswDohLc6n13
         zvQLALnQOlBBWcN5GKDJY7BT3BixFvBexdWrQZ5RVjXCD0tw3rcgyAJuCnJeb2PWP4oz
         oM69IWZ5sXaNEsAYT/EZQPQ67mhB6YUXnfFssHP46POsDXDiigmrZ8bF55BBVFvZEsW3
         Gr5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=rwULMl7YY+0IiC5Qa/QbKu8rtayAMyvvIGCqh9I+vyI=;
        b=WfkmQ1X4xQP5UG0n6xlNSufWB8Av5Csw4jAT+RoSR3Rgislxwu4bIOfbpxq0L/kPdZ
         twYjonsXVzK0030xph4JqlsD23yVn/2S0ZXBtUj+u+Wq1AU9A8FuQ5RnUxqL+sXZCGxq
         bkNUldQXuhXbHaew0vjicu4IKiwb2GSquLxSBGnNP4aS6S/USqdGqS0Wgsl4JmuEQIFP
         /RDhk4QJaP7h04S1l/TiqWoVBdsJKbrfJn3Aa2fCSErcrMaTgoCpbxgBv27F8Qg+/K8a
         /scDYQ/9nY6dxLJLeSwWO2wjMQcnI73mVX3qJsMhGnUcdSHi8Ul5lPt9jBSxPy8Vo+gr
         brYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: pavel@ucw.cz, len.brown@intel.com, rafael@kernel.org, gregkh@linuxfoundation.org, geert@linux-m68k.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PM / wakeup: use seq_open() to show wakeup stats
Date: Sun, 13 May 2018 10:46:57 +0200
Message-ID: <2754294.zfdF7jmEWy@aspire.rjw.lan>
In-Reply-To: <1524653971-10425-1-git-send-email-opensource.ganesh@gmail.com>
References: <1524653971-10425-1-git-send-email-opensource.ganesh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598715584055641513?=
X-GMAIL-MSGID: =?utf-8?q?1600337998673327049?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wednesday, April 25, 2018 12:59:31 PM CEST Ganesh Mahendran wrote:
> single_open() interface requires that the whole output must
> fit into a single buffer. This will lead to timeout when
> system memory is not in a good situation.
> 
> This patch use seq_open() to show wakeup stats. This method
> need only one page, so timeout will not be observed.
> 
> Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
> ----
> v3: simplify wakeup_sources_stats_seq_start
> v2: use srcu_read_lock instead of rcu_read_lock
> ---
>  drivers/base/power/wakeup.c | 75 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 59 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index ea01621..5872705 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -1029,32 +1029,75 @@ static int print_wakeup_source_stats(struct seq_file *m,
>  	return 0;
>  }
>  
> -/**
> - * wakeup_sources_stats_show - Print wakeup sources statistics information.
> - * @m: seq_file to print the statistics into.
> - */
> -static int wakeup_sources_stats_show(struct seq_file *m, void *unused)
> +static void *wakeup_sources_stats_seq_start(struct seq_file *m,
> +					loff_t *pos)
>  {
>  	struct wakeup_source *ws;
> -	int srcuidx;
> +	loff_t n = *pos;
> +	int *srcuidx = m->private;
>  
> -	seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
> -		"expire_count\tactive_since\ttotal_time\tmax_time\t"
> -		"last_change\tprevent_suspend_time\n");
> +	if (n == 0) {
> +		seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
> +			"expire_count\tactive_since\ttotal_time\tmax_time\t"
> +			"last_change\tprevent_suspend_time\n");
> +	}
>  
> -	srcuidx = srcu_read_lock(&wakeup_srcu);
> -	list_for_each_entry_rcu(ws, &wakeup_sources, entry)
> -		print_wakeup_source_stats(m, ws);
> -	srcu_read_unlock(&wakeup_srcu, srcuidx);
> +	*srcuidx = srcu_read_lock(&wakeup_srcu);
> +	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
> +		if (n-- <= 0)
> +			return ws;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void *wakeup_sources_stats_seq_next(struct seq_file *m,
> +					void *v, loff_t *pos)
> +{
> +	struct wakeup_source *ws = v;
> +	struct wakeup_source *next_ws = NULL;
> +
> +	++(*pos);
>  
> -	print_wakeup_source_stats(m, &deleted_ws);
> +	list_for_each_entry_continue_rcu(ws, &wakeup_sources, entry) {
> +		next_ws = ws;
> +		break;
> +	}
> +
> +	return next_ws;
> +}
> +
> +static void wakeup_sources_stats_seq_stop(struct seq_file *m, void *v)
> +{
> +	int *srcuidx = m->private;
> +
> +	srcu_read_unlock(&wakeup_srcu, *srcuidx);
> +}
> +
> +/**
> + * wakeup_sources_stats_seq_show - Print wakeup sources statistics information.
> + * @m: seq_file to print the statistics into.
> + * @v: wakeup_source of each iteration
> + */
> +static int wakeup_sources_stats_seq_show(struct seq_file *m, void *v)
> +{
> +	struct wakeup_source *ws = v;
> +
> +	print_wakeup_source_stats(m, ws);
>  
>  	return 0;
>  }
>  
> +static const struct seq_operations wakeup_sources_stats_seq_ops = {
> +	.start = wakeup_sources_stats_seq_start,
> +	.next  = wakeup_sources_stats_seq_next,
> +	.stop  = wakeup_sources_stats_seq_stop,
> +	.show  = wakeup_sources_stats_seq_show,
> +};
> +
>  static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
>  {
> -	return single_open(file, wakeup_sources_stats_show, NULL);
> +	return seq_open_private(file, &wakeup_sources_stats_seq_ops, sizeof(int));
>  }
>  
>  static const struct file_operations wakeup_sources_stats_fops = {
> @@ -1062,7 +1105,7 @@ static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
>  	.open = wakeup_sources_stats_open,
>  	.read = seq_read,
>  	.llseek = seq_lseek,
> -	.release = single_release,
> +	.release = seq_release_private,
>  };
>  
>  static int __init wakeup_sources_debugfs_init(void)
> 

Applied, thanks!
