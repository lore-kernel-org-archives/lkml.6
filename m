Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE06AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792D42085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792D42085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeKHAPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:15:11 -0500
Received: from relay.sw.ru ([185.231.240.75]:60230 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbeKHAPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:15:11 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gKP4G-0002v8-54; Wed, 07 Nov 2018 17:44:28 +0300
Subject: Re: [PATCH] ubsan: don't mark __ubsan_handle_builtin_unreachable as
 noreturn
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nicolas Pitre <nico@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180202154813.1625742-1-arnd@arndb.de>
 <d77f9a8a-0bb2-50a3-68e3-b4f4173645bc@virtuozzo.com>
 <CAK8P3a124Jdza9YbgOHECC2owpx_HmOuDMWtotxuC2-F9L9Cgg@mail.gmail.com>
 <00813389-daf0-a97f-8642-cb4e7a62fa27@virtuozzo.com>
 <CAOesGMi-vkYPDrL2drJ70zf3_xTMWrsfPoW68TkiRJCj8uWBLg@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <cca8985f-8279-7bd8-3ebe-f2f79cd98b91@virtuozzo.com>
Date:   Wed, 7 Nov 2018 17:44:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAOesGMi-vkYPDrL2drJ70zf3_xTMWrsfPoW68TkiRJCj8uWBLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/03/2018 12:27 AM, Olof Johansson wrote:
> On Mon, Feb 5, 2018 at 2:31 AM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>
>> On 02/05/2018 01:15 PM, Arnd Bergmann wrote:
>>> On Mon, Feb 5, 2018 at 10:02 AM, Andrey Ryabinin
>>> <aryabinin@virtuozzo.com> wrote:
>>>>
>>>>
>>>> On 02/02/2018 06:47 PM, Arnd Bergmann wrote:
>>>>> gcc-8 complains about the prototype for this function:
>>>>>
>>>>> lib/ubsan.c:432:1: error: ignoring attribute 'noreturn' in declaration of a built-in function '__ubsan_handle_builtin_unreachable' because it conflicts with attribute 'const' [-Werror=attributes]
>>>>>
>>>>
>>>> That's actually a bug in GCC. In GCC __ubsan_handle_builtin_unreachable declared
>>>> with 'noreturn' and 'const' attributes:
>>>>
>>>> DEF_SANITIZER_BUILTIN(BUILT_IN_UBSAN_HANDLE_BUILTIN_UNREACHABLE,
>>>>                       "__ubsan_handle_builtin_unreachable",
>>>>                       BT_FN_VOID_PTR,
>>>>                       ATTR_COLD_CONST_NORETURN_NOTHROW_LEAF_LIST)
>>>>
>>>>
>>>> But const attribute doesn't make any sense for function that returns void or doesn't return at all.
>>>> Given that gcc-8 has not released yet, it would be better to fix this bug there.
>>>
>>> Ok. Should I open a gcc bug, or will you take care of it?
>>>
>>
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84210
> 
> 8.2.0 still shows this, and there's been no movement on that bug. How
> about we pick up this patch until it's been resolved?
> 

Sure, I'll add info about GCC bug in changelog and resend the patch.

> 
> -Olof
> 
