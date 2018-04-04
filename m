Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeDDVlT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:41:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752156AbeDDVlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:41:17 -0400
References: <1522112702-27853-1-git-send-email-linuxram@us.ibm.com>
User-agent: mu4e 1.0; emacs 25.3.1
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
        fweimer@redhat.com, shuah@kernel.org, msuchanek@suse.com,
        linux-kernel@vger.kernel.org, mhocko@kernel.org, dave.hansen@intel.com,
        paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, tglx@linutronix.de,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc, pkey: make protection key 0 less special
In-reply-to: <1522112702-27853-1-git-send-email-linuxram@us.ibm.com>
Date: Wed, 04 Apr 2018 18:41:01 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18040421-0008-0000-0000-0000098E46A3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008803; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01013161; UDB=6.00516412; IPR=6.00792426;
 MB=3.00020419; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-04 21:41:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040421-0009-0000-0000-000046AC6436
Message-Id: <876056645u.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804040209
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Ram,

Ram Pai <linuxram@us.ibm.com> writes:

> Applications need the ability to associate an address-range with some
> key and latter revert to its initial default key. Pkey-0 comes close to
> providing this function but falls short, because the current
> implementation disallows applications to explicitly associate pkey-0 to
> the address range.
>
> Lets make pkey-0 less special and treat it almost like any other key.
> Thus it can be explicitly associated with any address range, and can be
> freed. This gives the application more flexibility and power.  The
> ability to free pkey-0 must be used responsibily, since pkey-0 is
> associated with almost all address-range by default.
>
> Even with this change pkey-0 continues to be slightly more special
> from the following point of view.
> (a) it is implicitly allocated.
> (b) it is the default key assigned to any address-range.

It's also special in more ways (and if intentional, these should be part
of the commit message as well):

(c) it's not possible to change permissions for key 0

  This has two causes: this patch explicitly forbids it in
  arch_set_user_pkey_access(), and also because even if it's allocated,
  the bits for key 0 in AMOR and UAMOR aren't set.

(d) it can be freed, but can't be allocated again later.

  This is because mm_pkey_alloc() only calls __arch_activate_pkey(ret)
  if ret > 0.

It looks like (d) is a bug. Either mm_pkey_free() should fail with key
0, or mm_pkey_alloc() should work with it.

(c) could be a measure to prevent users from shooting themselves in
their feet. But if that is the case, then mm_pkey_free() should forbid
freeing key 0 too.

> Tested on powerpc.
>
> cc: Thomas Gleixner <tglx@linutronix.de>
> cc: Dave Hansen <dave.hansen@intel.com>
> cc: Michael Ellermen <mpe@ellerman.id.au>
> cc: Ingo Molnar <mingo@kernel.org>
> cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
> History:
> 	v2: mm_pkey_is_allocated() continued to treat pkey-0 special.
> 	    fixed it.
>
>  arch/powerpc/include/asm/pkeys.h | 20 ++++++++++++++++----
>  arch/powerpc/mm/pkeys.c          | 20 ++++++++++++--------
>  2 files changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 0409c80..b598fa9 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -101,10 +101,14 @@ static inline u16 pte_to_pkey_bits(u64 pteflags)
>
>  static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
>  {
> -	/* A reserved key is never considered as 'explicitly allocated' */
> -	return ((pkey < arch_max_pkey()) &&
> -		!__mm_pkey_is_reserved(pkey) &&
> -		__mm_pkey_is_allocated(mm, pkey));
> +	if (pkey < 0 || pkey >= arch_max_pkey())
> +		return false;
> +
> +	/* Reserved keys are never allocated. */
> +	if (__mm_pkey_is_reserved(pkey))
> +		return false;
> +
> +	return __mm_pkey_is_allocated(mm, pkey);
>  }
>
>  extern void __arch_activate_pkey(int pkey);
> @@ -200,6 +204,14 @@ static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
>  {
>  	if (static_branch_likely(&pkey_disabled))
>  		return -EINVAL;
> +
> +	/*
> +	 * userspace is discouraged from changing permissions of
> +	 * pkey-0.

They're not discouraged. They're not allowed to. :-)

> +	 * powerpc hardware does not support it anyway.

It doesn't? I don't get that impression from reading the ISA, but
perhaps I'm missing something.

> +	 */
> +	if (!pkey)
> +		return init_val ? -EINVAL : 0;
> +
>  	return __arch_set_user_pkey_access(tsk, pkey, init_val);
>  }
>
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index ba71c54..e7a9e34 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -119,19 +119,21 @@ int pkey_initialize(void)
>  #else
>  	os_reserved = 0;
>  #endif
> -	/*
> -	 * Bits are in LE format. NOTE: 1, 0 are reserved.
> -	 * key 0 is the default key, which allows read/write/execute.
> -	 * key 1 is recommended not to be used. PowerISA(3.0) page 1015,
> -	 * programming note.
> -	 */
> +	/* Bits are in LE format. */
>  	initial_allocation_mask = ~0x0;
>
>  	/* register mask is in BE format */
>  	pkey_amr_uamor_mask = ~0x0ul;
>  	pkey_iamr_mask = ~0x0ul;
>
> -	for (i = 2; i < (pkeys_total - os_reserved); i++) {
> +	for (i = 0; i < (pkeys_total - os_reserved); i++) {
> +	 	/*

There's a space between the tabs here.

> +		 * key 1 is recommended not to be used.
> +		 * PowerISA(3.0) page 1015,
> +		 */
> +		if (i == 1)
> +			continue;
> +
>  		initial_allocation_mask &= ~(0x1 << i);
>  		pkey_amr_uamor_mask &= ~(0x3ul << pkeyshift(i));
>  		pkey_iamr_mask &= ~(0x1ul << pkeyshift(i));
> @@ -145,7 +147,9 @@ void pkey_mm_init(struct mm_struct *mm)
>  {
>  	if (static_branch_likely(&pkey_disabled))
>  		return;
> -	mm_pkey_allocation_map(mm) = initial_allocation_mask;
> +
> +	/* allocate key-0 by default */
> +	mm_pkey_allocation_map(mm) = initial_allocation_mask | 0x1;
>  	/* -1 means unallocated or invalid */
>  	mm->context.execute_only_pkey = -1;
>  }

I think we should also set the AMOR and UAMOR bits for key 0. Otherwise,
key 0 will be in allocated-but-not-enabled state which is yet another
subtle way in which it will be special.

Also, pkey_access_permitted() has a special case for key 0. Should it?

--
Thiago Jung Bauermann
IBM Linux Technology Center
