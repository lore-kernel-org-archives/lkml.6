Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA466C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B991217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbfB0Pgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:36:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726356AbfB0Pgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 10:36:37 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RFXqxI044584
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 10:36:36 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qwtuk09ks-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 10:36:36 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 27 Feb 2019 15:36:33 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Feb 2019 15:36:30 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1RFaTAw11731014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 15:36:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CEA34C046;
        Wed, 27 Feb 2019 15:36:29 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 321B94C058;
        Wed, 27 Feb 2019 15:36:28 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 27 Feb 2019 15:36:28 +0000 (GMT)
Date:   Wed, 27 Feb 2019 17:36:26 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "labbott@redhat.com" <labbott@redhat.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH V2] mm/cma: cma_declare_contiguous: correct err handling
References: <20190227144631.16708-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227144631.16708-1-peng.fan@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19022715-0020-0000-0000-0000031BF6C8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022715-0021-0000-0000-0000216D63E8
Message-Id: <20190227153626.GF16901@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 02:34:55PM +0000, Peng Fan wrote:
> In case cma_init_reserved_mem failed, need to free the memblock allocated
> by memblock_reserve or memblock_alloc_range.
> 
> Quote Catalin's comments:
> https://lkml.org/lkml/2019/2/26/482
> Kmemleak is supposed to work with the memblock_{alloc,free} pair and it
> ignores the memblock_reserve() as a memblock_alloc() implementation
> detail. It is, however, tolerant to memblock_free() being called on
> a sub-range or just a different range from a previous memblock_alloc().
> So the original patch looks fine to me. FWIW:
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> 
> V2:
>  Per Mike's comments, add more information in commit log
>  Add R-B
> 
>  mm/cma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index c7b39dd3b4f6..f4f3a8a57d86 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -353,12 +353,14 @@ int __init cma_declare_contiguous(phys_addr_t base,
>  
>  	ret = cma_init_reserved_mem(base, size, order_per_bit, name, res_cma);
>  	if (ret)
> -		goto err;
> +		goto free_mem;
>  
>  	pr_info("Reserved %ld MiB at %pa\n", (unsigned long)size / SZ_1M,
>  		&base);
>  	return 0;
>  
> +free_mem:
> +	memblock_free(base, size);
>  err:
>  	pr_err("Failed to reserve %ld MiB\n", (unsigned long)size / SZ_1M);
>  	return ret;
> -- 
> 2.16.4
> 

-- 
Sincerely yours,
Mike.

