Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeBTSmd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:42:33 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42812 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeBTSmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:42:32 -0500
X-Google-Smtp-Source: AH8x226rg9KEgtupJIqAlpUwIoEpMWc6cVX/8qTzsrGSikdyT38IbPsOjnFEbImMJxLVehd1VAKmWSjSGY3bEdknVVU=
MIME-Version: 1.0
In-Reply-To: <20180220180506.65523-1-andriy.shevchenko@linux.intel.com>
References: <20180220180506.65523-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Feb 2018 19:42:30 +0100
X-Google-Sender-Auth: nEdxyby6_UteqXxRWgJePYs0hG0
Message-ID: <CAJZ5v0g7XO2N0vCi-A95MDjgJpTS0M=ZXrSGu2fqkwSHZ79GEg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] ACPI / x86: boot: Split out acpi_generic_reduce_hw_init()
 and export
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 7:05 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> This is a preparation patch to allow override the hardware reduced
> initialization on ACPI enabled platforms.
>
> No functional change intended.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/include/asm/acpi.h |  4 ++++
>  arch/x86/kernel/acpi/boot.c | 22 +++++++++++++---------
>  2 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index 6609dd7289b5..a303d7b7d763 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -140,6 +140,8 @@ static inline u64 acpi_arch_get_root_pointer(void)
>         return x86_init.acpi.get_root_pointer();
>  }
>
> +void acpi_generic_reduced_hw_init(void);
> +
>  #else /* !CONFIG_ACPI */
>
>  #define acpi_lapic 0
> @@ -149,6 +151,8 @@ static inline void acpi_noirq_set(void) { }
>  static inline void acpi_disable_pci(void) { }
>  static inline void disable_acpi(void) { }
>
> +static inline void acpi_generic_reduced_hw_init(void) { }
> +
>  #endif /* !CONFIG_ACPI */
>
>  #define ARCH_HAS_POWER_INIT    1
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 2aa92094b59d..baa084ecffdb 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1376,17 +1376,21 @@ static int __init dmi_ignore_irq0_timer_override(const struct dmi_system_id *d)
>   *
>   * We initialize the Hardware-reduced ACPI model here:
>   */
> +void __init acpi_generic_reduced_hw_init(void)
> +{
> +       /*
> +        * Override x86_init functions and bypass legacy PIC in
> +        * hardware reduced ACPI mode.
> +        */
> +       x86_init.timers.timer_init      = x86_init_noop;
> +       x86_init.irqs.pre_vector_init   = x86_init_noop;
> +       legacy_pic                      = &null_legacy_pic;
> +}
> +
>  static void __init acpi_reduced_hw_init(void)
>  {
> -       if (acpi_gbl_reduced_hardware) {
> -               /*
> -                * Override x86_init functions and bypass legacy pic
> -                * in Hardware-reduced ACPI mode
> -                */
> -               x86_init.timers.timer_init      = x86_init_noop;
> -               x86_init.irqs.pre_vector_init   = x86_init_noop;
> -               legacy_pic                      = &null_legacy_pic;
> -       }
> +       if (acpi_gbl_reduced_hardware)
> +               acpi_generic_reduced_hw_init();
>  }
>
>  /*
> --
> 2.15.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
