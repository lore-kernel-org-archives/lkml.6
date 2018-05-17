Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeEQTaQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 15:30:16 -0400
Received: from muru.com ([72.249.23.125]:42828 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752234AbeEQTaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 15:30:13 -0400
Date: Thu, 17 May 2018 12:30:08 -0700
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
Message-ID: <20180517193008.GV25808@atomide.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
 <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
 <20180516100842.xuma7b3e727w7bpz@linutronix.de>
 <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
 <20180516104734.357oevogppu5bsg4@linutronix.de>
 <ed9879ef42a70d2609f60f73834cabb7e3df9e2f.camel@linux.intel.com>
 <20180517135621.GJ98604@atomide.com>
 <CAHp75VfqAK6+dPWWkQXjy0V-AFSGLSDJ9CmnUv=ba0F66TDTVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfqAK6+dPWWkQXjy0V-AFSGLSDJ9CmnUv=ba0F66TDTVg@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andy.shevchenko@gmail.com> [180517 16:41]:
> On Thu, May 17, 2018 at 4:56 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [180516 13:12]:
> >> On Wed, 2018-05-16 at 12:47 +0200, Sebastian Andrzej Siewior wrote:
> >> > But since I am on it. You have to enable runtime-PM for the UART. So
> >> > what is the problem if you simply don't enable it for the UART which
> >> > used as the kernel console?
> >>
> >> How do I know at the ->probe() time that device in question is going to
> >> be kernel console? Maybe I missed simple way of it.
> >
> > Hmm parse the kernel cmdline maybe? :)
> >
> > BTW, kernel already has earlycon doing exactly what you're trying to do.
> 
> I'm sorry, I didn't follow. What exactly earlycon does?

It provides a console very early on, see earlycon in
Documentation/admin-guide/kernel-parameters.txt

> The problem is in 8250 driver. The issue with runtime PM used in atomic context.

So how about add some "noidle" kernel command line parameter for console
that calls pm_runtime_forbid() and then you have the UART permanently
on. Hmm I guess you could make also serial8250_rpm_get() do nothing
based on that.

I do agree the serial runtime PM has an issue if it depends on
pm_runtime_irq_safe() being set.

> So, I can, of course just remove callbacks from the console ->write().
> Though it will prevent to use kernel console anyway.

Please et's not start breaking things, we already see a constant
flow of regressions on weekly basis.

Regards,

Tony
