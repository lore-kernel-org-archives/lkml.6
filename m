Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeBTPFy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:05:54 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:44389 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbeBTPFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:05:52 -0500
X-Google-Smtp-Source: AH8x224eoLXlvjLu1C1V1Cb0ZhTe79cEubqExkZsDhhmhhBJvFF/AjcODtL/OoQ45TZlvLgFwmslIw==
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 1/4] locking/ww_mutex: add ww_mutex_is_owned_by function
 v3
To: Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: dev@mblankhorst.nl, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180220125829.27060-1-christian.koenig@amd.com>
 <20180220131253.GF25314@hirez.programming.kicks-ass.net>
 <8fd80334-4d0e-8ed0-8a09-02a7e36a0eae@gmail.com>
 <20180220135709.GD25201@hirez.programming.kicks-ass.net>
 <b625cbca-c05a-afd1-fe97-a7a0760383c1@amd.com>
 <20180220145413.GF25201@hirez.programming.kicks-ass.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2dac8ec9-c54a-7dd1-af4e-62f2bc1a959c@gmail.com>
Date: Tue, 20 Feb 2018 16:05:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220145413.GF25201@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.02.2018 um 15:54 schrieb Peter Zijlstra:
> On Tue, Feb 20, 2018 at 03:34:07PM +0100, Christian König wrote:
>>> OK, but neither case would in fact need the !ctx case right? That's just
>>> there for completeness sake?
>> Unfortunately not. TTM uses trylock to lock BOs which are about to be
>> evicted to make room for all the BOs locked with a ctx.
>>
>> I need to be able to distinct between the BOs which are trylocked and those
>> which are locked with a ctx.
>>
>> Writing this I actually noticed the current version is buggy, cause even
>> when we check the mutex owner we still need to make sure that the ctx in the
>> lock is NULL.
> Hurm... I can't remember why trylocks behave like that, and it seems
> rather unfortunate / inconsistent.

Actually for me that is rather fortunate, cause I need to distinct 
between the locks acquired through trylock and lock.

In other words when the amdgpu does it's checking if userspace sends 
nonsense to the kernel it should only get a green signal when the lock 
was intentionally locked using the context.

If the lock was just taken because TTM trylocked it because TTM had to 
evict the BO to make room then the check should fail and we need to tell 
userspace that it did something wrong.

Regards,
Christian.

> Chris, Maarten, do either one of you remember?
>
> I'm thinking that if we do acquire the trylock, the thing should join
> the ctx such that a subsequent contending mutex_lock() can ww right.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
