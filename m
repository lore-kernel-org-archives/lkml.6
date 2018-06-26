Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F63C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A4126DC3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sua81iqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A4126DC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeFZRAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:00:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35694 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeFZRAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:00:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5QGx3mE189182;
        Tue, 26 Jun 2018 17:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=uu13tzXEek56fElJWDdqZooN/giP9fJJ4IS6zVfz/Lo=;
 b=Sua81iqmQAdR1ZpyN61WR5JqvFHrYX0yxrHYLX6YG1nY6qC5DJw/exHyWtuPEwKHOUL8
 yuc7ZdJLAbrRbWB4cbU2Ogh6rlD0PvaMsFmKjTilmDz4MCjEx2X8yLVq53EU7UtLZE1C
 9o/O1t5mlGNbqgd1fLChP95j0+QWNalkJi1JA0UCkJY2n8yZEdrPD4lHsUTg9N1q2ruW
 LAOkvins0fDrfmbbsSCfjOxqyPUsIbJutGj7Rp5VwHeFoNVDankjybCv5doWjmltQn+j
 cyBh+JQQLfI9VwGLJZFHMI+3TWwJzARgrS/lbDuVDC82bBZiIwBAMx0RaNXcV8V4Xnt3 Ww== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2jum57sf6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 17:00:18 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5QH0HSk008638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 17:00:18 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5QH0G1G028692;
        Tue, 26 Jun 2018 17:00:17 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Jun 2018 10:00:16 -0700
Subject: Re: [PATCH] userfaultfd: hugetlbfs: Fix userfaultfd_huge_must_wait
 pte access
To:     Janosch Frank <frankja@linux.ibm.com>, aarcange@redhat.com
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180626132421.78084-1-frankja@linux.ibm.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c9c5c76c-23e5-671f-1fdc-8326e42917b9@oracle.com>
Date:   Tue, 26 Jun 2018 10:00:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626132421.78084-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8936 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806260191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/2018 06:24 AM, Janosch Frank wrote:
> Use huge_ptep_get to translate huge ptes to normal ptes so we can
> check them with the huge_pte_* functions. Otherwise some architectures
> will check the wrong values and will not wait for userspace to bring
> in the memory.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Fixes: 369cd2121be4 ("userfaultfd: hugetlbfs: userfaultfd_huge_must_wait for hugepmd ranges")

Adding linux-mm and Andrew on Cc:

Thanks for catching and fixing this.
I think this needs to be fixed in stable as well.  Correct?  Assuming
userfaultfd is/can be enabled for impacted architectures.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> ---
>  fs/userfaultfd.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 123bf7d516fc..594d192b2331 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -222,24 +222,26 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
>  					 unsigned long reason)
>  {
>  	struct mm_struct *mm = ctx->mm;
> -	pte_t *pte;
> +	pte_t *ptep, pte;
>  	bool ret = true;
>  
>  	VM_BUG_ON(!rwsem_is_locked(&mm->mmap_sem));
>  
> -	pte = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
> -	if (!pte)
> +	ptep = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
> +
> +	if (!ptep)
>  		goto out;
>  
>  	ret = false;
> +	pte = huge_ptep_get(ptep);
>  
>  	/*
>  	 * Lockless access: we're in a wait_event so it's ok if it
>  	 * changes under us.
>  	 */
> -	if (huge_pte_none(*pte))
> +	if (huge_pte_none(pte))
>  		ret = true;
> -	if (!huge_pte_write(*pte) && (reason & VM_UFFD_WP))
> +	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
>  		ret = true;
>  out:
>  	return ret;
> 
