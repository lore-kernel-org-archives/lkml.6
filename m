Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932463AbeDWUIa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 16:08:30 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:40053 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932306AbeDWUI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 16:08:29 -0400
X-Google-Smtp-Source: AIpwx49iicc2R8W3P2Ie0JQ1txW6wbcX3L4F0XU4Czwx1/qr/1zsFjC7avZoFHjMtAdx5GrOwLnJi7RYJnLeRv91d58=
MIME-Version: 1.0
In-Reply-To: <20180423200255.154645-1-ksspiers@google.com>
References: <20180423200255.154645-1-ksspiers@google.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 23 Apr 2018 13:08:27 -0700
X-Google-Sender-Auth: qrmilydhxBYNtZR01B1Ne2W4V4E
Message-ID: <CAGXu5jJD6Rcszn5T+jeJBESg_0VbERJh6JWMtZaWjGszer1zGQ@mail.gmail.com>
Subject: Re: [PATCH] rave-sp: Remove VLA
To: Kyle Spiers <ksspiers@google.com>
Cc: Lee Jones <lee.jones@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 1:02 PM, Kyle Spiers <ksspiers@google.com> wrote:
> As part of the effort to remove VLAs from the kernel[1], this creates
> constants for the checksum lengths of CCITT and 8B2C and changes
> crc_calculated to be the maximum size of a checksum.
>
> https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Kyle Spiers <ksspiers@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/mfd/rave-sp.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
> index 5c858e784a89..99fa482419f9 100644
> --- a/drivers/mfd/rave-sp.c
> +++ b/drivers/mfd/rave-sp.c
> @@ -45,7 +45,9 @@
>  #define RAVE_SP_DLE                    0x10
>
>  #define RAVE_SP_MAX_DATA_SIZE          64
> -#define RAVE_SP_CHECKSUM_SIZE          2  /* Worst case scenario on RDU2 */
> +#define RAVE_SP_CHECKSUM_8B2C          1
> +#define RAVE_SP_CHECKSUM_CCITT         2
> +#define RAVE_SP_CHECKSUM_SIZE          RAVE_SP_CHECKSUM_CCITT
>  /*
>   * We don't store STX, ETX and unescaped bytes, so Rx is only
>   * DATA + CSUM
> @@ -415,7 +417,12 @@ static void rave_sp_receive_frame(struct rave_sp *sp,
>         const size_t payload_length  = length - checksum_length;
>         const u8 *crc_reported       = &data[payload_length];
>         struct device *dev           = &sp->serdev->dev;
> -       u8 crc_calculated[checksum_length];
> +       u8 crc_calculated[RAVE_SP_CHECKSUM_SIZE];
> +
> +       if (unlikely(length > sizeof(crc_calculated))) {
> +               dev_warn(dev, "Dropping oversized frame\n");
> +               return;
> +       }
>
>         print_hex_dump(KERN_DEBUG, "rave-sp rx: ", DUMP_PREFIX_NONE,
>                        16, 1, data, length, false);
> --
> 2.17.0.484.g0c8726318c-goog
>



-- 
Kees Cook
Pixel Security
