Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbeCZVqD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:46:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39413 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbeCZVqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:46:02 -0400
X-Google-Smtp-Source: AG47ELspAAuPSzSe5F19iQ87fRCdeRAcu7OrWKXhO1zek/K/pBYeEkSGAWiKbnm4DGgCVYpyF00dgkN2FVcv2GMNRmI=
MIME-Version: 1.0
In-Reply-To: <d5a326b6c284f7389301b265716dc58fda492c98.1521358552.git.arvind.yadav.cs@gmail.com>
References: <d5a326b6c284f7389301b265716dc58fda492c98.1521358552.git.arvind.yadav.cs@gmail.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 26 Mar 2018 15:46:00 -0600
Message-ID: <CANLsYkymOF2oG7TmKbRTakYKw0ECN_DXfkX5b8WjmS0Lz0sfig@mail.gmail.com>
Subject: Re: [PATCH] coresight: use put_device() instead of kfree()
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/hwtracing/coresight/coresight.c
On 18 March 2018 at 01:38, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> Never directly free @dev after calling device_register(), even
> if it returned an error. Always use put_device() to give up the
> reference initialized.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/hwtracing/coresight/coresight.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 389c4ba..132dfbc 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -1026,8 +1026,10 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>         dev_set_name(&csdev->dev, "%s", desc->pdata->name);
>
>         ret = device_register(&csdev->dev);
> -       if (ret)
> -               goto err_device_register;
> +       if (ret) {
> +               put_device(&csdev->dev);
> +               goto err_kzalloc_csdev;
> +       }
>
>         mutex_lock(&coresight_mutex);
>
> @@ -1038,8 +1040,6 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>
>         return csdev;
>
> -err_device_register:
> -       kfree(conns);

Apologies for the late reply, I was travelling.

I suggest to simply replace kfree() with put_device() in order to
concentrate the error handling code in the same area and make sure
that memory allocated for @conns and @refcnts is freed.

Thanks,
Mathieu

>  err_kzalloc_conns:
>         kfree(refcnts);
>  err_kzalloc_refcnts:
> --
> 2.7.4
>
