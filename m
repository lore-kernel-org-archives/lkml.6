Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBCCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B82420859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NdZPToB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfAQUKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:10:42 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55094 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbfAQUKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:10:41 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0HK8xST088262;
        Thu, 17 Jan 2019 20:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=RiKe57zOOVmULfRl8TWdM657giYm26btlicjuDAGmyk=;
 b=NdZPToB61u86VXfemArtvyTEoRyAI85rdbncXHGSdkbYmbAJmvKC/bpnhHJKhhQbAmXO
 3HXXqKxtEEQDWgDJ901PnkE+gI+limbhTxPH18jUTMit7PxoHqDIpyuQPIuVjNKEuMR9
 gjbTHv2BZ2uL8FgI2b8d0e2cRU8s+FriOoB4d+Q7q/cLLrtwS0cYOeiiY07cfZ4UeDig
 C3PrdDxoGYl5iSjP2yOlRYdEMi3MX7sNDe4YF7I3Pl7qRLOqv89g3B8a0WEd8EX3Eu/j
 FrOCnL41ARCtS8fQEOI0KkB+ohuIICEPBiksXXVrhQ51+5cbqhODTn/lB+hTCNn0A6A1 6Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2pybkct323-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 20:09:16 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0HK9Fj7003276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 20:09:15 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0HK9EEd028131;
        Thu, 17 Jan 2019 20:09:14 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Jan 2019 12:09:13 -0800
Subject: Re: [PATCH] hugetlb: allow to free gigantic pages regardless of the
 configuration
To:     Alexandre Ghiti <aghiti@upmem.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     linux-riscv@lists.infradead.org, hch@infradead.org,
        Alexandre Ghiti <alex@ghiti.fr>
References: <20190117183953.5990-1-aghiti@upmem.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5e02e9c1-efd5-fc1e-c658-5a11f6291bcd@oracle.com>
Date:   Thu, 17 Jan 2019 12:09:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117183953.5990-1-aghiti@upmem.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9139 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901170140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 10:39 AM, Alexandre Ghiti wrote:
> From: Alexandre Ghiti <alex@ghiti.fr>
> 
> On systems without CMA or (MEMORY_ISOLATION && COMPACTION) activated but
> that support gigantic pages, boottime reserved gigantic pages can not be
> freed at all. This patchs simply enables the possibility to hand back
> those pages to memory allocator.
> 
> This commit then renames gigantic_page_supported and
> ARCH_HAS_GIGANTIC_PAGE to make them more accurate. Indeed, those values
> being false does not mean that the system cannot use gigantic pages: it
> just means that runtime allocation of gigantic pages is not supported,
> one can still allocate boottime gigantic pages if the architecture supports
> it.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Thank you for doing this!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -589,8 +589,8 @@ static inline bool pm_suspended_storage(void)
>  /* The below functions must be run on a range from a single zone. */
>  extern int alloc_contig_range(unsigned long start, unsigned long end,
>  			      unsigned migratetype, gfp_t gfp_mask);
> -extern void free_contig_range(unsigned long pfn, unsigned nr_pages);
>  #endif
> +extern void free_contig_range(unsigned long pfn, unsigned int nr_pages);

I think nr_pages should be an unsigned long in cma_release() and here
as well, but that is beyond the scope of this patch.  Most callers of
cma_release pass in a truncated unsigned long.  The truncation is unlikely
to cause any issues, just would be nice if types were consistent.  I have
a patch to do that as part of a contiguous allocation series that I will
get back to someday.

> @@ -2350,9 +2355,10 @@ static unsigned long set_max_huge_pages(struct hstate *h, unsigned long count,
>  			break;
>  	}
>  out:
> -	ret = persistent_huge_pages(h);
> +	h->max_huge_pages = persistent_huge_pages(h);
>  	spin_unlock(&hugetlb_lock);
> -	return ret;
> +
> +	return 0;
>  }
>  
>  #define HSTATE_ATTR_RO(_name) \
> @@ -2404,11 +2410,6 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>  	int err;
>  	NODEMASK_ALLOC(nodemask_t, nodes_allowed, GFP_KERNEL | __GFP_NORETRY);
>  
> -	if (hstate_is_gigantic(h) && !gigantic_page_supported()) {
> -		err = -EINVAL;
> -		goto out;
> -	}
> -
>  	if (nid == NUMA_NO_NODE) {
>  		/*
>  		 * global hstate attribute
> @@ -2428,7 +2429,9 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>  	} else
>  		nodes_allowed = &node_states[N_MEMORY];
>  
> -	h->max_huge_pages = set_max_huge_pages(h, count, nodes_allowed);
> +	err = set_max_huge_pages(h, count, nodes_allowed);
> +	if (err)
> +		goto out;
>  
>  	if (nodes_allowed != &node_states[N_MEMORY])
>  		NODEMASK_FREE(nodes_allowed);

Yeah!  Those changes causes max_huge_pages to be modified while holding
hugetlb_lock as it should be.
-- 
Mike Kravetz
