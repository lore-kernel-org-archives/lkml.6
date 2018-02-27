Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbeB0HWc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 02:22:32 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:40279 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbeB0HWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 02:22:31 -0500
X-Google-Smtp-Source: AG47ELsIrbjOILVI6qwwD9PwezulYckkai6S67wQypYtOrg6SFMPVriLFogvjk6yPnZSam8oI0LJq7pj3CAwmBrDYSE=
MIME-Version: 1.0
In-Reply-To: <85047448dc1d2d3c725b6b78d5ef2a89fc81b83b.1519659254.git.jtoppins@redhat.com>
References: <85047448dc1d2d3c725b6b78d5ef2a89fc81b83b.1519659254.git.jtoppins@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 27 Feb 2018 07:22:29 +0000
Message-ID: <CAKv+Gu9FVD18v6WA8MMG5LFX9GPObq_79hFuYv6j+S98a5Ej6w@mail.gmail.com>
Subject: Re: [PATCH] arm64/acpi: make ACPI boot preference configurable
To: Jonathan Toppins <jtoppins@redhat.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        prarit@redhat.com, rhkernel-list@redhat.com,
        Jon Masters <jcm@redhat.com>, Bhupesh Sharma <bhsharma@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        astone@redhat.com, James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 27 February 2018 at 06:05, Jonathan Toppins <jtoppins@redhat.com> wrote:
> This patch allows a user to configure ACPI to be preferred over
> device-tree.
>

This comes up once a year or so, and the consensus has been so far
that it is not up to the kernel to reason about whether DT or ACPI
should be preferred if both are supplied, Instead, it is up to the
firmware to ensure that only one of those is provided, and we added a
generic driver to EDK2 that implements this.

> Currently for ACPI to be used a user either has to set acpi=on on the
> kernel command line or make sure any device tree passed to the kernel
> is empty. If the dtb passed to the kernel is non-empty then device-tree
> will be chosen as the boot method of choice even if it is not correct.

Your firmware is terminally broken if it provides an incorrect DT, and
we should not be fixing it in the kernel.

> To prevent this situation where a system is only intended to be booted
> via ACPI a user can set this kernel configuration so it ignores
> device-tree settings unless ACPI table checks fail.
>

'only intended to be booted via ACPI' is a property of the system, not
of the OS. If you need this functionality for development, you can
append 'acpi=on' to the kernel command line via kconfig.


> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
> ---
>
>  arch/arm64/Kconfig       | 13 +++++++++++++
>  arch/arm64/kernel/acpi.c |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7381eeb7ef8e..da8d9ab62825 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1170,6 +1170,19 @@ config ARM64_ACPI_PARKING_PROTOCOL
>           protocol even if the corresponding data is present in the ACPI
>           MADT table.
>
> +config ARM64_PREFER_ACPI
> +       bool "Prefer usage of ACPI boot tables over device-tree"
> +       depends on ACPI
> +       help
> +         Normally device-tree is preferred over ACPI on arm64 unless
> +         explicitly preferred via kernel command line, something like: acpi=on
> +         This configuration changes this default behaviour by pretending
> +         the user set acpi=on on the command line. This configuration still
> +         allows the user to turn acpi table parsing off via acpi=off. If
> +         for some reason the table checks fail the system will still fall
> +         back to using device-tree unless the user explicitly sets acpi=force
> +         on the command line.
> +
>  config CMDLINE
>         string "Default kernel command string"
>         default ""
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 7b09487ff8fb..315b001c45f1 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -44,7 +44,7 @@ int acpi_pci_disabled = 1;    /* skip ACPI PCI scan and IRQ initialization */
>  EXPORT_SYMBOL(acpi_pci_disabled);
>
>  static bool param_acpi_off __initdata;
> -static bool param_acpi_on __initdata;
> +static bool param_acpi_on __initdata = IS_ENABLED(CONFIG_ARM64_PREFER_ACPI);
>  static bool param_acpi_force __initdata;
>
>  static int __init parse_acpi(char *arg)
> --
> 2.13.6
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
