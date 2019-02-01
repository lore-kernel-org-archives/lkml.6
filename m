Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F54C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E172085B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfBABW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 20:22:26 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7169 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725870AbfBABW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 20:22:26 -0500
X-IronPort-AV: E=Sophos;i="5.56,546,1539619200"; 
   d="scan'208";a="53367439"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 01 Feb 2019 09:22:23 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 95C894C4BB6B;
        Fri,  1 Feb 2019 09:22:21 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 1 Feb 2019 09:22:20 +0800
Date:   Fri, 1 Feb 2019 09:21:03 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <kirill.shutemov@linux.intel.com>,
        <hjl.tools@gmail.com>, Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] x86/boot: Expand __puthex() to print 64-bit value in
 i386-PAE
Message-ID: <20190201012102.GB17551@localhost.localdomain>
References: <20190131083946.12272-1-fanc.fnst@cn.fujitsu.com>
 <20190131212013.GN6749@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190131212013.GN6749@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 95C894C4BB6B.AC55B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 10:20:13PM +0100, Borislav Petkov wrote:
>On Thu, Jan 31, 2019 at 04:39:46PM +0800, Chao Fan wrote:
>> __puthex() is the only method to print value in compressed boot stage.
>> But in i386-PAE, sizeof(unsigned long) is 4, so that the value of
>> 64-bit is cut and print a wrong value. That will mislead developers
>> when debugging.
>> Expand the type to unsigned long long to print the right value.
>> 
>> Suggested-by: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>> Here is my PATCHSET:
>> https://lkml.org/lkml/2019/1/23/266
>> When debugging, I need to print the memory address and length then
>> check the value is right or not. They may exceed 4G in i386-PAE,
>> but the upper half was cut because unsigned long is not enough.
>> 
>> A same condition fix after start_kernel() in ACPI has been merged:
>> commit b9ced18acf68dffebe6888c7ec765a2b1db7a039
>> Author: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> Date:   Wed Dec 26 11:34:50 2018 +0800
>> 
>>     ACPI: NUMA: Use correct type for printing addresses on i386-PAE
>> ---
>>  arch/x86/boot/compressed/misc.c | 2 +-
>>  arch/x86/boot/compressed/misc.h | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
>> index 8dd1d5ccae58..30fb8abdb154 100644
>> --- a/arch/x86/boot/compressed/misc.c
>> +++ b/arch/x86/boot/compressed/misc.c
>> @@ -153,7 +153,7 @@ void __putstr(const char *s)
>>  	outb(0xff & (pos >> 1), vidport+1);
>>  }
>>  
>> -void __puthex(unsigned long value)
>> +void __puthex(unsigned long long value)
>
>Not enough because debug_putaddr() still converts it to unsigned long.
>So you get (still truncated) values with 8 preceding zeroes:

Yes, so sometimes it's better to use debug_puthex().
>
>input_data: 0x00000000036bf100
>input_len: 0x00000000005b694b
>output: 0x0000000001000000
>output_len: 0x0000000000bfba30
>kernel_total_size: 0x0000000002c92000
>beefy: 0x00000000cafebabe
>
>beefy is a test variable I declared:
>
>u64 beefy = 0xdeadbeefcafebabe;
>
>If anything, there should be a separate set of helpers which take 64-bit
>quantities as arguments. But I don't see any need for them now.

It's not used for existing code, it's used to help developers debug.
Just in my RSDP PATCHSET, I need to print the memory regions from SRAT
and check the value, then I found the value of memory regions in last
2 nodes are always wrong, I though there are some problems in my code.
Later I found the value was cut and neither debug_putaddr() nor
debug_puthex() is enough to use, then I change them to unsigned
long long in my local code and continue to debug.
So I send the change as PATCH and to see if later developers need the
debug tool.

Thanks,
Chao Fan

>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


