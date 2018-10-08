Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55601C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996D62075E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TJbfaF8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996D62075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeJHRLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:11:11 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35492 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeJHRLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:11:10 -0400
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3B1E71283;
        Mon,  8 Oct 2018 12:00:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1538992813;
        bh=T7LQ8OYrIWnmpiePuzQLchnHINAkwT9pXI+tTCJ0TIU=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TJbfaF8mMcPP7LOyQ2Xf+LsFS/7Q5l0p0XSuACooJBte6l3Cz3keFY6j6ZY2TqnlS
         TzGVeZf2b0U6eigeXjH4tTC6HbVBD8gbsBecbOKw8ilAZYmbiCk/PGzpbopWR/llJe
         3928t0/fLZVXpSTlvUjCOAKUu1lAhc4/eRUtH5rM=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH] kbuild: fix kernel/bounds.c 'W=1' warning
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        miguel.ojeda.sandonis@gmail.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
References: <20180921142234.16882-1-kieran.bingham+renesas@ideasonboard.com>
 <20181005083313.2088252-1-arnd@arndb.de>
 <CANiq72mHDxe9-+pFf+dDuYXRz5YeyRYi6RW65tyo9-ENNngsCw@mail.gmail.com>
 <CAK7LNAT5h+Rku7DbD+kHGv7Kgk8FfuX4wwL_pwNOLSJbqw99MA@mail.gmail.com>
 <CAK7LNATycNLxzB=FtrBy9M4E6m9wx4Uhk=DQ7gcCMD2J_vfmfQ@mail.gmail.com>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <5cbb504c-0506-cec8-d51b-00928cdb27fe@ideasonboard.com>
Date:   Mon, 8 Oct 2018 11:00:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNATycNLxzB=FtrBy9M4E6m9wx4Uhk=DQ7gcCMD2J_vfmfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/18 23:06, Masahiro Yamada wrote:
> On Sun, Oct 7, 2018 at 6:58 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> Hi Miguel,
>>
>>
>> On Sun, Oct 7, 2018 at 6:18 AM Miguel Ojeda
>> <miguel.ojeda.sandonis@gmail.com> wrote:
>>>
>>> On Fri, Oct 5, 2018 at 10:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>>>
>>>> Building any configuration with 'make W=1' produces a warning:
>>>>
>>>> kernel/bounds.c:16:6: warnign: no previous prototype for 'foo' [-Wmissing-prototypes]
>>>>
>>>> When also passing -Werror, this prevents us from building any
>>>> other files. Nobody ever calls the function, but we can't make
>>>> it 'static' either since we want the compiler output.
>>>>
>>>> Calling it 'main' instead however avoids the warning, because gcc
>>>> does not insist on having a declaration for main.
>>>
>>> I think marking the function as static __used should do the trick and
>>> would be less confusing.
>>
>>
>>
>>
>> I tried __used, but I still see the warning.
>>
>>
>> masahiro@grover:~/ref/linux$ git diff
>> diff --git a/kernel/bounds.c b/kernel/bounds.c
>> index c373e88..aee0101 100644
>> --- a/kernel/bounds.c
>> +++ b/kernel/bounds.c
>> @@ -13,7 +13,7 @@
>>  #include <linux/log2.h>
>>  #include <linux/spinlock_types.h>
>>
>> -void foo(void)
>> +void __used foo(void)
>>  {
>>         /* The enum constants to put into include/generated/bounds.h */
>>         DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
>> masahiro@grover:~/ref/linux$ make W=1  prepare
>>   CC      kernel/bounds.s
>> kernel/bounds.c:16:13: warning: no previous prototype for ‘foo’
>> [-Wmissing-prototypes]
>>  void __used foo(void)
>>              ^
>>   CC      arch/x86/kernel/asm-offsets.s
> 
> 
> 
> Sorry, I forgot to add 'static'.
> 
> Adding both static and __used worked for me,
> and I like the idea.
> 

Aha - I'd also tried converting to static in my earlier attempts, but
didn't realise we had __used!

updating as "static __used" causes the following diff:

diff -Nurp bounds.s.foo bounds.s.static-used
--- bounds.s.foo        2018-10-05 10:20:53.269941404 +0100
+++ bounds.s.static-used        2018-10-08 10:51:18.079309049 +0100
@@ -110,7 +110,6 @@
 #NO_APP
        .align  2
        .p2align 3,,7
-       .global foo
        .type   foo, %function
 foo:
        stp     x29, x30, [sp, -16]!    //,,,


I'd say this is a pretty good alternative fix - however I see Arnd's
version is already on it's way though akpm's tree...

https://ozlabs.org/~akpm/mmots/broken-out/kbuild-fix-kernel-boundsc-w%3D1-warning.patch

Anyway, as long as one of the variants gets there I'll be happy :)

--
Regards

Kieran

