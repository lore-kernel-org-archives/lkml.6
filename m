Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BF8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E119D21920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G3tzAFjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404556AbeLUWS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:18:59 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41596 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbeLUWS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:18:58 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBLMA4OE018100;
        Fri, 21 Dec 2018 22:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=rYHhqlvWqgfVB9AvJZYBgzLS5RearaYuw3NK4hzWEHQ=;
 b=G3tzAFjDT7ItkmcAS/5j5IrA4EM6BMW/dUR5MT5uOaaztfDXtD+AiNJhyA0/jJKtaTvG
 SySM5zJ6ZW9Ut+FFBpmMoXLDg+N8wHa1MNYsV7Vvu7WF7SdmgIFdJBq5/EiGFZIk3iMG
 vl+ZexL9V/MSEJkglEwiizjry9G9YketYSeIWri8DvQbrBLZhVR33Ud/J1MqnMOfYLt/
 EbdeZttrQsBmcfsVFI7bDf0fgulS7S9R8JMlVhn6NKsOB7DWtWECv061IptYOO1TndPn
 9mwqEBFBoqxdZbE6YbdHu2GdtRrylgPup8NsH093heQyxjjaXcYO/BP8yFz7+C1p6NNm tw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2pf8gfr6yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Dec 2018 22:17:42 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBLMHZFI020850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Dec 2018 22:17:35 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBLMHXmL018931;
        Fri, 21 Dec 2018 22:17:34 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Dec 2018 14:17:33 -0800
Subject: Re: [PATCH v2 2/2] hugetlbfs: Use i_mmap_rwsem to fix page
 fault/truncate race
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
References: <20181218223557.5202-1-mike.kravetz@oracle.com>
 <20181218223557.5202-3-mike.kravetz@oracle.com>
 <20181221102824.5v36l6l5t2zthpgr@kshutemo-mobl1>
 <849f5202-2200-265f-7769-8363053e8373@oracle.com>
 <20181221202136.crrwojz3k7muvyrh@kshutemo-mobl1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <732c0b7d-5a4e-97a8-9677-30f3520893cb@oracle.com>
Date:   Fri, 21 Dec 2018 14:17:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181221202136.crrwojz3k7muvyrh@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9114 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=659
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812210165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 12:21 PM, Kirill A. Shutemov wrote:
> On Fri, Dec 21, 2018 at 10:28:25AM -0800, Mike Kravetz wrote:
>> On 12/21/18 2:28 AM, Kirill A. Shutemov wrote:
>>> On Tue, Dec 18, 2018 at 02:35:57PM -0800, Mike Kravetz wrote:
>>>> Instead of writing the required complicated code for this rare
>>>> occurrence, just eliminate the race.  i_mmap_rwsem is now held in read
>>>> mode for the duration of page fault processing.  Hold i_mmap_rwsem
>>>> longer in truncation and hold punch code to cover the call to
>>>> remove_inode_hugepages.
>>>
>>> One of remove_inode_hugepages() callers is noticeably missing --
>>> hugetlbfs_evict_inode(). Why?
>>>
>>> It at least deserves a comment on why the lock rule doesn't apply to it.
>>
>> In the case of hugetlbfs_evict_inode, the vfs layer guarantees there are
>> no more users of the inode/file.
> 
> I'm not convinced that it is true. See documentation for ->evict_inode()
> in Documentation/filesystems/porting:
> 
> 	Caller does *not* evict the pagecache or inode-associated
> 	metadata buffers; the method has to use truncate_inode_pages_final() to get rid
> 	of those.
> 

We may be talking about different things.

When I say there are no more users, I am talking about users via user space.
We get to the hugetlbfs evict inode code via iput->iput_final->evict.  In
this path the count on the inode is zero, and is marked (I_FREEING) so that
nobody will start using it.  As a result, there can be no additional page
faults against the file.  This is what we are using i_mmap_rwsem to prevent.

The Documentation above says that the ->evict_inode() method must evict from
pagecache and get rid of metadatta buffers.  hugetlbfs_evict_inode does this
remove_inode_hugepages evicts pages from page cache (and frees them) as well
as cleaning up the hugetlbfs specific reserve map metadata.

Am I misunderstanding your question/concern?

I have decided to add the locking (although unnecessary) with something like
this in hugetlbfs_evict_inode.

	/*
	 * The vfs layer guarantees that there are no other users of this
	 * inode.  Therefore, it would be safe to call remove_inode_hugepages
	 * without holding i_mmap_rwsem.  We acquire and hold here to be
	 * consistent with other callers.  Since there will be no contention
	 * on the semaphore, overhead is negligible.
	 */
	i_mmap_lock_write(mapping);
	remove_inode_hugepages(inode, 0, LLONG_MAX);
	i_mmap_unlock_write(mapping);

-- 
Mike Kravetz
