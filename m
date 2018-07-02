Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70B7C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C8224F91
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C8224F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeGBRIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:08:15 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:42967 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752184AbeGBRIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:08:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0T3r6H7X_1530551267;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T3r6H7X_1530551267)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Jul 2018 01:07:54 +0800
Subject: Re: [RFC v3 PATCH 4/5] mm: mmap: zap pages with read mmap_sem for
 large mapping
To:     Michal Hocko <mhocko@kernel.org>
Cc:     willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
 <1530311985-31251-5-git-send-email-yang.shi@linux.alibaba.com>
 <20180702135311.GY19043@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <ad7e1251-58f7-0903-18d0-646744c0665a@linux.alibaba.com>
Date:   Mon, 2 Jul 2018 10:07:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180702135311.GY19043@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/18 6:53 AM, Michal Hocko wrote:
> On Sat 30-06-18 06:39:44, Yang Shi wrote:
>> When running some mmap/munmap scalability tests with large memory (i.e.
>>> 300GB), the below hung task issue may happen occasionally.
>> INFO: task ps:14018 blocked for more than 120 seconds.
>>         Tainted: G            E 4.9.79-009.ali3000.alios7.x86_64 #1
>>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
>> message.
>>   ps              D    0 14018      1 0x00000004
>>    ffff885582f84000 ffff885e8682f000 ffff880972943000 ffff885ebf499bc0
>>    ffff8828ee120000 ffffc900349bfca8 ffffffff817154d0 0000000000000040
>>    00ffffff812f872a ffff885ebf499bc0 024000d000948300 ffff880972943000
>>   Call Trace:
>>    [<ffffffff817154d0>] ? __schedule+0x250/0x730
>>    [<ffffffff817159e6>] schedule+0x36/0x80
>>    [<ffffffff81718560>] rwsem_down_read_failed+0xf0/0x150
>>    [<ffffffff81390a28>] call_rwsem_down_read_failed+0x18/0x30
>>    [<ffffffff81717db0>] down_read+0x20/0x40
>>    [<ffffffff812b9439>] proc_pid_cmdline_read+0xd9/0x4e0
>>    [<ffffffff81253c95>] ? do_filp_open+0xa5/0x100
>>    [<ffffffff81241d87>] __vfs_read+0x37/0x150
>>    [<ffffffff812f824b>] ? security_file_permission+0x9b/0xc0
>>    [<ffffffff81242266>] vfs_read+0x96/0x130
>>    [<ffffffff812437b5>] SyS_read+0x55/0xc0
>>    [<ffffffff8171a6da>] entry_SYSCALL_64_fastpath+0x1a/0xc5
>>
>> It is because munmap holds mmap_sem from very beginning to all the way
>> down to the end, and doesn't release it in the middle. When unmapping
>> large mapping, it may take long time (take ~18 seconds to unmap 320GB
>> mapping with every single page mapped on an idle machine).
>>
>> It is because munmap holds mmap_sem from very beginning to all the way
>> down to the end, and doesn't release it in the middle. When unmapping
>> large mapping, it may take long time (take ~18 seconds to unmap 320GB
>> mapping with every single page mapped on an idle machine).
>>
>> Zapping pages is the most time consuming part, according to the
>> suggestion from Michal Hock [1], zapping pages can be done with holding
> s@Hock@Hocko@

Sorry for the wrong spelling.

>
>> read mmap_sem, like what MADV_DONTNEED does. Then re-acquire write
>> mmap_sem to cleanup vmas. All zapped vmas will have VM_DEAD flag set,
>> the page fault to VM_DEAD vma will trigger SIGSEGV.
> This really deserves an explanation why the all dance is really needed.
>
> It would be also good to mention how do you achieve the overal
> consistency. E.g. you are dropping mmap_sem and then re-taking it for
> write. What if any pending write lock succeeds and modify the address
> space? Does it matter, why if not?

Sure.

>
>> Define large mapping size thresh as PUD size or 1GB, just zap pages with
>> read mmap_sem for mappings which are >= thresh value.
>>
>> If the vma has VM_LOCKED | VM_HUGETLB | VM_PFNMAP or uprobe, then just
>> fallback to regular path since unmapping those mappings need acquire
>> write mmap_sem.
>>
>> For the time being, just do this in munmap syscall path. Other
>> vm_munmap() or do_munmap() call sites remain intact for stability
>> reason.
> What are those stability reasons?

mmap() and mremap() may call do_munmap() as well, so it may introduce 
more race condition if they use the zap early version of do_munmap too. 
They would have much more chances to take mmap_sem to change address 
space and cause conflict.

And, it looks they are not the vital source of long period of write 
mmap_sem hold. So, it sounds not worth making things more complicated 
for the time being.

>
>> The below is some regression and performance data collected on a machine
>> with 32 cores of E5-2680 @ 2.70GHz and 384GB memory.
>>
>> With the patched kernel, write mmap_sem hold time is dropped to us level
>> from second.
> I haven't read through the implemenation carefuly TBH but the changelog
> needs quite some work to explain the solution and resulting semantic of
> munmap after the change.

Thanks for the suggestion. Will polish the changelog.

Yang


