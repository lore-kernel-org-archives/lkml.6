Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0851DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 09:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A6621871
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 09:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfAAJXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 04:23:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728588AbfAAJXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 04:23:25 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x019K0Ww058061
        for <linux-kernel@vger.kernel.org>; Tue, 1 Jan 2019 04:23:24 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pr43mjx2t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 04:23:23 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Tue, 1 Jan 2019 09:23:21 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 1 Jan 2019 09:23:16 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x019NFSu55902356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Jan 2019 09:23:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46DDB4203F;
        Tue,  1 Jan 2019 09:23:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDE7142041;
        Tue,  1 Jan 2019 09:23:11 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.88.250])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Jan 2019 09:23:11 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Fengguang Wu <fengguang.wu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Yao Yuan <yuan.yao@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Fan Du <fan.du@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH v2 11/21] kvm: allocate page table pages from DRAM
In-Reply-To: <20181226133351.703380444@intel.com>
References: <20181226131446.330864849@intel.com> <20181226133351.703380444@intel.com>
Date:   Tue, 01 Jan 2019 14:53:07 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19010109-0012-0000-0000-000002E010DA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010109-0013-0000-0000-00002116C9E6
Message-Id: <87pntg7mv8.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901010086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fengguang Wu <fengguang.wu@intel.com> writes:

> From: Yao Yuan <yuan.yao@intel.com>
>
> Signed-off-by: Yao Yuan <yuan.yao@intel.com>
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
> arch/x86/kvm/mmu.c |   12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)
>
> --- linux.orig/arch/x86/kvm/mmu.c	2018-12-26 20:54:48.846720344 +0800
> +++ linux/arch/x86/kvm/mmu.c	2018-12-26 20:54:48.842719614 +0800
> @@ -950,6 +950,16 @@ static void mmu_free_memory_cache(struct
>  		kmem_cache_free(cache, mc->objects[--mc->nobjs]);
>  }
>  
> +static unsigned long __get_dram_free_pages(gfp_t gfp_mask)
> +{
> +       struct page *page;
> +
> +       page = __alloc_pages(GFP_KERNEL_ACCOUNT, 0, numa_node_id());
> +       if (!page)
> +	       return 0;
> +       return (unsigned long) page_address(page);
> +}
> +

May be it is explained in other patches. What is preventing the
allocation from pmem here? Is it that we are not using the memory
policy prefered node id and hence the zone list we built won't have the
PMEM node?


>  static int mmu_topup_memory_cache_page(struct kvm_mmu_memory_cache *cache,
>  				       int min)
>  {
> @@ -958,7 +968,7 @@ static int mmu_topup_memory_cache_page(s
>  	if (cache->nobjs >= min)
>  		return 0;
>  	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
> -		page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
> +		page = (void *)__get_dram_free_pages(GFP_KERNEL_ACCOUNT);
>  		if (!page)
>  			return cache->nobjs >= min ? 0 : -ENOMEM;
>  		cache->objects[cache->nobjs++] = page;

-aneesh

