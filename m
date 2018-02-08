Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeBHOxN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:53:13 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35820 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeBHOxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:53:12 -0500
X-Google-Smtp-Source: AH8x227AGhSyJycetLE8u9boJZ5GYpW7O74SAlpY60FkKsQ+5dhCWQSb4crz9+epDa1c8rl7rBSQ1A==
Date: Thu, 8 Feb 2018 23:53:07 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] printk: Relocate wake_klogd check close to the end of
 console_unlock()
Message-ID: <20180208145307.GA485@tigerII.localdomain>
References: <20180208130402.15157-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208130402.15157-1-pmladek@suse.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/08/18 14:04), Petr Mladek wrote:
> We mark for waking up klogd whenever we see a new message sequence in
> the main loop.  However, the actual wakeup is always at the end of the
> function and we can easily test for the wakeup condition when we do
> the final should-we-repeat check.
> 
> Move the wake_klogd condition check out of the main loop.  This avoids
> doing the same thing repeatedly and groups similar checks into a
> common place.
> 
> This fixes a race introduced by the commit dbdda842fe96f8932 ("printk: Add
> console owner and waiter logic to load balance console writes").
> The current console owner might process the newly added message before
> the related printk() start waiting for the console lock. Then the lock
> is passed without waking klogd. The new owner sees the already updated
> seen_seq and does not know that the wakeup is needed.

I need to do more "research" on this. I though about it some time ago,
and I think that waking up klogd _only_ when we don't have any pending
logbuf messages still can be pretty late. Can't it? We can spin in
console_unlock() printing loop for a long time, probably passing
console_sem ownership between CPUs, without waking up the log_wait waiter.
May be we can wake it up from the printing loop, outside of logbuf_lock,
and let klogd to compete for logbuf_lock with the printing CPU. Why do
we wake it up only when we are done pushing messages to a potentially
slow serial console?

	-ss
