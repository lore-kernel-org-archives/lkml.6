Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DB5C67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2032089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nn2ymjia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2032089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeJIHex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:34:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51378 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIHex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:34:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w990JQs7019578;
        Tue, 9 Oct 2018 00:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=96drUcax064lAd77K+cdaagA445NdnAl8n+l0A3qXuU=;
 b=Nn2ymjia+0X6//mz61HwRQfXVsnOHmK2sblCJJ3DqWdzoTjlCHFUmQFiUvJ2Blylzw1k
 JTMGpoPaCcMvKG7Aiudt3unJQNIjhhC/Sqg1F1PCpN4faGImaKu441JURqlgzuxqOcol
 i/LWbicpLMN+G5EKfDCvFMG0PD49g78EvU7wXA+ZRPuxuSC52vMFOuTDyARQnd50mGcA
 uyJPwkyAE+0HAVLV0IlDGsohs3mDBYotDA8PZkc5YYZpbhsdbbFrhQ10CPrWuZq/Fjms
 a3+94ETAUpM453n6hM+aly/uDMCa9718VX7Y3pUGKTgShkyWUqVXJxU3N10zF54f5/Lg lg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2mxnpqsrh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Oct 2018 00:20:23 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w990KMMW031782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Oct 2018 00:20:22 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w990KK25023146;
        Tue, 9 Oct 2018 00:20:20 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Oct 2018 00:20:19 +0000
Subject: Re: [PATCH RFC 1/1] hugetlbfs: introduce truncation/fault mutex to
 avoid races
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20181007233848.13397-1-mike.kravetz@oracle.com>
 <20181007233848.13397-2-mike.kravetz@oracle.com>
 <20181008080323.xg3v35uxgmakf6wy@kshutemo-mobl1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7b35a36e-62a0-ca84-00cf-a12a3233cb07@oracle.com>
Date:   Mon, 8 Oct 2018 17:20:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181008080323.xg3v35uxgmakf6wy@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9040 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=995
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810090002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/18 1:03 AM, Kirill A. Shutemov wrote:
> On Sun, Oct 07, 2018 at 04:38:48PM -0700, Mike Kravetz wrote:
>> The following hugetlbfs truncate/page fault race can be recreated
>> with programs doing something like the following.
>>
>> A huegtlbfs file is mmap(MAP_SHARED) with a size of 4 pages.  At
>> mmap time, 4 huge pages are reserved for the file/mapping.  So,
>> the global reserve count is 4.  In addition, since this is a shared
>> mapping an entry for 4 pages is added to the file's reserve map.
>> The first 3 of the 4 pages are faulted into the file.  As a result,
>> the global reserve count is now 1.
>>
>> Task A starts to fault in the last page (routines hugetlb_fault,
>> hugetlb_no_page).  It allocates a huge page (alloc_huge_page).
>> The reserve map indicates there is a reserved page, so this is
>> used and the global reserve count goes to 0.
>>
>> Now, task B truncates the file to size 0.  It starts by setting
>> inode size to 0(hugetlb_vmtruncate).  It then unmaps all mapping
>> of the file (hugetlb_vmdelete_list).  Since task A's page table
>> lock is not held at the time, truncation is not blocked.  Truncation
>> removes the 3 pages from the file (remove_inode_hugepages).  When
>> cleaning up the reserved pages (hugetlb_unreserve_pages), it notices
>> the reserve map was for 4 pages.  However, it has only freed 3 pages.
>> So it assumes there is still (4 - 3) 1 reserved pages.  It then
>> decrements the global reserve count by 1 and it goes negative.
>>
>> Task A then continues the page fault process and adds it's newly
>> acquired page to the page cache.  Note that the index of this page
>> is beyond the size of the truncated file (0).  The page fault process
>> then notices the file has been truncated and exits.  However, the
>> page is left in the cache associated with the file.
>>
>> Now, if the file is immediately deleted the truncate code runs again.
>> It will find and free the one page associated with the file.  When
>> cleaning up reserves, it notices the reserve map is empty.  Yet, one
>> page freed.  So, the global reserve count is decremented by (0 - 1) -1.
>> This returns the global count to 0 as it should be.  But, it is
>> possible for someone else to mmap this file/range before it is deleted.
>> If this happens, a reserve map entry for the allocated page is created
>> and the reserved page is forever leaked.
>>
>> To avoid all these conditions, let's simply prevent faults to a file
>> while it is being truncated.  Add a new truncation specific rw mutex
>> to hugetlbfs inode extensions.  faults take the mutex in read mode,
>> truncation takes in write mode.
> 
> Hm. Don't we have already a lock for this? I mean i_mmap_lock.
> 

Thanks Kirill,

Yes, we could use use i_mmap_rwsem for this synchronization.  I don't
see anyone else using the mutex in this manner.  hugetlb code only
explicitly takes this mutex in write mode today.  I suspect that is not
optimal and could be improved.  Certainly, the use within
hugetlb_fault->huge_pte_alloc->huge_pmd_share would need to be changed
if we always wanted to take the mutex in read mode during faults.

I'll work on the changes to use i_mmap_rwsem.

However, right now our DB team informs me that the truncate/fault race
is not the cause of their huge page reserve count going negative issue.
So, I am searching for more bugs in this area.  Found another where an
allocation for migration could race with a fault in a VM_NORESERVE vma.
But, there were no migrations noted on the system, so there must be another
bug.  Sigh!
-- 
Mike Kravetz
