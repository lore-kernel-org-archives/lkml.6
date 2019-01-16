Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CB9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0123820859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391823AbfAPJoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:44:01 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6891 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731932AbfAPJoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:44:00 -0500
X-IronPort-AV: E=Sophos;i="5.56,485,1539619200"; 
   d="scan'208";a="52134393"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Jan 2019 17:43:58 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id E8E734BAD9BE;
        Wed, 16 Jan 2019 17:43:55 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 16 Jan 2019 17:43:55 +0800
Subject: Re: question about head_64.S
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>, <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <6aebbf86-2ba1-c517-dc47-054279daec49@cn.fujitsu.com>
 <alpine.DEB.2.21.1901151641000.1561@nanos.tec.linutronix.de>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <642e4121-229f-7627-7f1d-737eb8ed4e5f@cn.fujitsu.com>
Date:   Wed, 16 Jan 2019 17:44:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901151641000.1561@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: E8E734BAD9BE.AAEEE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 11:55 PM, Thomas Gleixner wrote:
> On Tue, 15 Jan 2019, Cao jin wrote:
> 
>> Hi,
>>   I have been digging into this file for a while, and I still have 2
>> questions unclear, hope to get your help.
>>
>> 1.
>> At the entry of startup_64, we set all the data segment registers to 0,
>> according to commit 08da5a2ca("x86_64: Early segment setup for VT"), it
>> is said to accelerate the decompression under VT. I don't know Intel VT,
>> but I did test under physical machine and virtual machine(with KVM, and
>> intel VT enabled in BIOS) with following patch:
>>
>> diff --git a/arch/x86/boot/compressed/head_64.S
>> b/arch/x86/boot/compressed/head_64.S
>> index 58f6a467f1fa..595f3c300173 100644
>> --- a/arch/x86/boot/compressed/head_64.S
>> +++ b/arch/x86/boot/compressed/head_64.S
>> @@ -260,12 +260,12 @@ ENTRY(startup_64)
>>          */
>>
>>         /* Setup data segments. */
>> -       xorl    %eax, %eax
>> -       movl    %eax, %ds
>> -       movl    %eax, %es
>> -       movl    %eax, %ss
>> -       movl    %eax, %fs
>> -       movl    %eax, %gs
>> +//     xorl    %eax, %eax
>> +//     movl    %eax, %ds
>> +//     movl    %eax, %es
>> +//     movl    %eax, %ss
>> +//     movl    %eax, %fs
>> +//     movl    %eax, %gs
>>
>> I don't see any obvious booting time difference, is there anything I missed?
>> Also, I don't find explicit document saying we should zero these
>> registers under VT.
> 
> The decompressor is position independent code, so all segments have to be
> set to 0.
> 

Thank you Thomas! But I've never heard that PIC is correlated with
segment register value, could you elaborate a little bit? Because as I
know, startup_64 is in long mode, and CPU will treat all segment(except
fs, gs) base as 0, no matter whatever in them. And until now, I only see
fs is touched when parsing command line, not see any explicit gs usage.

On the other hand, I test the patch above, it can boot up, so seems
segment register value here is not necessary to be 0?

> The patch you mentioned was just adding fs/gs to the list of segments
> which are cleared and the commit message is not very clear. Though if you
> dig further down then you find the original version of that patch:
> 
>   commit ffb6017563aa("[PATCH] x86-64: x86_64 - Fix FS/GS registers for VT execution")
> 
> That one has a proper explantaion.
> 

Oh, I still not reach to the real kernel itself yet. At first glance,
"but it is important to reload them in protected mode" make sense to me.

But more confusion rise up: under 64-bit boot protocol, we can have more
than one entry? startup_64 in both:

  arch/x86/kernel/head_64.S
and
  arch/x86/boot/compressed/head_64.S

can be jumped to via bootloader? Seems Documentation/x86/boot.txt
doesn't say that.

-- 
Sincerely,
Cao jin


