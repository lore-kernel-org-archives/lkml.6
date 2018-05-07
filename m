Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeEGIYX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:24:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39448 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbeEGIYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:24:20 -0400
X-Google-Smtp-Source: AB8JxZqItye9y404+tiK5x738pivwlroRLINFi3qZ0aYcNmF3IT/GF41Z5QHMuM9SA7Tra50KI5ym9xukS0igHr67YM=
MIME-Version: 1.0
In-Reply-To: <1525004549-16266-1-git-send-email-etienne.carriere@linaro.org>
References: <1525004549-16266-1-git-send-email-etienne.carriere@linaro.org>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 7 May 2018 10:24:18 +0200
Message-ID: <CAHUa44GU5zWJOLGzQa06ZJO4eYitNFd+XkXL9gRXzt7zcbAd3A@mail.gmail.com>
Subject: Re: [PATCH] tee: check shm references are consistent in offset/size
To: Etienne Carriere <etienne.carriere@linaro.org>
Cc: alexandre.jutras@nxp.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 2:22 PM, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
> This change prevents userland from referencing TEE shared memory
> outside the area initially allocated by its owner. Prior this change an
> application could not reference or access memory it did not own but
> it could reference memory not explicitly allocated by owner but still
> allocated to the owner due to the memory allocation granule.
>
> Reported-by: Alexandre Jutras <alexandre.jutras@nxp.com>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  drivers/tee/tee_core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 0124a91..dd46b75 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -238,6 +238,17 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
>                         if (IS_ERR(shm))
>                                 return PTR_ERR(shm);
>
> +                       /*
> +                        * Ensure offset + size does not overflow offset
> +                        * and does not overflow the size of the referred
> +                        * shared memory object.
> +                        */
> +                       if ((ip.a + ip.b) < ip.a ||
> +                           (ip.a + ip.b) > shm->size) {
> +                               tee_shm_put(shm);
> +                               return -EINVAL;
> +                       }
> +
>                         params[n].u.memref.shm_offs = ip.a;
>                         params[n].u.memref.size = ip.b;
>                         params[n].u.memref.shm = shm;
> --
> 1.9.1
>

Looks good to me, I'll pick this up.

Thanks,
Jens
