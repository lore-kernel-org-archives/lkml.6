Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753326AbeE3NZL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:25:11 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37633 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbeE3NZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:25:08 -0400
X-Google-Smtp-Source: ADUXVKKDOFnSbjgBYPuMHY12X56znZ7EmgPg7XIxS0H/He7gixNvRvPqP4clovhR+HTsJRKNOFFtMWNvH/v2IbTAAtI=
MIME-Version: 1.0
In-Reply-To: <1527672059-6225-2-git-send-email-feng.tang@intel.com>
References: <1527672059-6225-1-git-send-email-feng.tang@intel.com> <1527672059-6225-2-git-send-email-feng.tang@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 May 2018 16:25:07 +0300
Message-ID: <CAHp75Vcii2=TDxBWeOve05peyiYiPeMu_ocBvj5SJ8UB+94eNQ@mail.gmail.com>
Subject: Re: [RFC 2/2] x86, tsc: Enable clock for ealry printk timestamp
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
> To show time info in kernel log earlier and help optimizing kernel
> boot time, printk adds a debug hook "boot_printk_clock_fn()"  for
> capable platform which has accurate clock in early boot phase.
>
> This patch will add early param setup option, so that user can
> chose to provide a tsc based early printk clock simply by adding
> in command line: "boot_tsc=xxxxM" (xxxxM is the stable TSC freq).

> +

This line is not needed.

> +       cur_tsc = rdtsc();
> +       cur_tsc -= boot_tsc_offset;

In one expression?

> +       if (!p)
> +               return -EINVAL;
> +

I'm not sure it's needed at all.

> +       boot_tsc_mhz = div64_u64(tsc_hz, 1024 * 1024);

Hmm... 1024*1024 != 1000 * 1000. So, hz -> mhz here (as by suffixes)
looks weird.

> +       if (boot_tsc_mhz == 0)
> +               return -EINVAL;

> +       pr_info("TSC has run for %lld us\n",
> +               div64_u64(boot_tsc_offset, boot_tsc_mhz));
> +
> +       /* Setup the early printk clock */
> +       boot_printk_clock_fn = boot_tsc_clock;

> +       pr_info("TSC: Setup early printk timestamp with %lldM TSC.",
> +               boot_tsc_mhz);

Perhaps remove period (above doesn't have it) and move this to one line?

-- 
With Best Regards,
Andy Shevchenko
