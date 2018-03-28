Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754091AbeC1Plf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:41:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37518 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753945AbeC1Plc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:41:32 -0400
X-Google-Smtp-Source: AIpwx48whxCe+gH0ZyD9BuY5yGNNpgGjM0eZs1+s60ghBAyKKQej1+tgif4NHDd13LgYOuJzZdXQtm2pgS9nOyxxE6A=
MIME-Version: 1.0
In-Reply-To: <d5a326b6c284f7389301b265716dc58fda492c98.1521358552.git.arvind.yadav.cs@gmail.com>
References: <d5a326b6c284f7389301b265716dc58fda492c98.1521358552.git.arvind.yadav.cs@gmail.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 28 Mar 2018 09:41:31 -0600
Message-ID: <CANLsYkydkz3JLwcMG-wFzVmV6zyYkTqQGaC3GRQMzgAS-EJTHg@mail.gmail.com>
Subject: Re: [PATCH] coresight: use put_device() instead of kfree()
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
>  err_kzalloc_conns:
>         kfree(refcnts);
>  err_kzalloc_refcnts:
> --
> 2.7.4
>

Applied - thanks
Mathieu
