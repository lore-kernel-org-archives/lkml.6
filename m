Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbeEWHtO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:49:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59664 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754514AbeEWHsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:48:38 -0400
Subject: Re: [PATCH 19/33] thermal: db8500: use match_string() helper
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-20-git-send-email-xieyisheng1@huawei.com>
 <CAHp75VfqEdoDZydwFmQaLiUN8cVtH3MbFHf3qixU8xUHXMwt1g@mail.gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <c058971b-e072-a7b5-3f6e-d06458099c60@huawei.com>
Date: Wed, 23 May 2018 15:47:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfqEdoDZydwFmQaLiUN8cVtH3MbFHf3qixU8xUHXMwt1g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 2018/5/22 6:00, Andy Shevchenko wrote:
> On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>> match_string() returns the index of an array for a matching string,
>> which can be used intead of open coded variant.
> 
>> +       i = match_string((const char **)trip_point->cdev_name,
> 
> Casting looks ugly. You need to constify the variable itself.
When I tried to const cdev_name like:
+++ b/include/linux/platform_data/db8500_thermal.h
@@ -27,7 +27,7 @@
 struct db8500_trip_point {
        unsigned long temp;
        enum thermal_trip_type type;
-       char cdev_name[COOLING_DEV_MAX][THERMAL_NAME_LENGTH];
+       char const cdev_name[COOLING_DEV_MAX][THERMAL_NAME_LENGTH]; // const char cdev_name[COOLING_DEV_MAX][THERMAL_NAME_LENGTH] will also the same
 };

The compiler will also warning:
drivers/thermal/db8500_thermal.c: In function ‘db8500_thermal_match_cdev’:
drivers/thermal/db8500_thermal.c:53:2: warning: passing argument 1 of ‘match_string’ from incompatible pointer type [enabled by default]
  i = match_string(trip_point->cdev_name, COOLING_DEV_MAX, cdev->type);
  ^
In file included from include/linux/bitmap.h:9:0,
                 from include/linux/cpumask.h:12,
                 from include/linux/rcupdate.h:44,
                 from include/linux/radix-tree.h:28,
                 from include/linux/idr.h:15,
                 from include/linux/kernfs.h:14,
                 from include/linux/sysfs.h:16,
                 from kernel/include/linux/kobject.h:20,
                 from kernel/include/linux/of.h:17,
                 from include/linux/cpu_cooling.h:27,
                 from drivers/thermal/db8500_thermal.c:20:
include/linux/string.h:184:5: note: expected ‘const char * const*’ but argument is of type ‘const char (*)[20]’

Any idea?

Thanks
Yisheng
> 
>> +                        COOLING_DEV_MAX, cdev->type);
>>
>> -       return -ENODEV;
>> +       return (i < 0) ? -ENODEV : 0;
> 
> I would rather go with
> 
> if (ret < 0)
>  return -ENODEV;
> 
> return 0;
> 
