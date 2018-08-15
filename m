Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2699BC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9874215B2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 11:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9874215B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbeHOOt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 10:49:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727141AbeHOOt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 10:49:28 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 507D7C0758F93;
        Wed, 15 Aug 2018 19:57:32 +0800 (CST)
Received: from [127.0.0.1] (10.119.159.246) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Wed, 15 Aug 2018
 19:57:23 +0800
Subject: Re: [PATCH RFC] usercopy: optimize stack check flow when the
 page-spanning test is disabled
To:     Kees Cook <keescook@chromium.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <yinyouzhan@huawei.com>
References: <1534249051-56879-1-git-send-email-yuanxiaofeng1@huawei.com>
 <20180814123454.GA25328@bombadil.infradead.org>
 <494CFD22286B8448AF161132C5FE9A985B624E05@dggema521-mbx.china.huawei.com>
 <CAGXu5jLw1=KB1J3gQRyg66MxfgOoRmZDfeM5KO57djKU_as+Xw@mail.gmail.com>
From:   "Yuanxiaofeng (XiAn)" <yuanxiaofeng1@huawei.com>
Message-ID: <2da82b8e-0e44-75e8-33d4-676fbd7ee98b@huawei.com>
Date:   Wed, 15 Aug 2018 19:59:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLw1=KB1J3gQRyg66MxfgOoRmZDfeM5KO57djKU_as+Xw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.119.159.246]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/2018 2:54 AM, Kees Cook wrote:
> (Please use contextual quoting in replies... mixing contextual with
> top-posting becomes very hard to read...)
> 
> On Tue, Aug 14, 2018 at 6:02 AM, Yuanxiaofeng (XiAn)
> <yuanxiaofeng1@huawei.com> wrote:
>> On Tue, Aug 14, 2018 at 8:35PM Matthew Wilcox wrote:
>>> On Tue, Aug 14, 2018 at 08:17:31PM +0800, Xiaofeng Yuan wrote:
>>>> The check_heap_object() checks the spanning multiple pages and slab.
>>>> When the page-spanning test is disabled, the check_heap_object() is
>>>> redundant for spanning multiple pages. However, the kernel stacks are
>>>> multiple pages under certain conditions: CONFIG_ARCH_THREAD_STACK_ALLOCATOR
>>>> is not defined and (THREAD_SIZE >= PAGE_SIZE). At this point, We can skip
>>>> the check_heap_object() for kernel stacks to improve performance.
>>>> Similarly, the virtually-mapped stack can skip check_heap_object() also,
>>>> beacause virt_addr_valid() will return.
>>>
>>> Why not just check_stack_object() first, then check_heap_object() second?
> 
> Most of the dynamically-sized copies (i.e. those that will trigger
> __check_object_size being used at all) come out of heap. Stack copies
> tend to be a fixed size. That said, the stack check is pretty cheap:
> if it's not bounded by task_stack_page(current) ... +THREAD_SIZE, it
> kicks out immediately. The frame-walking will only happen if it IS
> actually stack (and once finished will short-circuit all remaining
> tests).
>
>> 1, When the THREAD_SIZE is less than PAGE_SIZE, the stack will allocate memory by kmem_cache_alloc_node(), it's slab memory and will execute __check_heap_object().
> 
> Correct, though if an architecture supports stack frame analysis, this
> is a more narrow check than the bulk heap object check. (i.e. it may
> have sub-object granularity to determine if a copy spans a stack
> frame.) This supports the idea of just doing the stack check first,
> though.
> 

>> 2, When CONFIG_HARDENED_USERCOPY_PAGESPAN is enabled, the multiple-pages stacks will do some check in check_page_span().
> 
> PAGESPAN checking is buggy for a lot of reasons, unfortunately. It
> should generally stay disabled unless someone is working on getting
> rid of allocations that _should_ have marked themselves as spanning
> pages. It's unclear if this is even a solvable problem in the kernel
> right now due to how networking code manages skbs.
> 
I also found the PAGESPAN is disabled by default, it's a reason why I
change the heap/stack order. If PAGESPAN is enabled in the future,
this patch will restore the original check flow.

>> So, I set some restrictions to make sure the useful check will not be skipped.
> 
> It'd be nice to find some workloads that visibly change by making the
> heap/stack order change. I think the known worst-case (small-packet
> UDP flooding) wouldn't get worse since both checks will be performed
> in either case.
> 
Only the stack will skip the heap check. Other scenarios will return
NOT_STACK in check_stack_object(), and will not skip any checks.
This change just influences and benefits to the kernel stack check.

> (Maybe we should also short-circuit early in heap checks if it IS a
> valid heap object: no reason to go do the kernel text check after
> that...)
> 
I tested the average time of each check (there may be some bias on different
devices), the check_heap_object() spend most time.  And the kernel stack spend
many time in heap check. It's another reason why I want change the order.
If we can skip the valid heap's text check, we need do some validation.
However, it will be beneficial to performance as the usercopy check is executed
frequently.

> -Kees
> 
-Xiaofeng

