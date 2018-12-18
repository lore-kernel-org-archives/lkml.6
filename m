Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA221C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748BC214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbeLRGGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 01:06:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16585 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbeLRGGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 01:06:17 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5874A2568CDAC;
        Tue, 18 Dec 2018 14:06:12 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Tue, 18 Dec 2018
 14:06:12 +0800
Subject: Re: [PATCH] squashfs: enable __GFP_FS in ->readpage to prevent hang
 in mem alloc
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     <phillip@squashfs.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20181204020840.49576-1-houtao1@huawei.com>
 <20181215143824.GJ10600@bombadil.infradead.org>
 <69457a5a-79c9-4950-37ae-eff7fa4f949a@huawei.com>
 <20181217035157.GK10600@bombadil.infradead.org>
 <20181217093337.GC30879@dhcp22.suse.cz>
 <00ff5d2d-a50f-4730-db8a-cea3d7a3eef7@I-love.SAKURA.ne.jp>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <5ba9aba1-e00d-ae07-caf0-3e7eca7de4b6@huawei.com>
Date:   Tue, 18 Dec 2018 14:06:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <00ff5d2d-a50f-4730-db8a-cea3d7a3eef7@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.14]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018/12/17 18:51, Tetsuo Handa wrote:
> On 2018/12/17 18:33, Michal Hocko wrote:
>> On Sun 16-12-18 19:51:57, Matthew Wilcox wrote:
>> [...]
>>> Ah, yes, that makes perfect sense.  Thank you for the explanation.
>>>
>>> I wonder if the correct fix, however, is not to move the check for
>>> GFP_NOFS in out_of_memory() down to below the check whether to kill
>>> the current task.  That would solve your problem, and I don't _think_
>>> it would cause any new ones.  Michal, you touched this code last, what
>>> do you think?
>>
>> What do you mean exactly? Whether we kill a current task or something
>> else doesn't change much on the fact that NOFS is a reclaim restricted
>> context and we might kill too early. If the fs can do GFP_FS then it is
>> obviously a better thing to do because FS metadata can be reclaimed as
>> well and therefore there is potentially less memory pressure on
>> application data.
>>
> 
> I interpreted "to move the check for GFP_NOFS in out_of_memory() down to
> below the check whether to kill the current task" as
> 
> @@ -1077,15 +1077,6 @@ bool out_of_memory(struct oom_control *oc)
>  	}
>  
>  	/*
> -	 * The OOM killer does not compensate for IO-less reclaim.
> -	 * pagefault_out_of_memory lost its gfp context so we have to
> -	 * make sure exclude 0 mask - all other users should have at least
> -	 * ___GFP_DIRECT_RECLAIM to get here.
> -	 */
> -	if (oc->gfp_mask && !(oc->gfp_mask & __GFP_FS))
> -		return true;
> -
> -	/*
>  	 * Check if there were limitations on the allocation (only relevant for
>  	 * NUMA and memcg) that may require different handling.
>  	 */
> @@ -1104,6 +1095,19 @@ bool out_of_memory(struct oom_control *oc)
>  	}
>  
>  	select_bad_process(oc);
> +
> +	/*
> +	 * The OOM killer does not compensate for IO-less reclaim.
> +	 * pagefault_out_of_memory lost its gfp context so we have to
> +	 * make sure exclude 0 mask - all other users should have at least
> +	 * ___GFP_DIRECT_RECLAIM to get here.
> +	 */
> +	if ((oc->gfp_mask && !(oc->gfp_mask & __GFP_FS)) && oc->chosen &&
> +	    oc->chosen != (void *)-1UL && oc->chosen != current) {
> +		put_task_struct(oc->chosen);
> +		return true;
> +	}
> +
>  	/* Found nothing?!?! */
>  	if (!oc->chosen) {
>  		dump_header(oc, NULL);
> 
> which is prefixed by "the correct fix is not".
> 
> Behaving like sysctl_oom_kill_allocating_task == 1 if __GFP_FS is not used
> will not be the correct fix. But ...
> 
> Hou Tao wrote:
>> There is no need to disable __GFP_FS in ->readpage:
>> * It's a read-only fs, so there will be no dirty/writeback page and
>>   there will be no deadlock against the caller's locked page
> 
> is read-only filesystem sufficient for safe to use __GFP_FS?
> 
> Isn't "whether it is safe to use __GFP_FS" depends on "whether fs locks
> are held or not" rather than "whether fs has dirty/writeback page or not" ?
> 
In my understanding (correct me if I am wrong), there are three ways through which
reclamation will invoked fs related code and may cause dead-lock:

(1) write-back dirty pages. Not possible for squashfs.
(2) the reclamation of inodes & dentries. The current file is in-use, so it will be not
    reclaimed, and for other reclaimable inodes, squashfs_destroy_inode() will
    be invoked and it doesn't take any locks.
(3) customized shrinker defined by fs. No customized shrinker in squashfs.

So my point is that even a page lock is already held by squashfs_readpage() and
reclamation invokes back to squashfs code, there will be no dead-lock, so it's
safe to use __GFP_FS.

Regards,
Tao

> .
> 

