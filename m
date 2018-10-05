Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF79C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF42320834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dtkq1nsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF42320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbeJFAhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:37:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47484 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeJFAhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:37:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w95HSvEs119208;
        Fri, 5 Oct 2018 17:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=qu6+D26NE1pwSF+gUXBe/GMGkp8II/iqfZveB8Z213M=;
 b=Dtkq1nsB+AznWUv8HodlVMBlQHNDbJ7I1sj9Wst2JAngywrmw0FTjfOwxIVEpkEm659J
 FZRloJjNQp2cvC4dlBGos9z8XOZ7TVgUA4iwKCXF8otKaYnnL7eSz7nSJvZ0ukVsoGOf
 3NjSdrXMo/bCnvfjCyDy2UgEMONQ8QjKXgWaAU01zzPUjLB8Vog6eOeoSo00aDHSrA+1
 ZY3wv6NdVPY8yDlaKY5gsJFV6S86F8hDeAmzXingTxfUD3ijeYTt+7+ohi3jCNnzPjXA
 DtgVrDhFS8uV7T1buxKqrBcSCOn+fCBVVvWOFaWrOSuC5opFvaE3xeLiZwhwH7gaJEpD hg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mt0tuc3m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Oct 2018 17:37:24 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w95HbN5D013482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Oct 2018 17:37:24 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w95HbMCT031021;
        Fri, 5 Oct 2018 17:37:22 GMT
Received: from [192.168.1.44] (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Oct 2018 17:37:21 +0000
Subject: Re: [mm PATCH 1/5] mm: Use mm_zero_struct_page from SPARC on all 64b
 architectures
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, davem@davemloft.net, rppt@linux.vnet.ibm.com,
        vbabka@suse.cz, sparclinux@vger.kernel.org,
        dan.j.williams@intel.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
References: <20181005151006.17473.83040.stgit@localhost.localdomain>
 <20181005151203.17473.25723.stgit@localhost.localdomain>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <64b4e8da-1d64-f2c1-bdbf-69dbb105e4ec@oracle.com>
Date:   Fri, 5 Oct 2018 11:37:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005151203.17473.25723.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9037 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810050173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2018 09:12 AM, Alexander Duyck wrote:
> This change makes it so that we use the same approach that was already in
> use on Sparc on all the archtectures that support a 64b long.
> 
> This is mostly motivated by the fact that 8 to 10 store/move instructions
> are likely always going to be faster than having to call into a function
> that is not specialized for handling page init.
> 
> An added advantage to doing it this way is that the compiler can get away
> with combining writes in the __init_single_page call. As a result the
> memset call will be reduced to only about 4 write operations, or at least
> that is what I am seeing with GCC 6.2 as the flags, LRU poitners, and
> count/mapcount seem to be cancelling out at least 4 of the 8 assignments on
> my system.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> -- >   arch/sparc/include/asm/pgtable_64.h |   30 
------------------------------
>   include/linux/mm.h                  |   33 +++++++++++++++++++++++++++++++++
>   2 files changed, 33 insertions(+), 30 deletions(-)

Looks good to me.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>

--
Khalid

> 
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 1393a8ac596b..22500c3be7a9 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -231,36 +231,6 @@
>   extern struct page *mem_map_zero;
>   #define ZERO_PAGE(vaddr)	(mem_map_zero)
>   
> -/* This macro must be updated when the size of struct page grows above 80
> - * or reduces below 64.
> - * The idea that compiler optimizes out switch() statement, and only
> - * leaves clrx instructions
> - */
> -#define	mm_zero_struct_page(pp) do {					\
> -	unsigned long *_pp = (void *)(pp);				\
> -									\
> -	 /* Check that struct page is either 64, 72, or 80 bytes */	\
> -	BUILD_BUG_ON(sizeof(struct page) & 7);				\
> -	BUILD_BUG_ON(sizeof(struct page) < 64);				\
> -	BUILD_BUG_ON(sizeof(struct page) > 80);				\
> -									\
> -	switch (sizeof(struct page)) {					\
> -	case 80:							\
> -		_pp[9] = 0;	/* fallthrough */			\
> -	case 72:							\
> -		_pp[8] = 0;	/* fallthrough */			\
> -	default:							\
> -		_pp[7] = 0;						\
> -		_pp[6] = 0;						\
> -		_pp[5] = 0;						\
> -		_pp[4] = 0;						\
> -		_pp[3] = 0;						\
> -		_pp[2] = 0;						\
> -		_pp[1] = 0;						\
> -		_pp[0] = 0;						\
> -	}								\
> -} while (0)
> -
>   /* PFNs are real physical page numbers.  However, mem_map only begins to record
>    * per-page information starting at pfn_base.  This is to handle systems where
>    * the first physical page in the machine is at some huge physical address,
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 273d4dbd3883..a0440a6ef5cf 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -102,8 +102,41 @@ static inline void set_max_mapnr(unsigned long limit) { }
>    * zeroing by defining this macro in <asm/pgtable.h>.
>    */
>   #ifndef mm_zero_struct_page
> +#if BITS_PER_LONG == 64
> +/* This function must be updated when the size of struct page grows above 80
> + * or reduces below 64. The idea that compiler optimizes out switch()
> + * statement, and only leaves move/store instructions
> + */
> +#define	mm_zero_struct_page(pp) __mm_zero_struct_page(pp)
> +static inline void __mm_zero_struct_page(struct page *page)
> +{
> +	unsigned long *_pp = (void *)page;
> +
> +	 /* Check that struct page is either 64, 72, or 80 bytes */
> +	BUILD_BUG_ON(sizeof(struct page) & 7);
> +	BUILD_BUG_ON(sizeof(struct page) < 64);
> +	BUILD_BUG_ON(sizeof(struct page) > 80);
> +
> +	switch (sizeof(struct page)) {
> +	case 80:
> +		_pp[9] = 0;	/* fallthrough */
> +	case 72:
> +		_pp[8] = 0;	/* fallthrough */
> +	default:
> +		_pp[7] = 0;
> +		_pp[6] = 0;
> +		_pp[5] = 0;
> +		_pp[4] = 0;
> +		_pp[3] = 0;
> +		_pp[2] = 0;
> +		_pp[1] = 0;
> +		_pp[0] = 0;
> +	}
> +}
> +#else
>   #define mm_zero_struct_page(pp)  ((void)memset((pp), 0, sizeof(struct page)))
>   #endif
> +#endif
>   
>   /*
>    * Default maximum number of active map areas, this limits the number of vmas
> 

