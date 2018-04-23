Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755706AbeDWQTw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:19:52 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:53384 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755423AbeDWQTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:19:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0T.kE6bO_1524500369;
Subject: Re: [RFC v2 PATCH] mm: shmem: make stat.st_blksize return huge page
 size if THP is on
To: Michal Hocko <mhocko@kernel.org>, kirill.shutemov@linux.intel.com
Cc: hughd@google.com, hch@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1524242039-64997-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180423004748.GP17484@dhcp22.suse.cz>
 <3c59a1d1-dc66-ae5f-452c-dd0adb047433@linux.alibaba.com>
 <20180423150435.GS17484@dhcp22.suse.cz>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <4d2693a6-e2eb-5108-d423-765de2bf7a19@linux.alibaba.com>
Date: Mon, 23 Apr 2018 10:19:27 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423150435.GS17484@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/23/18 9:04 AM, Michal Hocko wrote:
> On Sun 22-04-18 21:28:59, Yang Shi wrote:
>>
>> On 4/22/18 6:47 PM, Michal Hocko wrote:
> [...]
>>> will be used on the first aligned address even when the initial/last
>>> portion of the mapping is not THP aligned.
>> No, my test shows it is not. And, transhuge_vma_suitable() does check the
>> virtual address alignment. If it is not huge page size aligned, it will not
>> set PMD for huge page.
> It's been quite some time since I've looked at that code but I think you
> are wrong. It just doesn't make sense to make the THP decision on the
> VMA alignment much. Kirill, can you clarify please?

In the test, QEMU is trying to mmap a file (16GB in my configuration) + 
a guard page. If the page size is 4KB, there not any pages are mapped by 
PMD, but if the page size is 2MB (huge page aligned) we can see a lot 
pages are mapped by PMD. The test result is showed in the commit log.

So, if your assumption is right, there must be something wrong in THP code.

>
> Please note that I have no objections to actually export the huge page
> size as the max block size but your changelog just doesn't make any
> sense to me.

Thanks,
Yang
