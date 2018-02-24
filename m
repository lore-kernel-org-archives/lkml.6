Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeBXQpd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 11:45:33 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:39542 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeBXQpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 11:45:31 -0500
X-Google-Smtp-Source: AG47ELsJmTtKOxFhAmdqlh544nrWfKaTIxdlb8UXV4elVwUSRE/AfN6pWVLileynO9RUYq9AxgkTs9npYv4aDhK87uQ=
MIME-Version: 1.0
In-Reply-To: <20180223200333.6410-9-Yazen.Ghannam@amd.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com> <20180223200333.6410-9-Yazen.Ghannam@amd.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 24 Feb 2018 16:45:30 +0000
Message-ID: <CAKv+Gu_kwJTxsmmQSAMKgSmK6w_-BhqBTnv3Sqv-K1TCYq4X-Q@mail.gmail.com>
Subject: Re: [PATCH 8/8] efi: Decode IA32/X64 Context Info structure
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
> Print the fields of the IA32/X64 Context Information structure.
>
> Print the "Register Array" as raw values. Some context types are defined
> in the UEFI spec, so more detailed decoded may be added in the future.
>
> Based on UEFI 2.7 section N.2.4.2.2 IA32/X64 Processor Context
> Information Structure.
>
> Cc: <stable@vger.kernel.org> # 4.16.x
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/firmware/efi/cper-x86.c | 55 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
> index 02b1b424f537..bb6cef0b5e53 100644
> --- a/drivers/firmware/efi/cper-x86.c
> +++ b/drivers/firmware/efi/cper-x86.c
> @@ -13,6 +13,7 @@
>  #define VALID_LAPIC_ID                 BIT_ULL(0)
>  #define VALID_CPUID_INFO               BIT_ULL(1)
>  #define VALID_PROC_ERR_INFO_NUM(bits)  ((bits & GENMASK_ULL(7, 2)) >> 2)
> +#define VALID_PROC_CNXT_INFO_NUM(bits) ((bits & GENMASK_ULL(13, 8)) >> 8)

Parens

Also, CNXT isn't really idiomatic when abbreviating 'context' (and you
use CTX below as well)

>
>  #define INFO_ERR_STRUCT_TYPE_CACHE                                     \
>         GUID_INIT(0xA55701F5, 0xE3EF, 0x43DE, 0xAC, 0x72, 0x24, 0x9B,   \
> @@ -74,6 +75,9 @@
>  #define CHECK_MS_RESTARTABLE_IP                BIT_ULL(22)
>  #define CHECK_MS_OVERFLOW              BIT_ULL(23)
>
> +#define CTX_TYPE_MSR                   1
> +#define CTX_TYPE_MMREG                 7
> +
>  enum err_types {
>         ERR_TYPE_CACHE = 0,
>         ERR_TYPE_TLB,
> @@ -137,6 +141,17 @@ static const char * const ia_check_ms_error_type_strs[] = {
>         "Internal Unclassified",
>  };
>
> +static const char * const ia_reg_ctx_strs[] = {
> +       "Unclassified Data",
> +       "MSR Registers (Machine Check and other MSRs)",
> +       "32-bit Mode Execution Context",
> +       "64-bit Mode Execution Context",
> +       "FXSAVE Context",
> +       "32-bit Mode Debug Registers (DR0-DR7)",
> +       "64-bit Mode Debug Registers (DR0-DR7)",
> +       "Memory Mapped Registers",
> +};
> +
>  static inline void print_bool(char *str, const char *pfx, u64 check, u64 bit)
>  {
>         printk("%s%s: %s\n", pfx, str, (check & bit) ? "true" : "false");
> @@ -247,8 +262,10 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
>  {
>         int i;
>         struct cper_ia_err_info *err_info;
> +       struct cper_ia_proc_ctx *ctx_info;
>         char newpfx[64], infopfx[64];
>         enum err_types err_type;
> +       unsigned int max_ctx_type = ARRAY_SIZE(ia_reg_ctx_strs) - 1;
>
>         printk("%sValidation Bits: 0x%016llx\n", pfx, proc->validation_bits);
>
> @@ -313,4 +330,42 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
>
>                 err_info++;
>         }
> +
> +       ctx_info = (struct cper_ia_proc_ctx *)err_info;
> +       for (i = 0; i < VALID_PROC_CNXT_INFO_NUM(proc->validation_bits); i++) {
> +               int size = sizeof(*ctx_info) + ctx_info->reg_arr_size;
> +               int groupsize = 4;
> +
> +               printk("%sContext Information Structure %d:\n", pfx, i);
> +
> +               if (ctx_info->reg_ctx_type > max_ctx_type) {
> +                       printk("%sInvalid Register Context Type: %d (max: %d)\n",
> +                                newpfx, ctx_info->reg_ctx_type, max_ctx_type);
> +                       goto next_ctx;
> +               }
> +
> +               printk("%sRegister Context Type: %s\n", newpfx,
> +                        ia_reg_ctx_strs[ctx_info->reg_ctx_type]);
> +
> +               printk("%sRegister Array Size: 0x%04x\n", newpfx,
> +                        ctx_info->reg_arr_size);
> +
> +               if (ctx_info->reg_ctx_type == CTX_TYPE_MSR) {
> +                       groupsize = 8; /* MSRs are 8 bytes wide. */
> +                       printk("%sMSR Address: 0x%08x\n", newpfx,
> +                                ctx_info->msr_addr);
> +               }
> +
> +               if (ctx_info->reg_ctx_type == CTX_TYPE_MMREG) {
> +                       printk("%sMM Register Address: 0x%016llx\n", newpfx,
> +                                ctx_info->mm_reg_addr);
> +               }
> +
> +               printk("%sRegister Array:\n", newpfx);
> +               print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
> +                              (ctx_info + 1), ctx_info->reg_arr_size, 0);
> +
> +next_ctx:
> +               ctx_info = (struct cper_ia_proc_ctx *)((long)ctx_info + size);
> +       }
>  }
> --
> 2.14.1
>
