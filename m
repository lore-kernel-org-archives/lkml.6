Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7493FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42522206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbeLQK0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:26:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726642AbeLQK0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:26:07 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBHAOH7d028141
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 05:26:06 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pe7b17039-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 05:26:06 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Mon, 17 Dec 2018 10:26:05 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Dec 2018 10:26:01 -0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBHAPx0J27590778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 10:26:00 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0BB36A04F;
        Mon, 17 Dec 2018 10:25:59 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDD016A047;
        Mon, 17 Dec 2018 10:25:43 +0000 (GMT)
Received: from [9.85.72.89] (unknown [9.85.72.89])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 17 Dec 2018 10:25:29 +0000 (GMT)
Subject: Re: [PATCH 2/3] hugetlbfs: Use i_mmap_rwsem to fix page
 fault/truncate race
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Mon, 17 Dec 2018 15:55:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181203200850.6460-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121710-0004-0000-0000-000014C33F9D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010240; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01133028; UDB=6.00588965; IPR=6.00913167;
 MB=3.00024716; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-17 10:26:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121710-0005-0000-0000-000089E21433
Message-Id: <27f8893b-57b3-088d-2d48-9e8acc5987bd@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 1:38 AM, Mike Kravetz wrote:
> hugetlbfs page faults can race with truncate and hole punch operations.
> Current code in the page fault path attempts to handle this by 'backing
> out' operations if we encounter the race.  One obvious omission in the
> current code is removing a page newly added to the page cache.  This is
> pretty straight forward to address, but there is a more subtle and
> difficult issue of backing out hugetlb reservations.  To handle this
> correctly, the 'reservation state' before page allocation needs to be
> noted so that it can be properly backed out.  There are four distinct
> possibilities for reservation state: shared/reserved, shared/no-resv,
> private/reserved and private/no-resv.  Backing out a reservation may
> require memory allocation which could fail so that needs to be taken
> into account as well.
> 
> Instead of writing the required complicated code for this rare
> occurrence, just eliminate the race.  i_mmap_rwsem is now held in read
> mode for the duration of page fault processing.  Hold i_mmap_rwsem
> longer in truncation and hold punch code to cover the call to
> remove_inode_hugepages.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: ebed4bfc8da8 ("hugetlb: fix absurd HugePages_Rsvd")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   fs/hugetlbfs/inode.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 32920a10100e..3244147fc42b 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -505,8 +505,8 @@ static int hugetlb_vmtruncate(struct inode *inode, loff_t offset)
>   	i_mmap_lock_write(mapping);
>   	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
>   		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
> -	i_mmap_unlock_write(mapping);
>   	remove_inode_hugepages(inode, offset, LLONG_MAX);
> +	i_mmap_unlock_write(mapping);
>   	return 0;
>   }


We used to do remove_inode_hugepages()

	mutex_lock(&hugetlb_fault_mutex_table[hash]);
	i_mmap_lock_write(mapping);
	hugetlb_vmdelete_list(&mapping->i_mmap,
	i_mmap_unlock_write(mapping);

did we change the lock ordering with this patch?


> 
> @@ -540,8 +540,8 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>   			hugetlb_vmdelete_list(&mapping->i_mmap,
>   						hole_start >> PAGE_SHIFT,
>   						hole_end  >> PAGE_SHIFT);
> -		i_mmap_unlock_write(mapping);
>   		remove_inode_hugepages(inode, hole_start, hole_end);
> +		i_mmap_unlock_write(mapping);
>   		inode_unlock(inode);
>   	}
> 

-aneesh

