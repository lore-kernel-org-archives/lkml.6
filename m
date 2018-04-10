Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeDJQei (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:34:38 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38880 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeDJQeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 12:34:36 -0400
X-Google-Smtp-Source: AIpwx4+UpXzCTpPX+hWQe1g2mhr1ff7G1DXAvCjfAM8H1/38c1UG6APKULavzOsipTAxtFhLFZRB17r7mu8BNtYHgCA=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWm96dPSx8bms0esFaDhCri9daon0UT4x=qEqeK2XFnTA@mail.gmail.com>
References: <1523276721-4982-1-git-send-email-geert+renesas@glider.be>
 <9bea3ad8-7e84-87c2-9963-de81ad4cb3bf@gmail.com> <CAMuHMdWHoxrq-tj=QznAhuZ8eC22gTTgWFi9HgyqT9pNfJFJyw@mail.gmail.com>
 <87feac02-e955-1897-d4a4-d6d6d1082e45@gmail.com> <CAMuHMdWm96dPSx8bms0esFaDhCri9daon0UT4x=qEqeK2XFnTA@mail.gmail.com>
From: Steve deRosier <derosier@gmail.com>
Date: Tue, 10 Apr 2018 09:34:34 -0700
Message-ID: <CALupW3CvugBA6WZ1+xf1sh5Qmz1s1V8BNSXGATzDzP_t_=6J_A@mail.gmail.com>
Subject: Re: [PATCH] mtd: partitions: Handle add_mtd_device() failures gracefully
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 7:47 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Marek,
>
> On Tue, Apr 10, 2018 at 4:37 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 04/10/2018 03:26 PM, Geert Uytterhoeven wrote:
>>> On Mon, Apr 9, 2018 at 11:59 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>>> On 04/09/2018 02:25 PM, Geert Uytterhoeven wrote:
>>>>> Currently add_mtd_device() failures are plainly ignored, which may lead
>>>>> to kernel crashes later.
>>>
>>>>> Fix this by ignoring and freeing partitions that failed to add in
>>>>> add_mtd_partitions().  The same issue is present in mtd_add_partition(),
>>>>> so fix that as well.
>>>>>
>>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>> ---
>>>>> I don't know if it is worthwhile factoring out the common handling.
>>>>>
>>>>> Should allocate_partition() fail instead?  There's a comment saying
>>>>> "let's register it anyway to preserve ordering".
>>>
>>>>> --- a/drivers/mtd/mtdpart.c
>>>>> +++ b/drivers/mtd/mtdpart.c
>>>
>>>>> @@ -746,7 +753,15 @@ int add_mtd_partitions(struct mtd_info *master,
>>>>>               list_add(&slave->list, &mtd_partitions);
>>>>>               mutex_unlock(&mtd_partitions_mutex);
>>>>>
>>>>> -             add_mtd_device(&slave->mtd);
>>>>> +             ret = add_mtd_device(&slave->mtd);
>>>>> +             if (ret) {
>>>>> +                     mutex_lock(&mtd_partitions_mutex);
>>>>> +                     list_del(&slave->list);
>>>>> +                     mutex_unlock(&mtd_partitions_mutex);
>>>>> +                     free_partition(slave);
>>>>> +                     continue;
>>>>> +             }
>>>>
>>>> Why is the partition even in the list in the first place ? Can we avoid
>>>> adding it rather than adding and removing it ?
>>>
>>> Hence my question "Should allocate_partition() fail instead?".
>>> Note that if we go that route, it should be a "soft" failure, as we
>>> probably don't
>>> want to drop all other partitions on the device.
>> Is the number of partitions ie. in /proc/mtdparts an ABI ?
>
> I don't know.
>

I don't know if it's an ABI, but having consistent /dev/mtdX numbering
is important, even in the case of a failed partition.  Many scripts on
embedded systems are hard-coded to /dev/mtdX identifies with the
expectation that they can access a particular address region of flash.
I'm sure that's what the "let's register it anyway to preserve
ordering" comment was trying to get across. I've even seen weird
things in dts files where later entries specify earlier addresses in
order to leave the old /dev/mtdX numbering alone.

Obviously, a better user solution is to construct the mtdX number from
/proc/mtd based on filtering for the name field, but not everyone
does.

I'd be wary about doing any fix that disturbs the numbering as you'll
be disturbing users.  At a minum, a loud warning in the log.

That said - obviously fixing the kernel crash must happen.

- Steve
