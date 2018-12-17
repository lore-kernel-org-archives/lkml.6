Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D61C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5371220874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p7n4cSGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbeLQSmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:42:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42068 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbeLQSmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:42:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBHIcoEs075359;
        Mon, 17 Dec 2018 18:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=5NQAwKI6BPkMli61v3/BbXZPUF3F0B7MFFmBnQFNKgk=;
 b=p7n4cSGvtMxSsCu0np6uk2cEH/1hNoZqvzlZyW/kxapIA5jSmEYNcsxrfbYjm+P7urFx
 N6YJjNSezMu7OPBdvgWZ4lF4b3Z6UHwnzu55UUK2WehLPEEtI4bJV7bVmbMm4fRivz85
 OdV3Zsnk0b6WxVvBvbJkwOw+Ur5ybJq3RX+lV/ZNmqeEHIpHna/PbmHI6robD5neWMLS
 zRmJJfckiWNUBUJeI1oBBEqQNla/4jUE1Gnf5RtjVdRvby6n7tpvDXcCg3UKBjMq043A
 6ANYmBND/7zgaJJWxsj7pIeUtc4KYX9TnxafZPG9+kjbGIH2IalKMG7Gyi3kt24K8tlu AQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2pct8qq5jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Dec 2018 18:42:24 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBHIgM0o005317
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Dec 2018 18:42:22 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBHIgJug003501;
        Mon, 17 Dec 2018 18:42:19 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Dec 2018 10:42:19 -0800
Subject: Re: [PATCH 2/3] hugetlbfs: Use i_mmap_rwsem to fix page
 fault/truncate race
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>, Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
References: <20181203200850.6460-1-mike.kravetz@oracle.com>
 <20181203200850.6460-3-mike.kravetz@oracle.com>
 <27f8893b-57b3-088d-2d48-9e8acc5987bd@linux.ibm.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f6fd9491-4b3d-16ca-f606-025c78756936@oracle.com>
Date:   Mon, 17 Dec 2018 10:42:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <27f8893b-57b3-088d-2d48-9e8acc5987bd@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9110 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812170163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/18 2:25 AM, Aneesh Kumar K.V wrote:
> On 12/4/18 1:38 AM, Mike Kravetz wrote:
>> hugetlbfs page faults can race with truncate and hole punch operations.
>> Current code in the page fault path attempts to handle this by 'backing
>> out' operations if we encounter the race.  One obvious omission in the
>> current code is removing a page newly added to the page cache.  This is
>> pretty straight forward to address, but there is a more subtle and
>> difficult issue of backing out hugetlb reservations.  To handle this
>> correctly, the 'reservation state' before page allocation needs to be
>> noted so that it can be properly backed out.  There are four distinct
>> possibilities for reservation state: shared/reserved, shared/no-resv,
>> private/reserved and private/no-resv.  Backing out a reservation may
>> require memory allocation which could fail so that needs to be taken
>> into account as well.
>>
>> Instead of writing the required complicated code for this rare
>> occurrence, just eliminate the race.  i_mmap_rwsem is now held in read
>> mode for the duration of page fault processing.  Hold i_mmap_rwsem
>> longer in truncation and hold punch code to cover the call to
>> remove_inode_hugepages.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: ebed4bfc8da8 ("hugetlb: fix absurd HugePages_Rsvd")
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>   fs/hugetlbfs/inode.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index 32920a10100e..3244147fc42b 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -505,8 +505,8 @@ static int hugetlb_vmtruncate(struct inode *inode, loff_t
>> offset)
>>       i_mmap_lock_write(mapping);
>>       if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
>>           hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
>> -    i_mmap_unlock_write(mapping);
>>       remove_inode_hugepages(inode, offset, LLONG_MAX);
>> +    i_mmap_unlock_write(mapping);
>>       return 0;
>>   }
> 
> 
> We used to do remove_inode_hugepages()
> 
>     mutex_lock(&hugetlb_fault_mutex_table[hash]);
>     i_mmap_lock_write(mapping);
>     hugetlb_vmdelete_list(&mapping->i_mmap,
>     i_mmap_unlock_write(mapping);
> 
> did we change the lock ordering with this patch?

Thanks for taking a look.

Yes, we did take locks in that order in the 'if (unlikely(page_mapped(page)))'
case within remove_inode_hugepages.  That ordering was important as the
fault_mutex prevented faults while unmapping the page in all potential
mappings.

With the change above, we will be holding i_mmap_rwsem in write mode while
calling remove_inode_hugepages.  The page fault code (modified in previous
patch) acquires i_mmap_rwsem in read mode.  Therefore, no page faults can
occur and, that 'if (unlikely(page_mapped(page)))' case within
remove_inode_hugepages will never happen.  The now dead code is removed in
the subsequent patch.

As you suggested in a comment to the subsequent patch, it would be better to
combine the patches and remove the dead code when it becomes dead.  I will
work on that.  Actually some of the code in patch 3 applies to patch 1 and
some applies to patch 2.  So, it will not be simply combining patch 2 and 3.

-- 
Mike Kravetz
