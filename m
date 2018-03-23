Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeCWJTd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:19:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35359 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752284AbeCWJT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:19:27 -0400
X-Google-Smtp-Source: AG47ELvTjfyNh0239aUsrejs52ZkPwx3HbA7g7UPdSFUOm/pXZcV22hdDK/txnR9aSDMgZVdo67XFfw8Ud71BDwxBGg=
MIME-Version: 1.0
In-Reply-To: <20180323083847.GJ23100@dhcp22.suse.cz>
References: <1521791852-7048-1-git-send-email-zhaoyang.huang@spreadtrum.com> <20180323083847.GJ23100@dhcp22.suse.cz>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 23 Mar 2018 17:19:26 +0800
Message-ID: <CAGWkznHxTaymoEuFEQ+nN0ZvpPLhdE_fbwpT3pbDf+NQyHw-3g@mail.gmail.com>
Subject: Re: [PATCH v1] mm: help the ALLOC_HARDER allocation pass the
 watermarki when CMA on
To: Michal Hocko <mhocko@kernel.org>
Cc: zhaoyang.huang@spreadtrum.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        vel Tatashin <pasha.tatashin@oracle.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-patch-test@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 4:38 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Fri 23-03-18 15:57:32, Zhaoyang Huang wrote:
>> For the type of 'ALLOC_HARDER' page allocation, there is an express
>> highway for the whole process which lead the allocation reach __rmqueue_xxx
>> easier than other type.
>> However, when CMA is enabled, the free_page within zone_watermark_ok() will
>> be deducted for number the pages in CMA type, which may cause the watermark
>> check fail, but there are possible enough HighAtomic or Unmovable and
>> Reclaimable pages in the zone. So add 'alloc_harder' here to
>> count CMA pages in to clean the obstacles on the way to the final.
>
> This is no longer the case in the current mmotm tree. Have a look at
> Joonsoo's zone movable based CMA patchset http://lkml.kernel.org/r/1512114786-5085-1-git-send-email-iamjoonsoo.kim@lge.com
>
Thanks for the information. However, I can't find the commit in the
latest mainline, is it merged?
>> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
>> ---
>>  mm/page_alloc.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 635d7dd..cc18620 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -3045,8 +3045,11 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
>>
>>
>>  #ifdef CONFIG_CMA
>> -     /* If allocation can't use CMA areas don't use free CMA pages */
>> -     if (!(alloc_flags & ALLOC_CMA))
>> +     /*
>> +      * If allocation can't use CMA areas and no alloc_harder set for none
>> +      * order0 allocation, don't use free CMA pages.
>> +      */
>> +     if (!(alloc_flags & ALLOC_CMA) && (!alloc_harder || !order))
>>               free_pages -= zone_page_state(z, NR_FREE_CMA_PAGES);
>>  #endif
>>
>> --
>> 1.9.1
>>
>
> --
> Michal Hocko
> SUSE Labs
