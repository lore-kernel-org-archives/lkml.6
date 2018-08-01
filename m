Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED99C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880D8208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880D8208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389885AbeHARRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:17:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45323 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389437AbeHARRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:17:38 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AC4A2FC1CAB65;
        Wed,  1 Aug 2018 23:31:19 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 23:31:16 +0800
Message-ID: <5B61D243.9050608@huawei.com>
Date:   Wed, 1 Aug 2018 23:31:15 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Laura Abbott <labbott@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Oleg Nesterov <oleg@redhat.com>
CC:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [Question] A novel case happened when using mempool allocate memory.
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  Everyone

 I ran across the following novel case similar to memory leak in linux-4.1 stable when allocating
 memory object by kmem_cache_alloc.   it rarely can be reproduced.

I create a specific  mempool with 24k size based on the slab.  it can not be merged with
other kmem cache.  I  record the allocation and free usage by atomic_add/sub.    After a while,
I watch the specific slab consume most of total memory.   After halting the code execution.
The counter of allocation and free is equal.  Therefore,  I am sure that module have released
all meory resource.  but the statistic of specific slab is very high but stable by checking /proc/slabinfo.

but It is strange that the specific slab will free get back all memory when unregister the module.
I got the following information from specific slab data structure when halt the module execution.


kmem_cache_node                                                          kmem_cache

nr_partial = 1,                                                             min_partial = 7
partial = {                                                                    cpu_partial = 2
        next = 0xffff7c00085cae20                             object_size = 24576
        prev = 0xffff7c00085cae20
},

nr_slabs = {
    counter = 365610
 },

total_objects = {
 counter = 365610
},

full = {
      next =  0xffff8013e44f75f0,
     prev =  0xffff8013e44f75f0
},

From the above restricted information , we can know that the node full list is empty.  and partial list only
have a  slab.   A slab contain a object.  I think that most of slab stay in the cpu_partial
list even though it seems to be impossible theoretically.  because I come to the conclusion based on the case
that slab take up the memory will be release when unregister the moudle.

but I check the code(mm/slub.c) carefully . I can not find any clue to prove my assumption.
I will be appreciate if anyone have any idea about the case. 


Thanks
zhong jiang

