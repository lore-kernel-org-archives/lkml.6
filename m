Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeEPKro (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:47:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38465 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752101AbeEPKrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:47:41 -0400
Date: Wed, 16 May 2018 12:47:35 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
Message-ID: <20180516104734.357oevogppu5bsg4@linutronix.de>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
 <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
 <20180516100842.xuma7b3e727w7bpz@linutronix.de>
 <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-16 13:17:36 [+0300], Andy Shevchenko wrote:
> > The output is usually short so there
> > shouldn't be much benefit from using it.
> 
> > I remember Tony wanted runtime-pm on the kernel console, too. And he
> > told me explicit how to test it so that it works. Once the UART goes
> > into PM (down), the whole IP block can go into power save mode. The
> > board can be woken up by sending a character via the UART. The first few
> > (incoming / read) characters are lost until the IP block is up again the
> > frequency stable. This is known / expected.
> 
> Don't consider world the OMAP only. The things more complicated if we
> go out of it. Which I tried to explain in the commit message of patch
> 2.

I am not saying the world is OMAP only. I just tried to explain how any
why it got there and its purpose. I haven't NACKed it. I would believe
that with that information and Tony not defending his use case or
possible change it somehow so it is not standing in your way, Greg would
have enough information to go your way.
But since I am on it. You have to enable runtime-PM for the UART. So
what is the problem if you simply don't enable it for the UART which
used as the kernel console?
>From reading the description of #2, my understanding is that you are
afraid that enabling the UART (bringing it from power-down mode) might
take too long because it requires (or might require) an ACPI function
call. This brings me again to: why bother and enable it in the first
place? Because this might not work from NMI context.

>From looking at #2. You remove put/get in console_write() and avoid
runtime PM by pm_runtime_get_noresume() and need the extra hook on
console exit. I wasn't aware that you can remove the console at runtime
(and assumed you have to stick to what said in console= at bootime).
Because if that is the case, you could simply strip UART_CAP_RPM and
then there is no more runtime-PM for you. Or is it too simple and I
miss something here?

> > In order to achieve the same thing you would have to disable the kernel
> > console on that UART. I leave this to Tony.
> 
> Precisely the point of the series.

Sebastian
