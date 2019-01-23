Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BC0C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 04:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A028321019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 04:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfAWEEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 23:04:08 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35002 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726964AbfAWEEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 23:04:08 -0500
X-IronPort-AV: E=Sophos;i="5.56,509,1539619200"; 
   d="scan'208";a="52623961"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jan 2019 12:04:04 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id D963B4C47E9C;
        Wed, 23 Jan 2019 12:04:02 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 23 Jan 2019 12:04:01 +0800
Subject: Re: question about head_64.S
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <6aebbf86-2ba1-c517-dc47-054279daec49@cn.fujitsu.com>
 <023da151-bb1d-1b11-ec1d-01eb675d528f@cn.fujitsu.com>
 <20190122130800.cpfor3klov22badb@kshutemo-mobl1>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <4d4efba6-9b15-4730-b4c4-b70e79a5e6e2@cn.fujitsu.com>
Date:   Wed, 23 Jan 2019 12:01:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190122130800.cpfor3klov22badb@kshutemo-mobl1>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: D963B4C47E9C.AA8D5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/19 9:08 PM, Kirill A. Shutemov wrote:
> On Tue, Jan 22, 2019 at 03:31:25PM +0800, Cao jin wrote:
>> Hi, Kirll,
>>

>>> 2.
>>> Why gdt64 has following definition?:
>>>
>>> gdt64:
>>> 	.word	gdt_end - gdt
>>> 	.long	0
>>> 	.word	0
>>> 	.quad   0
>>>
>>> obviously, gdt64 stores the GDTR content under x86_64, which is 10 bytes
>>> long, so why not just:
>>>
>>> gdt64:
>>> 	.word	gdt_end - gdt
>>> 	.quad   0
>>>
>>> With above modification, it can boot.
>>>
>>
>> Seems you introduced gdt64 code in commit beebaccd50, could you help
>> with this question?
> 
> Looks like you are right. I've got confused at some point.
> 
> Could you prepare a patch?

Sure.

> 
>> And it also remind me of another question about adjust_got which is also
>> introduced by you. Because I failed to construct a test environment with
>> ld version less than 2.24 until now, so I wanna do a quick ask here:
>> does it make sense to adjust GOT from the 4th entry of it? Because as I
>> know, the first 3 entries are special one, which (I guess) will be not used.
> 
> No.
> 
> These 3 entries are reserved for a special symbols (like entry 0 for
> _DYNAMIC). It means linker should not use these entries for normal
> symbols, but it doesn't mean that they don't need to be adjusted during
> the load.
> 

Thanks for your info! BTW, could I know how you construct the test
environment?

I tried centos6, the GCC version is too old to compile; then tried
fedora28 with binutils-2.20.51.0.2-5.48.el6.x86_64.rpm from centos6, ld
reported errors; and then tried compiling binutils source with tag 2.23,
stopped at configure phase:(

-- 
Sincerely,
Cao jin


