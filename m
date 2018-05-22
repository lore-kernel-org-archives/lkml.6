Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753210AbeEVVju (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:39:50 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37272 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753168AbeEVVjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:39:48 -0400
X-Google-Smtp-Source: ADUXVKJjgWCPHhGgpJ5mRd0voN1ohsBXAQASQamumb79IMytmztqoG3YGniJvLfz66hJgdAw7DWJB3G23+bx9kVY8+c=
MIME-Version: 1.0
In-Reply-To: <20180517193008.GV25808@atomide.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
 <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
 <20180516100842.xuma7b3e727w7bpz@linutronix.de> <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
 <20180516104734.357oevogppu5bsg4@linutronix.de> <ed9879ef42a70d2609f60f73834cabb7e3df9e2f.camel@linux.intel.com>
 <20180517135621.GJ98604@atomide.com> <CAHp75VfqAK6+dPWWkQXjy0V-AFSGLSDJ9CmnUv=ba0F66TDTVg@mail.gmail.com>
 <20180517193008.GV25808@atomide.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 23 May 2018 00:39:46 +0300
Message-ID: <CAHp75Ve56pyEC41XZ9i9yxBNberQe=ee2miQL0v9T4vRtkWPBQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
To: Tony Lindgren <tony@atomide.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 10:30 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Andy Shevchenko <andy.shevchenko@gmail.com> [180517 16:41]:
>> On Thu, May 17, 2018 at 4:56 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [180516 13:12]:
>> >> On Wed, 2018-05-16 at 12:47 +0200, Sebastian Andrzej Siewior wrote:
>> >> > But since I am on it. You have to enable runtime-PM for the UART. So
>> >> > what is the problem if you simply don't enable it for the UART which
>> >> > used as the kernel console?
>> >>
>> >> How do I know at the ->probe() time that device in question is going to
>> >> be kernel console? Maybe I missed simple way of it.
>> >
>> > Hmm parse the kernel cmdline maybe? :)
>> >
>> > BTW, kernel already has earlycon doing exactly what you're trying to do.
>>
>> I'm sorry, I didn't follow. What exactly earlycon does?
>
> It provides a console very early on, see earlycon in
> Documentation/admin-guide/kernel-parameters.txt

Yes, but what we are talking is to put the kernel console out of power
management due to _real_ issues with it.

>> The problem is in 8250 driver. The issue with runtime PM used in atomic context.
>
> So how about add some "noidle" kernel command line parameter for console
> that calls
> pm_runtime_forbid() and then you have the UART permanently
> on.

IIUC _forbid() can be overwritten via sysfs.
And I would prefer to do other way around, something like console.idle
and put default for OMAP to yes and no for everything else.

> Hmm I guess you could make also serial8250_rpm_get() do nothing
> based on that.

Have you seen entire series which I keep here:
https://bitbucket.org/andy-shev/linux/branch/topic/uart/rpm?
Among other things it gets rid of those specific callbacks entirely.

> I do agree the serial runtime PM has an issue if it depends on
> pm_runtime_irq_safe() being set.

It's more than an issue. The  so called "support" of RPM for UART is
_based on the hack_.
I would love to NAK that in the first place if I would have known of it in time.

>> So, I can, of course just remove callbacks from the console ->write().
>> Though it will prevent to use kernel console anyway.
>
> Please et's not start breaking things, we already see a constant
> flow of regressions on weekly basis.

Now we are stick with a hack and the case based on that is against
fixing things.
This is how it looks from my side.

-- 
With Best Regards,
Andy Shevchenko
