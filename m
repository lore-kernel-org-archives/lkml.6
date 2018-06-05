Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbeFEQOh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:14:37 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45833 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbeFEQOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:14:35 -0400
X-Google-Smtp-Source: ADUXVKJfSeNVOQpiieuqTj7VjZPXy/oM9dCB/Bp1+LgPmh2Q764w3U7Wg1zbiALAQ7osNsEti6rTevI5kuclQOffV8E=
MIME-Version: 1.0
In-Reply-To: <c058971b-e072-a7b5-3f6e-d06458099c60@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-20-git-send-email-xieyisheng1@huawei.com>
 <CAHp75VfqEdoDZydwFmQaLiUN8cVtH3MbFHf3qixU8xUHXMwt1g@mail.gmail.com> <c058971b-e072-a7b5-3f6e-d06458099c60@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 19:14:33 +0300
Message-ID: <CAHp75Vf=DJ2U6_XrBNdbHwHOnDPKe5ZVUtsHzi0WPJAw3bBR7g@mail.gmail.com>
Subject: Re: [PATCH 19/33] thermal: db8500: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w55GEg87024315

On Wed, May 23, 2018 at 10:47 AM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> Hi Andy,
>
> On 2018/5/22 6:00, Andy Shevchenko wrote:
>> On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>>> match_string() returns the index of an array for a matching string,
>>> which can be used intead of open coded variant.
>>
>>> +       i = match_string((const char **)trip_point->cdev_name,
>>
>> Casting looks ugly. You need to constify the variable itself.
> When I tried to const cdev_name like:
> +++ b/include/linux/platform_data/db8500_thermal.h
> @@ -27,7 +27,7 @@
>  struct db8500_trip_point {
>         unsigned long temp;
>         enum thermal_trip_type type;
> -       char cdev_name[COOLING_DEV_MAX][THERMAL_NAME_LENGTH];
> +       char const cdev_name[COOLING_DEV_MAX][THERMAL_NAME_LENGTH]; // const char cdev_name[COOLING_DEV_MAX][THERMAL_NAME_LENGTH] will also the same
>  };
>
> The compiler will also warning:
> drivers/thermal/db8500_thermal.c: In function ‘db8500_thermal_match_cdev’:
> drivers/thermal/db8500_thermal.c:53:2: warning: passing argument 1 of ‘match_string’ from incompatible pointer type [enabled by default]
>   i = match_string(trip_point->cdev_name, COOLING_DEV_MAX, cdev->type);
>   ^
> In file included from include/linux/bitmap.h:9:0,
>                  from include/linux/cpumask.h:12,
>                  from include/linux/rcupdate.h:44,
>                  from include/linux/radix-tree.h:28,
>                  from include/linux/idr.h:15,
>                  from include/linux/kernfs.h:14,
>                  from include/linux/sysfs.h:16,
>                  from kernel/include/linux/kobject.h:20,
>                  from kernel/include/linux/of.h:17,
>                  from include/linux/cpu_cooling.h:27,
>                  from drivers/thermal/db8500_thermal.c:20:
> include/linux/string.h:184:5: note: expected ‘const char * const*’ but argument is of type ‘const char (*)[20]’
>
> Any idea?

Yes.
If you wish to continue, you need to do two patches instead, where in
first you are changing fixed array size of pointers to dynamic one and
replace or loops from being by size to ones being NULL terminated.


-- 
With Best Regards,
Andy Shevchenko
