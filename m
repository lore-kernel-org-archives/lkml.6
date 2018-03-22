Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeCVCfD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 22:35:03 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39527 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbeCVCfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 22:35:02 -0400
X-Google-Smtp-Source: AG47ELsgjchY1z+heynvPSSgyUPbGcUEVRr5mBNnjev896CofLxznn05SjptLYEn/hZGA+mzYm7T2A==
Date: Thu, 22 Mar 2018 11:34:57 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        bugzilla-daemon@bugzilla.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, wen.yang99@zte.com.cn,
        Petr Mladek <pmladek@suse.com>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [Bug 199003] console stalled, cause Hard LOCKUP.
Message-ID: <20180322023457.GB3181@jagdpanzerIV>
References: <bug-199003-8243@https.bugzilla.kernel.org/>
 <bug-199003-8243-Txkdkdv5Cm@https.bugzilla.kernel.org/>
 <20180321094422.6e099480@gandalf.local.home>
 <20180322021437.GA3181@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322021437.GA3181@jagdpanzerIV>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/22/18 11:14), Sergey Senozhatsky wrote:
[..]
> Looking at
>  printk()->call_console_drivers()->serial8250_console_putchar()->wait_for_xmitr()
> 
> ... wait_for_xmitr() can spin for over 1 second waiting for the UART_MSR_CTS
> bit.

[..]

> a 1+ second long busy loop in the console driver is quite close to
> "problems guaranteed". But, wait, there is even more. This wait_for_xmitr()
> busy wait is happening after every character we print on the console. So
> printk("foo") will generate 5 * wait_for_xmitr() busy loops [foo + \r + \n].
> They punch&touch watchdog a lot, so at the least the system won't get killed
> by the hardlockup detector. But at the same time, it's still potentially a
> 1+ second busy loop in the console driver * strlen(message).

One does not even need to have concurrent printk()-s in this case. A
single CPU doing several direct printks under spin_lock is already
enough:

	CPUA						CPUB ~ CPUZ
	spin_lock(&lock)
	 printk->wait_for_xmitr				spin_lock(&lock)
	 printk->wait_for_xmitr
	 ...
	 printk->wait_for_xmitr				<< lockups >>
	 printk->wait_for_xmitr
	spin_unlock(&lock)

> Sometimes I really wish we had detached consoles. Direct printk()->console
> is nice and cool, but... we can't have it.

And this is, basically, what they do with printk_deferred(). We usually
use it to avoid deadlocks, but in this particular case it's used due to
the fact that direct printk() is way too painful, so they are detaching
printout and move it to another control path. Quite an interesting idea,
I must say.

	-ss
