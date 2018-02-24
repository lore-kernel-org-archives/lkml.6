Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeBXQoB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 11:44:01 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:34103 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeBXQn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 11:43:59 -0500
X-Google-Smtp-Source: AH8x227/KFnsCZbwcHK1NzORfgskiJI4xh0HR8fErcKaMWzACc8ZguPRnXpYtmB/2pOA1XooWk4/bjttrE6yDRNj/zA=
MIME-Version: 1.0
In-Reply-To: <20180223200333.6410-8-Yazen.Ghannam@amd.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com> <20180223200333.6410-8-Yazen.Ghannam@amd.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 24 Feb 2018 16:43:58 +0000
Message-ID: <CAKv+Gu9hhkOfG1U7RSSdMZY6D94qNdBGabb6ARUGAAY=vuH+SQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] efi: Decode IA32/X64 MS Check structure
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
> The IA32/X64 MS Check structure varies from the other Check structures
> in the the bit positions of its fields, and it includes an additional
> "Error Type" field.
>
> Decode the MS Check structure in a separate function.
>
> Based on UEFI 2.7 Table 260. IA32/X64 MS Check Field Description.
>
> Cc: <stable@vger.kernel.org> # 4.16.x
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/firmware/efi/cper-x86.c | 55 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
> index df4cf6221d8e..02b1b424f537 100644
> --- a/drivers/firmware/efi/cper-x86.c
> +++ b/drivers/firmware/efi/cper-x86.c
> @@ -60,6 +60,20 @@
>  #define CHECK_BUS_TIME_OUT             BIT_ULL(32)
>  #define CHECK_BUS_ADDR_SPACE(check)    ((check & GENMASK_ULL(34, 33)) >> 33)
>
> +#define CHECK_VALID_MS_ERR_TYPE                BIT_ULL(0)
> +#define CHECK_VALID_MS_PCC             BIT_ULL(1)
> +#define CHECK_VALID_MS_UNCORRECTED     BIT_ULL(2)
> +#define CHECK_VALID_MS_PRECISE_IP      BIT_ULL(3)
> +#define CHECK_VALID_MS_RESTARTABLE_IP  BIT_ULL(4)
> +#define CHECK_VALID_MS_OVERFLOW                BIT_ULL(5)
> +
> +#define CHECK_MS_ERR_TYPE(check)       ((check & GENMASK_ULL(18, 16)) >> 16)

Parens

> +#define CHECK_MS_PCC                   BIT_ULL(19)
> +#define CHECK_MS_UNCORRECTED           BIT_ULL(20)
> +#define CHECK_MS_PRECISE_IP            BIT_ULL(21)
> +#define CHECK_MS_RESTARTABLE_IP                BIT_ULL(22)
> +#define CHECK_MS_OVERFLOW              BIT_ULL(23)
> +
>  enum err_types {
>         ERR_TYPE_CACHE = 0,
>         ERR_TYPE_TLB,
> @@ -114,19 +128,58 @@ static const char * const ia_check_bus_addr_space_strs[] = {
>         "Other Transaction",
>  };
>
> +static const char * const ia_check_ms_error_type_strs[] = {
> +       "No Error",
> +       "Unclassified",
> +       "Microcode ROM Parity Error",
> +       "External Error",
> +       "FRC Error",
> +       "Internal Unclassified",
> +};
> +
>  static inline void print_bool(char *str, const char *pfx, u64 check, u64 bit)
>  {
>         printk("%s%s: %s\n", pfx, str, (check & bit) ? "true" : "false");
>  }
>
> +static void print_err_info_ms(const char *pfx, u16 validation_bits, u64 check)
> +{
> +       if (validation_bits & CHECK_VALID_MS_ERR_TYPE) {
> +               u8 err_type = CHECK_MS_ERR_TYPE(check);
> +
> +               printk("%sError Type: %u, %s\n", pfx, err_type,
> +                        err_type < ARRAY_SIZE(ia_check_ms_error_type_strs) ?
> +                        ia_check_ms_error_type_strs[err_type] : "unknown");
> +       }
> +
> +       if (validation_bits & CHECK_VALID_MS_PCC)
> +               print_bool("Processor Context Corrupt", pfx, check, CHECK_MS_PCC);
> +
> +       if (validation_bits & CHECK_VALID_MS_UNCORRECTED)
> +               print_bool("Uncorrected", pfx, check, CHECK_MS_UNCORRECTED);
> +
> +       if (validation_bits & CHECK_VALID_MS_PRECISE_IP)
> +               print_bool("Precise IP", pfx, check, CHECK_MS_PRECISE_IP);
> +
> +       if (validation_bits & CHECK_VALID_MS_RESTARTABLE_IP)
> +               print_bool("Restartable IP", pfx, check, CHECK_MS_RESTARTABLE_IP);
> +
> +       if (validation_bits & CHECK_VALID_MS_OVERFLOW)
> +               print_bool("Overflow", pfx, check, CHECK_MS_OVERFLOW);
> +}
> +
>  static void print_err_info(const char *pfx, enum err_types err_type, u64 check)
>  {
>         u16 validation_bits = CHECK_VALID_BITS(check);
>
>         printk("%sValidation Bits: 0x%04x\n", pfx, validation_bits);
>
> +       /*
> +        * The MS Check structure varies a lot from the others, so use a
> +        * separate function for decoding.
> +        */
>         if (err_type == ERR_TYPE_MS)
> -               return;
> +               return print_err_info_ms(pfx, validation_bits, check);
>
>         if (validation_bits & CHECK_VALID_TRANS_TYPE) {
>                 u8 trans_type = CHECK_TRANS_TYPE(check);
> --
> 2.14.1
>
