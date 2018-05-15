Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbeEORsN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:48:13 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39508 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752458AbeEORsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:48:12 -0400
X-Google-Smtp-Source: AB8JxZoc8hd8ESaFFzNfdQ3s79P4usbsoWDKTbAWeX3uGT6XzxWulXZ0BlqwlRr91uURPJdckW22KkKLHRrq5iU8GQk=
MIME-Version: 1.0
In-Reply-To: <20180514135759.r4jxnw7mp3h6ak36@quack2.suse.cz>
References: <20180512045921.18311-1-deepa.kernel@gmail.com>
 <20180512045921.18311-6-deepa.kernel@gmail.com> <20180514135759.r4jxnw7mp3h6ak36@quack2.suse.cz>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 15 May 2018 10:48:11 -0700
Message-ID: <CABeXuvqso4mbFMmTnScwtxpNFYRGT8AoEdA=KKfBmOFMPGpWzQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] udf: Simplify calls to udf_disk_stamp_to_time
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>, Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 6:57 AM, Jan Kara <jack@suse.cz> wrote:
> Hello,
>
> On Fri 11-05-18 21:59:20, Deepa Dinamani wrote:
>> Subsequent patches in the series convert inode timestamps
>> to use struct timespec64 instead of struct timespec as
>> part of solving the y2038 problem.
>>
>> commit fd3cfad374d4 ("udf: Convert udf_disk_stamp_to_time() to use mktime64()")
>> eliminated the NULL return condition from udf_disk_stamp_to_time().
>> udf_time_to_disk_time() is always called with a valid dest pointer and
>> the return value is ignored.
>> Further, caller can as well check the dest pointer being passed in rather
>> than return argument.
>> Make both the functions return void.
>>
>> This will make the inode timestamp conversion simpler.
>>
>> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
>> Cc: jack@suse.com
>
> I'm fine with this. Just one bug below:
>
>> diff --git a/fs/udf/super.c b/fs/udf/super.c
>> index 0d27d41f5c6e..bd0ae64bc31c 100644
>> --- a/fs/udf/super.c
>> +++ b/fs/udf/super.c
>> @@ -862,6 +862,9 @@ static int udf_load_pvoldesc(struct super_block *sb, sector_t block)
>>       struct buffer_head *bh;
>>       uint16_t ident;
>>       int ret = -ENOMEM;
>> +#ifdef UDFFS_DEBUG
>> +     struct timestamp *ts;
>> +#endif
>>
>>       outstr = kmalloc(128, GFP_NOFS);
>>       if (!outstr)
>> @@ -880,15 +883,14 @@ static int udf_load_pvoldesc(struct super_block *sb, sector_t block)
>>
>>       pvoldesc = (struct primaryVolDesc *)bh->b_data;
>>
>> -     if (udf_disk_stamp_to_time(&UDF_SB(sb)->s_record_time,
>> -                           pvoldesc->recordingDateAndTime)) {
>> +     udf_disk_stamp_to_time(&UDF_SB(sb)->s_record_time,
>> +                           pvoldesc->recordingDateAndTime);
>>  #ifdef UDFFS_DEBUG
>> -             struct timestamp *ts = &pvoldesc->recordingDateAndTime;
>> -             udf_debug("recording time %04u/%02u/%02u %02u:%02u (%x)\n",
>> -                       le16_to_cpu(ts->year), ts->month, ts->day, ts->hour,
>> -                       ts->minute, le16_to_cpu(ts->typeAndTimezone));
>> +     *ts = &pvoldesc->recordingDateAndTime;
>
> This should be 'ts ='.

Thanks, I will fix this in v2.

> Do you prefer me taking this patch through my tree or will you carry it as
> a part of your series?

I can carry the patch as part of the series.

-Deepa
