Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417A1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA4D218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfBKMkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:40:41 -0500
Received: from mail.sysgo.com ([176.9.12.79]:36668 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfBKMkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:40:39 -0500
Subject: Re: [PATCH RESEND] initramfs: cleanup incomplete rootfs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
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
From:   David Engraf <david.engraf@sysgo.com>
Message-ID: <84d387a3-0519-d50b-2c5d-98c10f694376@sysgo.com>
Date:   Mon, 11 Feb 2019 13:40:35 +0100
MIME-Version: 1.0
In-Reply-To: <CAHp75VfPBD-9_ddGMNX2jVCynWLS61GLZVva7sM5aj2Sp==vzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.02.19 at 12:40, Andy Shevchenko wrote:
> On Mon, Feb 11, 2019 at 10:49 AM David Engraf <david.engraf@sysgo.com> wrote:
>> On 11.02.19 at 08:56, David Engraf wrote:
>>> On 09.02.19 at 11:35, Andy Shevchenko wrote:
>>>> On Sat, Feb 9, 2019 at 12:08 AM Andrew Morton
>>>> <akpm@linux-foundation.org> wrote:
>>>>> On Fri, 8 Feb 2019 21:45:21 +0200 Andy Shevchenko
>>>>> <andy.shevchenko@gmail.com> wrote:
>>>>>> On Tue, Oct 30, 2018 at 5:22 PM David Engraf
>>>>>> <david.engraf@sysgo.com> wrote:
>>>>>>>
>>>>>>> Unpacking an external initrd may fail e.g. not enough memory. This
>>>>>>> leads
>>>>>>> to an incomplete rootfs because some files might be extracted already.
>>>>>>> Fixed by cleaning the rootfs so the kernel is not using an incomplete
>>>>>>> rootfs.
>>>>>>
>>>>>> This breaks my setup where I have U-boot provided more size of
>>>>>> initramfs than needed. This allows a bit of flexibility to increase or
>>>>>> decrease initramfs compressed image without taking care of bootloader.
>>>>>> The proper solution is to do this if we sure that we didn't get enough
>>>>>> memory, otherwise I can't consider the error fatal to clean up rootfs.
>>>>>
>>>>> OK, thanks.  Maybe David can suggest a fix - I'll queue up a revert
>>>>> meanwhile.
>>>>>
>>>>> I don't really understand the failure.  Why does an oversized initramfs
>>>>> cause unpack_to_rootfs() to fail?
>>>>
>>>> In my case I have got "Junk in compressed archive". I don't know (I
>>>> would check if needed) which exact condition I got  since there are
>>>> three places with this message. The file itself smaller than the size
>>>> passed through bootparam. So, when decomression is finished
>>>> (successfully!) we still have a garbarge in the memory which is not
>>>> related to archive. Message per se is okay to have, though I consider
>>>> this non-fatal.
>>>
>>> I can reproduce this special case. The unpacking decompresses the whole
>>> size instead of checking the archive size. I will have a look how to get
>>> the real archive size.
>>
>> I did some checks and manually increased the initramfs size but I always
>> get the following kernel panic:
> 
> We need to be on the same page here.
> There are two sizes of initramfs compressed archive:
>   1) actual file size;
>   2) what is declared by boot loader and provided via boot parameters.
> 
> In my case I have the 2) bigger than the actual file size.
> Kernel decompresses the initramfs, prints an error that there is junk,
> which is understandable and continues to run init, etc.

Ok got it. When the memory behind the actual file size is clear (0x0) 
the decompression doesn't complain and just ignores the padding. Any 
other data will be interpreted as a new archive and thus you'll see the 
error message.

Is it possible for you to fill the padding after the actual file size 
with 0x00 ?

Best regards
- David


>> Kernel panic - not syncing: junk in compressed archive
>> ---[ end Kernel panic - not syncing: junk in compressed archive
>>
>> The panic was not introduced by my patch. Could you please check if you
>> get a panic as well or is your rootfs just empty?
> 
> Since your patch applied I get rootfs clean followed by inability to
> find working init. So, I have a panic with different reason.
> 
>> I also had a look at the decompression in unpack_to_rootfs(). This
>> function already ensures unpacking only the real size of the archive.
>> But it is called in a loop, thus it unpacks the first archive and then
>> tries to unpack the reset of the data which are garbage in my case.
> 
>> Is it intended to allow extracting multiple archives as rootfs?
> 
> Yes. You can chain up to 64 archives IIRC.
> 
>> If not
>> we could remove the loop and unpack only the first archive. Otherwise we
>> could ignore errors when the first archive was extracted without errors.
> 
> Not the first one, but all the first one_s_. Means, that at least one,
> when it's first(!),  is decompressed successfully.
> 

