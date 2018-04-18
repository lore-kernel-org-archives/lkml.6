Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeDRSSw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 14:18:52 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:46315 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752953AbeDRSSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 14:18:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0T.QgVzL_1524075510;
Subject: Re: [RFC PATCH] fs: introduce ST_HUGE flag and set it to tmpfs and
 hugetlbfs
To: Christoph Hellwig <hch@infradead.org>
Cc: viro@zeniv.linux.org.uk, nyc@holomorphy.com, mike.kravetz@oracle.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1523999293-94152-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180418102744.GA10397@infradead.org>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <73090d4b-6831-805b-8b9d-5dff267428d9@linux.alibaba.com>
Date: Wed, 18 Apr 2018 11:18:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418102744.GA10397@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/18 3:27 AM, Christoph Hellwig wrote:
> On Wed, Apr 18, 2018 at 05:08:13AM +0800, Yang Shi wrote:
>> Since tmpfs THP was supported in 4.8, hugetlbfs is not the only
>> filesystem with huge page support anymore. tmpfs can use huge page via
>> THP when mounting by "huge=" mount option.
>>
>> When applications use huge page on hugetlbfs, it just need check the
>> filesystem magic number, but it is not enough for tmpfs. So, introduce
>> ST_HUGE flag to statfs if super block has SB_HUGE set which indicates
>> huge page is supported on the specific filesystem.
>>
>> Some applications could benefit from this change, for example QEMU.
>> When use mmap file as guest VM backend memory, QEMU typically mmap the
>> file size plus one extra page. If the file is on hugetlbfs the extra
>> page is huge page size (i.e. 2MB), but it is still 4KB on tmpfs even
>> though THP is enabled. tmpfs THP requires VMA is huge page aligned, so
>> if 4KB page is used THP will not be used at all. The below /proc/meminfo
>> fragment shows the THP use of QEMU with 4K page:
>>
>> ShmemHugePages:   679936 kB
>> ShmemPmdMapped:        0 kB
>>
>> With ST_HUGE flag, QEMU can get huge page, then /proc/meminfo looks
>> like:
>>
>> ShmemHugePages:    77824 kB
>> ShmemPmdMapped:     6144 kB
>>
>> With this flag, the applications can know if huge page is supported on
>> the filesystem then optimize the behavior of the applications
>> accordingly. Although the similar function can be implemented in
>> applications by traversing the mount options, it looks more convenient
>> if kernel can provide such flag.
>>
>> Even though ST_HUGE is set, f_bsize still returns 4KB for tmpfs since
>> THP could be split, and it also my fallback to 4KB page silently if
>> there is not enough huge page.
> Seems like your should report it through the st_blksize field of struct
> stat then, instead of introducing a not very useful binary field then.

Yes, thanks for the suggestion. I did think about it before I went with 
the new flag. Not like hugetlb, THP will *not* guarantee huge page is 
used all the time, it may fallback to regular 4K page or may get split. 
I'm not sure how the applications use f_bsize field, it might break 
existing applications and the value might be abused by applications to 
have counter optimization. So, IMHO, a new flag may sound safer.

Yang
