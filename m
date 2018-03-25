Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbeCYTMB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 15:12:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751049AbeCYTL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 15:11:59 -0400
Date: Sun, 25 Mar 2018 12:12:43 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>,
        Christopher Lameter <cl@linux.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rcu: declare rcu_eqs_special_set() in public header
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
 <20180325175004.28162-2-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180325175004.28162-2-ynorov@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18032519-0056-0000-0000-000004328E85
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008742; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01008312; UDB=6.00513550; IPR=6.00787601;
 MB=3.00020235; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-25 19:11:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032519-0057-0000-0000-000008749967
Message-Id: <20180325191243.GH3675@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803250233
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2018 at 08:50:03PM +0300, Yury Norov wrote:
> rcu_eqs_special_set() is declared only in internal header
> kernel/rcu/tree.h and stubbed in include/linux/rcutiny.h.
> 
> This patch declares rcu_eqs_special_set() in include/linux/rcutree.h, so
> it can be used in non-rcu kernel code.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  include/linux/rcutree.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index fd996cdf1833..448f20f27396 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -74,6 +74,7 @@ static inline void synchronize_rcu_bh_expedited(void)
>  void rcu_barrier(void);
>  void rcu_barrier_bh(void);
>  void rcu_barrier_sched(void);
> +bool rcu_eqs_special_set(int cpu);
>  unsigned long get_state_synchronize_rcu(void);
>  void cond_synchronize_rcu(unsigned long oldstate);
>  unsigned long get_state_synchronize_sched(void);

Good point, a bit hard to use otherwise.  ;-)

I removed the declaration from rcutree.h and updated the commit log as
follows.  Does it look OK?

							Thanx, Paul

------------------------------------------------------------------------

commit 4497105b718a819072d48a675916d9d200b5327f
Author: Yury Norov <ynorov@caviumnetworks.com>
Date:   Sun Mar 25 20:50:03 2018 +0300

    rcu: Declare rcu_eqs_special_set() in public header
    
    Because rcu_eqs_special_set() is declared only in internal header
    kernel/rcu/tree.h and stubbed in include/linux/rcutiny.h, it is
    inaccessible outside of the RCU implementation.  This patch therefore
    moves the  rcu_eqs_special_set() declaration to include/linux/rcutree.h,
    which allows it to be used in non-rcu kernel code.
    
    Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index fd996cdf1833..448f20f27396 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -74,6 +74,7 @@ static inline void synchronize_rcu_bh_expedited(void)
 void rcu_barrier(void);
 void rcu_barrier_bh(void);
 void rcu_barrier_sched(void);
+bool rcu_eqs_special_set(int cpu);
 unsigned long get_state_synchronize_rcu(void);
 void cond_synchronize_rcu(unsigned long oldstate);
 unsigned long get_state_synchronize_sched(void);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 59ad0e23c722..d5f617aaa744 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -415,7 +415,6 @@ extern struct rcu_state rcu_preempt_state;
 #endif /* #ifdef CONFIG_PREEMPT_RCU */
 
 int rcu_dynticks_snap(struct rcu_dynticks *rdtp);
-bool rcu_eqs_special_set(int cpu);
 
 #ifdef CONFIG_RCU_BOOST
 DECLARE_PER_CPU(unsigned int, rcu_cpu_kthread_status);
