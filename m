Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA47C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C878F214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C878F214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbeIZI7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:59:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbeIZI7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:59:11 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8Q2dIhF087606
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 22:48:32 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mr052jub3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 22:48:31 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 26 Sep 2018 03:48:29 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Sep 2018 03:48:25 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8Q2mOjt62717986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Sep 2018 02:48:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C8A652050;
        Wed, 26 Sep 2018 05:48:06 +0100 (BST)
Received: from skywalker (unknown [9.199.41.211])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 8991052054;
        Wed, 26 Sep 2018 05:48:04 +0100 (BST)
Received: (nullmailer pid 7370 invoked by uid 1000);
        Wed, 26 Sep 2018 02:48:22 -0000
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 18/22] powerpc/mm: Extend pte_fragment functionality to nohash/32
In-Reply-To: <cda95a5508594e2a2ad5f6f214c435d9a1b44c46.1537892499.git.christophe.leroy@c-s.fr>
References: <cover.1537892498.git.christophe.leroy@c-s.fr> <cda95a5508594e2a2ad5f6f214c435d9a1b44c46.1537892499.git.christophe.leroy@c-s.fr>
Date:   Wed, 26 Sep 2018 08:18:22 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18092602-0028-0000-0000-000002FE9A2F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092602-0029-0000-0000-000023B8B049
Message-Id: <87in2tgeix.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=966 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> In order to allow the 8xx to handle pte_fragments, this patch
> extends the use of pte_fragments to nohash/32 platforms.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/mmu_context.h       |  2 +-
>  arch/powerpc/include/asm/nohash/32/mmu-40x.h |  1 +
>  arch/powerpc/include/asm/nohash/32/mmu-44x.h |  1 +
>  arch/powerpc/include/asm/nohash/32/mmu-8xx.h |  1 +
>  arch/powerpc/include/asm/nohash/32/mmu.h     |  4 ++-
>  arch/powerpc/include/asm/nohash/32/pgalloc.h | 52 +++++++++++++---------------
>  arch/powerpc/include/asm/nohash/32/pgtable.h | 11 ++++--
>  arch/powerpc/include/asm/nohash/mmu-book3e.h |  1 +
>  arch/powerpc/mm/Makefile                     |  3 ++
>  arch/powerpc/mm/mmu_context_nohash.c         | 14 ++++++++
>  10 files changed, 57 insertions(+), 33 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index b2f89b621b15..7f2c37a3f99d 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -222,7 +222,7 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm,
>  	return 0;
>  }
>  
> -#ifndef CONFIG_PPC_BOOK3S_64
> +#if defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_PPC_BOOK3S_32)
>  static inline void arch_exit_mmap(struct mm_struct *mm)
>  {
>  }


Can we do that with #ifndef arch_exit_mmap? This should handle every
platform that doesn't use pte_frag right?


> diff --git a/arch/powerpc/include/asm/nohash/32/mmu-40x.h b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
> index 74f4edb5916e..7c77ceed71d6 100644
> --- a/arch/powerpc/include/asm/nohash/32/mmu-40x.h
> +++ b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
> @@ -58,6 +58,7 @@ typedef struct {
>  	unsigned int	id;
>  	unsigned int	active;
>  	unsigned long	vdso_base;

-aneesh

