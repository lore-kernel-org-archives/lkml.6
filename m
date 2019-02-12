Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B5CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADBB2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfBLMMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:12:53 -0500
Received: from mail.sysgo.com ([176.9.12.79]:42090 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfBLMMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:12:52 -0500
Subject: Re: [PATCH RESEND] initramfs: cleanup incomplete rootfs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181022134048.19693-1-david.engraf@sysgo.com>
 <20181030151805.5519-1-david.engraf@sysgo.com>
 <CAHp75VdOSC8j_1G3z-UO01_JYN20M-YMGOC2JkFDhi8njNZAvA@mail.gmail.com>
 <20190208140810.76ef6c25825a5644d9625f0a@linux-foundation.org>
 <CAHp75VdWyGv2QyuwE+4-oFJt8St2UmeuaHhveeLAFPPPuN5=tg@mail.gmail.com>
 <744e7bcb-9315-0283-67c5-c2cb2d094251@sysgo.com>
 <28139206-7fed-e00e-8f52-47e68655963d@sysgo.com>
 <CAHp75VfPBD-9_ddGMNX2jVCynWLS61GLZVva7sM5aj2Sp==vzQ@mail.gmail.com>
 <84d387a3-0519-d50b-2c5d-98c10f694376@sysgo.com>
 <CAHp75VcNY3ZX9XF10mmOGgRq=-Soa+a0y=iFC0c+S=gzJ0+2RQ@mail.gmail.com>
From:   David Engraf <david.engraf@sysgo.com>
Message-ID: <b40bc54f-9fcc-91d4-0e25-231acf34d992@sysgo.com>
Date:   Tue, 12 Feb 2019 13:12:48 +0100
MIME-Version: 1.0
In-Reply-To: <CAHp75VcNY3ZX9XF10mmOGgRq=-Soa+a0y=iFC0c+S=gzJ0+2RQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.02.19 at 11:43, Andy Shevchenko wrote:
> On Mon, Feb 11, 2019 at 2:40 PM David Engraf <david.engraf@sysgo.com> wrote:
>> On 11.02.19 at 12:40, Andy Shevchenko wrote:
>>> On Mon, Feb 11, 2019 at 10:49 AM David Engraf <david.engraf@sysgo.com> wrote:
>>>> On 11.02.19 at 08:56, David Engraf wrote:
>>>>> On 09.02.19 at 11:35, Andy Shevchenko wrote:
>>>>>> On Sat, Feb 9, 2019 at 12:08 AM Andrew Morton
>>>>>> <akpm@linux-foundation.org> wrote:
>>>>>>> On Fri, 8 Feb 2019 21:45:21 +0200 Andy Shevchenko
>>>>>>> <andy.shevchenko@gmail.com> wrote:
>>>>>>>> On Tue, Oct 30, 2018 at 5:22 PM David Engraf
>>>>>>>> <david.engraf@sysgo.com> wrote:
> 
>>>>>> In my case I have got "Junk in compressed archive". I don't know (I
>>>>>> would check if needed) which exact condition I got  since there are
>>>>>> three places with this message. The file itself smaller than the size
>>>>>> passed through bootparam. So, when decomression is finished
>>>>>> (successfully!) we still have a garbarge in the memory which is not
>>>>>> related to archive. Message per se is okay to have, though I consider
>>>>>> this non-fatal.
>>>>>
>>>>> I can reproduce this special case. The unpacking decompresses the whole
>>>>> size instead of checking the archive size. I will have a look how to get
>>>>> the real archive size.
>>>>
>>>> I did some checks and manually increased the initramfs size but I always
>>>> get the following kernel panic:
>>>
>>> We need to be on the same page here.
>>> There are two sizes of initramfs compressed archive:
>>>    1) actual file size;
>>>    2) what is declared by boot loader and provided via boot parameters.
>>>
>>> In my case I have the 2) bigger than the actual file size.
>>> Kernel decompresses the initramfs, prints an error that there is junk,
>>> which is understandable and continues to run init, etc.
>>
>> Ok got it. When the memory behind the actual file size is clear (0x0)
>> the decompression doesn't complain and just ignores the padding. Any
>> other data will be interpreted as a new archive and thus you'll see the
>> error message.
> 
> Correct.
> 
>> Is it possible for you to fill the padding after the actual file size
>> with 0x00 ?
> 
> Not sure. This is boot loader realm. Even if I patch U-Boot, not every
> boot loader will guarantee this.
> So, it's fragile to rely on data being 0x00 after actual archive.

The problem is that the kernel expects another archive if there are data 
left. If these data do not contain a valid magic the kernel prints an 
error message which is correct.

I could make this error not critical and keep the rootfs, but it's still 
an error and unexpected. You're using a modified bootloader which 
reports a size larger than the file itself. Other bootloader will use 
the file size and report the correct size to the kernel. So this 
workaround is required by your setup only.

@Andrew: What do you think about that? Shall I create a workaround for 
the special case?

Best regards
- David

