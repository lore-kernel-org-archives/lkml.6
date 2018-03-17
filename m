Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753178AbeCQXYu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 19:24:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751849AbeCQXYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 19:24:48 -0400
Date: Sat, 17 Mar 2018 16:24:25 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
        dave.hansen@intel.com, mpe@ellerman.id.au, mingo@kernel.org,
        akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [PATCH 1/3] x86, pkeys: do not special case protection key 0
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180316214654.895E24EC@viggo.jf.intel.com>
 <20180316214656.0E059008@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316214656.0E059008@viggo.jf.intel.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18031723-0020-0000-0000-00000406650D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031723-0021-0000-0000-0000429A745E
Message-Id: <20180317232425.GH1060@ram.oc3035372033.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-17_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803170294
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 02:46:56PM -0700, Dave Hansen wrote:
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

So your proposal 
(a) allocates pkey 0 implicitly, 
(b) does not stop anyone from freeing pkey-0
(c) and allows pkey-0 to be explicitly associated with any address range.
correct?

My proposal
(a) allocates pkey 0 implicitly, 
(b) stops anyone from freeing pkey-0
(c) and allows pkey-0 to be explicitly associated with any address range.

So the difference between the two proposals is just the freeing part i.e (b).
Did I get this right?

Its a philosophical debate; allow the user
to shoot-in-the-feet or stop from not doing so. There is no 
clear answer either way. I am fine either way.

So here is my

Reviewed-by: Ram Pai <linuxram@us.ibm.com>

I will write a corresponding patch for powerpc.

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
> --- a/arch/x86/include/asm/mmu_context.h~x86-pkey-0-default-allocated	2018-03-16 14:46:39.023285476 -0700
> +++ b/arch/x86/include/asm/mmu_context.h	2018-03-16 14:46:39.028285476 -0700
> @@ -191,7 +191,7 @@ static inline int init_new_context(struc
> 
>  #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
>  	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
> -		/* pkey 0 is the default and always allocated */
> +		/* pkey 0 is the default and allocated implicitly */
>  		mm->context.pkey_allocation_map = 0x1;
>  		/* -1 means unallocated or invalid */
>  		mm->context.execute_only_pkey = -1;
> diff -puN arch/x86/include/asm/pkeys.h~x86-pkey-0-default-allocated arch/x86/include/asm/pkeys.h
> --- a/arch/x86/include/asm/pkeys.h~x86-pkey-0-default-allocated	2018-03-16 14:46:39.025285476 -0700
> +++ b/arch/x86/include/asm/pkeys.h	2018-03-16 14:46:39.028285476 -0700
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
