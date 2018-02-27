Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932105AbeB0Mkd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 07:40:33 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38142 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbeB0Mkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 07:40:31 -0500
X-Google-Smtp-Source: AG47ELv79HGUA65kg0P3WyavmbKh0eDAW3lo2r7U2By7/CWmdpxThdLUCB5+odXbWxTFhDDqpcEy0tqqojRstE0GqtU=
MIME-Version: 1.0
In-Reply-To: <85047448dc1d2d3c725b6b78d5ef2a89fc81b83b.1519659254.git.jtoppins@redhat.com>
References: <85047448dc1d2d3c725b6b78d5ef2a89fc81b83b.1519659254.git.jtoppins@redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Tue, 27 Feb 2018 18:10:29 +0530
Message-ID: <CACi5LpM9hn17o7i7R3GUjQYy=6DFtCFKSbDUN7A7MGBTuf7=xw@mail.gmail.com>
Subject: Re: [PATCH] arm64/acpi: make ACPI boot preference configurable
To: Jonathan Toppins <jtoppins@redhat.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        astone@redhat.com, Jonathan Masters <jcm@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, rafael.j.wysocki@intel.com,
        Ingo Molnar <mingo@kernel.org>, Prarit Bhargava <prarit@redhat.com>,
        James Morse <james.morse@arm.com>, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 27, 2018 at 11:35 AM, Jonathan Toppins <jtoppins@redhat.com> wrote:
> This patch allows a user to configure ACPI to be preferred over
> device-tree.
>
> Currently for ACPI to be used a user either has to set acpi=on on the
> kernel command line or make sure any device tree passed to the kernel
> is empty. If the dtb passed to the kernel is non-empty then device-tree
> will be chosen as the boot method of choice even if it is not correct.

Hmm. Not sure if I correctly understand what you mean here by the term
'incorrect device tree'. Do you mean a corrupted device tree blob (but
normally we can catch those cases via the device tree header) or a
deliberate (or a broken) firmware attempt to pass an incorrect device
tree blob to the OS.

If its the later, I think the onus should be on the firmware (u-boot
or UEFI or others.. ) to fix the problems. I know we carry a lot of
fixes in the kernel for x86 firmware quirks but then we have several
broken x86 machines on which kernel has been running since several
years now.

IMO, if we have a known firmware quirk (to fix the broken DTB being
passed from the firmware), we can look at adding it in the early arm64
kernel code (similar to the quirk handling we do in the x86 early
kernel code for broken firmware), rather than forcing ACPI as the boot
method.

> To prevent this situation where a system is only intended to be booted
> via ACPI a user can set this kernel configuration so it ignores
> device-tree settings unless ACPI table checks fail.

Or, if decide to depreciate DTB as the boot method for such boards,
can we look at setting 'acpi=force' in the bootagrs always to make
sure that ACPI (and no fallback on DTB) is forced as the boot method
for such arm64 machines.

Regards,
Bhupesh

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
