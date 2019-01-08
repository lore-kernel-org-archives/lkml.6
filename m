Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6080DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4F720449
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfAHIi5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:38:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50857 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfAHIi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:38:56 -0500
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x088cYTp3431687
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 8 Jan 2019 00:38:34 -0800
Date:   Tue, 08 Jan 2019 00:38:27 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <28158fd7-8569-e0c1-75d0-c423330e256d@cn.fujitsu.com>
References: <20190107074056.12532-1-caoj.fnst@cn.fujitsu.com> <000CE7C8-33F3-404A-9E7D-F2CCB0BA110E@zytor.com> <28158fd7-8569-e0c1-75d0-c423330e256d@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] x86/boot: drop memset from copy.S
To:     Cao jin <caoj.fnst@cn.fujitsu.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
CC:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
From:   hpa@zytor.com
Message-ID: <1DA6B342-5F32-4C73-9352-4DB9F176D53C@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 7, 2019 12:52:57 AM PST, Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>Hi,
>
>On 1/7/19 3:59 PM, hpa@zytor.com wrote:
>> On January 6, 2019 11:40:56 PM PST, Cao jin
><caoj.fnst@cn.fujitsu.com> wrote:
>>> According to objdump output of setup, function memset is not used in
>>> setup code. Currently, all usage of memset in setup come from macro
>>> definition of string.h.
>>>
>>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>>> ---
>>> Compiled and booted under x86_64; compiled under i386.
>>>
>>> Questions: now there is 2 definition of memcpy, one lies in copy.S,
>>> another lies in string.h which is mapped to gcc builtin function. Do
>we
>>> still need 2 definition? Could we move the content of copy.S to
>>> boot/string.c?
>>>
>>> At first glance, the usage of string.{c.h} of setup is kind of
>>> confusing,
>>> they are also used in compressed/ and purgatory/
>>>
>>> arch/x86/boot/copy.S | 15 ---------------
>>> 1 file changed, 15 deletions(-)
>>>
>>> diff --git a/arch/x86/boot/copy.S b/arch/x86/boot/copy.S
>>> index 15d9f74b0008..5157d08b0ff2 100644
>>> --- a/arch/x86/boot/copy.S
>>> +++ b/arch/x86/boot/copy.S
>>> @@ -33,21 +33,6 @@ GLOBAL(memcpy)
>>> 	retl
>>> ENDPROC(memcpy)
>>>
>>> -GLOBAL(memset)
>>> -	pushw	%di
>>> -	movw	%ax, %di
>>> -	movzbl	%dl, %eax
>>> -	imull	$0x01010101,%eax
>>> -	pushw	%cx
>>> -	shrw	$2, %cx
>>> -	rep; stosl
>>> -	popw	%cx
>>> -	andw	$3, %cx
>>> -	rep; stosb
>>> -	popw	%di
>>> -	retl
>>> -ENDPROC(memset)
>>> -
>>> GLOBAL(copy_from_fs)
>>> 	pushw	%ds
>>> 	pushw	%fs
>> 
>> This is dependent on both gcc version and flags.
>> 
>
>Thanks for your info, but I still don't quite get your point. All files
>who has memset reference in setup will also #include "string.h", so how
>gcc version and flags will associate memset reference to the assembly
>function by force?  Hope to get a little more details when you are
>convenient:)

GCC will sometimes emit calls to certain functions including memcpy().
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
