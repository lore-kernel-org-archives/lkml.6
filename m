Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C1CC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 09:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BB42146F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 09:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfBJJz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 04:55:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbfBJJz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 04:55:28 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1A9sTMH134273
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 04:55:27 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qjd74msxd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 04:55:27 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 10 Feb 2019 09:55:24 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 10 Feb 2019 09:55:19 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1A9tIar54657110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 10 Feb 2019 09:55:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E25E4C050;
        Sun, 10 Feb 2019 09:55:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 647D84C046;
        Sun, 10 Feb 2019 09:55:17 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 10 Feb 2019 09:55:17 +0000 (GMT)
Date:   Sun, 10 Feb 2019 11:55:15 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "ghackmann@android.com" <ghackmann@android.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH] arm64: use memblocks_present
References: <20190210093738.30923-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210093738.30923-1-peng.fan@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19021009-0028-0000-0000-00000346C58A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021009-0029-0000-0000-00002404DDD0
Message-Id: <20190210095515.GA12403@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902100077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 09:28:43AM +0000, Peng Fan wrote:
> arm64_memory_present is doing same thing as memblocks_present, so
> let's use common code memblocks_present instead of platform
> specific arm64_memory_present.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/arm64/mm/init.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 7205a9085b4d..2302b4093a63 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -285,24 +285,6 @@ int pfn_valid(unsigned long pfn)
>  }
>  EXPORT_SYMBOL(pfn_valid);
>  
> -#ifndef CONFIG_SPARSEMEM
> -static void __init arm64_memory_present(void)
> -{
> -}
> -#else
> -static void __init arm64_memory_present(void)
> -{
> -	struct memblock_region *reg;
> -
> -	for_each_memblock(memory, reg) {
> -		int nid = memblock_get_region_node(reg);
> -
> -		memory_present(nid, memblock_region_memory_base_pfn(reg),
> -				memblock_region_memory_end_pfn(reg));
> -	}
> -}
> -#endif
> -
>  static phys_addr_t memory_limit = PHYS_ADDR_MAX;
>  
>  /*
> @@ -489,7 +471,7 @@ void __init bootmem_init(void)
>  	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
>  	 * done after the fixed reservations.
>  	 */
> -	arm64_memory_present();
> +	memblocks_present();
>  
>  	sparse_init();
>  	zone_sizes_init(min, max);
> -- 
> 2.14.1
> 

-- 
Sincerely yours,
Mike.

