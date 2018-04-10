Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbeDJGbs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 02:31:48 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42214 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbeDJGbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 02:31:46 -0400
X-Google-Smtp-Source: AIpwx49/i0Phw6j27bxRD+WFKQKhWy9FQ2k3Z6l8B1RNUNJfgHJ8ojjXhjfUwKLFRKnLkJ9BdWZm2O/Gd0MPKK12Fmw=
MIME-Version: 1.0
In-Reply-To: <20180408013525.GE3036@codeaurora.org>
References: <20180406142832.2243021-1-arnd@arndb.de> <20180408013525.GE3036@codeaurora.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 10 Apr 2018 08:31:44 +0200
X-Google-Sender-Auth: uqUAEi4u7Ce8kOLjcDTSkB5AE-U
Message-ID: <CAK8P3a0ZhHY35rDrg5m4o3fTXugAG3QipnaZQupnUafvKcH6HQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] hexagon: fix ffz/fls/ffs return type
To: Richard Kuo <rkuo@codeaurora.org>
Cc: "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 8, 2018 at 3:35 AM, Richard Kuo <rkuo@codeaurora.org> wrote:
> On Fri, Apr 06, 2018 at 04:28:21PM +0200, Arnd Bergmann wrote:
>> Let's use the same return type as the major architectures to
>> avoid warnings like
>>
>> drivers/ata/libahci_platform.c: In function 'ahci_platform_init_host':
>> drivers/ata/libahci_platform.c:561:12: warning: comparison of distinct pointer types lacks a cast [enabled by default]
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/hexagon/include/asm/bitops.h | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
>> index 5e4a59b3ec1b..8790a50b1f5e 100644
>> --- a/arch/hexagon/include/asm/bitops.h
>> +++ b/arch/hexagon/include/asm/bitops.h
>> @@ -194,7 +194,7 @@ static inline int __test_bit(int nr, const volatile unsigned long *addr)
>>   *
>>   * Undefined if no zero exists, so code should check against ~0UL first.
>>   */
>> -static inline long ffz(int x)
>> +static inline int ffz(int x)
>>  {
>>       int r;
>>
>> @@ -211,7 +211,7 @@ static inline long ffz(int x)
>>   * This is defined the same way as ffs.
>>   * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
>>   */
>> -static inline long fls(int x)
>> +static inline int fls(int x)
>>  {
>>       int r;
>>
>> @@ -232,7 +232,7 @@ static inline long fls(int x)
>>   * the libc and compiler builtin ffs routines, therefore
>>   * differs in spirit from the above ffz (man ffs).
>>   */
>> -static inline long ffs(int x)
>> +static inline int ffs(int x)
>>  {
>>       int r;
>>
>
>
> Isn't ffz usually long/unsigned long on other architectures?

Yes, that's right. Let's drop my patch for the moment and maybe revisit it
later. There were only a couple of warnings in an allmodconfig build from
this one, so it might be better change the generic bitops and the more
common architectures to all consistently use 'long' or maybe 'unsigned long'
as the return type for all those functions.

       Arnd
