Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A371C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7DE20813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w0WKJ2LM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7DE20813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbeJXBzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:55:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50836 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeJXBzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:55:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9NHNW6O054338;
        Tue, 23 Oct 2018 17:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=JreCUfoo2UrgGYgPqbO6iOOF5jGhsKu6hPiCYeKrNSY=;
 b=w0WKJ2LMhVKoMEJTQkb6lsp4jSywjdInIzQz8cfZpGcd3jc4dn1mQWf5kwrb37RxKZ6C
 +cpsXtDFdNspDK4M8AdML/EzBYKVr4rulVolRTnX+MpB/wm6SlAntTr0RUOLnTfWgVo0
 KHBJJFgAmzee3Pt5kxtyueYVtj3NUzR/MnBuf/8aQ3QEAiWYlyWvz2WoZ0gJRE7N6mwp
 R33w557qiiElarsp81Qan3EgWjKmzzH2FNNntp/uF4aGPNCFkKABrzCAahs81nDiJw0H
 nWiXLjDinjgYNOizZmc9R4c7OW7A+3XRDvEYz2YnW0jGD298I0RfLgbOpCqn1nqA1Gw6 Xg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2n7w0qpsb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 17:30:49 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9NHUltO006764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 17:30:48 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9NHUkoW001118;
        Tue, 23 Oct 2018 17:30:46 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Oct 2018 10:30:45 -0700
Subject: Re: [PATCH] hugetlbfs: dirty pages as they are added to pagecache
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
References: <20181018041022.4529-1-mike.kravetz@oracle.com>
 <20181023074340.GO18839@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b5be45b8-5afe-56cd-9482-28384699a049@oracle.com>
Date:   Tue, 23 Oct 2018 10:30:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181023074340.GO18839@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9055 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810230141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/18 12:43 AM, Michal Hocko wrote:
> On Wed 17-10-18 21:10:22, Mike Kravetz wrote:
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
>> Fixes: 70c3547e36f5 ("hugetlbfs: add hugetlbfs_fallocate()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> I do agree with others that HUGETLBFS_MAGIC check in drop_pagecache_sb
> is wrong in principal. I am not even sure we want to special case memory
> backed filesystems. What if we ever implement MADV_FREE on fs? Should
> those pages be dropped? My first idea take would be yes.

Ok, I have removed that hard coded check.  Implementing MADV_FREE on
hugetlbfs would take some work, but it could be done.

> Acked-by: Michal Hocko <mhocko@suse.com> to the set_page_dirty dirty
> part.
> 
> Although I am wondering why you haven't covered only the fallocate path
> wrt Fixes tag. In other words, do we need the same treatment for the
> page fault path? We do not set dirty bit on page there as well. We rely
> on the dirty bit in pte and only for writable mappings. I have hard time
> to see why we have been safe there as well. So maybe it is your Fixes:
> tag which is not entirely correct, or I am simply missing the fault
> path.

No, you are not missing anything.  In the commit log I mentioned that this
also does apply to the fault path.  The change takes care of them both.

I was struggling with what to put in the fixes tag.  As mentioned, this
problem also exists in the fault path.  Since 3.16 is the oldest stable
release, I went back and used the commit next to the add_to_page_cache code
there.  However, that seems kind of random.  Is there a better way to say
the patch applies to all stable releases?

Here is updated patch without the drop_caches change and updated fixes tag.

From: Mike Kravetz <mike.kravetz@oracle.com>

hugetlbfs: dirty pages as they are added to pagecache

Some test systems were experiencing negative huge page reserve
counts and incorrect file block counts.  This was traced to
/proc/sys/vm/drop_caches removing clean pages from hugetlbfs
file pagecaches.  When non-hugetlbfs explicit code removes the
pages, the appropriate accounting is not performed.

This can be recreated as follows:
 fallocate -l 2M /dev/hugepages/foo
 echo 1 > /proc/sys/vm/drop_caches
 fallocate -l 2M /dev/hugepages/foo
 grep -i huge /proc/meminfo
   AnonHugePages:         0 kB
   ShmemHugePages:        0 kB
   HugePages_Total:    2048
   HugePages_Free:     2047
   HugePages_Rsvd:    18446744073709551615
   HugePages_Surp:        0
   Hugepagesize:       2048 kB
   Hugetlb:         4194304 kB
 ls -lsh /dev/hugepages/foo
   4.0M -rw-r--r--. 1 root root 2.0M Oct 17 20:05 /dev/hugepages/foo

To address this issue, dirty pages as they are added to pagecache.
This can easily be reproduced with fallocate as shown above. Read
faulted pages will eventually end up being marked dirty.  But there
is a window where they are clean and could be impacted by code such
as drop_caches.  So, just dirty them all as they are added to the
pagecache.

Fixes: 6bda666a03f0 ("hugepages: fold find_or_alloc_pages into huge_no_page()")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5c390f5a5207..7b5c0ad9a6bd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3690,6 +3690,12 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 		return err;
 	ClearPagePrivate(page);
 
+	/*
+	 * set page dirty so that it will not be removed from cache/file
+	 * by non-hugetlbfs specific code paths.
+	 */
+	set_page_dirty(page);
+
 	spin_lock(&inode->i_lock);
 	inode->i_blocks += blocks_per_huge_page(h);
 	spin_unlock(&inode->i_lock);
-- 
2.17.2

