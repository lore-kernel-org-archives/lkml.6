Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbeFAAsj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 20:48:39 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34383 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeFAAsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 20:48:33 -0400
X-Google-Smtp-Source: ADUXVKLxXydCGXlZ0jeHSf4oOy3mKF6NIQr28zEcpcLqTucKlqRApvLQ8LFcAUyi0/NZ/ITev7BGpplRxXRqUKx96U8=
MIME-Version: 1.0
In-Reply-To: <20180531171834.e16fc59550d24437a12c612b@linux-foundation.org>
References: <20180530001204.183758-1-shakeelb@google.com> <20180531171834.e16fc59550d24437a12c612b@linux-foundation.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 31 May 2018 17:48:31 -0700
Message-ID: <CALvZod69UOuEzsDZ1V-f5Nc5Ou=7qSvmxsyucBioZc1MunRHUw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: fix race between kmem_cache destroy, create and deactivate
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>,
        Linux MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 5:18 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 29 May 2018 17:12:04 -0700 Shakeel Butt <shakeelb@google.com> wrote:
>
>> The memcg kmem cache creation and deactivation (SLUB only) is
>> asynchronous. If a root kmem cache is destroyed whose memcg cache is in
>> the process of creation or deactivation, the kernel may crash.
>>
>> Example of one such crash:
>>       general protection fault: 0000 [#1] SMP PTI
>>       CPU: 1 PID: 1721 Comm: kworker/14:1 Not tainted 4.17.0-smp
>>       ...
>>       Workqueue: memcg_kmem_cache kmemcg_deactivate_workfn
>>       RIP: 0010:has_cpu_slab
>>       ...
>>       Call Trace:
>>       ? on_each_cpu_cond
>>       __kmem_cache_shrink
>>       kmemcg_cache_deact_after_rcu
>>       kmemcg_deactivate_workfn
>>       process_one_work
>>       worker_thread
>>       kthread
>>       ret_from_fork+0x35/0x40
>>
>> To fix this race, on root kmem cache destruction, mark the cache as
>> dying and flush the workqueue used for memcg kmem cache creation and
>> deactivation.
>>
>> Signed-off-by: Shakeel Butt <shakeelb@google.com>
>> ---
>> Changelog since v2:
>> - Instead of refcount, flush the workqueue
>
> This one-liner doesn't appear to fully describe the difference between
> v2 and v3, which is rather large:
>

Sorry about that, I should have explained more. The reason the diff
between v2 and v3 is large is because v3 is the complete rewrite. So,
the diff is the revert of v2 and then v3 patch. If you drop all the
previous versions and just keep v3, it will be smaller.

thanks,
Shakeel
