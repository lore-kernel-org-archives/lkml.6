Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52042ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A0D21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A0D21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeJQVUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:20:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726990AbeJQVUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:20:02 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9HDOJp5011905
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 09:24:20 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n64aavvrw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 09:24:19 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 17 Oct 2018 07:24:03 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Oct 2018 07:23:59 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9HDNxh747710356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Oct 2018 06:23:59 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E50086E052;
        Wed, 17 Oct 2018 13:23:58 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3F326E04E;
        Wed, 17 Oct 2018 13:23:56 +0000 (GMT)
Received: from [9.102.2.58] (unknown [9.102.2.58])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 17 Oct 2018 13:23:56 +0000 (GMT)
Subject: Re: [PATCH] powerpc/book3e: redefine pte_mkprivileged() and
 pte_mkuser()
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <19885260cc71182f8c03840204e2553ef42acb67.1539781367.git.christophe.leroy@c-s.fr>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Wed, 17 Oct 2018 18:53:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <19885260cc71182f8c03840204e2553ef42acb67.1539781367.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101713-0036-0000-0000-00000A4BFDA8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009891; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01103982; UDB=6.00571481; IPR=6.00884035;
 MB=3.00023793; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-17 13:24:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101713-0037-0000-0000-000049513656
Message-Id: <99072b0a-5650-46cf-28b9-1083e1919a36@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810170117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 6:33 PM, Christophe Leroy wrote:
> Book3e defines both _PAGE_USER and _PAGE_PRIVILEGED, so the nohash
> default pte_mkprivileged() and pte_mkuser() are not usable.
> 
> This patch redefines them for book3e.
> 
> In theorie, only pte_mkprivileged() needs to be redefined because
> _PAGE_USER includes _PAGE_PRIVILEGED, but it is less confusing
> to redefine both.
> 
> Fixes: a0da4bc166f2 ("powerpc/mm: Allow platforms to redefine some helpers")

  Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/include/asm/nohash/pte-book3e.h | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/nohash/pte-book3e.h b/arch/powerpc/include/asm/nohash/pte-book3e.h
> index 58eef8cb569d..fa1451e15b4e 100644
> --- a/arch/powerpc/include/asm/nohash/pte-book3e.h
> +++ b/arch/powerpc/include/asm/nohash/pte-book3e.h
> @@ -109,5 +109,21 @@
>   #define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
>   #define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
>   
> +#ifndef __ASSEMBLY__
> +static inline pte_t pte_mkprivileged(pte_t pte)
> +{
> +	return __pte((pte_val(pte) & ~_PAGE_USER) | _PAGE_PRIVILEGED);
> +}
> +
> +#define pte_mkprivileged pte_mkprivileged
> +
> +static inline pte_t pte_mkuser(pte_t pte)
> +{
> +	return __pte((pte_val(pte) & ~_PAGE_PRIVILEGED) | _PAGE_USER);
> +}
> +
> +#define pte_mkuser pte_mkuser
> +#endif /* __ASSEMBLY__ */
> +
>   #endif /* __KERNEL__ */
>   #endif /*  _ASM_POWERPC_NOHASH_PTE_BOOK3E_H */
> 

