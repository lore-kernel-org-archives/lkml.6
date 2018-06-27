Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BC1C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A31D261C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A31D261C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934558AbeF0BDz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:03:55 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:50968 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932649AbeF0BDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:03:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0T3PEXoX_1530061415;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T3PEXoX_1530061415)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Jun 2018 09:03:41 +0800
Subject: Re: [RFC v2 PATCH 2/2] mm: mmap: zap pages with read mmap_sem for
 large mapping
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        ldufour@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
References: <1529364856-49589-1-git-send-email-yang.shi@linux.alibaba.com>
 <1529364856-49589-3-git-send-email-yang.shi@linux.alibaba.com>
 <3DDF2672-FCC4-4387-9624-92F33C309CAE@gmail.com>
 <158a4e4c-d290-77c4-a595-71332ede392b@linux.alibaba.com>
 <BFD6A249-B1D7-43D5-8D7C-9FAED4A168A1@gmail.com>
 <20180620071817.GJ13685@dhcp22.suse.cz>
 <263935d9-d07c-ab3e-9e42-89f73f57be1e@linux.alibaba.com>
 <20180626074344.GZ2458@hirez.programming.kicks-ass.net>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <e54e298d-ef86-19a7-6f6b-07776f9a43e2@linux.alibaba.com>
Date:   Tue, 26 Jun 2018 18:03:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180626074344.GZ2458@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/26/18 12:43 AM, Peter Zijlstra wrote:
> On Mon, Jun 25, 2018 at 05:06:23PM -0700, Yang Shi wrote:
>> By looking this deeper, we may not be able to cover all the unmapping range
>> for VM_DEAD, for example, if the start addr is in the middle of a vma. We
>> can't set VM_DEAD to that vma since that would trigger SIGSEGV for still
>> mapped area.
>>
>> splitting can't be done with read mmap_sem held, so maybe just set VM_DEAD
>> to non-overlapped vmas. Access to overlapped vmas (first and last) will
>> still have undefined behavior.
> Acquire mmap_sem for writing, split, mark VM_DEAD, drop mmap_sem. Acquire
> mmap_sem for reading, madv_free drop mmap_sem. Acquire mmap_sem for
> writing, free everything left, drop mmap_sem.
>
> ?
>
> Sure, you acquire the lock 3 times, but both write instances should be
> 'short', and I suppose you can do a demote between 1 and 2 if you care.

Thanks, Peter. Yes, by looking the code and trying two different 
approaches, it looks this approach is the most straight-forward one.

Splitting vma up-front can save a lot pain later. Holding write mmap_sem 
for this job before zapping mappings sounds worth the cost (very short 
write critical section).

And, VM_DEAD can be set exclusively with write mmap_sem without racing 
with page faults, this will give us consistent behavior for the race 
between PF and munmap. And, we don't need care about overlapped vma 
since it has been split before.

Yang


