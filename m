Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeC0BEK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 21:04:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751866AbeC0BEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 21:04:08 -0400
Date: Mon, 26 Mar 2018 18:03:53 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
        aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
        hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
        fweimer@redhat.com, msuchanek@suse.com, tglx@linutronix.de,
        shuah@kernel.org
Subject: Re: [PATCH] powerpc, pkey: make protection key 0 less special
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1522107101-16083-1-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522107101-16083-1-git-send-email-linuxram@us.ibm.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18032701-0040-0000-0000-0000042735FC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032701-0041-0000-0000-0000262A4BD4
Message-Id: <20180327010353.GC5743@ram.oc3035372033.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-26_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803270010
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 04:31:41PM -0700, Ram Pai wrote:
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
> 
> Tested on powerpc.

This patch is not entirely correct.
> 
> cc: Thomas Gleixner <tglx@linutronix.de>
> cc: Dave Hansen <dave.hansen@intel.com>
> cc: Michael Ellermen <mpe@ellerman.id.au>
> cc: Ingo Molnar <mingo@kernel.org>
> cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/pkeys.h | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 0409c80..9c7d3bd 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -101,10 +101,18 @@ static inline u16 pte_to_pkey_bits(u64 pteflags)
> 
>  static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
>  {
> -	/* A reserved key is never considered as 'explicitly allocated' */
> -	return ((pkey < arch_max_pkey()) &&
> -		!__mm_pkey_is_reserved(pkey) &&
> -		__mm_pkey_is_allocated(mm, pkey));
> +	/* pkey 0 is allocated by default. */
> +	if (!pkey)
> +		return true;

This is wrong. pkey-0 should not be treated any special here. Will fix
this and send a new patch. Sorry for the noise.

RP
