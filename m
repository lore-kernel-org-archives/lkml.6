Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbeBVVqK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:46:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751330AbeBVVqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:46:07 -0500
Date: Thu, 22 Feb 2018 13:46:25 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Richard Henderson <rth@twiddle.net>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] locking/xchg/alpha: Use smp_mb() in place of
 __ASM__MB
Reply-To: paulmck@linux.vnet.ibm.com
References: <1519291469-5702-1-git-send-email-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519291469-5702-1-git-send-email-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022221-0040-0000-0000-000003FBA110
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008578; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00993612; UDB=6.00504897; IPR=6.00772952;
 MB=3.00019694; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-22 21:46:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022221-0041-0000-0000-000007FCA824
Message-Id: <20180222214625.GM2855@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220269
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 10:24:29AM +0100, Andrea Parri wrote:
> Replace each occurrence of __ASM__MB with a (trailing) smp_mb() in
> xchg(), cmpxchg(), and remove the now unused __ASM__MB definitions;
> this improves readability, with no additional synchronization cost.
> 
> Suggested-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

I am a bit confused by the use of out-of-line branches to do a backwards
branch, but those were in place to start with.  Maybe the point is to
defeat backwards-branch prediction or some such.

Regardless...

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/alpha/include/asm/cmpxchg.h |  6 ------
>  arch/alpha/include/asm/xchg.h    | 16 ++++++++--------
>  2 files changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
> index 46ebf14aed4e5..8a2b331e43feb 100644
> --- a/arch/alpha/include/asm/cmpxchg.h
> +++ b/arch/alpha/include/asm/cmpxchg.h
> @@ -6,7 +6,6 @@
>   * Atomic exchange routines.
>   */
> 
> -#define __ASM__MB
>  #define ____xchg(type, args...)		__xchg ## type ## _local(args)
>  #define ____cmpxchg(type, args...)	__cmpxchg ## type ## _local(args)
>  #include <asm/xchg.h>
> @@ -33,10 +32,6 @@
>  	cmpxchg_local((ptr), (o), (n));					\
>  })
> 
> -#ifdef CONFIG_SMP
> -#undef __ASM__MB
> -#define __ASM__MB	"\tmb\n"
> -#endif
>  #undef ____xchg
>  #undef ____cmpxchg
>  #define ____xchg(type, args...)		__xchg ##type(args)
> @@ -64,7 +59,6 @@
>  	cmpxchg((ptr), (o), (n));					\
>  })
> 
> -#undef __ASM__MB
>  #undef ____cmpxchg
> 
>  #endif /* _ALPHA_CMPXCHG_H */
> diff --git a/arch/alpha/include/asm/xchg.h b/arch/alpha/include/asm/xchg.h
> index e2660866ce972..e1facf6fc2446 100644
> --- a/arch/alpha/include/asm/xchg.h
> +++ b/arch/alpha/include/asm/xchg.h
> @@ -28,12 +28,12 @@ ____xchg(_u8, volatile char *m, unsigned long val)
>  	"	or	%1,%2,%2\n"
>  	"	stq_c	%2,0(%3)\n"
>  	"	beq	%2,2f\n"
> -		__ASM__MB
>  	".subsection 2\n"
>  	"2:	br	1b\n"
>  	".previous"
>  	: "=&r" (ret), "=&r" (val), "=&r" (tmp), "=&r" (addr64)
>  	: "r" ((long)m), "1" (val) : "memory");
> +	smp_mb();
> 
>  	return ret;
>  }
> @@ -52,12 +52,12 @@ ____xchg(_u16, volatile short *m, unsigned long val)
>  	"	or	%1,%2,%2\n"
>  	"	stq_c	%2,0(%3)\n"
>  	"	beq	%2,2f\n"
> -		__ASM__MB
>  	".subsection 2\n"
>  	"2:	br	1b\n"
>  	".previous"
>  	: "=&r" (ret), "=&r" (val), "=&r" (tmp), "=&r" (addr64)
>  	: "r" ((long)m), "1" (val) : "memory");
> +	smp_mb();
> 
>  	return ret;
>  }
> @@ -72,12 +72,12 @@ ____xchg(_u32, volatile int *m, unsigned long val)
>  	"	bis $31,%3,%1\n"
>  	"	stl_c %1,%2\n"
>  	"	beq %1,2f\n"
> -		__ASM__MB
>  	".subsection 2\n"
>  	"2:	br 1b\n"
>  	".previous"
>  	: "=&r" (val), "=&r" (dummy), "=m" (*m)
>  	: "rI" (val), "m" (*m) : "memory");
> +	smp_mb();
> 
>  	return val;
>  }
> @@ -92,12 +92,12 @@ ____xchg(_u64, volatile long *m, unsigned long val)
>  	"	bis $31,%3,%1\n"
>  	"	stq_c %1,%2\n"
>  	"	beq %1,2f\n"
> -		__ASM__MB
>  	".subsection 2\n"
>  	"2:	br 1b\n"
>  	".previous"
>  	: "=&r" (val), "=&r" (dummy), "=m" (*m)
>  	: "rI" (val), "m" (*m) : "memory");
> +	smp_mb();
> 
>  	return val;
>  }
> @@ -150,12 +150,12 @@ ____cmpxchg(_u8, volatile char *m, unsigned char old, unsigned char new)
>  	"	stq_c	%2,0(%4)\n"
>  	"	beq	%2,3f\n"
>  	"2:\n"
> -		__ASM__MB
>  	".subsection 2\n"
>  	"3:	br	1b\n"
>  	".previous"
>  	: "=&r" (prev), "=&r" (new), "=&r" (tmp), "=&r" (cmp), "=&r" (addr64)
>  	: "r" ((long)m), "Ir" (old), "1" (new) : "memory");
> +	smp_mb();
> 
>  	return prev;
>  }
> @@ -177,12 +177,12 @@ ____cmpxchg(_u16, volatile short *m, unsigned short old, unsigned short new)
>  	"	stq_c	%2,0(%4)\n"
>  	"	beq	%2,3f\n"
>  	"2:\n"
> -		__ASM__MB
>  	".subsection 2\n"
>  	"3:	br	1b\n"
>  	".previous"
>  	: "=&r" (prev), "=&r" (new), "=&r" (tmp), "=&r" (cmp), "=&r" (addr64)
>  	: "r" ((long)m), "Ir" (old), "1" (new) : "memory");
> +	smp_mb();
> 
>  	return prev;
>  }
> @@ -200,12 +200,12 @@ ____cmpxchg(_u32, volatile int *m, int old, int new)
>  	"	stl_c %1,%2\n"
>  	"	beq %1,3f\n"
>  	"2:\n"
> -		__ASM__MB
>  	".subsection 2\n"
>  	"3:	br 1b\n"
>  	".previous"
>  	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
>  	: "r"((long) old), "r"(new), "m"(*m) : "memory");
> +	smp_mb();
> 
>  	return prev;
>  }
> @@ -223,12 +223,12 @@ ____cmpxchg(_u64, volatile long *m, unsigned long old, unsigned long new)
>  	"	stq_c %1,%2\n"
>  	"	beq %1,3f\n"
>  	"2:\n"
> -		__ASM__MB
>  	".subsection 2\n"
>  	"3:	br 1b\n"
>  	".previous"
>  	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
>  	: "r"((long) old), "r"(new), "m"(*m) : "memory");
> +	smp_mb();
> 
>  	return prev;
>  }
> -- 
> 2.7.4
> 
