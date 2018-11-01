Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB53C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F2A2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F2A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeKAVmp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:42:45 -0400
Received: from smtp.h3c.com ([60.191.123.56]:22758 "EHLO h3cmg01-ex.h3c.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727644AbeKAVmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:42:45 -0400
Received: from BJHUB02-EX.srv.huawei-3com.com (unknown [10.63.20.170]) by h3cmg01-ex.h3c.com with smtp
         id 139e_1809_37f026bf_4291_463f_8239_b27a3481cab2;
        Thu, 01 Nov 2018 20:35:06 +0800
Received: from H3CMLB12-EX.srv.huawei-3com.com ([fe80::10fe:abde:731b:fdde])
 by BJHUB02-EX.srv.huawei-3com.com ([::1]) with mapi id 14.03.0415.000; Thu, 1
 Nov 2018 20:34:59 +0800
From:   Changwei Ge <ge.changwei@h3c.com>
To:     Joseph Qi <jiangqi903@gmail.com>, Larry Chen <lchen@suse.com>,
        "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Ocfs2-devel] [PATCH V3] ocfs2: fix dead lock caused by
 ocfs2_defrag_extent
Thread-Topic: [Ocfs2-devel] [PATCH V3] ocfs2: fix dead lock caused by
 ocfs2_defrag_extent
Thread-Index: AQHUcbKZagBejW0xd0Sk/bgqi0J6UA==
Date:   Thu, 1 Nov 2018 12:34:58 +0000
Message-ID: <63ADC13FD55D6546B7DECE290D39E37301277DE3FE@H3CMLB12-EX.srv.huawei-3com.com>
References: <20181101071422.14470-1-lchen@suse.com>
 <c07c65cb-8492-d866-6a1f-ffa64b293ea0@gmail.com>
 <63ADC13FD55D6546B7DECE290D39E37301277DE397@H3CMLB12-EX.srv.huawei-3com.com>
 <4f96339a-6209-eee1-3792-4720eca35688@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.125.20.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joseph,

On 2018/11/1 20:16, Joseph Qi wrote:
> 
> 
> On 18/11/1 19:52, Changwei Ge wrote:
>> Hello Joseph,
>>
>> On 2018/11/1 17:01, Joseph Qi wrote:
>>> Hi Larry,
>>>
>>> On 18/11/1 15:14, Larry Chen wrote:
>>>> ocfs2_defrag_extent may fall into deadlock.
>>>>
>>>> ocfs2_ioctl_move_extents
>>>>       ocfs2_ioctl_move_extents
>>>>         ocfs2_move_extents
>>>>           ocfs2_defrag_extent
>>>>             ocfs2_lock_allocators_move_extents
>>>>
>>>>               ocfs2_reserve_clusters
>>>>                 inode_lock GLOBAL_BITMAP_SYSTEM_INODE
>>>>
>>>> 	  __ocfs2_flush_truncate_log
>>>>                 inode_lock GLOBAL_BITMAP_SYSTEM_INODE
>>>>
>>>> As backtrace shows above, ocfs2_reserve_clusters() will call inode_lock
>>>> against the global bitmap if local allocator has not sufficient cluters.
>>>> Once global bitmap could meet the demand, ocfs2_reserve_cluster will
>>>> return success with global bitmap locked.
>>>>
>>>> After ocfs2_reserve_cluster(), if truncate log is full,
>>>> __ocfs2_flush_truncate_log() will definitely fall into deadlock because it
>>>> needs to inode_lock global bitmap, which has already been locked.
>>>>
>>>> To fix this bug, we could remove from ocfs2_lock_allocators_move_extents()
>>>> the code which intends to lock global allocator, and put the removed code
>>>> after __ocfs2_flush_truncate_log().
>>>>
>>>> ocfs2_lock_allocators_move_extents() is referred by 2 places, one is here,
>>>> the other does not need the data allocator context, which means this patch
>>>> does not affect the caller so far.
>>>>
>>>> Change log:
>>>> 1. Correct the function comment.
>>>> 2. Remove unused argument from ocfs2_lock_meta_allocator_move_extents.
>>>>
>>>> Signed-off-by: Larry Chen <lchen@suse.com>
>>>> ---
>>>>    fs/ocfs2/move_extents.c | 47 ++++++++++++++++++++++++++---------------------
>>>>    1 file changed, 26 insertions(+), 21 deletions(-)
>>>>
>>
>>> IMO, here clusters_to_move is only for data_ac, since we change this
>>> function to only handle meta_ac, I'm afraid clusters_to_move related
>>> logic has to been changed correspondingly.
>>
>> I think we can't remove *clusters_to_move* from here as clusters can be reserved latter outsides this function, but we
>> still have to reserve metadata(extents) in advance.
>> So we need that argument.
>>
> I was not saying just remove it.
> IIUC, clusters_to_move is for reserving data clusters (for meta_ac, we

Um...
*cluster_to_move* is not only used for reserving data clusters.
It is also an effecting input for calculating if existed extents still have enough free records for later
tree operation like attaching clusters to extents.

Please refer to below code:
  175         unsigned int max_recs_needed = 2 * extents_to_split + clusters_to_move;



> mostly talk about blocks). Since we have moved data cluster reserve
> logic out of ocfs2_lock_allocators_move_extents() now, then left
> clusters_to_move related logic here is odd.

Like my preceding elaboration, it is used for telling if we need more extents.
Anyway, I think we must keep *cluster_to_move* here as it used to. :-)

