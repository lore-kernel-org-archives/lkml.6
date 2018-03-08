Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755701AbeCHL6y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:58:54 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36660 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751971AbeCHL6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:58:52 -0500
X-Google-Smtp-Source: AG47ELsHT31ZVfRrTDEYMKIeY9bPEraoh4WrbHD3FryOrJfu9HeRLkxZojdj5i6VHqcKEPx+Gciwr+MqJNTxHuI2ucw=
MIME-Version: 1.0
In-Reply-To: <20180307195415.GA666@embeddedgus>
References: <20180307195415.GA666@embeddedgus>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Thu, 8 Mar 2018 11:58:50 +0000
Message-ID: <CACvgo5055A0yVCY4vFp1zN+gW0XVu+DbrmrL4dEXoR7PqDXFmA@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: via_aux_vt1632: remove VLA usage
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev <linux-fbdev@vger.kernel.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On 7 March 2018 at 19:54, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wvla, remove VLA and replace it
> with a fixed-length array instead. Also, remove variable 'len'.
>
What is the reason behind adding -Wvla? Is there a thread some that I
can read up on?

> Notice that no new IDs have been added in seven years.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/video/fbdev/via/via_aux_vt1632.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/fbdev/via/via_aux_vt1632.c b/drivers/video/fbdev/via/via_aux_vt1632.c
> index d24f4cd..0cd0d2a 100644
> --- a/drivers/video/fbdev/via/via_aux_vt1632.c
> +++ b/drivers/video/fbdev/via/via_aux_vt1632.c
> @@ -35,10 +35,10 @@ static void probe(struct via_aux_bus *bus, u8 addr)
>                 .addr   =       addr,
>                 .name   =       name};
>         /* check vendor id and device id */
> -       const u8 id[] = {0x06, 0x11, 0x92, 0x31}, len = ARRAY_SIZE(id);
> -       u8 tmp[len];
> +       const u8 id[4] = {0x06, 0x11, 0x92, 0x31};
> +       u8 tmp[4];
>
> -       if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
> +       if (!via_aux_read(&drv, 0x00, tmp, 4) || memcmp(id, tmp, 4))

Generally, hard coding a bunch of numbers like that makes for
confusing and fragile code.

A lot simpler and more obvious solution is like the following.
It silences the compiler warning (-Wvla - pedantic) you while keeping
the original clarity.

        const u8 id[] = {0x06, 0x11, 0x92, 0x31}, len = ARRAY_SIZE(id);
-       u8 tmp[len];
+       u8 tmp[ARRAY_SIZE(id)]; // Using len causes a Wvla warning

HTH
Emil
