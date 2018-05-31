Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754413AbeEaKFE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:05:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:36442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754273AbeEaKFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:05:01 -0400
Date: Thu, 31 May 2018 12:04:57 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: bhelgaas@google.com, sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>, corbet@lwn.net,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: Can printk() sleep at runtime?
Message-ID: <20180531100457.fncibp5cxdozvbjh@pathway.suse.cz>
References: <ba98332d-7013-f5cb-7d49-645ee6f49156@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba98332d-7013-f5cb-7d49-645ee6f49156@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Geert and timer people into Cc.

On Thu 2018-05-31 17:08:49, Jia-Ju Bai wrote:
> Hello,
> 
> I write a static analysis tool (DSAC), and it finds that printk can sleep.
> According to this finding, there is an example bug in drivers/pci/pci.c in
> Linux-4.16.7.
> 
> Here is the call path for this bug.
> Please look at it *from the bottom up*.
> 
> ========== BUG ==========
> [FUNC] __might_sleep
> kernel/locking/mutex.c: 747: __might_sleep in __mutex_lock_common
> kernel/locking/mutex.c: 893: __mutex_lock_common in __mutex_lock
> kernel/locking/mutex.c: 908: __mutex_lock in mutex_lock_nested
> drivers/clk/clk.c, 123: mutex_lock_nested in clk_prepare_lock
> drivers/clk/clk.c, 1369: clk_prepare_lock in clk_core_get_rate
> drivers/clk/clk.c, 1393: clk_core_get_rate in clk_get_rate
> lib/vsprintf.c, 1450: clk_get_rate in clock

The problem is in %pCr print format implementation. It calls
clk_get_rate() that might sleep. I wonder if we could use some
lock-less alternative instead.

Anyway, we need to fix or remove this format. vsprintf-like functions
are called in any context and nobody expect that they might sleep.

In each case, printk() must call it under logbuf_lock spinlock.
Otherwise, it would need to allocate a buffer for the formatted
string and it is not acceptable.

Best Regards,
Petr

> lib/vsprintf.c, 1944: clock in pointer
> lib/vsprintf.c, 2286: pointer in vsnprintf
> lib/vsprintf.c, 2385: vsnprintf in vscnprintf
> kernel/printk/printk.c, 1853: vscnprintf in vprintk_emit
> kernel/printk/printk.c, 1947: vprintk_emit in vprintk_default
> kernel/printk/printk_safe.c, 379: vprintk_default in vprintk_func
> kernel/printk/printk.c, 1980: vprintk_func in printk
> drivers/pci/pci.c, 5364: printk in pci_specified_resource_alignment
> drivers/pci/pci.c, 5313: spin_lock in pci_specified_resource_alignment
> 
> In fact, I suspect that my report is false, because I always have an
> impression that printk() cannot sleep.
> But according to the call path, I cannot find where I make the mistake...
> 
> So could someone please help me to point the mistake?
> 
> 
> Best wishes,
> Jia-Ju Bai
