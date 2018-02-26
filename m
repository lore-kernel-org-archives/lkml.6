Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeBZGhl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 01:37:41 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33949 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeBZGhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 01:37:40 -0500
X-Google-Smtp-Source: AH8x225yPZNzn1IvHHqSe8PDiyesLD+rkCwRbPyJrRsEdfJtUfw3LSmshlmYX7BvJMM2IlB9mSQfJQ==
Date: Mon, 26 Feb 2018 15:37:35 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3] printk: Relocate wake_klogd check close to the end of
 console_unlock()
Message-ID: <20180226063735.GC12539@jagdpanzerIV>
References: <20180208130402.15157-1-pmladek@suse.com>
 <20180219155817.yfo7yrnz4vyzxerx@pathway.suse.cz>
 <20180219160122.upqkpbbffm3rth6p@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219160122.upqkpbbffm3rth6p@pathway.suse.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/19/18 17:01), Petr Mladek wrote:
[..]
> -	raw_spin_lock(&logbuf_lock);
>  	retry = console_seq != log_next_seq;
> +	/*
> +	 * Check whether userland needs notification. Do this only when really
> +	 * leaving to avoid race with console_trylock_spinning().
> +	 */
> +	if (seen_seq != log_next_seq && !retry) {
> +		wake_klogd = true;
> +		seen_seq = log_next_seq;
> +	}

Let's add the "why" part. This "!retry" might be hard to understand. We
are looking at

- CPUa is about to leave console_unlock()
- printk on CPUb appends a new message
- CPUa detects that `console_seq != log_next_seq', updates `seen_seq'
- printk on CPUb is getting preempted
- CPUa re-takes the console_sem via retry path
- printk CPUb is becoming TASK_RUNNING again - it now spins for console_sem,
  since we have an active console_sem owner
- CPUa detects that there is a console_sem waiter, so it offloads the
  printing task, without ever waking up klogd


Either we can have that complex "seen_seq != log_next_seq && !retry"
check - or we simply can add

	if (console_lock_spinning_disable_and_check()) {
		printk_safe_exit_irqrestore(flags);
		if (wake_klogd)
			wake_up_klogd();
	}

to the offloading return path.

The later is *may be* simpler to follow. The rule is: every
!console_suspend and !cant-use-consoles return path from console_unlock()
must wake_up_klogd() [if needed].

	-ss
