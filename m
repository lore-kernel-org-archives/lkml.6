Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D72ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12312147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12312147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeIQOa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:30:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727185AbeIQOa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:30:28 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8H8ws8x079844
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:03:58 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mj73kwt9n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:03:58 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Mon, 17 Sep 2018 10:03:56 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Sep 2018 10:03:53 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8H93qqP60948558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Sep 2018 09:03:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCFAC52063;
        Mon, 17 Sep 2018 12:03:38 +0100 (BST)
Received: from skywalker (unknown [9.124.31.179])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 6D2F552054;
        Mon, 17 Sep 2018 12:03:37 +0100 (BST)
Received: (nullmailer pid 13563 invoked by uid 1000);
        Mon, 17 Sep 2018 09:03:50 -0000
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        aneesh.kumar@linux.vnet.ibm.com,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to handle PTE tables with non contiguous entries ?
In-Reply-To: <ddc3bb56-4da0-c093-256f-185d4a612b5c@c-s.fr>
References: <ddc3bb56-4da0-c093-256f-185d4a612b5c@c-s.fr>
Date:   Mon, 17 Sep 2018 14:33:50 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18091709-0016-0000-0000-000002063EFA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091709-0017-0000-0000-0000325D1F16
Message-Id: <87tvmoh4w9.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809170095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Hi,
>
> I'm having a hard time figuring out the best way to handle the following 
> situation:
>
> On the powerpc8xx, handling 16k size pages requires to have page tables 
> with 4 identical entries.

I assume that hugetlb page size? If so isn't that similar to FSL hugetlb
page table layout?

>
> Initially I was thinking about handling this by simply modifying 
> pte_index() which changing pte_t type in order to have one entry every 
> 16 bytes, then replicate the PTE value at *ptep, *ptep+1,*ptep+2 and 
> *ptep+3 both in set_pte_at() and pte_update().
>
> However, this doesn't work because many many places in the mm core part 
> of the kernel use loops on ptep with single ptep++ increment.
>
> Therefore did it with the following hack:
>
>   /* PTE level */
> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
> +typedef struct { pte_basic_t pte, pte1, pte2, pte3; } pte_t;
> +#else
>   typedef struct { pte_basic_t pte; } pte_t;
> +#endif
>
> @@ -181,7 +192,13 @@ static inline unsigned long pte_update(pte_t *p,
>          : "cc" );
>   #else /* PTE_ATOMIC_UPDATES */
>          unsigned long old = pte_val(*p);
> -       *p = __pte((old & ~clr) | set);
> +       unsigned long new = (old & ~clr) | set;
> +
> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
> +       p->pte = p->pte1 = p->pte2 = p->pte3 = new;
> +#else
> +       *p = __pte(new);
> +#endif
>   #endif /* !PTE_ATOMIC_UPDATES */
>
>   #ifdef CONFIG_44x
>
>
> @@ -161,7 +161,11 @@ static inline void __set_pte_at(struct mm_struct 
> *mm, unsigned long addr,
>          /* Anything else just stores the PTE normally. That covers all 
> 64-bit
>           * cases, and 32-bit non-hash with 32-bit PTEs.
>           */
> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
> +       ptep->pte = ptep->pte1 = ptep->pte2 = ptep->pte3 = pte_val(pte);
> +#else
>          *ptep = pte;
> +#endif
>
>
>
> But I'm not too happy with it as it means pte_t is not a single type 
> anymore so passing it from one function to the other is quite heavy.
>
>
> Would someone have an idea of an elegent way to handle that ?
>
> Thanks
> Christophe

Why would pte_update bother about updating all the 4 entries?. Can you
help me understand the issue?

-aneesh

