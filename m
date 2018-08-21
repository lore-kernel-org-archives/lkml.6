Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBCCC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181D6216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181D6216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeHURps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:45:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726679AbeHURpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:45:47 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7LEItci115708
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:25:25 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m0k56v4gc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:25:25 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Tue, 21 Aug 2018 15:25:23 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Aug 2018 15:25:21 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7LEPKhp30212132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Aug 2018 14:25:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C376E52051;
        Tue, 21 Aug 2018 17:25:20 +0100 (BST)
Received: from skywalker (unknown [9.85.94.159])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id E72975204E;
        Tue, 21 Aug 2018 17:25:18 +0100 (BST)
Received: (nullmailer pid 18405 invoked by uid 1000);
        Tue, 21 Aug 2018 14:25:17 -0000
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/nohash: fix pte_access_permitted()
In-Reply-To: <8097a1d32403ea47d076803e9070869badfe24bc.1534856426.git.christophe.leroy@c-s.fr>
References: <8097a1d32403ea47d076803e9070869badfe24bc.1534856426.git.christophe.leroy@c-s.fr>
Date:   Tue, 21 Aug 2018 19:55:17 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18082114-0008-0000-0000-00000264B0D9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082114-0009-0000-0000-000021CCEF7B
Message-Id: <87eferg5ki.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=890 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808210151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Commit 5769beaf180a8 ("powerpc/mm: Add proper pte access check helper
> for other platforms") replaced generic pte_access_permitted() by an
> arch specific one.
>
> The generic one is defined as
> (pte_present(pte) && (!(write) || pte_write(pte)))
>
> The arch specific one is open coded checking that _PAGE_USER and
> _PAGE_WRITE (_PAGE_RW) flags are set, but lacking to check that
> _PAGE_RO and _PAGE_PRIVILEGED are unset, leading to a useless test
> on targets like the 8xx which defines _PAGE_RW and _PAGE_USER as 0.
>
> Commit 5fa5b16be5b31 ("powerpc/mm/hugetlb: Use pte_access_permitted
> for hugetlb access check") replaced some tests performed with
> pte helpers by a call to pte_access_permitted(), leading to the same
> issue.
>
> This patch rewrites powerpc/nohash pte_access_permitted()
> using pte helpers.
>

Thanks for fixing this. I should have used the helper instead of
opencoding it on nohash platforms. This is another reason why I was also
suggesting we should avoid consolidating pte accessors across platforms
and user accessors instead of opencoding. 

https://lore.kernel.org/lkml/87lgcusc6z.fsf@linux.vnet.ibm.com/T/#u

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Fixes: 5769beaf180a8 ("powerpc/mm: Add proper pte access check helper for other platforms")
> Fixes: 5fa5b16be5b31 ("powerpc/mm/hugetlb: Use pte_access_permitted for hugetlb access check")
> Cc: stable@vger.kernel.org # v4.15+
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/nohash/pgtable.h | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
> index 2160be2e4339..b321c82b3624 100644
> --- a/arch/powerpc/include/asm/nohash/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/pgtable.h
> @@ -51,17 +51,14 @@ static inline int pte_present(pte_t pte)
>  #define pte_access_permitted pte_access_permitted
>  static inline bool pte_access_permitted(pte_t pte, bool write)
>  {
> -	unsigned long pteval = pte_val(pte);
>  	/*
>  	 * A read-only access is controlled by _PAGE_USER bit.
>  	 * We have _PAGE_READ set for WRITE and EXECUTE
>  	 */
> -	unsigned long need_pte_bits = _PAGE_PRESENT | _PAGE_USER;
> -
> -	if (write)
> -		need_pte_bits |= _PAGE_WRITE;
> +	if (!pte_present(pte) || !pte_user(pte) || !pte_read(pte))
> +		return false;
>  
> -	if ((pteval & need_pte_bits) != need_pte_bits)
> +	if (write && !pte_write(pte))
>  		return false;
>  
>  	return true;
> -- 
> 2.13.3

