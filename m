Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE80C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDB820825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="x35RhPrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDB820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbeKFHHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:07:37 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41964 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387580AbeKFHHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:07:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA5LdIgx159001;
        Mon, 5 Nov 2018 21:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=2z4/yD+RY1r4CkBBc1e5G116pxB9q0L/xkzHIOuV33I=;
 b=x35RhPrVaN4tC1/93MrtDBurXuVLhgZll1YzCURQdI3CIF6uMJ+q1Zw62sRycCksIUVB
 RlG5oCKG9q6llvEN6CyEtN3UEmM8VGXwTwhGR82981Yxf790UErBGaXNnzKS36q3AJwV
 M/vl7Mkox0pjXZhU3AxV7XP7ZIYm+Ssd786emdHBUi0kls/YEvKgtsBX0nwKU9omWMgw
 +YBsXMzOB4mgbUlGoDNQRgc+D1k6i9/CDabFbuW564R3SGf3u3OfhOc8f3hnbRYhHNZf
 1BFXmxCYKfPmx7mlSyaK6L8UhzEh0RDe6ynUy8b/PMbgfhTdnv9b52cxhfdMSodn6oip wQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2nh3mphqnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Nov 2018 21:44:40 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA5LiY2G028641
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Nov 2018 21:44:34 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA5LiXme009948;
        Mon, 5 Nov 2018 21:44:33 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 13:44:33 -0800
Subject: Re: [PATCH] hugetlbfs: fix kernel BUG at fs/hugetlbfs/inode.c:444!
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
References: <20181105212315.14125-1-mike.kravetz@oracle.com>
 <20181105133013.35fdb58c16d9318538fc0cb6@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8d4b90a9-1e7c-f748-8bd2-fada0175aa31@oracle.com>
Date:   Mon, 5 Nov 2018 13:44:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105133013.35fdb58c16d9318538fc0cb6@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811050191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18 1:30 PM, Andrew Morton wrote:
> On Mon,  5 Nov 2018 13:23:15 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>> This bug has been experienced several times by Oracle DB team.
>> The BUG is in the routine remove_inode_hugepages() as follows:
>> 	/*
>> 	 * If page is mapped, it was faulted in after being
>> 	 * unmapped in caller.  Unmap (again) now after taking
>> 	 * the fault mutex.  The mutex will prevent faults
>> 	 * until we finish removing the page.
>> 	 *
>> 	 * This race can only happen in the hole punch case.
>> 	 * Getting here in a truncate operation is a bug.
>> 	 */
>> 	if (unlikely(page_mapped(page))) {
>> 		BUG_ON(truncate_op);
>>
>> In this case, the elevated map count is not the result of a race.
>> Rather it was incorrectly incremented as the result of a bug in the
>> huge pmd sharing code.  Consider the following:
>> - Process A maps a hugetlbfs file of sufficient size and alignment
>>   (PUD_SIZE) that a pmd page could be shared.
>> - Process B maps the same hugetlbfs file with the same size and alignment
>>   such that a pmd page is shared.
>> - Process B then calls mprotect() to change protections for the mapping
>>   with the shared pmd.  As a result, the pmd is 'unshared'.
>> - Process B then calls mprotect() again to chage protections for the
>>   mapping back to their original value.  pmd remains unshared.
>> - Process B then forks and process C is created.  During the fork process,
>>   we do dup_mm -> dup_mmap -> copy_page_range to copy page tables.  Copying
>>   page tables for hugetlb mappings is done in the routine
>>   copy_hugetlb_page_range.
>>
>> In copy_hugetlb_page_range(), the destination pte is obtained by:
>> 	dst_pte = huge_pte_alloc(dst, addr, sz);
>> If pmd sharing is possible, the returned pointer will be to a pte in
>> an existing page table.  In the situation above, process C could share
>> with either process A or process B.  Since process A is first in the
>> list, the returned pte is a pointer to a pte in process A's page table.
>>
>> However, the following check for pmd sharing is in copy_hugetlb_page_range.
>> 	/* If the pagetables are shared don't copy or take references */
>> 	if (dst_pte == src_pte)
>> 		continue;
>>
>> Since process C is sharing with process A instead of process B, the above
>> test fails.  The code in copy_hugetlb_page_range which follows assumes
>> dst_pte points to a huge_pte_none pte.  It copies the pte entry from
>> src_pte to dst_pte and increments this map count of the associated page.
>> This is how we end up with an elevated map count.
>>
>> To solve, check the dst_pte entry for huge_pte_none.  If !none, this
>> implies PMD sharing so do not copy.
>>
> 
> Does it warrant a cc:stable?

My apologies,  yes it does.  Here are the additional tags:

Fixes: c5c99429fa57 ("fix hugepages leak due to pagetable page sharing")
Cc: <stable@vger.kernel.org>

Let me know if you want me to resend with these.
-- 
Mike Kravetz
