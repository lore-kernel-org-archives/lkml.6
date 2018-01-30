Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeA3SOa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:14:30 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45223 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbeA3SO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:14:27 -0500
X-Google-Smtp-Source: AH8x224BW9NE99WkQVSu5zosrtit0FV7I+867s+KzNsGuzXMVu9F3vmoAEV/y6rMOY00im65K5DmrPBeuoiYkMYzBoA=
MIME-Version: 1.0
In-Reply-To: <20180130171745.i5wwcwr4qdbcoxhm@pali>
References: <1517331540-13266-1-git-send-email-mario.limonciello@dell.com> <20180130171745.i5wwcwr4qdbcoxhm@pali>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 30 Jan 2018 20:14:26 +0200
Message-ID: <CAHp75VcqCdEQjUCoSGz87Mb3HFomfOwKWxC7S2CjtqSAZQEpsA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: Allocate buffer on heap rather
 than globally
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Mario Limonciello <mario.limonciello@dell.com>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0UIEYwJ015890

On Tue, Jan 30, 2018 at 7:17 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> On Tuesday 30 January 2018 10:59:00 Mario Limonciello wrote:
>> There may be race conditions with multiple different functions working
>> on a module wide buffer causing one function to get the wrong results.
>
> Yes, this is better. We really do not need to allocate shared buffer in
> dell-laptop anymore. Before this buffer was specially allocated in first
> 4GB addresses space because its physical addresses was passed into SMM.

+1.

>> -static void dell_set_arguments(u32 arg0, u32 arg1, u32 arg2, u32 arg3)
>> +static void dell_set_arguments(struct calling_interface_buffer *buffer,
>> +                            u32 arg0, u32 arg1, u32 arg2, u32 arg3)
>
> Hm... this function has too many parameters :-(
>
> What about following API?
>
> static struct calling_interface_buffer dell_set_arguments(u32 arg0, u32 arg1, u32 arg2, u32 arg3);
>
> It would return filled structure (not a pointer !)

I do not think it's a good idea. Either we allocate request on a heap
and return a pointer, or we fill the struct with some data on spot.

To naming:

for allocation: ..._alloc_request()
for filling: _fill_request() / _prepare_request()

or alike.

_set_arguments() not good enough to me.

> and caller would be
> able to use it as:
>
>   struct calling_interface_buffer buffer;
>   buffer = dell_set_arguments(0x2, 0, 0, 0);
>   ret = dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);

See above.

> And maybe after this change, function dell_set_arguments() could have
> better name, e.g. dell_prepare_request() (or dell_prepare_request_buffer)
> as "set arguments" is not really what would function do (as it return
> something).

Agree.

>
>   struct calling_interface_buffer buffer;
>   buffer = dell_prepare_request_buffer(0x2, 0, 0, 0);
>   ret = dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
>
> Andy, any suggestion or opinion?

See above.

-- 
With Best Regards,
Andy Shevchenko
