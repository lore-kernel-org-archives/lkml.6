Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEC7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A331B208CC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A331B208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeHWAMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:12:24 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:56378 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbeHWAMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:12:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0T72p0Py_1534970745;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T72p0Py_1534970745)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Aug 2018 04:45:49 +0800
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
 <e691d054-f807-80ad-9934-a1917d8e2e77@suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <3c62f605-2244-6a05-2dc4-34a3f1c56300@linux.alibaba.com>
Date:   Wed, 22 Aug 2018 13:45:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e691d054-f807-80ad-9934-a1917d8e2e77@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/18 4:19 AM, Vlastimil Babka wrote:
> On 08/15/2018 08:49 PM, Yang Shi wrote:
>> +	downgrade_write(&mm->mmap_sem);
>> +
>> +	/* Zap mappings with read mmap_sem */
>> +	unmap_region(mm, start_vma, prev, start, end);
>> +
>> +	arch_unmap(mm, start_vma, start, end);
> Hmm, did you check that all architectures' arch_unmap() is safe with
> read mmap_sem instead of write mmap_sem? E.g. x86 does
> mpx_notify_unmap() there where I would be far from sure at first glance...

Yes, I'm also not quite sure if it is 100% safe or not. I was trying to 
move this before downgrade_write, however, I'm not sure if it is ok or 
not too, so I keep the calling sequence.

For architectures, just x86 and ppc really do something. PPC just uses 
it for vdso unmap which should just happen during process exit, so it 
sounds safe.

For x86, mpx_notify_unmap() looks finally zap the VM_MPX vmas in bound 
table range with zap_page_range() and doesn't update vm flags, so it 
sounds ok to me since vmas have been detached, nobody can find those 
vmas. But, I'm not familiar with the details of mpx, maybe Kirill could 
help to confirm this?

Thanks,
Yang

>
>> +	remove_vma_list(mm, start_vma);
>> +	up_read(&mm->mmap_sem);

