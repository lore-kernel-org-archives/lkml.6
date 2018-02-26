Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754009AbeBZOwY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:52:24 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42203 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbeBZOwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:52:22 -0500
X-Google-Smtp-Source: AG47ELt9kkgVWKEejpH9jorxr4aPZrWHCXqYPsyuti6TAqD2KhfCSuIHbWLDWjTrGGnXOHsH2aigGf1Gj1kXWwovIZI=
MIME-Version: 1.0
In-Reply-To: <20180226023957.22861-1-douly.fnst@cn.fujitsu.com>
References: <20180226023957.22861-1-douly.fnst@cn.fujitsu.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 16:52:21 +0200
Message-ID: <CAHp75VcvSMc1mKMrk1Skm8kcer6NmRpM4hTUpU12FEfz+-+gKQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] x86/apic: Move pending intr check code into it's
 own function
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
> the pending interrupt check code is mixed with the local APIC setup code,
> that looks messy.
>
> Extract the related code, move it into a new function named
> apic_pending_intr_clear().

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
>  arch/x86/kernel/apic/apic.c | 98 ++++++++++++++++++++++++---------------------
>  1 file changed, 52 insertions(+), 46 deletions(-)
>
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 84b244ec49ed..be223ebd1bb3 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -1408,6 +1408,56 @@ static void lapic_setup_esr(void)
>                         oldvalue, value);
>  }
>
> +static void apic_pending_intr_clear(void)
> +{
> +       long long max_loops = cpu_khz ? cpu_khz : 1000000;
> +       unsigned long long tsc = 0, ntsc;
> +       unsigned int value, queued;
> +       int i, j, acked = 0;
> +
> +       if (boot_cpu_has(X86_FEATURE_TSC))
> +               tsc = rdtsc();
> +       /*
> +        * After a crash, we no longer service the interrupts and a pending
> +        * interrupt from previous kernel might still have ISR bit set.
> +        *
> +        * Most probably by now CPU has serviced that pending interrupt and
> +        * it might not have done the ack_APIC_irq() because it thought,
> +        * interrupt came from i8259 as ExtInt. LAPIC did not get EOI so it
> +        * does not clear the ISR bit and cpu thinks it has already serivced
> +        * the interrupt. Hence a vector might get locked. It was noticed
> +        * for timer irq (vector 0x31). Issue an extra EOI to clear ISR.
> +        */
> +       do {
> +               queued = 0;
> +               for (i = APIC_ISR_NR - 1; i >= 0; i--)
> +                       queued |= apic_read(APIC_IRR + i*0x10);
> +
> +               for (i = APIC_ISR_NR - 1; i >= 0; i--) {
> +                       value = apic_read(APIC_ISR + i*0x10);
> +                       for (j = 31; j >= 0; j--) {
> +                               if (value & (1<<j)) {
> +                                       ack_APIC_irq();
> +                                       acked++;
> +                               }
> +                       }
> +               }
> +               if (acked > 256) {
> +                       printk(KERN_ERR "LAPIC pending interrupts after %d EOI\n",
> +                              acked);
> +                       break;
> +               }
> +               if (queued) {
> +                       if (boot_cpu_has(X86_FEATURE_TSC) && cpu_khz) {
> +                               ntsc = rdtsc();
> +                               max_loops = (cpu_khz << 10) - (ntsc - tsc);
> +                       } else
> +                               max_loops--;
> +               }
> +       } while (queued && max_loops > 0);
> +       WARN_ON(max_loops <= 0);
> +}
> +
>  /**
>   * setup_local_APIC - setup the local APIC
>   *
> @@ -1417,13 +1467,7 @@ static void lapic_setup_esr(void)
>  static void setup_local_APIC(void)
>  {
>         int cpu = smp_processor_id();
> -       unsigned int value, queued;
> -       int i, j, acked = 0;
> -       unsigned long long tsc = 0, ntsc;
> -       long long max_loops = cpu_khz ? cpu_khz : 1000000;
> -
> -       if (boot_cpu_has(X86_FEATURE_TSC))
> -               tsc = rdtsc();
> +       unsigned int value;
>
>         if (disable_apic) {
>                 disable_ioapic_support();
> @@ -1475,45 +1519,7 @@ static void setup_local_APIC(void)
>         value &= ~APIC_TPRI_MASK;
>         apic_write(APIC_TASKPRI, value);
>
> -       /*
> -        * After a crash, we no longer service the interrupts and a pending
> -        * interrupt from previous kernel might still have ISR bit set.
> -        *
> -        * Most probably by now CPU has serviced that pending interrupt and
> -        * it might not have done the ack_APIC_irq() because it thought,
> -        * interrupt came from i8259 as ExtInt. LAPIC did not get EOI so it
> -        * does not clear the ISR bit and cpu thinks it has already serivced
> -        * the interrupt. Hence a vector might get locked. It was noticed
> -        * for timer irq (vector 0x31). Issue an extra EOI to clear ISR.
> -        */
> -       do {
> -               queued = 0;
> -               for (i = APIC_ISR_NR - 1; i >= 0; i--)
> -                       queued |= apic_read(APIC_IRR + i*0x10);
> -
> -               for (i = APIC_ISR_NR - 1; i >= 0; i--) {
> -                       value = apic_read(APIC_ISR + i*0x10);
> -                       for (j = 31; j >= 0; j--) {
> -                               if (value & (1<<j)) {
> -                                       ack_APIC_irq();
> -                                       acked++;
> -                               }
> -                       }
> -               }
> -               if (acked > 256) {
> -                       printk(KERN_ERR "LAPIC pending interrupts after %d EOI\n",
> -                              acked);
> -                       break;
> -               }
> -               if (queued) {
> -                       if (boot_cpu_has(X86_FEATURE_TSC) && cpu_khz) {
> -                               ntsc = rdtsc();
> -                               max_loops = (cpu_khz << 10) - (ntsc - tsc);
> -                       } else
> -                               max_loops--;
> -               }
> -       } while (queued && max_loops > 0);
> -       WARN_ON(max_loops <= 0);
> +       apic_pending_intr_clear();
>
>         /*
>          * Now that we are all set up, enable the APIC
> --
> 2.14.3
>
>
>



-- 
With Best Regards,
Andy Shevchenko