Thanks,
Changwei




> 
>>>>    					u32 extents_to_split,
>>>>    					struct ocfs2_alloc_context **meta_ac,
>>>> -					struct ocfs2_alloc_context **data_ac,
>>>>    					int extra_blocks,
>>>>    					int *credits)
>>>>    {
>>>> @@ -192,13 +188,6 @@ static int ocfs2_lock_allocators_move_extents(struct inode *inode,
>>>>    		goto out;
>>>>    	}
>>>>    
>>>> -	if (data_ac) {
>>>> -		ret = ocfs2_reserve_clusters(osb, clusters_to_move, data_ac);
>>>> -		if (ret) {
>>>> -			mlog_errno(ret);
>>>> -			goto out;
>>>> -		}
>>>> -	}
>>>>    
>>>>    	*credits += ocfs2_calc_extend_credits(osb->sb, et->et_root_el);
>>>>    
>>>> @@ -257,10 +246,10 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
>>>>    		}
>>>>    	}
>>>>    
>>>> -	ret = ocfs2_lock_allocators_move_extents(inode, &context->et, *len, 1,
>>>> -						 &context->meta_ac,
>>>> -						 &context->data_ac,
>>>> -						 extra_blocks, &credits);
>>>> +	ret = ocfs2_lock_meta_allocator_move_extents(inode, &context->et,
>>>> +						*len, 1,
>>>> +						&context->meta_ac,
>>>> +						extra_blocks, &credits);
>>>>    	if (ret) {
>>>>    		mlog_errno(ret);
>>>>    		goto out;
>>>> @@ -283,6 +272,21 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
>>>>    		}
>>>>    	}
>>>>    
>>>> +	/*
>>>> +	 * Make sure ocfs2_reserve_cluster is called after
>>>> +	 * __ocfs2_flush_truncate_log, otherwise, dead lock may happen.
>>>> +	 *
>>>> +	 * If ocfs2_reserve_cluster is called
>>>> +	 * before __ocfs2_flush_truncate_log, dead lock on global bitmap
>>>> +	 * may happen.
>>>> +	 *
>>>> +	 */
>>>> +	ret = ocfs2_reserve_clusters(osb, *len, &context->data_ac);
>>>> +	if (ret) {
>>>> +		mlog_errno(ret);
>>>> +		goto out_unlock_mutex;
>>>> +	}
>>>> +
>>>>    	handle = ocfs2_start_trans(osb, credits);
>>>>    	if (IS_ERR(handle)) {
>>>>    		ret = PTR_ERR(handle);
>>>> @@ -600,9 +604,10 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
>>>>    		}
>>>>    	}
>>>>    
>>>> -	ret = ocfs2_lock_allocators_move_extents(inode, &context->et, len, 1,
>>>> -						 &context->meta_ac,
>>>> -						 NULL, extra_blocks, &credits);
>>>> +	ret = ocfs2_lock_meta_allocator_move_extents(inode, &context->et,
>>>> +						len, 1,
>>>> +						&context->meta_ac,
>>>> +						extra_blocks, &credits);
>>>>    	if (ret) {
>>>>    		mlog_errno(ret);
>>>>    		goto out;
>>>>
>>>
>>> _______________________________________________
>>> Ocfs2-devel mailing list
>>> Ocfs2-devel@oss.oracle.com
>>> https://oss.oracle.com/mailman/listinfo/ocfs2-devel
>>>
> 
