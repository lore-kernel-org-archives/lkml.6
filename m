Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027DFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD41A20881
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfAGIw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:52:57 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49181 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726572AbfAGIw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:52:57 -0500
X-IronPort-AV: E=Sophos;i="5.56,450,1539619200"; 
   d="scan'208";a="51461993"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Jan 2019 16:52:53 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 6C3404B7EC74;
        Mon,  7 Jan 2019 16:52:50 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 7 Jan 2019 16:52:52 +0800
Subject: Re: [PATCH] x86/boot: drop memset from copy.S
To:     <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
References: <20190107074056.12532-1-caoj.fnst@cn.fujitsu.com>
 <000CE7C8-33F3-404A-9E7D-F2CCB0BA110E@zytor.com>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <28158fd7-8569-e0c1-75d0-c423330e256d@cn.fujitsu.com>
Date:   Mon, 7 Jan 2019 16:52:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <000CE7C8-33F3-404A-9E7D-F2CCB0BA110E@zytor.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 6C3404B7EC74.A7781
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/7/19 3:59 PM, hpa@zytor.com wrote:
> On January 6, 2019 11:40:56 PM PST, Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>> According to objdump output of setup, function memset is not used in
>> setup code. Currently, all usage of memset in setup come from macro
>> definition of string.h.
>>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> ---
>> Compiled and booted under x86_64; compiled under i386.
>>
>> Questions: now there is 2 definition of memcpy, one lies in copy.S,
>> another lies in string.h which is mapped to gcc builtin function. Do we
>> still need 2 definition? Could we move the content of copy.S to
>> boot/string.c?
>>
>> At first glance, the usage of string.{c.h} of setup is kind of
>> confusing,
>> they are also used in compressed/ and purgatory/
>>
>> arch/x86/boot/copy.S | 15 ---------------
>> 1 file changed, 15 deletions(-)
>>
>> diff --git a/arch/x86/boot/copy.S b/arch/x86/boot/copy.S
>> index 15d9f74b0008..5157d08b0ff2 100644
>> --- a/arch/x86/boot/copy.S
>> +++ b/arch/x86/boot/copy.S
>> @@ -33,21 +33,6 @@ GLOBAL(memcpy)
>> 	retl
>> ENDPROC(memcpy)
>>
>> -GLOBAL(memset)
>> -	pushw	%di
>> -	movw	%ax, %di
>> -	movzbl	%dl, %eax
>> -	imull	$0x01010101,%eax
>> -	pushw	%cx
>> -	shrw	$2, %cx
>> -	rep; stosl
>> -	popw	%cx
>> -	andw	$3, %cx
>> -	rep; stosb
>> -	popw	%di
>> -	retl
>> -ENDPROC(memset)
>> -
>> GLOBAL(copy_from_fs)
>> 	pushw	%ds
>> 	pushw	%fs
> 
> This is dependent on both gcc version and flags.
> 

Thanks for your info, but I still don't quite get your point. All files
who has memset reference in setup will also #include "string.h", so how
gcc version and flags will associate memset reference to the assembly
function by force?  Hope to get a little more details when you are
convenient:)


