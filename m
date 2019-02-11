Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBBEC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B77D2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfBKH4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:56:36 -0500
Received: from mail.sysgo.com ([176.9.12.79]:57324 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfBKH4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:56:35 -0500
From:   David Engraf <david.engraf@sysgo.com>
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
Message-ID: <744e7bcb-9315-0283-67c5-c2cb2d094251@sysgo.com>
Date:   Mon, 11 Feb 2019 08:56:32 +0100
MIME-Version: 1.0
In-Reply-To: <CAHp75VdWyGv2QyuwE+4-oFJt8St2UmeuaHhveeLAFPPPuN5=tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.19 at 11:35, Andy Shevchenko wrote:
> On Sat, Feb 9, 2019 at 12:08 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>> On Fri, 8 Feb 2019 21:45:21 +0200 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>> On Tue, Oct 30, 2018 at 5:22 PM David Engraf <david.engraf@sysgo.com> wrote:
>>>>
>>>> Unpacking an external initrd may fail e.g. not enough memory. This leads
>>>> to an incomplete rootfs because some files might be extracted already.
>>>> Fixed by cleaning the rootfs so the kernel is not using an incomplete
>>>> rootfs.
>>>
>>> This breaks my setup where I have U-boot provided more size of
>>> initramfs than needed. This allows a bit of flexibility to increase or
>>> decrease initramfs compressed image without taking care of bootloader.
>>> The proper solution is to do this if we sure that we didn't get enough
>>> memory, otherwise I can't consider the error fatal to clean up rootfs.
>>
>> OK, thanks.  Maybe David can suggest a fix - I'll queue up a revert
>> meanwhile.
>>
>> I don't really understand the failure.  Why does an oversized initramfs
>> cause unpack_to_rootfs() to fail?
> 
> In my case I have got "Junk in compressed archive". I don't know (I
> would check if needed) which exact condition I got  since there are
> three places with this message. The file itself smaller than the size
> passed through bootparam. So, when decomression is finished
> (successfully!) we still have a garbarge in the memory which is not
> related to archive. Message per se is okay to have, though I consider
> this non-fatal.

I can reproduce this special case. The unpacking decompresses the whole 
size instead of checking the archive size. I will have a look how to get 
the real archive size.

Best regards
- David
