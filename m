Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeCUH26 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:28:58 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41750 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbeCUH25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:28:57 -0400
X-Google-Smtp-Source: AG47ELv1MF7T/N8Q1oXRuxKoNQBEqFgoN+VbDe0JXDQ+RnXJd5+wC7O6EraB8/QO2bBTaOJtD8YKjg==
Date: Wed, 21 Mar 2018 16:28:51 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: bugzilla-daemon@bugzilla.kernel.org
Cc: sergey.senozhatsky@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bug 199003] console stalled, cause Hard LOCKUP.
Message-ID: <20180321072851.GB468@jagdpanzerIV>
References: <bug-199003-14532@https.bugzilla.kernel.org/>
 <bug-199003-14532-4aWzZJgGHz@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-199003-14532-4aWzZJgGHz@https.bugzilla.kernel.org/>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/20/18 09:34), bugzilla-daemon@bugzilla.kernel.org wrote:
[..]
> Thanks very much.
> commit e480af09c49736848f749a43dff2c902104f6691 avoided the NMI watchdog
> trigger.

Hm, okay... But "touch_nmi_watchdog() everywhere printk/console-related"
is not exactly where I wanted us to be.

By the way e480af09c49736848f749a43dff2c902104f6691 is from 2006.
Are you sure you meant exactly that commit? What kernel do you use?


Are you saying that none of Steven's patches helped on your setups?


> And this patch may  avdoid long time blocking:
> https://lkml.org/lkml/2018/3/8/584
> 
> We've test it several days.

Hm, printk_deferred is a bit dangerous; it moves console_unlock() to
IRQ. So you still can have the problem of stuck CPUs, it's just now
you shut up the watchdog. Did you test Steven's patches?


A tricky part about printk_deferred() is that it does not use hand off
mechanism. And even more...  What we have with "printk vs printk"
sceanrio

	CPU0			CPU1		...		CPUN

	printk			printk
	 console_unlock 	 hand off			printk
	 			  console_unlock		 hand off
								  console_unlock

turns into a good old "one CPU prints it all" when we have "printk vs
printk_deferred" case. Because printk_deferred just log_store messages
and then _may be_ it grabs the console_sem from IRQ and invokes
console_unlock().

So it's something like this

	CPU0			CPU1		...		CPUN

	printk			printk_deffered
	 console_unlock						printk_deferred
	 console_unlock
	 console_unlock
	...			...				...
				printk_deffered			printk_deferred
	 console_unlock
	 console_unlock


// offtopic  "I can has printk_kthread?"



You now touch_nmi_watchdog() from the console driver [well... at least this
is what e480af09c4973 is doing, but I'm not sure I see how come you didn't
have it applied], so that's why you don't see hard lockups on that CPU0. But
your printing CPU still can stuck, which will defer RCUs on that CPU, etc.
etc. etc. So I'd say that those two approaches

		printk_deferred + touch_nmi_watchdog

combined can do quite some harm. One thing for sure - they don't really fix
any problems.

	-ss
