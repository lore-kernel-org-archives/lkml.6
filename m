Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755880AbeEaRXF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:23:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44994 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755556AbeEaRXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:23:04 -0400
Subject: Re: [RFC 1/2] printk: Enable platform to provide a early boot clock
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Feng Tang <feng.tang@intel.com>
Cc: Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alek.du@intel.com
References: <1527672059-6225-1-git-send-email-feng.tang@intel.com>
 <CAHp75VdFZcNMMt6aRWicCozMJ+wfAyJ4ajegHCgNg2X-x_KN_A@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ea92b4fb-a1c9-a961-b67e-7834e351d6e1@infradead.org>
Date: Thu, 31 May 2018 10:22:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdFZcNMMt6aRWicCozMJ+wfAyJ4ajegHCgNg2X-x_KN_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/2018 12:18 AM, Andy Shevchenko wrote:
> On Wed, May 30, 2018 at 12:20 PM, Feng Tang <feng.tang@intel.com> wrote:
>> Currently printk timestamp mostly come from the sched_clock which
>> depends on the clock setup, so there are many kernel logs started
>> with "[    0.000000]   " before the clock is calibrated.
>>
>> This patch will provide an debug option for specific platform to
>> provide a early boot time clock, so that we can have time info in
>> kernel log much earlier, which can show the time info for the early
>> kernel boot, and make boottime tuning/optimization easier (boot time
>> is critical for phone/tablet and embedded devices).
>>
>> Capable platform only need to setup the "boot_printk_clock_fn"
>> which could return time in nano seconds.
>>
>> Together with a TSC patch on x86 system, we have easily captured
>> some early boottime killer like unwind_init() which takes about
>> 300ms in boot phase.
> 
>> +static u64 printk_clock(void)
>> +{
>> +       /* If platform provides early boot printk clock, then use it */
>> +       if (unlikely(system_state == SYSTEM_BOOTING && boot_printk_clock_fn))
>> +               return boot_printk_clock_fn();
>> +       else
>> +               return local_clock();
> 
> 'else' is redundant.

So it is.  Is this a style comment?
This shouldn't matter to a smart compiler, should it?

>> +}

thanks,
-- 
~Randy
