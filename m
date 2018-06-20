Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E55FC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F882083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F882083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754378AbeFTQXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:23:36 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:48500 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754065AbeFTQXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:23:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0T33Bl7A_1529511799;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T33Bl7A_1529511799)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Jun 2018 00:23:26 +0800
Subject: Re: [RFC v2 PATCH 2/2] mm: mmap: zap pages with read mmap_sem for
 large mapping
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, akpm@linux-foundation.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1529364856-49589-1-git-send-email-yang.shi@linux.alibaba.com>
 <1529364856-49589-3-git-send-email-yang.shi@linux.alibaba.com>
 <20180619100218.GN2458@hirez.programming.kicks-ass.net>
 <f78924fc-ea81-9ddd-ebb2-28241d5721c8@linux.alibaba.com>
 <20180620071708.GI13685@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <41456a0f-0091-dfdb-952b-9bf08b323ba6@linux.alibaba.com>
Date:   Wed, 20 Jun 2018 09:23:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180620071708.GI13685@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/18 12:17 AM, Michal Hocko wrote:
> On Tue 19-06-18 14:13:05, Yang Shi wrote:
>>
>> On 6/19/18 3:02 AM, Peter Zijlstra wrote:
> [...]
>>> Hold up, two things: you having to copy most of do_munmap() didn't seem
>>> to suggest a helper function? And second, since when are we allowed to
>> Yes, they will be extracted into a helper function in the next version.
>>
>> May bad, I don't think it is allowed. We could reform this to:
>>
>> acquire write mmap_sem
>> vma lookup (split vmas)
>> release write mmap_sem
>>
>> acquire read mmap_sem
>> zap pages
>> release read mmap_sem
>>
>> I'm supposed this is safe as what Michal said before.
> I didn't get to read your patches carefully yet but I am wondering why
> do you need to split in the first place. Why cannot you simply unmap the
> range (madvise(DONTNEED)) under the read lock and then take the lock for
> write to finish the rest?

Yes, we can. I just thought splitting vma up-front sounds more straight 
forward. But, I neglected the write mmap_sem issue. Will move the vma 
split into later write mmap_sem in the next version.

Thanks,
Yang


