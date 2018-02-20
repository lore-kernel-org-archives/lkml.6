Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeBTSmz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:42:55 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41258 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbeBTSmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:42:53 -0500
X-Google-Smtp-Source: AH8x227aZXwJdX8w3mNmsBoIFls3544bg2EAMsIe41yejeURwyE/jcV8gVuk5CDMvN4N1TK0WEcFcE/enU8FKWQ40ZI=
MIME-Version: 1.0
In-Reply-To: <20180220180506.65523-2-andriy.shevchenko@linux.intel.com>
References: <20180220180506.65523-1-andriy.shevchenko@linux.intel.com> <20180220180506.65523-2-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Feb 2018 19:42:52 +0100
X-Google-Sender-Auth: KBkfa0GIETkIUUW7JjOdI4GuW2Y
Message-ID: <CAJZ5v0i-zAnRjm_WRp0H6Dr5QLsUqsgYwmvhLLo_8yBgS4ehvg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] ACPI / x86: boot: Not all platforms require acpi_generic_reduced_hw_init()
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
> Some ACPI hardware reduced platforms need to initialize certain devices
> defined by the ACPI hardware specification even though in principle
> those devices should not be present in an ACPI hardware reduced platform.
>
> To allow that to happen, make it possible to override the generic
> x86_init callbacks and provide a custom legacy_pic value, add a new
> ->reduced_hw_early_init() callback to struct x86_init_acpi and make
> acpi_reduced_hw_init() use it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>
> - address Rafael's comments
> - requires patches from Juergen Gross
> - supposed to go via tip tree (x86/boot branch)
> - tested on ASuS T100ta (HW reduced) and Intel Broxton based platforms
>
>  arch/x86/include/asm/x86_init.h | 2 ++
>  arch/x86/kernel/acpi/boot.c     | 2 +-
>  arch/x86/kernel/x86_init.c      | 2 ++
>  3 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index 2e2c34d2bb00..5bd45a8f5ae3 100644
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
> index baa084ecffdb..7a37d9357bc4 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1390,7 +1390,7 @@ void __init acpi_generic_reduced_hw_init(void)
>  static void __init acpi_reduced_hw_init(void)
>  {
>         if (acpi_gbl_reduced_hardware)
> -               acpi_generic_reduced_hw_init();
> +               x86_init.acpi.reduced_hw_early_init();
>  }
>
>  /*
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index 9e4e994a4836..03452b73e2ea 100644
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
> +               .reduced_hw_early_init  = acpi_generic_reduced_hw_init,
>         },
>  };
>
> --
> 2.15.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
