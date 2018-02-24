Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbeBXQiw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 11:38:52 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:39124 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbeBXQit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 11:38:49 -0500
X-Google-Smtp-Source: AG47ELu204gLpHZ3fIldwLYv7EOLcrZtaaHrGLXsAF1SX6KOU+xiiAxuqhcq7OJZ800iDhIT/2zXLpiqmQSdz2DhcsI=
MIME-Version: 1.0
In-Reply-To: <20180223200333.6410-3-Yazen.Ghannam@amd.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com> <20180223200333.6410-3-Yazen.Ghannam@amd.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 24 Feb 2018 16:38:47 +0000
Message-ID: <CAKv+Gu8ShPeJz0HsqR=8GSjj+PyC=sVJv_MhidVR6cU4W-WjLA@mail.gmail.com>
Subject: Re: [PATCH 2/8] efi: Decode IA32/X64 Processor Error Section
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 February 2018 at 20:03, Yazen Ghannam <Yazen.Ghannam@amd.com> wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
>
> Recognize the IA32/X64 Processor Error Section.
>
> Do the section decoding in a new "cper-x86.c" file and add this to the
> Makefile depending on a new "UEFI_CPER_X86" config option.
>
> Print the Local APIC ID and CPUID info from the Processor Error Record.
>
> The "Processor Error Info" and "Processor Context" fields will be
> decoded in following patches.
>
> Based on UEFI 2.7 Table 255. Processor Error Record.
>
> Cc: <stable@vger.kernel.org> # 4.16.x
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/firmware/efi/Kconfig    |  5 +++++
>  drivers/firmware/efi/Makefile   |  2 ++
>  drivers/firmware/efi/cper-x86.c | 26 ++++++++++++++++++++++++++
>  drivers/firmware/efi/cper.c     | 10 ++++++++++
>  include/linux/cper.h            |  2 ++
>  5 files changed, 45 insertions(+)
>  create mode 100644 drivers/firmware/efi/cper-x86.c
>
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 3098410abad8..8b684147835d 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -174,6 +174,11 @@ config UEFI_CPER_ARM
>         depends on UEFI_CPER && ( ARM || ARM64 )
>         default y
>
> +config UEFI_CPER_X86
> +       bool
> +       depends on UEFI_CPER && ( X86_32 || X86_64 )

Just 'UEFI_CPER && X86' should be sufficient, no?

> +       default y
> +
>  config EFI_DEV_PATH_PARSER
>         bool
>         depends on ACPI
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index cb805374f4bc..7cf8d75ebe51 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -31,3 +31,5 @@ obj-$(CONFIG_ARM)                     += $(arm-obj-y)
>  obj-$(CONFIG_ARM64)                    += $(arm-obj-y)
>  obj-$(CONFIG_EFI_CAPSULE_LOADER)       += capsule-loader.o
>  obj-$(CONFIG_UEFI_CPER_ARM)            += cper-arm.o
> +

Spurious newline

> +obj-$(CONFIG_UEFI_CPER_X86)            += cper-x86.o
> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
> new file mode 100644
> index 000000000000..b50ee3cdf637
> --- /dev/null
> +++ b/drivers/firmware/efi/cper-x86.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018, Advanced Micro Devices, Inc.
> +// Copyright (C) 2018, Yazen Ghannam <yazen.ghannam@amd.com>
> +

Do you really own the copyright for code that you write on behalf of
your employer?

> +#include <linux/cper.h>
> +
> +/*
> + * We don't need a "CPER_IA" prefix since these are all locally defined.
> + * This will save us a lot of line space.
> + */
> +#define VALID_LAPIC_ID                 BIT_ULL(0)
> +#define VALID_CPUID_INFO               BIT_ULL(1)
> +
> +void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
> +{
> +       printk("%sValidation Bits: 0x%016llx\n", pfx, proc->validation_bits);
> +
> +       if (proc->validation_bits & VALID_LAPIC_ID)
> +               printk("%sLocal APIC_ID: 0x%llx\n", pfx, proc->lapic_id);
> +
> +       if (proc->validation_bits & VALID_CPUID_INFO) {
> +               printk("%sCPUID Info:\n", pfx);
> +               print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, proc->cpuid,
> +                              sizeof(proc->cpuid), 0);
> +       }
> +}
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index c165933ebf38..5a59b582c9aa 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -469,6 +469,16 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
>                         cper_print_proc_arm(newpfx, arm_err);
>                 else
>                         goto err_section_too_small;
> +#endif
> +#if defined(CONFIG_UEFI_CPER_X86)
> +       } else if (guid_equal(sec_type, &CPER_SEC_PROC_IA)) {
> +               struct cper_sec_proc_ia *ia_err = acpi_hest_get_payload(gdata);
> +
> +               printk("%ssection_type: IA32/X64 processor error\n", newpfx);
> +               if (gdata->error_data_length >= sizeof(*ia_err))
> +                       cper_print_proc_ia(newpfx, ia_err);
> +               else
> +                       goto err_section_too_small;
>  #endif
>         } else {
>                 const void *err = acpi_hest_get_payload(gdata);
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index 4b5f8459b403..9c703a0abe6e 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -551,5 +551,7 @@ const char *cper_mem_err_unpack(struct trace_seq *,
>                                 struct cper_mem_err_compact *);
>  void cper_print_proc_arm(const char *pfx,
>                          const struct cper_sec_proc_arm *proc);
> +void cper_print_proc_ia(const char *pfx,
> +                       const struct cper_sec_proc_ia *proc);
>
>  #endif
> --
> 2.14.1
>
