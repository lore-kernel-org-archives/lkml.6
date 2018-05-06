Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751509AbeEFN6K (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 09:58:10 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:44348 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbeEFN6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 09:58:09 -0400
X-Google-Smtp-Source: AB8JxZo2NJ3TNLMLkJwbJSjBnkGjhvATG4lgSxlsIfPltH0fGsbFwZDUTDub/GTG3g3YphaC+sTDckthZ0pxpyRMsdA=
MIME-Version: 1.0
In-Reply-To: <20180505202450.26630-1-malat@debian.org>
References: <20180505202450.26630-1-malat@debian.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 6 May 2018 16:58:08 +0300
Message-ID: <CAHp75VcG6qX8_BjEHpB8UGHP+bw+=E8ki8_r=-PVqv1kQUOQXQ@mail.gmail.com>
Subject: Re: [PATCH] nvmem: properly handle returned value nvmem_reg_read
To: Mathieu Malaterre <malat@debian.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w46DwOIr001480

On Sat, May 5, 2018 at 11:24 PM, Mathieu Malaterre <malat@debian.org> wrote:
> Function nvmem_reg_read can return a non zero value indicating an error.
> This returned value must be read and error propagated to
> nvmem_cell_prepare_write_buffer.

Must is to strong word here. How come it *must*?
Did you investigate the history of the changes that brought us to current code?

How had you tested your change?
While it looks subtle it is in one of the storage class devices core,
which might be very sensible to changing workflow.

> Silence the following gcc warning (W=1):
>
>   drivers/nvmem/core.c:1093:9: warning: variable ‘rc’ set but not used [-Wunused-but-set-variable]

This is least argument to accept this patch.

>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/nvmem/core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index b05aa8e81303..f34f2363925a 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1107,6 +1107,8 @@ static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
>
>                 /* setup the first byte with lsb bits from nvmem */
>                 rc = nvmem_reg_read(nvmem, cell->offset, &v, 1);
> +               if (rc)
> +                       goto err;
>                 *b++ |= GENMASK(bit_offset - 1, 0) & v;
>
>                 /* setup rest of the byte if any */
> @@ -1125,11 +1127,16 @@ static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
>                 /* setup the last byte with msb bits from nvmem */
>                 rc = nvmem_reg_read(nvmem,
>                                     cell->offset + cell->bytes - 1, &v, 1);
> +               if (rc)
> +                       goto err;
>                 *p |= GENMASK(7, (nbits + bit_offset) % BITS_PER_BYTE) & v;
>
>         }
>
>         return buf;
> +err:
> +       kfree(buf);
> +       return NULL;
>  }
>
>  /**
> --
> 2.11.0
>



-- 
With Best Regards,
Andy Shevchenko
