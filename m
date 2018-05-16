Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeEPNKX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:10:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:41262 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbeEPNKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:10:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="224701186"
Message-ID: <ed9879ef42a70d2609f60f73834cabb7e3df9e2f.camel@linux.intel.com>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>
Date: Wed, 16 May 2018 16:10:15 +0300
In-Reply-To: <20180516104734.357oevogppu5bsg4@linutronix.de>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
         <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
         <20180516100842.xuma7b3e727w7bpz@linutronix.de>
         <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
         <20180516104734.357oevogppu5bsg4@linutronix.de>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-16 at 12:47 +0200, Sebastian Andrzej Siewior wrote:
> On 2018-05-16 13:17:36 [+0300], Andy Shevchenko wrote:
> > > The output is usually short so there
> > > shouldn't be much benefit from using it.
> > > I remember Tony wanted runtime-pm on the kernel console, too. And
> > > he
> > > told me explicit how to test it so that it works. Once the UART
> > > goes
> > > into PM (down), the whole IP block can go into power save mode.
> > > The
> > > board can be woken up by sending a character via the UART. The
> > > first few
> > > (incoming / read) characters are lost until the IP block is up
> > > again the
> > > frequency stable. This is known / expected.
> > 
> > Don't consider world the OMAP only. The things more complicated if
> > we
> > go out of it. Which I tried to explain in the commit message of
> > patch
> > 2.
> 
> I am not saying the world is OMAP only. I just tried to explain how
> any
> why it got there and its purpose. I haven't NACKed it. I would believe
> that with that information and Tony not defending his use case or
> possible change it somehow so it is not standing in your way, Greg
> would
> have enough information to go your way.

Yes, I got it.

> But since I am on it. You have to enable runtime-PM for the UART. So
> what is the problem if you simply don't enable it for the UART which
> used as the kernel console?

How do I know at the ->probe() time that device in question is going to
be kernel console? Maybe I missed simple way of it.

> From reading the description of #2, my understanding is that you are
> afraid that enabling the UART (bringing it from power-down mode) might
> take too long because it requires (or might require) an ACPI function
> call. This brings me again to: why bother and enable it in the first
> place? Because this might not work from NMI context.

> From looking at #2. You remove put/get in console_write()

...which must be removed in any case...

>  and avoid
> runtime PM by pm_runtime_get_noresume() and need the extra hook on
> console exit. I wasn't aware that you can remove the console at
> runtime
> (and assumed you have to stick to what said in console= at bootime).

> Because if that is the case, you could simply strip UART_CAP_RPM and
> then there is no more runtime-PM for you. Or is it too simple and I
> miss something here?

See above question. IIRC it's either too early or too late to decide on
per port basis.

> 
> > > In order to achieve the same thing you would have to disable the
> > > kernel
> > > console on that UART. I leave this to Tony.
> > 
> > Precisely the point of the series.

Besides above this would be needed _at least_ for several 8250 glue
drivers, so, I decide to go once for all.

> 
> Sebastian

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
