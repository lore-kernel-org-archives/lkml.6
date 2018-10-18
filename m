Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0186DC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DE4208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n7X5bIB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DE4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeJSHUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:20:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36666 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeJSHUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:20:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9IN9nkK099712;
        Thu, 18 Oct 2018 23:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=nPVFryI0pCs/xJbexKiYz8erMunSxOIVHjBA0pKw0mo=;
 b=n7X5bIB6H+MZJ4P2LK6fovILbd5J4zwwzrSYU2OR0b2u87WH3EQU5GxMXUFb6vi4fzRv
 ARuVY2Kl0KQJnNDJkexlN0xPjVcaOG5wRHdVAGnjocrR/b6tE/ywEjQjnAzRplLVJeDX
 D516JKOycOOPe+sMHqdVeSAaWaFeLMeuDXBXJbGyqfmImV5TrmjKrvkS924iYimYQtjp
 9j6Oi5t4q3Fo2c5/pTlGCoeqssIdY4Mh0c8N84kww5RNBTu83wK2LXood0WaEDMLUqYU
 GZgGjg0bDAxhXVYpMle8qkxMT2KCCCa8k+7l/dhtFz/moarYQQ/DEAhryUBPNLoG+QYN lw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2n39brs7fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 23:16:45 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9INGha5014170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 23:16:44 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9INGgUx019962;
        Thu, 18 Oct 2018 23:16:42 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 16:16:42 -0700
Subject: Re: [PATCH] hugetlbfs: dirty pages as they are added to pagecache
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
References: <20181018041022.4529-1-mike.kravetz@oracle.com>
 <20181018160827.0cb656d594ffb2f0f069326c@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6d6e4733-39aa-a958-c0a2-c5a47cdcc7d0@oracle.com>
Date:   Thu, 18 Oct 2018 16:16:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181018160827.0cb656d594ffb2f0f069326c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810180195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 4:08 PM, Andrew Morton wrote:
> On Wed, 17 Oct 2018 21:10:22 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>> Some test systems were experiencing negative huge page reserve
>> counts and incorrect file block counts.  This was traced to
>> /proc/sys/vm/drop_caches removing clean pages from hugetlbfs
>> file pagecaches.  When non-hugetlbfs explicit code removes the
>> pages, the appropriate accounting is not performed.
>>
>> This can be recreated as follows:
>>  fallocate -l 2M /dev/hugepages/foo
>>  echo 1 > /proc/sys/vm/drop_caches
>>  fallocate -l 2M /dev/hugepages/foo
>>  grep -i huge /proc/meminfo
>>    AnonHugePages:         0 kB
>>    ShmemHugePages:        0 kB
>>    HugePages_Total:    2048
>>    HugePages_Free:     2047
>>    HugePages_Rsvd:    18446744073709551615
>>    HugePages_Surp:        0
>>    Hugepagesize:       2048 kB
>>    Hugetlb:         4194304 kB
>>  ls -lsh /dev/hugepages/foo
>>    4.0M -rw-r--r--. 1 root root 2.0M Oct 17 20:05 /dev/hugepages/foo
>>
>> To address this issue, dirty pages as they are added to pagecache.
>> This can easily be reproduced with fallocate as shown above. Read
>> faulted pages will eventually end up being marked dirty.  But there
>> is a window where they are clean and could be impacted by code such
>> as drop_caches.  So, just dirty them all as they are added to the
>> pagecache.
>>
>> In addition, it makes little sense to even try to drop hugetlbfs
>> pagecache pages, so disable calls to these filesystems in drop_caches
>> code.
>>
>> ...
>>
>> --- a/fs/drop_caches.c
>> +++ b/fs/drop_caches.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/writeback.h>
>>  #include <linux/sysctl.h>
>>  #include <linux/gfp.h>
>> +#include <linux/magic.h>
>>  #include "internal.h"
>>  
>>  /* A global variable is a bit ugly, but it keeps the code simple */
>> @@ -18,6 +19,12 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
>>  {
>>  	struct inode *inode, *toput_inode = NULL;
>>  
>> +	/*
>> +	 * It makes no sense to try and drop hugetlbfs page cache pages.
>> +	 */
>> +	if (sb->s_magic == HUGETLBFS_MAGIC)
>> +		return;
> 
> Hardcoding hugetlbfs seems wrong here.  There are other filesystems
> where it makes no sense to try to drop pagecache.  ramfs and, errrr...
> 
> I'm struggling to remember which is the correct thing to test here. 
> BDI_CAP_NO_WRITEBACK should get us there, but doesn't seem quite
> appropriate.

I was not sure about this, and expected someone could come up with
something better.  It just seems there are filesystems like huegtlbfs,
where it makes no sense wasting cycles traversing the filesystem.  So,
let's not even try.

Hoping someone can come up with a better method than hard coding as
I have done above.
-- 
Mike Kravetz
