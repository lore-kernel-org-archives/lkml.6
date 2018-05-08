Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754832AbeEHI1H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 04:27:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754816AbeEHI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 04:27:05 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  02/17] powerpc/nohash: remove _PAGE_BUSY
In-Reply-To: <7332568467307f9fc79eeef47507909ddc423c4b.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr> <7332568467307f9fc79eeef47507909ddc423c4b.1525435203.git.christophe.leroy@c-s.fr>
Date: Tue, 08 May 2018 13:56:59 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18050808-0008-0000-0000-000004F44293
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050808-0009-0000-0000-00001E8882AB
Message-Id: <87o9hqsgbw.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805080083
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> _PAGE_BUSY is always 0, remove it
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/nohash/64/pgtable.h | 10 +++-------
>  arch/powerpc/include/asm/nohash/pte-book3e.h |  5 -----
>  2 files changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
> index 4f6f5a27bfb5..c3559d7a94fb 100644
> --- a/arch/powerpc/include/asm/nohash/64/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
> @@ -186,14 +186,12 @@ static inline unsigned long pte_update(struct mm_struct *mm,
>  
>  	__asm__ __volatile__(
>  	"1:	ldarx	%0,0,%3		# pte_update\n\
> -	andi.	%1,%0,%6\n\
> -	bne-	1b \n\
>  	andc	%1,%0,%4 \n\
> -	or	%1,%1,%7\n\
> +	or	%1,%1,%6\n\
>  	stdcx.	%1,0,%3 \n\
>  	bne-	1b"
>  	: "=&r" (old), "=&r" (tmp), "=m" (*ptep)
> -	: "r" (ptep), "r" (clr), "m" (*ptep), "i" (_PAGE_BUSY), "r" (set)
> +	: "r" (ptep), "r" (clr), "m" (*ptep), "r" (set)
>  	: "cc" );
>  #else
>  	unsigned long old = pte_val(*ptep);
> @@ -290,13 +288,11 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
>  
>  	__asm__ __volatile__(
>  	"1:	ldarx	%0,0,%4\n\
> -		andi.	%1,%0,%6\n\
> -		bne-	1b \n\
>  		or	%0,%3,%0\n\
>  		stdcx.	%0,0,%4\n\
>  		bne-	1b"
>  	:"=&r" (old), "=&r" (tmp), "=m" (*ptep)
> -	:"r" (bits), "r" (ptep), "m" (*ptep), "i" (_PAGE_BUSY)
> +	:"r" (bits), "r" (ptep), "m" (*ptep)
>  	:"cc");
>  #else
>  	unsigned long old = pte_val(*ptep);
> diff --git a/arch/powerpc/include/asm/nohash/pte-book3e.h b/arch/powerpc/include/asm/nohash/pte-book3e.h
> index 9ff51b4c0cac..12730b81cd98 100644
> --- a/arch/powerpc/include/asm/nohash/pte-book3e.h
> +++ b/arch/powerpc/include/asm/nohash/pte-book3e.h
> @@ -57,13 +57,8 @@
>  #define _PAGE_USER		(_PAGE_BAP_UR | _PAGE_BAP_SR) /* Can be read */
>  #define _PAGE_PRIVILEGED	(_PAGE_BAP_SR)
>  
> -#define _PAGE_BUSY	0
> -
>  #define _PAGE_SPECIAL	_PAGE_SW0
>  
> -/* Flags to be preserved on PTE modifications */
> -#define _PAGE_HPTEFLAGS	_PAGE_BUSY
> -
>  /* Base page size */
>  #ifdef CONFIG_PPC_64K_PAGES
>  #define _PAGE_PSIZE	_PAGE_PSIZE_64K
> -- 
> 2.13.3
