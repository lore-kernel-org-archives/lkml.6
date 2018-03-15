Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeCOKXg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:23:36 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37170 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbeCOKXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:23:31 -0400
X-Google-Smtp-Source: AG47ELuvxHFXWQD/vQDce7RvcohqlvBlakEGEzwjD4Jxfdsw0ypzfP+Fs5a+dBDoYdZi7Il88VGrmnCT6RBgWTTIWTI=
MIME-Version: 1.0
In-Reply-To: <4eca7388-cb2d-31e0-b64d-afb30818f53e@users.sourceforge.net>
References: <4eca7388-cb2d-31e0-b64d-afb30818f53e@users.sourceforge.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Mar 2018 11:23:30 +0100
Message-ID: <CAPDyKFpBjRF4ggd73mA8QnybVVGuzA16SNCdYnZaBRNTbOuPAw@mail.gmail.com>
Subject: Re: [PATCH] mmc/core/block: Use memdup_user() rather than duplicating
 its implementation
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 March 2018 at 13:08, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 5 Mar 2018 11:33:21 +0100
>
> Reuse existing functionality from memdup_user() instead of keeping
> duplicate source code.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 20135a5de748..4b09c7380e70 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -375,22 +375,15 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
>                 return idata;
>         }
>
> -       idata->buf = kmalloc(idata->buf_bytes, GFP_KERNEL);
> -       if (!idata->buf) {
> -               err = -ENOMEM;
> +       idata->buf = memdup_user((void __user *)(unsigned long)
> +                                idata->ic.data_ptr, idata->buf_bytes);
> +       if (IS_ERR(idata->buf)) {
> +               err = PTR_ERR(idata->buf);
>                 goto idata_err;
>         }
>
> -       if (copy_from_user(idata->buf, (void __user *)(unsigned long)
> -                                       idata->ic.data_ptr, idata->buf_bytes)) {
> -               err = -EFAULT;
> -               goto copy_err;
> -       }
> -
>         return idata;
>
> -copy_err:
> -       kfree(idata->buf);
>  idata_err:
>         kfree(idata);
>  out:
> --
> 2.16.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
