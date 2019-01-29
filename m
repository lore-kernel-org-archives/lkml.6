Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8268EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEB5214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfA2PwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:52:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:57152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725795AbfA2PwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:52:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D88CDB11F;
        Tue, 29 Jan 2019 15:52:22 +0000 (UTC)
Subject: Re: [PATCH] mm: proc: smaps_rollup: Fix pss_locked calculation
To:     Andrew Morton <akpm@linux-foundation.org>,
        Sandeep Patil <sspatil@android.com>
Cc:     adobriyan@gmail.com, avagin@openvz.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@android.com, dancol@google.com
References: <20190121011049.160505-1-sspatil@android.com>
 <20190128161509.5085cacf939463f1c22e0550@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b15205cd-33e3-6cac-b6a4-65266be7a9c8@suse.cz>
Date:   Tue, 29 Jan 2019 16:52:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128161509.5085cacf939463f1c22e0550@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/19 1:15 AM, Andrew Morton wrote:
> On Sun, 20 Jan 2019 17:10:49 -0800 Sandeep Patil <sspatil@android.com> wrote:
> 
>> The 'pss_locked' field of smaps_rollup was being calculated incorrectly
>> as it accumulated the current pss everytime a locked VMA was found.
>> 
>> Fix that by making sure we record the current pss value before each VMA
>> is walked. So, we can only add the delta if the VMA was found to be
>> VM_LOCKED.
>> 
>> ...
>>
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -709,6 +709,7 @@ static void smap_gather_stats(struct vm_area_struct *vma,
>>  #endif
>>  		.mm = vma->vm_mm,
>>  	};
>> +	unsigned long pss;
>>  
>>  	smaps_walk.private = mss;
>>  
>> @@ -737,11 +738,12 @@ static void smap_gather_stats(struct vm_area_struct *vma,
>>  		}
>>  	}
>>  #endif
>> -
>> +	/* record current pss so we can calculate the delta after page walk */
>> +	pss = mss->pss;
>>  	/* mmap_sem is held in m_start */
>>  	walk_page_vma(vma, &smaps_walk);
>>  	if (vma->vm_flags & VM_LOCKED)
>> -		mss->pss_locked += mss->pss;
>> +		mss->pss_locked += mss->pss - pss;
>>  }
> 
> This seems to be a rather obscure way of accumulating
> mem_size_stats.pss_locked.  Wouldn't it make more sense to do this in
> smaps_account(), wherever we increment mem_size_stats.pss?
> 
> It would be a tiny bit less efficient but I think that the code cleanup
> justifies such a cost?

Yeah, Sandeep could you add 'bool locked' param to smaps_account() and check it
there? We probably don't need the whole vma param yet.

Thanks.
