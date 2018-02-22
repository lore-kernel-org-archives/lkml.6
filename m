Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeBVVrA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:47:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751484AbeBVVqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:46:49 -0500
Date: Thu, 22 Feb 2018 13:47:08 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Richard Henderson <rth@twiddle.net>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] locking/xchg/alpha: Add leading smp_mb() to xchg(),
 cmpxchg()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1519291488-5752-1-git-send-email-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519291488-5752-1-git-send-email-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022221-0040-0000-0000-000003FBA11A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008578; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00993612; UDB=6.00504898; IPR=6.00772952;
 MB=3.00019694; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-22 21:46:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022221-0041-0000-0000-000007FCA82E
Message-Id: <20180222214708.GN2855@linux.vnet.ibm.com>
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

On Thu, Feb 22, 2018 at 10:24:48AM +0100, Andrea Parri wrote:
> Successful RMW operations are supposed to be fully ordered, but
> Alpha's xchg() and cmpxchg() do not align to this requirement.
> 
> Will reported that:
> 
> > So MP using xchg:
> >
> > WRITE_ONCE(x, 1)
> > xchg(y, 1)
> >
> > smp_load_acquire(y) == 1
> > READ_ONCE(x) == 0
> >
> > would be allowed.
> 
> (thus violating the above requirement).  Amend this by adding a
> leading smp_mb() to the implementations of xchg(), cmpxchg().
> 
> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

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
>  arch/alpha/include/asm/xchg.h | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/xchg.h b/arch/alpha/include/asm/xchg.h
> index e1facf6fc2446..e2b59fac5257d 100644
> --- a/arch/alpha/include/asm/xchg.h
> +++ b/arch/alpha/include/asm/xchg.h
> @@ -12,6 +12,10 @@
>   * Atomic exchange.
>   * Since it can be used to implement critical sections
>   * it must clobber "memory" (also for interrupts in UP).
> + *
> + * The leading and the trailing memory barriers guarantee that these
> + * operations are fully ordered.
> + *
>   */
> 
>  static inline unsigned long
> @@ -19,6 +23,7 @@ ____xchg(_u8, volatile char *m, unsigned long val)
>  {
>  	unsigned long ret, tmp, addr64;
> 
> +	smp_mb();
>  	__asm__ __volatile__(
>  	"	andnot	%4,7,%3\n"
>  	"	insbl	%1,%4,%1\n"
> @@ -43,6 +48,7 @@ ____xchg(_u16, volatile short *m, unsigned long val)
>  {
>  	unsigned long ret, tmp, addr64;
> 
> +	smp_mb();
>  	__asm__ __volatile__(
>  	"	andnot	%4,7,%3\n"
>  	"	inswl	%1,%4,%1\n"
> @@ -67,6 +73,7 @@ ____xchg(_u32, volatile int *m, unsigned long val)
>  {
>  	unsigned long dummy;
> 
> +	smp_mb();
>  	__asm__ __volatile__(
>  	"1:	ldl_l %0,%4\n"
>  	"	bis $31,%3,%1\n"
> @@ -87,6 +94,7 @@ ____xchg(_u64, volatile long *m, unsigned long val)
>  {
>  	unsigned long dummy;
> 
> +	smp_mb();
>  	__asm__ __volatile__(
>  	"1:	ldq_l %0,%4\n"
>  	"	bis $31,%3,%1\n"
> @@ -128,9 +136,12 @@ ____xchg(, volatile void *ptr, unsigned long x, int size)
>   * store NEW in MEM.  Return the initial value in MEM.  Success is
>   * indicated by comparing RETURN with OLD.
>   *
> - * The memory barrier is placed in SMP unconditionally, in order to
> - * guarantee that dependency ordering is preserved when a dependency
> - * is headed by an unsuccessful operation.
> + * The leading and the trailing memory barriers guarantee that these
> + * operations are fully ordered.
> + *
> + * The trailing memory barrier is placed in SMP unconditionally, in
> + * order to guarantee that dependency ordering is preserved when a
> + * dependency is headed by an unsuccessful operation.
>   */
> 
>  static inline unsigned long
> @@ -138,6 +149,7 @@ ____cmpxchg(_u8, volatile char *m, unsigned char old, unsigned char new)
>  {
>  	unsigned long prev, tmp, cmp, addr64;
> 
> +	smp_mb();
>  	__asm__ __volatile__(
>  	"	andnot	%5,7,%4\n"
>  	"	insbl	%1,%5,%1\n"
> @@ -165,6 +177,7 @@ ____cmpxchg(_u16, volatile short *m, unsigned short old, unsigned short new)
>  {
>  	unsigned long prev, tmp, cmp, addr64;
> 
> +	smp_mb();
>  	__asm__ __volatile__(
>  	"	andnot	%5,7,%4\n"
>  	"	inswl	%1,%5,%1\n"
> @@ -192,6 +205,7 @@ ____cmpxchg(_u32, volatile int *m, int old, int new)
>  {
>  	unsigned long prev, cmp;
> 
> +	smp_mb();
>  	__asm__ __volatile__(
>  	"1:	ldl_l %0,%5\n"
>  	"	cmpeq %0,%3,%1\n"
> @@ -215,6 +229,7 @@ ____cmpxchg(_u64, volatile long *m, unsigned long old, unsigned long new)
>  {
>  	unsigned long prev, cmp;
> 
> +	smp_mb();
>  	__asm__ __volatile__(
>  	"1:	ldq_l %0,%5\n"
>  	"	cmpeq %0,%3,%1\n"
> -- 
> 2.7.4
> 
