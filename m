Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AIpwx49rWylMplUnfCVouJ7FthW8rKE1+lflHsoVzQDLyrgjcmpGvDK0pS5yQLQsg9kMS0UoEdsl
ARC-Seal: i=1; a=rsa-sha256; t=1522405529; cv=none;
        d=google.com; s=arc-20160816;
        b=cHtYwqMwTG86SmNLbsA2tCUrG2HACsnazi70/2gNxVSySrj3n6FJcdBChoWYiAGetf
         ioM/szEQ28idoYQUE3SKU65BIrzX0ksNEXWQxfhrTbHDxut7gne3WA+j9ZPNwx0pny+r
         gssfziwp2uxSJXcq6okZaVcCXMqalyrodwwNCjyZLmWNnLbnDWo0yr1aGTKaT0B6ANfr
         9pUQoOjbSIv7JcFKA6Q2Kr+3Um899wrKFRjYYGdcWqXjB/zC3qYQI30AZnyaauUpH0nw
         pk8BRiu4XtZrg17QIGS++pKIuV0uxwFwF2g5wWUn1uA8wCNJ7S5+KmFZt0nOSqypzaKj
         CCBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=JdXFXPnaT3CcQTXe3czAjgn2Gk8FUxzNGO5FkZtnLEY=;
        b=0FyCmN43QRlPWQTL8JOL0mOXPv4O/1dxzBRzkBaaHcksHBIT9Dwu/66fStGh765ZcQ
         oTSkRm8pLw0d2ExyJZ7jZhtOzo9puiVGHse2mi+GPAIzQAaZd2OOk/5BHuwN4SHSNC1r
         JVYgq0preAnXBw3s+M8QERRcz8aMBGHzqLjZO7Fm+HLYN1HXuXCUW8YeRnz0NFveCP7h
         vgNIQ5amj61GeSqNeby7SHPWvH2eZg0UHdq1+XlILpodRYX9T2Z2zei1IAiVLWrA/lUr
         wF7v/QcngoxaJoQl93eNi75V4b0KML4zX7vNH3+wRgIR+fHUsTt5Mp7VbufSWdb1/XDm
         Ka6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: pavel@ucw.cz, len.brown@intel.com, rafael@kernel.org, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM / wakeup: use seq_open() to show wakeup stats
Date: Fri, 30 Mar 2018 12:25:46 +0200
Message-ID: <2654052.UvzeiuBsVA@aspire.rjw.lan>
In-Reply-To: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com>
References: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594086852232118519?=
X-GMAIL-MSGID: =?utf-8?q?1596357899982673973?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Monday, March 5, 2018 9:47:46 AM CEST Ganesh Mahendran wrote:
> single_open() interface requires that the whole output must
> fit into a single buffer. This will lead to timeout when
> system memory is not in a good situation.
> 
> This patch use seq_open() to show wakeup stats. This method
> need only one page, so timeout will not be observed.
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
> +		if (n-- > 0)
> +			continue;
> +		goto out;
> +	}
> +	ws = NULL;
> +out:
> +	return ws;
> +}

Please clean up the above at least.

If I'm not mistaken, you don't need the label and the goto here.
