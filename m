Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10831C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC76620851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC76620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeLDBk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:40:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16074 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725915AbeLDBk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 20:40:58 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 761491F3AA615;
        Tue,  4 Dec 2018 09:40:52 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Tue, 4 Dec 2018
 09:40:46 +0800
CC:     <wangbinghui@hisilicon.com>, USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 10/12] hikey960: Support usb functionality of Hikey960
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-11-chenyu56@huawei.com>
 <CAHp75VdSowHk4meQqqUamSjJJoVT59+pMZ1qjmmWd-W5nWBcUw@mail.gmail.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <6810012e-9a77-dfdf-a738-14ce77a3027a@huawei.com>
Date:   Tue, 4 Dec 2018 09:40:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VdSowHk4meQqqUamSjJJoVT59+pMZ1qjmmWd-W5nWBcUw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018/12/3 17:23, Andy Shevchenko wrote:
> On Mon, Dec 3, 2018 at 5:47 AM Yu Chen <chenyu56@huawei.com> wrote:
>>
>> This driver handles usb hub power on and typeC port event of HiKey960 board:
>> 1)DP&DM switching between usb hub and typeC port base on typeC port
>> state
>> 2)Control power of usb hub on Hikey960
>> 3)Control vbus of typeC port
> 
>> +config HISI_HIKEY_USB
>> +       tristate "USB functionality of HiSilicon Hikey Platform"
>> +       depends on GPIOLIB
> 
>> +       default n
> 
> No, Linus is not happy about this.
> Default n _is_ a default.

OK.
> 
>> +       help
>> +         If you say yes here you get support for usb functionality of HiSilicon Hikey Platform.
> 
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * hisi_hikey_usb.c
>> + *
>> + * Copyright (c) Hisilicon Tech. Co., Ltd. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
> 
> Same comments to the above lines.
> 
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/of.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/usb/role.h>
>> +#include <linux/notifier.h>
> 
> Order?
> 
>> +       pr_debug("%s: set hub power %d\n", __func__, value);
> 
> Noise.
> 
>> +       pr_debug("%s: switch to %s\n", __func__, switch_to_str);
> 
> Noise.
> 
>> +       pr_debug("%s: set typec vbus gpio to %d\n", __func__, value);
> 
> Noise.
> 
>> +       if (!nb)
>> +               return -EINVAL;
> 
> On which conditions this happen?
> 
>> +       pr_info("%s:set typec state to %lu\n", __func__, state);
> 
> Noise!
> 
> Guys, you perhaps can read about tracepoints and function tracer
> facilities in the kernel.
> 
>> +static int hisi_hikey_usb_probe(struct platform_device *pdev)
>> +{
> 
>> +               pr_info("%s: typc_vbus_enable_val can't get\n", __func__);
> 
> Noise!

OK.
> 
>> +       if (IS_ERR_OR_NULL(hisi_hikey_usb->typec_vbus)) {
> 
> So, this check is redundant. You are repeating it below.
> 
>> +               if (!hisi_hikey_usb->typec_vbus)
>> +                       ret = -EINVAL;
>> +               else
>> +                       ret = PTR_ERR(hisi_hikey_usb->typec_vbus);
>> +               return ret;
>> +       }
OK.

> 
>> +       if (IS_ERR_OR_NULL(hisi_hikey_usb->role_sw)) {
> 
>> +               pr_err("%s: usb_role_switch_get failed\n", __func__);
> 
> Noise and same comment to the conditional check as above
> 
>> +               if (!hisi_hikey_usb->role_sw)
>> +                       ret = -ENOENT;
>> +               else
>> +                       ret = PTR_ERR(hisi_hikey_usb->role_sw);
>> +               return ret;
>> +       }
> 
>> +               .of_match_table = of_match_ptr(id_table_hisi_hikey_usb),
> 
> Does it compiles for non-OF case? Why macro is in use?
> 
OK. I will add the "CONFIG_OF".

