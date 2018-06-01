Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbeFAJyI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:54:08 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42661 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeFAJyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:54:05 -0400
X-Google-Smtp-Source: ADUXVKLyI7QHY5gag6heT/vDycG0ayi15eUPmYuT1T9x4zEfXaDiXwJKf3XCIyCatzFOM+k4Q1rBA1kDt9FD/7Guvbo=
MIME-Version: 1.0
In-Reply-To: <20180531225700.721-2-bastiangermann@fishpost.de>
References: <f885fcb0-d9f3-7702-13ad-5af2913131f0@roeck-us.net>
 <20180531225700.721-1-bastiangermann@fishpost.de> <20180531225700.721-2-bastiangermann@fishpost.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 12:54:04 +0300
Message-ID: <CAHp75VcZqpQ7qM2aBzSsqa+xYOdevZkWy=h+u8=nhdP2foyH4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] hwmon: (asus_atk0110) Make use of device managed memory
To: Bastian Germann <bastiangermann@fishpost.de>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Luca Tettamanti <kronos.it@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 1:57 AM, Bastian Germann
<bastiangermann@fishpost.de> wrote:
> Use devm_* variants of kstrdup and kzalloc. Get rid of the kfree cleanups.

>  static int atk_debugfs_ggrp_open(struct inode *inode, struct file *file)
>  {
>         struct atk_data *data = inode->i_private;
> +       struct device *dev = &data->acpi_dev->dev;
>         char *buf = NULL;
>         union acpi_object *ret;
>         u8 cls;
> @@ -748,7 +748,7 @@ static int atk_debugfs_ggrp_open(struct inode *inode, struct file *file)
>                 id = &pack->package.elements[0];
>                 if (id->integer.value == data->debugfs.id) {
>                         /* Print the package */
> -                       buf = kzalloc(512, GFP_KERNEL);
> +                       buf = devm_kzalloc(dev, 512, GFP_KERNEL);
>                         if (!buf) {
>                                 ACPI_FREE(ret);
>                                 return -ENOMEM;

Looking to the function name, it feels like you are creating a memory
leak and devm_ is inappropriate here.

> @@ -776,16 +776,9 @@ static ssize_t atk_debugfs_ggrp_read(struct file *file, char __user *buf,
>         return simple_read_from_buffer(buf, count, pos, str, len);
>  }
>
> -static int atk_debugfs_ggrp_release(struct inode *inode, struct file *file)
> -{
> -       kfree(file->private_data);
> -       return 0;
> -}
> -
>  static const struct file_operations atk_debugfs_ggrp_fops = {
>         .read           = atk_debugfs_ggrp_read,
>         .open           = atk_debugfs_ggrp_open,
> -       .release        = atk_debugfs_ggrp_release,
>         .llseek         = no_llseek,
>  };

So do these.

Also the question of time to leave of the objects used for debugfs
communication. Please double check that it's not affected by the
change.

Otherwise looks good.

-- 
With Best Regards,
Andy Shevchenko
