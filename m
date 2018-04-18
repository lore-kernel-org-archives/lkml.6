Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeDRUxk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 16:53:40 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:50427 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752391AbeDRUxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 16:53:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07402;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0T.QnsIg_1524084808;
Subject: Re: [RFC PATCH] fs: introduce ST_HUGE flag and set it to tmpfs and
 hugetlbfs
To: Mike Kravetz <mike.kravetz@oracle.com>, viro@zeniv.linux.org.uk,
        nyc@holomorphy.com, kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1523999293-94152-1-git-send-email-yang.shi@linux.alibaba.com>
 <2804a1d0-9d68-ac43-3041-9490147b52b5@oracle.com>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <293caaaf-39c0-7634-fbd2-70a540ea58db@linux.alibaba.com>
Date: Wed, 18 Apr 2018 13:53:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2804a1d0-9d68-ac43-3041-9490147b52b5@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/18 1:26 PM, Mike Kravetz wrote:
> On 04/17/2018 02:08 PM, Yang Shi wrote:
>> And, set the flag for hugetlbfs as well to keep the consistency, and the
>> applications don't have to know what filesystem is used to use huge
>> page, just need to check ST_HUGE flag.
> For hugetlbfs, setting such a flag would be for consistency only.  mapping
> hugetlbfs files REQUIRES huge page alignment and size.

Yes, applications don't have to read this flag if the underlying 
filesystem is hugetlbfs. The fs magic number is good enough.

>
> If an application would want to take advantage of this flag for tmpfs, it
> needs to map at a fixed address (MAP_FIXED) for huge page alignment.  So,
> it will need to do one of the 'mmap tricks' to get a mapping at a suitably
> aligned address.

It doesn't have to be MAP_FIXED, but definitely has to be huge page 
aligned. This flag is aimed for this case. With this flag, the 
applications can know the underlying tmpfs with huge page supported, 
then the applications can mmap memory with huge page alignment 
intentionally.

>
> IIRC, there is code to 'suitably align' DAX mappings to appropriate huge page
> boundaries.  Perhaps, something like this could be added for tmpfs mounted
> with huge=?  Of course, this would not take into account 'length' but may
> help some.

Might be. However THP already exported huge page size to sysfs, the 
applications can read it to get the alignment.

Thanks,
Yang

>
