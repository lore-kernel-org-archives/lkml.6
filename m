Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F7EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50962098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50962098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeHVWrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:47:00 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:38584 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728051AbeHVWrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:47:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0T734itb_1534965638;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T734itb_1534965638)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Aug 2018 03:20:43 +0800
Subject: Re: [RFC v8 PATCH 3/5] mm: mmap: zap pages with read mmap_sem in
 munmap
To:     Vlastimil Babka <vbabka@suse.cz>, mhocko@kernel.org,
        willy@infradead.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1534358990-85530-1-git-send-email-yang.shi@linux.alibaba.com>
 <1534358990-85530-4-git-send-email-yang.shi@linux.alibaba.com>
 <7145895b-ef56-f5ee-d139-609819d9a107@suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <2f447d4e-9e16-8030-85f0-4e258a7eafa3@linux.alibaba.com>
Date:   Wed, 22 Aug 2018 12:20:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7145895b-ef56-f5ee-d139-609819d9a107@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/18 4:11 AM, Vlastimil Babka wrote:
> On 08/15/2018 08:49 PM, Yang Shi wrote:
>
>> +	start_vma = munmap_lookup_vma(mm, start, end);
>> +	if (!start_vma)
>> +		goto out;
>> +	if (IS_ERR(start_vma)) {
>> +		ret = PTR_ERR(start_vma);
>> +		goto out;
>> +	}
>> +
>> +	prev = start_vma->vm_prev;
>> +
>> +	if (unlikely(uf)) {
>> +		ret = userfaultfd_unmap_prep(start_vma, start, end, uf);
>> +		if (ret)
>> +			goto out;
>> +	}
>> +
> You sure it's ok to redo this in case of goto regular path? The
> preparations have some side-effects... I would rather move this after
> the regular path check?

This preparation sets vma->vm_userfaultfd_ctx.ctx for each vmas. But, 
before doing this, it calls has_unmap_ctx() to check if the ctx has been 
set or not. If it has been set, it just skip the vma. It sounds ok, right?


