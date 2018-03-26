Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeCZRfi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:35:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751684AbeCZRfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:35:37 -0400
Date: Mon, 26 Mar 2018 10:35:23 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
        dave.hansen@intel.com, mpe@ellerman.id.au, mingo@kernel.org,
        akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [PATCH 1/9] x86, pkeys: do not special case protection key 0
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180323180903.33B17168@viggo.jf.intel.com>
 <20180323180905.B40984E6@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323180905.B40984E6@viggo.jf.intel.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18032617-0040-0000-0000-000004271CAD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032617-0041-0000-0000-0000262A31C9
Message-Id: <20180326173522.GB5743@ram.oc3035372033.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803260180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 11:09:05AM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> mm_pkey_is_allocated() treats pkey 0 as unallocated.  That is
> inconsistent with the manpages, and also inconsistent with
> mm->context.pkey_allocation_map.  Stop special casing it and only
> disallow values that are actually bad (< 0).
> 
> The end-user visible effect of this is that you can now use
> mprotect_pkey() to set pkey=0.
> 
> This is a bit nicer than what Ram proposed because it is simpler
> and removes special-casing for pkey 0.  On the other hand, it does
> allow applciations to pkey_free() pkey-0, but that's just a silly
> thing to do, so we are not going to protect against it.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ram Pai <linuxram@us.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Michael Ellermen <mpe@ellerman.id.au>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>p
> Cc: Shuah Khan <shuah@kernel.org>
> ---
> 
>  b/arch/x86/include/asm/mmu_context.h |    2 +-
>  b/arch/x86/include/asm/pkeys.h       |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff -puN arch/x86/include/asm/mmu_context.h~x86-pkey-0-default-allocated arch/x86/include/asm/mmu_context.h
> --- a/arch/x86/include/asm/mmu_context.h~x86-pkey-0-default-allocated	2018-03-21 15:47:48.182198927 -0700
> +++ b/arch/x86/include/asm/mmu_context.h	2018-03-21 15:47:48.187198927 -0700
> @@ -192,7 +192,7 @@ static inline int init_new_context(struc
> 
>  #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
>  	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
> -		/* pkey 0 is the default and always allocated */
> +		/* pkey 0 is the default and allocated implicitly */
>  		mm->context.pkey_allocation_map = 0x1;

In the second patch, you introduce DEFAULT_KEY. Maybe you 
should introduce here and express the above code as

		mm->context.pkey_allocation_map = (0x1 << DEFAULT_KEY);

Incase your default key changes to something else, you are still good.

>  		/* -1 means unallocated or invalid */
>  		mm->context.execute_only_pkey = -1;
> diff -puN arch/x86/include/asm/pkeys.h~x86-pkey-0-default-allocated arch/x86/include/asm/pkeys.h
> --- a/arch/x86/include/asm/pkeys.h~x86-pkey-0-default-allocated	2018-03-21 15:47:48.184198927 -0700
> +++ b/arch/x86/include/asm/pkeys.h	2018-03-21 15:47:48.188198927 -0700
> @@ -49,10 +49,10 @@ bool mm_pkey_is_allocated(struct mm_stru
>  {
>  	/*
>  	 * "Allocated" pkeys are those that have been returned
> -	 * from pkey_alloc().  pkey 0 is special, and never
> -	 * returned from pkey_alloc().
> +	 * from pkey_alloc() or pkey 0 which is allocated
> +	 * implicitly when the mm is created.
>  	 */
> -	if (pkey <= 0)
> +	if (pkey < 0)
>  		return false;
>  	if (pkey >= arch_max_pkey())
>  		return false;
> _

-- 
Ram Pai
