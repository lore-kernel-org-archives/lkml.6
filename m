Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAE6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2172086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfANQII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:08:08 -0500
Received: from relay.sw.ru ([185.231.240.75]:57070 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfANQII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:08:08 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gj4mK-0004Ut-5L; Mon, 14 Jan 2019 19:07:56 +0300
Subject: Re: [PATCH] kasan: Remove use after scope bugs detection.
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Qian Cai <cai@lca.pw>, Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <20190111185842.13978-1-aryabinin@virtuozzo.com>
 <CACT4Y+YV+jjcXE1oa=Gf031KAgEy40Nq83x3_nj3TwQpw3b+Ug@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <296f2311-0a11-f4bd-b665-70c3ffad2124@virtuozzo.com>
Date:   Mon, 14 Jan 2019 19:08:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YV+jjcXE1oa=Gf031KAgEy40Nq83x3_nj3TwQpw3b+Ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/19 4:24 PM, Dmitry Vyukov wrote:
> On Fri, Jan 11, 2019 at 7:58 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>
>> Use after scope bugs detector seems to be almost entirely useless
>> for the linux kernel. It exists over two years, but I've seen only
>> one valid bug so far [1]. And the bug was fixed before it has been
>> reported. There were some other use-after-scope reports, but they
>> were false-positives due to different reasons like incompatibility
>> with structleak plugin.
>>
>> This feature significantly increases stack usage, especially with
>> GCC < 9 version, and causes a 32K stack overflow. It probably
>> adds performance penalty too.
>>
>> Given all that, let's remove use-after-scope detector entirely.
>>
>> While preparing this patch I've noticed that we mistakenly enable
>> use-after-scope detection for clang compiler regardless of
>> CONFIG_KASAN_EXTRA setting. This is also fixed now.
> 
> Hi Andrey,
> 
> I am on a fence. On one hand removing bug detection sucks and each
> case of a missed memory corruption leads to a splash of assorted bug
> reports by syzbot. On the other hand everything you said is true.
> Maybe support for CONFIG_VMAP_STACK will enable stacks larger then
> PAGE_ALLOC_COSTLY_ORDER?
> 

Yes, with vmap stacks higher order won't be a problem, since vmalloc() does only 0-order 
allocations. But even with vmap stacks use-after-scope won't become useful,
thus I don't see the point of re-enabling it with vmap stacks.
If feature doesn't detect bugs, but waste resources, than it's bad for detecting bugs.
We wasting our limited resources for useless checks, instead of using these resources
for doing more useful checks, running tests faster hence detecting more bugs per-time. 




