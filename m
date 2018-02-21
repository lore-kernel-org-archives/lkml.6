Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbeBUHXP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 02:23:15 -0500
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:39443 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751350AbeBUHXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 02:23:14 -0500
Authentication-Results: smtpcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [PATCH 3/4] kernel/fork: switch vmapped stack callation to
 __vmalloc_area()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>
References: <151670492223.658225.4605377710524021456.stgit@buzz>
 <151670492913.658225.2758351129158778856.stgit@buzz>
 <5c19630f-7466-676d-dbbc-a5668c91cbcd@yandex-team.ru>
 <20180220161634.517598ec63ec4a785c4c81cc@linux-foundation.org>
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <d636d1cb-88d9-8474-d5bc-fb2994108919@yandex-team.ru>
Date: Wed, 21 Feb 2018 10:23:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220161634.517598ec63ec4a785c4c81cc@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.02.2018 03:16, Andrew Morton wrote:
> On Tue, 23 Jan 2018 16:57:21 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:
> 
>> # stress-ng --clone 100 -t 10s --metrics-brief
>> at 32-core machine shows boost 35000 -> 36000 bogo ops
>>
>> Patch 4/4 is a kind of RFC.
>> Actually per-cpu cache of preallocated stacks works faster than buddy allocator thus
>> performance boots for it happens only at completely insane rate of clones.
>>
> 
> I'm not really sure what to make of this patchset.  Is it useful in any
> known real-world use cases?

Not yet. Feel free to ignore last patch.

> 
>> +	  This option neutralize stack overflow protection but allows to
>> +	  achieve best performance for syscalls fork() and clone().
> 
> That sounds problematic, but perhaps acceptable if the fallback only
> happens rarely.
> 
> Can this code be folded into CONFIG_VMAP_STACk in some cleaner fashion?
> We now have options for non-vmapped stacks, vmapped stacks and a mix
> of both.
> 
> And what about this comment in arch/Kconfig:VMAP_STACK:
> 
>            This is presently incompatible with KASAN because KASAN expects
>            the stack to map directly to the KASAN shadow map using a formula
>            that is incorrect if the stack is in vmalloc space.
> 
> 
> So VMAP_STACK_AS_FALLBACK will intermittently break KASAN?
> 

All of this (including CONFIG_VMAP_STACK) could be turned into boot option.
I think this would be a best solution.
