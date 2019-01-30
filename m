Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A6AC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8381F2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbfA3RM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:12:27 -0500
Received: from relay.sw.ru ([185.231.240.75]:33224 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbfA3RM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:12:27 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gotPT-00043X-36; Wed, 30 Jan 2019 20:12:23 +0300
Subject: Re: [PATCH] lib/ubsan: default UBSAN_ALIGNMENT to not set
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, arnd@arndb.de,
        linux-kernel@vger.kernel.org
References: <20181217150326.30933-1-anders.roxell@linaro.org>
 <8bc73bbf-6c12-7fd1-3253-676731bf5ae5@virtuozzo.com>
 <20190129173634.ee579795b227b141efc8bd30@linux-foundation.org>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <2370bfbc-762f-fb3f-79b1-483a095fdf7c@virtuozzo.com>
Date:   Wed, 30 Jan 2019 20:12:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129173634.ee579795b227b141efc8bd30@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/19 4:36 AM, Andrew Morton wrote:
> On Fri, 11 Jan 2019 22:01:16 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> 
>>
>>
>> On 12/17/18 6:03 PM, Anders Roxell wrote:
>>> When booting an allmodconfig kernel, there are a lot of false-positives.
>>> With a message like this 'UBSAN: Undefined behaviour in...' with a call
>>> trace that follows.
>>>
>>> Reworked so that when building a allmodconfig kernel that turns
>>> everything into '=m' or '=y' will turn off UBSAN_ALIGNMENT.
>>>
>>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>> ---
>>
>> Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>>
> 
> Confused.  Why does allmodconfig result in UBSAN warnings?
>  

UBSAN warnings is a result of enabling noisy CONFIG_UBSAN_ALIGNMENT which is disabled
by default if HAVE_EFFICIENT_UNALIGNED_ACCESS=y.
It's noisy even if don't have efficient unaligned access, e.g. people often add  __cacheline_aligned_in_smp
in structs, but forget to align allocations of such struct (kmalloc() give 8-byte alignment in worst case).
