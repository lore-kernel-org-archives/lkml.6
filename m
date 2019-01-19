Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA63C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E68208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfASJUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 04:20:23 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:38704 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727644AbfASJUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 04:20:22 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07457527|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07440;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.DnpktYB_1547889617;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.DnpktYB_1547889617)
          by smtp.aliyun-inc.com(10.147.42.22);
          Sat, 19 Jan 2019 17:20:17 +0800
Subject: Re: [RFC v5 2/4] pstore/blk: add sample for pstore_blk
To:     Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1546862462-19640-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1546862462-19640-3-git-send-email-liaoweixiong@allwinnertech.com>
 <CAGXu5j+4QdqSYokE-0Y_pm5RgBp6i+xMgeXjTnNGVVMKeUafYg@mail.gmail.com>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <853df536-a86d-de14-47f4-244f60d9eceb@allwinnertech.com>
Date:   Sat, 19 Jan 2019 17:20:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+4QdqSYokE-0Y_pm5RgBp6i+xMgeXjTnNGVVMKeUafYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-18 08:15, Kees Cook wrote:
> On Mon, Jan 7, 2019 at 4:01 AM liaoweixiong
> <liaoweixiong@allwinnertech.com> wrote:
>>
>> It is a sample for pstore_blk, using general ram rather than block device.
>> According to pstore_blk, the data will be saved to ram buffer if not
>> register device path and apis for panic. So, it can only used to dump
>> Oops and some things will not reboot.
> 
> I'm not sure I see the purpose of this implementation? Doesn't this
> just cause all the pstore machinery to skip any actions?

It just a sample for pstore_blk, which can used to record OOPS log on
ram buffer. This module make it easier for device, without panic apis,
to record oops log only.

> i.e. without bzinfo->part_path, won't blkz_sample_write() just return
-EINVAL, etc?

Sure, blkz_sample_write (named blkz_default_general_write now) just
return -EINVAL without bzinfo->part_path. How is the write path? It is
blkoops_pstore_write->blkz_dmesg_write->blkz_zone_write->blkz_default_general_write.
The blkz_zone_write will save the log to ram buffer even
blkz_default_general_write return failure.

>>
>> Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
>> ---
>>  fs/pstore/Kconfig  |  9 +++++++++
>>  fs/pstore/Makefile |  2 ++
>>  fs/pstore/blkbuf.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 57 insertions(+)
>>  create mode 100644 fs/pstore/blkbuf.c
>>
>> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
>> index a881c53..18b1fe6 100644
>> --- a/fs/pstore/Kconfig
>> +++ b/fs/pstore/Kconfig
>> @@ -159,3 +159,12 @@ config PSTORE_BLK
>>         help
>>           This enables panic and oops message to be logged to a block dev
>>           where it can be read back at some later point.
>> +
>> +config PSTORE_BLKBUF
>> +       tristate "pstore block buffer sample"
>> +       depends on PSTORE_BLK
>> +       help
>> +         This is a sample for pstore block, but do NOT have a block dev.
>> +         According to pstore_blk, the data will be saved to ram buffer and
>> +         dropped when reboot. So, it can only used to dump Oops and some
>> +         things will not reboot.
>> diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
>> index c431700..4a6cde1 100644
>> --- a/fs/pstore/Makefile
>> +++ b/fs/pstore/Makefile
>> @@ -15,3 +15,5 @@ obj-$(CONFIG_PSTORE_RAM)      += ramoops.o
>>
>>  obj-$(CONFIG_PSTORE_BLK)       += pstore_blk.o
>>  pstore_blk-y += blkzone.o
>> +
>> +obj-$(CONFIG_PSTORE_BLKBUF)    += blkbuf.o
>> diff --git a/fs/pstore/blkbuf.c b/fs/pstore/blkbuf.c
>> new file mode 100644
>> index 0000000..f1c6f57
>> --- /dev/null
>> +++ b/fs/pstore/blkbuf.c
>> @@ -0,0 +1,46 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *
>> + * blkbuf.c: Block device Oops/Panic logger
>> + *
>> + * Copyright (C) 2019 liaoweixiong <liaoweixiong@gallwinnertech.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +#define pr_fmt(fmt) "blkbuf: " fmt
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/pstore_blk.h>
>> +
>> +struct blkz_info blkbuf_info = {
>> +       .owner = THIS_MODULE,
>> +       .name = "blkbuf",
>> +       .part_size = 512 * 1024,
>> +       .dmesg_size = 64 * 1024,
>> +       .dump_oops = true,
>> +};
>> +
>> +static int __init blkbuf_init(void)
>> +{
>> +       return blkz_register(&blkbuf_info);
>> +}
>> +module_init(blkbuf_init);
>> +
>> +static void __exit blkbuf_exit(void)
>> +{
>> +       blkz_unregister(&blkbuf_info);
>> +}
>> +module_exit(blkbuf_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("liaoweixiong <liaoweixiong@allwinnertech.com>");
>> +MODULE_DESCRIPTION("Sample for Pstore BLK with Oops logger");
>> --
>> 1.9.1
>>
> 
> 
