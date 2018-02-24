Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeBXQn1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 11:43:27 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:38464 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeBXQnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 11:43:25 -0500
X-Google-Smtp-Source: AH8x2241p+IIZX48HPt4m3VfQo/wV1FbwOC97LWI4qhKPnjvxeVFdnKtLhm5QmsAG+I9drKgHBY9kfErwvlNJ9iYBSw=
MIME-Version: 1.0
In-Reply-To: <20180223200333.6410-7-Yazen.Ghannam@amd.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com> <20180223200333.6410-7-Yazen.Ghannam@amd.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 24 Feb 2018 16:43:24 +0000
Message-ID: <CAKv+Gu9btAJ9u+bqT3FdT9G7mdMzhWLLd0BBMnZQgsTZfkOBig@mail.gmail.com>
Subject: Re: [PATCH 6/8] efi: Decode additional IA32/X64 Bus Check fields
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
> The "Participation Type", "Time Out", and "Address Space" fields are
> unique to the IA32/X64 Bus Check structure. Print these fields.
>
> Based on UEFI 2.7 Table 259. IA32/X64 Bus Check Structure
>
> Cc: <stable@vger.kernel.org> # 4.16.x
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/firmware/efi/cper-x86.c | 44 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
> index 75f664043076..df4cf6221d8e 100644
> --- a/drivers/firmware/efi/cper-x86.c
> +++ b/drivers/firmware/efi/cper-x86.c
> @@ -42,6 +42,10 @@
>  #define CHECK_VALID_RESTARTABLE_IP     BIT_ULL(6)
>  #define CHECK_VALID_OVERFLOW           BIT_ULL(7)
>
> +#define CHECK_VALID_BUS_PART_TYPE      BIT_ULL(8)
> +#define CHECK_VALID_BUS_TIME_OUT       BIT_ULL(9)
> +#define CHECK_VALID_BUS_ADDR_SPACE     BIT_ULL(10)
> +
>  #define CHECK_VALID_BITS(check)                ((check & GENMASK_ULL(15, 0)))
>  #define CHECK_TRANS_TYPE(check)                ((check & GENMASK_ULL(17, 16)) >> 16)
>  #define CHECK_OPERATION(check)         ((check & GENMASK_ULL(21, 18)) >> 18)
> @@ -52,6 +56,10 @@
>  #define CHECK_RESTARTABLE_IP           BIT_ULL(28)
>  #define CHECK_OVERFLOW                 BIT_ULL(29)
>
> +#define CHECK_BUS_PART_TYPE(check)     ((check & GENMASK_ULL(31, 30)) >> 30)
> +#define CHECK_BUS_TIME_OUT             BIT_ULL(32)
> +#define CHECK_BUS_ADDR_SPACE(check)    ((check & GENMASK_ULL(34, 33)) >> 33)
> +

Parens around 'check' please

>  enum err_types {
>         ERR_TYPE_CACHE = 0,
>         ERR_TYPE_TLB,
> @@ -92,6 +100,20 @@ static const char * const ia_check_op_strs[] = {
>         "snoop",
>  };
>
> +static const char * const ia_check_bus_part_type_strs[] = {
> +       "Local Processor originated request",
> +       "Local Processor responded to request",
> +       "Local Processor observed",
> +       "Generic",
> +};
> +
> +static const char * const ia_check_bus_addr_space_strs[] = {
> +       "Memory Access",
> +       "Reserved",
> +       "I/O",
> +       "Other Transaction",
> +};
> +
>  static inline void print_bool(char *str, const char *pfx, u64 check, u64 bit)
>  {
>         printk("%s%s: %s\n", pfx, str, (check & bit) ? "true" : "false");
> @@ -144,6 +166,28 @@ static void print_err_info(const char *pfx, enum err_types err_type, u64 check)
>
>         if (validation_bits & CHECK_VALID_OVERFLOW)
>                 print_bool("Overflow", pfx, check, CHECK_OVERFLOW);
> +
> +       if (err_type != ERR_TYPE_BUS)
> +               return;
> +
> +       if (validation_bits & CHECK_VALID_BUS_PART_TYPE) {
> +               u8 part_type = CHECK_BUS_PART_TYPE(check);
> +
> +               printk("%sParticipation Type: %u, %s\n", pfx, part_type,
> +                        part_type < ARRAY_SIZE(ia_check_bus_part_type_strs) ?
> +                        ia_check_bus_part_type_strs[part_type] : "unknown");
> +       }
> +
> +       if (validation_bits & CHECK_VALID_BUS_TIME_OUT)
> +               print_bool("Time Out", pfx, check, CHECK_BUS_TIME_OUT);
> +
> +       if (validation_bits & CHECK_VALID_BUS_ADDR_SPACE) {
> +               u8 addr_space = CHECK_BUS_ADDR_SPACE(check);
> +
> +               printk("%sAddress Space: %u, %s\n", pfx, addr_space,
> +                        addr_space < ARRAY_SIZE(ia_check_bus_addr_space_strs) ?
> +                        ia_check_bus_addr_space_strs[addr_space] : "unknown");
> +       }
>  }
>
>  void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
> --
> 2.14.1
>
