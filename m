Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933265AbeDXNI4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:08:56 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:50784 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932864AbeDXNIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:08:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0T.nSCVH_1524575317;
Subject: Re: [RFC v2 PATCH] mm: shmem: make stat.st_blksize return huge page
 size if THP is on
To: Michal Hocko <mhocko@kernel.org>
Cc: kirill.shutemov@linux.intel.com, hughd@google.com, hch@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1524242039-64997-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180423004748.GP17484@dhcp22.suse.cz>
 <3c59a1d1-dc66-ae5f-452c-dd0adb047433@linux.alibaba.com>
 <20180423150435.GS17484@dhcp22.suse.cz>
 <aa4b8c48-781a-204c-246a-afa5a54dba99@linux.alibaba.com>
 <20180424124312.GZ17484@dhcp22.suse.cz>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <eefa688b-3d0f-6c9b-628e-8b81394deca6@linux.alibaba.com>
Date: Tue, 24 Apr 2018 07:08:36 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424124312.GZ17484@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/18 6:43 AM, Michal Hocko wrote:
> On Mon 23-04-18 21:41:50, Yang Shi wrote:
>>
>> On 4/23/18 9:04 AM, Michal Hocko wrote:
>>> On Sun 22-04-18 21:28:59, Yang Shi wrote:
>>>> On 4/22/18 6:47 PM, Michal Hocko wrote:
>>> [...]
>>>>> will be used on the first aligned address even when the initial/last
>>>>> portion of the mapping is not THP aligned.
>>>> No, my test shows it is not. And, transhuge_vma_suitable() does check the
>>>> virtual address alignment. If it is not huge page size aligned, it will not
>>>> set PMD for huge page.
>>> It's been quite some time since I've looked at that code but I think you
>>> are wrong. It just doesn't make sense to make the THP decision on the
>>> VMA alignment much. Kirill, can you clarify please?
>> Thanks a lot Michal and Kirill to elaborate how tmpfs THP make pmd map.
>>
>> I did a quick test, THP will be PMD mapped as long as :
>> * hint address is huge page aligned if MAP_FIXED
>> Or
>> * offset is huge page aligned
>> And
>> * The size is big enough (>= huge page size)
>>
>> This test does verify what Kirill said. And, I dig into a little further
>> qemu code and did strace, qemu does try to mmap the file to non huge page
>> aligned address with MAP_FIXED.
> Does it make sense to contact Qemu developers and probably fix this?

Yes, I think so. We can submit a bug report to QEMU.

>
