Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754027AbeEaHSt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:18:49 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44637 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753946AbeEaHSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:18:47 -0400
X-Google-Smtp-Source: ADUXVKKMT+CjwPRmUyyvt8r7dtc2iRiEuolpdHEgBHdSIhr2x83r8WSuCQ/9QfQBHa8c7NVvztXwBM88mpS0XDIiGdk=
MIME-Version: 1.0
In-Reply-To: <1527672059-6225-1-git-send-email-feng.tang@intel.com>
References: <1527672059-6225-1-git-send-email-feng.tang@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 May 2018 10:18:46 +0300
Message-ID: <CAHp75VdFZcNMMt6aRWicCozMJ+wfAyJ4ajegHCgNg2X-x_KN_A@mail.gmail.com>
Subject: Re: [RFC 1/2] printk: Enable platform to provide a early boot clock
To: Feng Tang <feng.tang@intel.com>
Cc: Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alek.du@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 12:20 PM, Feng Tang <feng.tang@intel.com> wrote:
> Currently printk timestamp mostly come from the sched_clock which
> depends on the clock setup, so there are many kernel logs started
> with "[    0.000000]   " before the clock is calibrated.
>
> This patch will provide an debug option for specific platform to
> provide a early boot time clock, so that we can have time info in
> kernel log much earlier, which can show the time info for the early
> kernel boot, and make boottime tuning/optimization easier (boot time
> is critical for phone/tablet and embedded devices).
>
> Capable platform only need to setup the "boot_printk_clock_fn"
> which could return time in nano seconds.
>
> Together with a TSC patch on x86 system, we have easily captured
> some early boottime killer like unwind_init() which takes about
> 300ms in boot phase.

> +static u64 printk_clock(void)
> +{
> +       /* If platform provides early boot printk clock, then use it */
> +       if (unlikely(system_state == SYSTEM_BOOTING && boot_printk_clock_fn))
> +               return boot_printk_clock_fn();
> +       else
> +               return local_clock();

'else' is redundant.

> +}


-- 
With Best Regards,
Andy Shevchenko
