Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24FBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBA62089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfAHCTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 21:19:10 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:39932 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbfAHCTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 21:19:10 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436283|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07426;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.DiqYf8w_1546913942;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.DiqYf8w_1546913942)
          by smtp.aliyun-inc.com(10.147.42.253);
          Tue, 08 Jan 2019 10:19:03 +0800
Subject: Re: [RFC v5 0/4] pstore/block: new support logger for block devices
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
 <CAGXu5jKrEHkogWsNW0rui8fBbdGin0syWzdfhVhw1V9tTRy0+A@mail.gmail.com>
From:   =?UTF-8?B?5buW5aiB6ZuE?= <liaoweixiong@allwinnertech.com>
Message-ID: <46d11c0f-fa85-1214-6676-10b255e1a20e@allwinnertech.com>
Date:   Tue, 8 Jan 2019 10:19:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKrEHkogWsNW0rui8fBbdGin0syWzdfhVhw1V9tTRy0+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-08 05:47, Kees Cook wrote:
> On Mon, Jan 7, 2019 at 4:01 AM liaoweixiong
> <liaoweixiong@allwinnertech.com> wrote:
>>
>> Why should we need pstore_block?
>> 1. Most embedded intelligent equipment have no persistent ram, which
>> increases costs. We perfer to cheaper solutions, like block devices.
>> In fast, there is already a sample for block device logger in driver
>> MTD (drivers/mtd/mtdoops.c).
>> 2. Do not any equipment have battery, which means that it lost all data
>> on general ram if power failure. Pstore has little to do for these
>> equipments.
> 
> I'm catching up from being off over the holidays, but I just wanted to
> say that I like the general idea here.

Thanks for your work very much! :)

> 
>> [PATCH v5]
>> On patch 1:
>> 1. rename pstore/rom to pstore/blk
> 
> Thanks! The earlier name seemed wrong. :)
> 
>> 2. Do not allocate any memory in the write path of panic. So, use local
>> array instead in function romz_recover_dmesg_meta.
>> 3. Add C header file "linux/fs.h" to fix implicit declaration of function
>>    'filp_open','kernel_read'...
>> On patch 3:
>> 1. If panic, do not recover pmsg but flush if it is dirty.
>> 2. Fix erase pmsg failed.
>> On patch 4:
>> 1. Create a document for pstore/blk
> 
> Overall, I wonder if more of the ram backend code could get reused for
> the blk backend? I'd much rather be able to share that, since much of
> the logic is the same.

Before I wrote pstore/blk, I specially studied pstore/ram. As your
words, much of the logic is the same, you will see some codes similar to
pstore/ram.
But there is still something different with pstore/ram. For example,
block device maybe unready for read/write before kernel finish
initializing. So, pstore/blk recovers old data when  mount rather than
initialize.
In addition, pstore/blk could not be used for pstore-console, since
block device much slower than ram.
In my original design, pstore/blk works like a manager for storage
space, don't care if it is ram or block device. So, it may works for
persistent ram too.

> 
> I'll get to a more detailed review in the coming days. Thanks for sending this!
> 
> -Kees
> 
>>
>> [PATCH v4]
>> On patch 1:
>> 1. Fix always true condition '(--i >= 0) => (0-u32max >= 0)' in function
>>    romz_init_zones by defining variable i to 'int' rahter than
>>    'unsigned int'.
>> 2. To make codes more easily to read, we use macro READ_NEXT_ZONE for
>>    return value of romz_dmesg_read if it need to read next zone.
>>    Moveover, we assign READ_NEXT_ZONE -1024 rather than 0.
>> 3. Add 'FLUSH_META' to 'enum romz_flush_mode' and rename 'NOT_FLUSH' to
>>    'FLUSH_NONE'
>> 4. Function romz_zone_write work badly with FLUSH_PART mode as badly
>>    address and offset to write.
>> On patch 3:
>> NEW SUPPORT psmg for pstore_rom.
>>
>> [PATCH v3]
>> On patch 1:
>> Fix build as module error for undefined 'vfs_read' and 'vfs_write'
>> Both of 'vfs_read' and 'vfs_write' haven't be exproted yet, so we use
>> 'kernel_read' and 'kernel_write' instead.
>>
>> [PATCH v2]
>> On patch 1:
>> Fix build as module error for redefinition of 'romz_unregister' and
>> 'romz_register'
>>
>> [PATCH v1]
>> On patch 1:
>> Core codes of pstore_rom, which works well on allwinner(sunxi) platform.
>> On patch 2:
>> A sample for pstore_rom, using general ram rather than block device.
>>
>> liaoweixiong (4):
>>   pstore/blk: new support logger for block devices
>>   pstore/blk: add sample for pstore_blk
>>   pstore/blk: support pmsg for pstore block
>>   Documentation: pstore/blk: create document for pstore_blk
>>
>>  Documentation/admin-guide/pstore-block.rst |  226 ++++++
>>  MAINTAINERS                                |    1 +
>>  fs/pstore/Kconfig                          |   20 +
>>  fs/pstore/Makefile                         |    5 +
>>  fs/pstore/blkbuf.c                         |   46 ++
>>  fs/pstore/blkzone.c                        | 1168 ++++++++++++++++++++++++++++
>>  include/linux/pstore_blk.h                 |   62 ++
>>  7 files changed, 1528 insertions(+)
>>  create mode 100644 Documentation/admin-guide/pstore-block.rst
>>  create mode 100644 fs/pstore/blkbuf.c
>>  create mode 100644 fs/pstore/blkzone.c
>>  create mode 100644 include/linux/pstore_blk.h
>>
>> --
>> 1.9.1
>>
> 
> 
