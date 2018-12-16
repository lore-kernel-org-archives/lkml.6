Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE75C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D873A217FB
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbeLPJiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 04:38:16 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45484 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729354AbeLPJiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 04:38:16 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 553B28BBB0216;
        Sun, 16 Dec 2018 17:38:13 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Sun, 16 Dec 2018
 17:38:13 +0800
Subject: Re: [PATCH] squashfs: enable __GFP_FS in ->readpage to prevent hang
 in mem alloc
To:     Matthew Wilcox <willy@infradead.org>
CC:     <phillip@squashfs.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20181204020840.49576-1-houtao1@huawei.com>
 <20181215143824.GJ10600@bombadil.infradead.org>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <69457a5a-79c9-4950-37ae-eff7fa4f949a@huawei.com>
Date:   Sun, 16 Dec 2018 17:38:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181215143824.GJ10600@bombadil.infradead.org>
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

On 2018/12/15 22:38, Matthew Wilcox wrote:
> On Tue, Dec 04, 2018 at 10:08:40AM +0800, Hou Tao wrote:
>> There is no need to disable __GFP_FS in ->readpage:
>> * It's a read-only fs, so there will be no dirty/writeback page and
>>   there will be no deadlock against the caller's locked page
>> * It just allocates one page, so compaction will not be invoked
>> * It doesn't take any inode lock, so the reclamation of inode will be fine
>>
>> And no __GFP_FS may lead to hang in __alloc_pages_slowpath() if a
>> squashfs page fault occurs in the context of a memory hogger, because
>> the hogger will not be killed due to the logic in __alloc_pages_may_oom().
> 
> I don't understand your argument here.  There's a comment in
> __alloc_pages_may_oom() saying that we _should_ treat GFP_NOFS
> specially, but we currently don't.
I am trying to say that if __GFP_FS is used in pagecache_get_page() when it tries
to allocate a new page for squashfs, that will be no possibility of dead-lock for
squashfs.

We do treat GFP_NOFS specially in out_of_memory():

    /*
     * The OOM killer does not compensate for IO-less reclaim.
     * pagefault_out_of_memory lost its gfp context so we have to
     * make sure exclude 0 mask - all other users should have at least
     * ___GFP_DIRECT_RECLAIM to get here.
     */
    if (oc->gfp_mask && !(oc->gfp_mask & __GFP_FS))
        return true;

So if GFP_FS is used, no task will be killed because we will return from
out_of_memory() prematurely. And that will lead to an infinite loop in
__alloc_pages_slowpath() as we have observed:

* a squashfs page fault occurred in the context of a memory hogger
* the page used for page fault allocated successfully
* in squashfs_readpage() squashfs will try to allocate other pages
  in the same 128KB block, and __GFP_NOFS is used (actually GFP_HIGHUSER_MOVABLE & ~__GFP_FS)
* in __alloc_pages_slowpath() we can not get any pages through reclamation
  (because most of memory is used by the current task) and we also can not kill
  the current task (due to __GFP_NOFS), and it will loop forever until it's killed.

> 
>         /*
>          * XXX: GFP_NOFS allocations should rather fail than rely on
>          * other request to make a forward progress.
>          * We are in an unfortunate situation where out_of_memory cannot
>          * do much for this context but let's try it to at least get
>          * access to memory reserved if the current task is killed (see
>          * out_of_memory). Once filesystems are ready to handle allocation
>          * failures more gracefully we should just bail out here.
>          */
> 
> What problem are you actually seeing?
> 
> .
> 

