Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbeBXQkM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 11:40:12 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:40221 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBXQkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 11:40:10 -0500
X-Google-Smtp-Source: AG47ELspqJB9EAsva09Vu9fZ6VeQBbCcfRrtVTZio/HQGIT7D/PPqrRI0HH1OIKQmOEzTv/DWkJWbvDjv4bQqyl6OKg=
MIME-Version: 1.0
In-Reply-To: <20180223200333.6410-4-Yazen.Ghannam@amd.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com> <20180223200333.6410-4-Yazen.Ghannam@amd.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 24 Feb 2018 16:40:09 +0000
Message-ID: <CAKv+Gu_18==LT3eGPJh9Lveq_CWXwveBD4EYnTWvT7FbTtM_jg@mail.gmail.com>
Subject: Re: [PATCH 3/8] efi: Decode IA32/X64 Processor Error Info Structure
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
> Print the fields in the IA32/X64 Processor Error Info Structure.
>
> Based on UEFI 2.7 Table 256. IA32/X64 Processor Error Information
> Structure.
>
> Cc: <stable@vger.kernel.org> # 4.16.x
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/firmware/efi/cper-x86.c | 53 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
> index b50ee3cdf637..9d608f742c98 100644
> --- a/drivers/firmware/efi/cper-x86.c
> +++ b/drivers/firmware/efi/cper-x86.c
> @@ -4,15 +4,28 @@
>
>  #include <linux/cper.h>
>
> +#define INDENT_SP      " "
> +
>  /*
>   * We don't need a "CPER_IA" prefix since these are all locally defined.
>   * This will save us a lot of line space.
>   */
>  #define VALID_LAPIC_ID                 BIT_ULL(0)
>  #define VALID_CPUID_INFO               BIT_ULL(1)
> +#define VALID_PROC_ERR_INFO_NUM(bits)  ((bits & GENMASK_ULL(7, 2)) >> 2)
> +

Parens around 'bits' please

> +#define INFO_VALID_CHECK_INFO          BIT_ULL(0)
> +#define INFO_VALID_TARGET_ID           BIT_ULL(1)
> +#define INFO_VALID_REQUESTOR_ID                BIT_ULL(2)
> +#define INFO_VALID_RESPONDER_ID                BIT_ULL(3)
> +#define INFO_VALID_IP                  BIT_ULL(4)
>
>  void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
>  {
> +       int i;
> +       struct cper_ia_err_info *err_info;
> +       char newpfx[64];
> +
>         printk("%sValidation Bits: 0x%016llx\n", pfx, proc->validation_bits);
>
>         if (proc->validation_bits & VALID_LAPIC_ID)
> @@ -23,4 +36,44 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
>                 print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, proc->cpuid,
>                                sizeof(proc->cpuid), 0);
>         }
> +
> +       snprintf(newpfx, sizeof(newpfx), "%s%s", pfx, INDENT_SP);
> +
> +       err_info = (struct cper_ia_err_info *)(proc + 1);
> +       for (i = 0; i < VALID_PROC_ERR_INFO_NUM(proc->validation_bits); i++) {
> +               printk("%sError Information Structure %d:\n", pfx, i);
> +
> +               printk("%sError Structure Type: %pUl\n", newpfx,
> +                        &err_info->err_type);
> +

The indentation is a bit awkward here. Could you please align followup
lines with the character following the ( on the first line?

> +               printk("%sValidation Bits: 0x%016llx\n",
> +                        newpfx, err_info->validation_bits);
> +
> +               if (err_info->validation_bits & INFO_VALID_CHECK_INFO) {
> +                       printk("%sCheck Information: 0x%016llx\n", newpfx,
> +                                err_info->check_info);
> +               }
> +
> +               if (err_info->validation_bits & INFO_VALID_TARGET_ID) {
> +                       printk("%sTarget Identifier: 0x%016llx\n",
> +                                newpfx, err_info->target_id);
> +               }
> +
> +               if (err_info->validation_bits & INFO_VALID_REQUESTOR_ID) {
> +                       printk("%sRequestor Identifier: 0x%016llx\n",
> +                                newpfx, err_info->requestor_id);
> +               }
> +
> +               if (err_info->validation_bits & INFO_VALID_RESPONDER_ID) {
> +                       printk("%sResponder Identifier: 0x%016llx\n",
> +                                newpfx, err_info->responder_id);
> +               }
> +
> +               if (err_info->validation_bits & INFO_VALID_IP) {
> +                       printk("%sInstruction Pointer: 0x%016llx\n",
> +                                newpfx, err_info->ip);
> +               }
> +
> +               err_info++;
> +       }
>  }
> --
> 2.14.1
>
