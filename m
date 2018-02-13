Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965582AbeBMSk7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:40:59 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42292 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965530AbeBMSkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:40:55 -0500
X-Google-Smtp-Source: AH8x227FFQWsSKtBtEjen/HkNDF4sut8giaZKKekG7Oii5A8xbgrfJcEh1p9DoCmSkiMW71wjI1IPg==
Subject: Re: [PATCH 00/11] KASan for arm
To: Abbott Liu <liuwenliang@huawei.com>, linux@armlinux.org.uk,
        aryabinin@virtuozzo.com, afzal.mohd.ma@gmail.com, labbott@redhat.com,
        kirill.shutemov@linux.intel.com, mhocko@suse.com, cdall@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, mawilcox@microsoft.com, tglx@linutronix.de,
        thgarnie@google.com, keescook@chromium.org, arnd@arndb.de,
        vladimir.murzin@arm.com, tixy@linaro.org, ard.biesheuvel@linaro.org,
        robin.murphy@arm.com, mingo@kernel.org, grygorii.strashko@linaro.org
Cc: glider@google.com, dvyukov@google.com, opendmb@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org, jiazhenghua@huawei.com,
        dylix.dailei@huawei.com, zengweilin@huawei.com, heshaoliang@huawei.com
References: <20171011082227.20546-1-liuwenliang@huawei.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <09f86876-2247-1d2c-b195-76d8b34d0aff@gmail.com>
Date: Tue, 13 Feb 2018 10:40:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20171011082227.20546-1-liuwenliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abbott,

On 10/11/2017 01:22 AM, Abbott Liu wrote:
> Hi,all:
>    These patches add arch specific code for kernel address sanitizer 
> (see Documentation/kasan.txt). 
> 
>    1/8 of kernel addresses reserved for shadow memory. There was no 
> big enough hole for this, so virtual addresses for shadow were 
> stolen from user space.
>    
>    At early boot stage the whole shadow region populated with just 
> one physical page (kasan_zero_page). Later, this page reused 
> as readonly zero shadow for some memory that KASan currently 
> don't track (vmalloc). 
> 
>   After mapping the physical memory, pages for shadow memory are 
> allocated and mapped. 
> 
>   KASan's stack instrumentation significantly increases stack's 
> consumption, so CONFIG_KASAN doubles THREAD_SIZE.
>   
>   Functions like memset/memmove/memcpy do a lot of memory accesses. 
> If bad pointer passed to one of these function it is important 
> to catch this. Compiler's instrumentation cannot do this since 
> these functions are written in assembly. 
> 
>   KASan replaces memory functions with manually instrumented variants. 
> Original functions declared as weak symbols so strong definitions 
> in mm/kasan/kasan.c could replace them. Original functions have aliases 
> with '__' prefix in name, so we could call non-instrumented variant 
> if needed. 
> 
>   Some files built without kasan instrumentation (e.g. mm/slub.c). 
> Original mem* function replaced (via #define) with prefixed variants 
> to disable memory access checks for such files. 
> 
>   On arm LPAE architecture,  the mapping table of KASan shadow memory(if 
> PAGE_OFFSET is 0xc0000000, the KASan shadow memory's virtual space is 
> 0xb6e000000~0xbf000000) can't be filled in do_translation_fault function, 
> because kasan instrumentation maybe cause do_translation_fault function 
> accessing KASan shadow memory. The accessing of KASan shadow memory in 
> do_translation_fault function maybe cause dead circle. So the mapping table 
> of KASan shadow memory need be copyed in pgd_alloc function.
> 
> 
> Most of the code comes from:
> https://github.com/aryabinin/linux/commit/0b54f17e70ff50a902c4af05bb92716eb95acefe.

Are you planning on picking up these patches and sending a second
version? I would be more than happy to provide test results once you
have something, this is very useful, thank you!
-- 
Florian
