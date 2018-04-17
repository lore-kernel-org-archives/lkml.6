Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbeDQXh0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 19:37:26 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:41092 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752728AbeDQXhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 19:37:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0T.N9QRM_1524008232;
Subject: Re: [RFC PATCH] fs: introduce ST_HUGE flag and set it to tmpfs and
 hugetlbfs
To: Matthew Wilcox <willy@infradead.org>
Cc: viro@zeniv.linux.org.uk, nyc@holomorphy.com, mike.kravetz@oracle.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1523999293-94152-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180417232248.GA27631@bombadil.infradead.org>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <6782cd11-48e5-6c12-db1c-9478ab37f77e@linux.alibaba.com>
Date: Tue, 17 Apr 2018 16:37:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417232248.GA27631@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/18 4:22 PM, Matthew Wilcox wrote:
> On Wed, Apr 18, 2018 at 05:08:13AM +0800, Yang Shi wrote:
>> When applications use huge page on hugetlbfs, it just need check the
>> filesystem magic number, but it is not enough for tmpfs. So, introduce
>> ST_HUGE flag to statfs if super block has SB_HUGE set which indicates
>> huge page is supported on the specific filesystem.
> Hm.  What's the plan for communicating support for page sizes other
> than PMD page sizes?  I know ARM has several different page sizes,
> as do PA-RISC and ia64.  Even x86 might support 1G page sizes through
> tmpfs one day.

For THP page size, we already have 
/sys/kernel/mm/transparent_hugepage/hpage_pmd_size exported. The 
applications could read this to get the THP size. If PUD size THP 
supported is added later, we can export hpage_pud_size.

Please see the below commit log for more details:

commit 49920d28781dcced10cd30cb9a938e7d045a1c94
Author: Hugh Dickins <hughd@google.com>
Date:   Mon Dec 12 16:44:50 2016 -0800

     mm: make transparent hugepage size public

     Test programs want to know the size of a transparent hugepage. While it
     is commonly the same as the size of a hugetlbfs page (shown as
     Hugepagesize in /proc/meminfo), that is not always so: powerpc
     implements transparent hugepages in a different way from hugetlbfs
     pages, so it's coincidence when their sizes are the same; and x86 and
     others can support more than one hugetlbfs page size.

     Add /sys/kernel/mm/transparent_hugepage/hpage_pmd_size to show the THP
     size in bytes - it's the same for Anonymous and Shmem hugepages.  Call
     it hpage_pmd_size (after HPAGE_PMD_SIZE) rather than hpage_size, in 
case
     some transparent support for pud and pgd pages is added later.


Thanks,
Yang
