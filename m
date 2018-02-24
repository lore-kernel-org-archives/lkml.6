Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeBXQlZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 11:41:25 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:40298 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeBXQlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 11:41:23 -0500
X-Google-Smtp-Source: AH8x227BLiEci14RvXydcHTRlw/6kMa5sa8TyK76EOk4SwFVHt1DPfdPCDXQdBu4eOE0sDxT5QPdjo0Kan7PHAKa42Y=
MIME-Version: 1.0
In-Reply-To: <20180223200333.6410-5-Yazen.Ghannam@amd.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com> <20180223200333.6410-5-Yazen.Ghannam@amd.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 24 Feb 2018 16:41:22 +0000
Message-ID: <CAKv+Gu_xQseJg3ABoD74hJt6ZbMZF7zE75Gc9ZNN4SsftnNN4g@mail.gmail.com>
Subject: Re: [PATCH 4/8] efi: Decode UEFI-defined IA32/X64 Error Structure GUIDs
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
> For easier handling, match the known IA32/X64 error structure GUIDs to
> enums.
>
> Also, print out the name of the matching Error Structure Type.
>
> GUIDs taken from UEFI 2.7 section N.2.4.2.1 IA32/X64 Processor Error
> Information Structure.
>
> Cc: <stable@vger.kernel.org> # 4.16.x
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/firmware/efi/cper-x86.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
> index 9d608f742c98..3b86223bdb67 100644
> --- a/drivers/firmware/efi/cper-x86.c
> +++ b/drivers/firmware/efi/cper-x86.c
> @@ -14,17 +14,53 @@
>  #define VALID_CPUID_INFO               BIT_ULL(1)
>  #define VALID_PROC_ERR_INFO_NUM(bits)  ((bits & GENMASK_ULL(7, 2)) >> 2)
>
> +#define INFO_ERR_STRUCT_TYPE_CACHE                                     \
> +       GUID_INIT(0xA55701F5, 0xE3EF, 0x43DE, 0xAC, 0x72, 0x24, 0x9B,   \
> +                 0x57, 0x3F, 0xAD, 0x2C)
> +#define INFO_ERR_STRUCT_TYPE_TLB                                       \
> +       GUID_INIT(0xFC06B535, 0x5E1F, 0x4562, 0x9F, 0x25, 0x0A, 0x3B,   \
> +                 0x9A, 0xDB, 0x63, 0xC3)
> +#define INFO_ERR_STRUCT_TYPE_BUS                                       \
> +       GUID_INIT(0x1CF3F8B3, 0xC5B1, 0x49a2, 0xAA, 0x59, 0x5E, 0xEF,   \
> +                 0x92, 0xFF, 0xA6, 0x3C)
> +#define INFO_ERR_STRUCT_TYPE_MS                                                \
> +       GUID_INIT(0x48AB7F57, 0xDC34, 0x4f6c, 0xA7, 0xD3, 0xB0, 0xB5,   \
> +                 0xB0, 0xA7, 0x43, 0x14)
> +
>  #define INFO_VALID_CHECK_INFO          BIT_ULL(0)
>  #define INFO_VALID_TARGET_ID           BIT_ULL(1)
>  #define INFO_VALID_REQUESTOR_ID                BIT_ULL(2)
>  #define INFO_VALID_RESPONDER_ID                BIT_ULL(3)
>  #define INFO_VALID_IP                  BIT_ULL(4)
>
> +enum err_types {
> +       ERR_TYPE_CACHE = 0,
> +       ERR_TYPE_TLB,
> +       ERR_TYPE_BUS,
> +       ERR_TYPE_MS,
> +       N_ERR_TYPES
> +};
> +
> +static enum err_types cper_get_err_type(const guid_t *err_type)
> +{
> +       if (guid_equal(err_type, &INFO_ERR_STRUCT_TYPE_CACHE))
> +               return ERR_TYPE_CACHE;
> +       else if (guid_equal(err_type, &INFO_ERR_STRUCT_TYPE_TLB))
> +               return ERR_TYPE_TLB;
> +       else if (guid_equal(err_type, &INFO_ERR_STRUCT_TYPE_BUS))
> +               return ERR_TYPE_BUS;
> +       else if (guid_equal(err_type, &INFO_ERR_STRUCT_TYPE_MS))
> +               return ERR_TYPE_MS;
> +       else
> +               return N_ERR_TYPES;
> +}
> +
>  void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
>  {
>         int i;
>         struct cper_ia_err_info *err_info;
>         char newpfx[64];
> +       enum err_types err_type;
>

Can you make this an u8 please? The signedness of an enum is not well
defined, and you only check the upper bound below.

>         printk("%sValidation Bits: 0x%016llx\n", pfx, proc->validation_bits);
>
> @@ -46,6 +82,11 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
>                 printk("%sError Structure Type: %pUl\n", newpfx,
>                          &err_info->err_type);
>
> +               err_type = cper_get_err_type(&err_info->err_type);
> +               printk("%sError Structure Type: %s\n", newpfx,
> +                        err_type < ARRAY_SIZE(cper_proc_error_type_strs) ?
> +                        cper_proc_error_type_strs[err_type] : "unknown");
> +
>                 printk("%sValidation Bits: 0x%016llx\n",
>                          newpfx, err_info->validation_bits);
>
> --
> 2.14.1
>
