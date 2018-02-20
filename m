Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbeBTQ1a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:27:30 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44520 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753148AbeBTQ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:27:20 -0500
X-Google-Smtp-Source: AG47ELscerVaZPmGtrbdU/uiwqnn2oOm2l2tw4U2c/43gJsL1m4vnNvbw37kerUWroPD/+055DH0dh2kgGY7Nlp6hUA=
MIME-Version: 1.0
In-Reply-To: <20180220160358.68832-1-andriy.shevchenko@linux.intel.com>
References: <20180220160358.68832-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Feb 2018 17:27:18 +0100
X-Google-Sender-Auth: ovEXqF50ufGpDS0OJV0Vumu0Td0
Message-ID: <CAJZ5v0jAvkcNgieaRjnAss+vqg+=+STp8-ASqjVAh_KxP+swOQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ACPI / x86: boot: Not all platforms require acpi_reduced_hw_init()
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

On Tue, Feb 20, 2018 at 5:03 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Some platforms might take care of legacy devices on theirs own. Due to this,
> export acpi_reduced_hw_init() and put it into struct x86_init_acpi.

IMO this completely doesn't explain what really happens here.

You basically want to provide your own versions of
x86_init.timers.timer_init, x86_init.irqs.pre_vector_init and
legacy_pic on some HW-reduced platforms AFAICS, so you make it
possible for the platform to provide its own variant of
acpi_reduced_hw_init().

I would say something like this:

"Some ACPI hawdware-reduced platforms need to initialize certain
devices defined by the ACPI hardware specification even though in
principle those devices should not be present in an ACPI
hawdware-reduced platform.  To allow that to happen, make it possible
to override the generic x86_init callbacks and provide a custom
legacy_pic value, add a new ->reduced_hw_early_init() callback to
struct x86_init_acpi and make acpi_reduced_hw_init() use it."

And I would retain acpi_reduced_hw_init(), but ->

> While doing this, rename acpi_reduced_hw_init() to
> acpi_reduced_hw_early_init() to show the stage at which it's called.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> - re-done based on patches from Juergen Gross
> - supposed to go via tip tree (x86/boot branch)
> - tested on ASuS T100ta (HW reduced) and Intel Broxton based platforms
>
>  arch/x86/include/asm/acpi.h     |  4 ++++
>  arch/x86/include/asm/x86_init.h |  2 ++
>  arch/x86/kernel/acpi/boot.c     | 21 ++++++++++-----------
>  arch/x86/kernel/x86_init.c      |  2 ++
>  4 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index 6609dd7289b5..f3f86be35fc5 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -140,6 +140,8 @@ static inline u64 acpi_arch_get_root_pointer(void)
>         return x86_init.acpi.get_root_pointer();
>  }
>
> +void acpi_reduced_hw_early_init(void);
> +
>  #else /* !CONFIG_ACPI */
>
>  #define acpi_lapic 0
> @@ -149,6 +151,8 @@ static inline void acpi_noirq_set(void) { }
>  static inline void acpi_disable_pci(void) { }
>  static inline void disable_acpi(void) { }
>
> +static inline void acpi_reduced_hw_early_init(void) { }
> +
>  #endif /* !CONFIG_ACPI */
>
>  #define ARCH_HAS_POWER_INIT    1
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index 5ffa116ddb08..199e15bd3ec5 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -133,9 +133,11 @@ struct x86_hyper_init {
>  /**
>   * struct x86_init_acpi - x86 ACPI init functions
>   * @get_root_pointer:          get RSDP address
> + * @reduced_hw_early_init:     hardware reduced platform early init
>   */
>  struct x86_init_acpi {
>         u64 (*get_root_pointer)(void);
> +       void (*reduced_hw_early_init)(void);
>  };
>
>  /**
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index d3deae23e584..02acf1c58d3a 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1378,17 +1378,15 @@ static int __init dmi_ignore_irq0_timer_override(const struct dmi_system_id *d)
>   *
>   * We initialize the Hardware-reduced ACPI model here:
>   */
> -static void __init acpi_reduced_hw_init(void)
> +void __init acpi_reduced_hw_early_init(void)

-> I would call this acpi_generic_reduced_hw_init() and ->>

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
> +       /*
> +        * Override x86_init functions and bypass legacy pic
> +        * in Hardware-reduced ACPI mode.
> +        */
> +       x86_init.timers.timer_init      = x86_init_noop;
> +       x86_init.irqs.pre_vector_init   = x86_init_noop;
> +       legacy_pic                      = &null_legacy_pic;
>  }
>
>  /*
> @@ -1593,7 +1591,8 @@ int __init early_acpi_boot_init(void)
>         /*
>          * Hardware-reduced ACPI mode initialization:
>          */
> -       acpi_reduced_hw_init();
> +       if (acpi_gbl_reduced_hardware)
> +               x86_init.acpi.reduced_hw_early_init();

->> I would put the two lines above into acpi_reduced_hw_init().

>
>         return 0;
>  }
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index 32c288ebf870..8fd63640e764 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -8,6 +8,7 @@
>  #include <linux/export.h>
>  #include <linux/pci.h>
>
> +#include <asm/acpi.h>
>  #include <asm/bios_ebda.h>
>  #include <asm/paravirt.h>
>  #include <asm/pci_x86.h>
> @@ -95,6 +96,7 @@ struct x86_init_ops x86_init __initdata = {
>
>         .acpi = {
>                 .get_root_pointer       = u64_x86_init_noop,
> +               .reduced_hw_early_init  = acpi_reduced_hw_early_init,
>         },
>  };
>
> --
