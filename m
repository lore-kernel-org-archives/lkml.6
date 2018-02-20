Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeBTTig (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 14:38:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752047AbeBTTif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 14:38:35 -0500
Date: Tue, 20 Feb 2018 11:38:50 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xchg/alpha: Add unconditional memory barrier to cmpxchg
Reply-To: paulmck@linux.vnet.ibm.com
References: <1519152356-4804-1-git-send-email-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519152356-4804-1-git-send-email-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022019-0040-0000-0000-000003FA18A9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008565; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992609; UDB=6.00504297; IPR=6.00771955;
 MB=3.00019659; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-20 19:38:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022019-0041-0000-0000-000007FB1DEE
Message-Id: <20180220193850.GV3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=60 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802200235
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 07:45:56PM +0100, Andrea Parri wrote:
> Continuing along with the fight against smp_read_barrier_depends() [1]
> (or rather, against its improper use), add an unconditional barrier to
> cmpxchg.  This guarantees that dependency ordering is preserved when a
> dependency is headed by an unsuccessful cmpxchg.  As it turns out, the
> change could enable further simplification of LKMM as proposed in [2].
> 
> [1] https://marc.info/?l=linux-kernel&m=150884953419377&w=2
>     https://marc.info/?l=linux-kernel&m=150884946319353&w=2
>     https://marc.info/?l=linux-kernel&m=151215810824468&w=2
>     https://marc.info/?l=linux-kernel&m=151215816324484&w=2
> 
> [2] https://marc.info/?l=linux-kernel&m=151881978314872&w=2
> 
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Acked-by: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Acked-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/alpha/include/asm/xchg.h | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/xchg.h b/arch/alpha/include/asm/xchg.h
> index 68dfb3cb71454..e2660866ce972 100644
> --- a/arch/alpha/include/asm/xchg.h
> +++ b/arch/alpha/include/asm/xchg.h
> @@ -128,10 +128,9 @@ ____xchg(, volatile void *ptr, unsigned long x, int size)
>   * store NEW in MEM.  Return the initial value in MEM.  Success is
>   * indicated by comparing RETURN with OLD.
>   *
> - * The memory barrier should be placed in SMP only when we actually
> - * make the change. If we don't change anything (so if the returned
> - * prev is equal to old) then we aren't acquiring anything new and
> - * we don't need any memory barrier as far I can tell.
> + * The memory barrier is placed in SMP unconditionally, in order to
> + * guarantee that dependency ordering is preserved when a dependency
> + * is headed by an unsuccessful operation.
>   */
> 
>  static inline unsigned long
> @@ -150,8 +149,8 @@ ____cmpxchg(_u8, volatile char *m, unsigned char old, unsigned char new)
>  	"	or	%1,%2,%2\n"
>  	"	stq_c	%2,0(%4)\n"
>  	"	beq	%2,3f\n"
> -		__ASM__MB
>  	"2:\n"
> +		__ASM__MB
>  	".subsection 2\n"
>  	"3:	br	1b\n"
>  	".previous"
> @@ -177,8 +176,8 @@ ____cmpxchg(_u16, volatile short *m, unsigned short old, unsigned short new)
>  	"	or	%1,%2,%2\n"
>  	"	stq_c	%2,0(%4)\n"
>  	"	beq	%2,3f\n"
> -		__ASM__MB
>  	"2:\n"
> +		__ASM__MB
>  	".subsection 2\n"
>  	"3:	br	1b\n"
>  	".previous"
> @@ -200,8 +199,8 @@ ____cmpxchg(_u32, volatile int *m, int old, int new)
>  	"	mov %4,%1\n"
>  	"	stl_c %1,%2\n"
>  	"	beq %1,3f\n"
> -		__ASM__MB
>  	"2:\n"
> +		__ASM__MB
>  	".subsection 2\n"
>  	"3:	br 1b\n"
>  	".previous"
> @@ -223,8 +222,8 @@ ____cmpxchg(_u64, volatile long *m, unsigned long old, unsigned long new)
>  	"	mov %4,%1\n"
>  	"	stq_c %1,%2\n"
>  	"	beq %1,3f\n"
> -		__ASM__MB
>  	"2:\n"
> +		__ASM__MB
>  	".subsection 2\n"
>  	"3:	br 1b\n"
>  	".previous"
> -- 
> 2.7.4
> 
