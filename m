Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbeCILK6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 06:10:58 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:49854 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751001AbeCILK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 06:10:57 -0500
Subject: Re: [PATCH] mm/mempolicy: Avoid use uninitialized preferred_node
To: Alexander Potapenko <glider@google.com>
References: <CAG_fn=VW5tfzT6cHJd+jF=t3WO6XS3HqSF_TYnKdycX_M_48vw@mail.gmail.com>
 <4ebee1c2-57f6-bcb8-0e2d-1833d1ee0bb7@huawei.com>
 <CAG_fn=XP6X5rqRVBameyU-F2UOc4hpbowUBNxZENf2ZHpMSmfQ@mail.gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dmitriy Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <a4efd431-39c3-8ede-9fa1-e69924263ce0@huawei.com>
Date: Fri, 9 Mar 2018 19:10:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAG_fn=XP6X5rqRVBameyU-F2UOc4hpbowUBNxZENf2ZHpMSmfQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander ,

On 2018/3/9 18:49, Alexander Potapenko wrote:
> On Fri, Mar 9, 2018 at 6:21 AM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>> Alexander reported an use of uninitialized memory in __mpol_equal(),
>> which is caused by incorrect use of preferred_node.
>>
>> When mempolicy in mode MPOL_PREFERRED with flags MPOL_F_LOCAL, it use
>> numa_node_id() instead of preferred_node, however, __mpol_equeue() use
>> preferred_node without check whether it is MPOL_F_LOCAL or not.
>>
>> Reported-by: Alexander Potapenko <glider@google.com>
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> Tested-by: Alexander Potapenko <glider@google.com>

Thanks,
> 
> I confirm that the patch fixes the problem. Thanks for the quick turnaround!
> Any idea which commit had introduced the bug in the first place?

IIUC, It is introduce by:
Fixes: fc36b8d3d819 (mempolicy: use MPOL_F_LOCAL to Indicate Preferred Local Policy)

Thanks
Yisheng
>> ---
>>  mm/mempolicy.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index d879f1d..641545e 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -2124,6 +2124,9 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
>>         case MPOL_INTERLEAVE:
>>                 return !!nodes_equal(a->v.nodes, b->v.nodes);
>>         case MPOL_PREFERRED:
>> +               /* a's flags is the same as b's */
>> +               if (a->flags & MPOL_F_LOCAL)
>> +                       return true;
>>                 return a->v.preferred_node == b->v.preferred_node;
>>         default:
>>                 BUG();
>> --
>> 1.8.3.1
>>
> 
> 
> 
