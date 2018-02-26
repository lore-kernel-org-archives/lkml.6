Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752744AbeBZLuJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:50:09 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45395 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752048AbeBZLuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:50:07 -0500
X-Google-Smtp-Source: AG47ELs0csZJF2UfxTIxP/OdpYIQUV3nBY9PNYfwZ9aiabFDWnVj6HVlPoXtyDzwVuY0fKTtT5x+BYShS7zcgwLmdcc=
MIME-Version: 1.0
In-Reply-To: <20180226023957.22861-2-douly.fnst@cn.fujitsu.com>
References: <20180226023957.22861-1-douly.fnst@cn.fujitsu.com> <20180226023957.22861-2-douly.fnst@cn.fujitsu.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 13:50:06 +0200
Message-ID: <CAHp75Vf6NwsB2CTPThG-95OgD6Xb6AHU2KGRnjxDGk4KP9xyWg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] x86/apic: Replace common tools with new ones
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, ebiederm@xmission.com,
        Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 4:39 AM, Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> The pending interrupt check code is old, update the following.
>
>   -Replace for-if pair with for_each_set_bit()
>   -Replace printk() with pr_err()
>
> Also merge the printk's code in one line and make curly braces balanced
>

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
> changlog:
> v3 --> v4:
>   -Fix the wrong check for bit 0 suggested by Andy
>
>  arch/x86/kernel/apic/apic.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index be223ebd1bb3..81db2aab257b 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -1412,7 +1412,8 @@ static void apic_pending_intr_clear(void)
>  {
>         long long max_loops = cpu_khz ? cpu_khz : 1000000;
>         unsigned long long tsc = 0, ntsc;
> -       unsigned int value, queued;
> +       unsigned int queued;
> +       unsigned long value;
>         int i, j, acked = 0;
>
>         if (boot_cpu_has(X86_FEATURE_TSC))
> @@ -1435,24 +1436,22 @@ static void apic_pending_intr_clear(void)
>
>                 for (i = APIC_ISR_NR - 1; i >= 0; i--) {
>                         value = apic_read(APIC_ISR + i*0x10);
> -                       for (j = 31; j >= 0; j--) {
> -                               if (value & (1<<j)) {
> -                                       ack_APIC_irq();
> -                                       acked++;
> -                               }
> +                       for_each_set_bit(j, &value, 32) {
> +                               ack_APIC_irq();
> +                               acked++;
>                         }
>                 }
>                 if (acked > 256) {
> -                       printk(KERN_ERR "LAPIC pending interrupts after %d EOI\n",
> -                              acked);
> +                       pr_err("LAPIC pending interrupts after %d EOI\n", acked);
>                         break;
>                 }
>                 if (queued) {
>                         if (boot_cpu_has(X86_FEATURE_TSC) && cpu_khz) {
>                                 ntsc = rdtsc();
>                                 max_loops = (cpu_khz << 10) - (ntsc - tsc);
> -                       } else
> +                       } else {
>                                 max_loops--;
> +                       }
>                 }
>         } while (queued && max_loops > 0);
>         WARN_ON(max_loops <= 0);
> --
> 2.14.3
>
>
>



-- 
With Best Regards,
Andy Shevchenko
