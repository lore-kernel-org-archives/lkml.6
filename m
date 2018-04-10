Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753826AbeDJOhp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:37:45 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46761 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbeDJOhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:37:43 -0400
X-Google-Smtp-Source: AIpwx49oi+WkagVwB4+ti8eLKVjhTe85a9Be5MdVl2EQyjAaDlCss7g6cdJZ5CZzqtsVbOUOcksb/A==
Subject: Re: [PATCH] mtd: partitions: Handle add_mtd_device() failures
 gracefully
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1523276721-4982-1-git-send-email-geert+renesas@glider.be>
 <9bea3ad8-7e84-87c2-9963-de81ad4cb3bf@gmail.com>
 <CAMuHMdWHoxrq-tj=QznAhuZ8eC22gTTgWFi9HgyqT9pNfJFJyw@mail.gmail.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <87feac02-e955-1897-d4a4-d6d6d1082e45@gmail.com>
Date: Tue, 10 Apr 2018 16:37:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWHoxrq-tj=QznAhuZ8eC22gTTgWFi9HgyqT9pNfJFJyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 03:26 PM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Mon, Apr 9, 2018 at 11:59 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 04/09/2018 02:25 PM, Geert Uytterhoeven wrote:
>>> Currently add_mtd_device() failures are plainly ignored, which may lead
>>> to kernel crashes later.
> 
>>> Fix this by ignoring and freeing partitions that failed to add in
>>> add_mtd_partitions().  The same issue is present in mtd_add_partition(),
>>> so fix that as well.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>> I don't know if it is worthwhile factoring out the common handling.
>>>
>>> Should allocate_partition() fail instead?  There's a comment saying
>>> "let's register it anyway to preserve ordering".
> 
>>> --- a/drivers/mtd/mtdpart.c
>>> +++ b/drivers/mtd/mtdpart.c
> 
>>> @@ -746,7 +753,15 @@ int add_mtd_partitions(struct mtd_info *master,
>>>               list_add(&slave->list, &mtd_partitions);
>>>               mutex_unlock(&mtd_partitions_mutex);
>>>
>>> -             add_mtd_device(&slave->mtd);
>>> +             ret = add_mtd_device(&slave->mtd);
>>> +             if (ret) {
>>> +                     mutex_lock(&mtd_partitions_mutex);
>>> +                     list_del(&slave->list);
>>> +                     mutex_unlock(&mtd_partitions_mutex);
>>> +                     free_partition(slave);
>>> +                     continue;
>>> +             }
>>
>> Why is the partition even in the list in the first place ? Can we avoid
>> adding it rather than adding and removing it ?
> 
> Hence my question "Should allocate_partition() fail instead?".
> Note that if we go that route, it should be a "soft" failure, as we
> probably don't
> want to drop all other partitions on the device.
Is the number of partitions ie. in /proc/mtdparts an ABI ?

-- 
Best regards,
Marek Vasut
