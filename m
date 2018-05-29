Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933475AbeE2MDJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:03:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933357AbeE2MDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:03:06 -0400
Date: Tue, 29 May 2018 05:04:43 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] kernel/SRCU: provide a static initializer
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180525101958.13277-1-bigeasy@linutronix.de>
 <20180525101958.13277-2-bigeasy@linutronix.de>
 <CAJZ5v0jEUR7YxzujvZn8WVK+dMxmOxoHNiLKcmgCq9awHR=vYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jEUR7YxzujvZn8WVK+dMxmOxoHNiLKcmgCq9awHR=vYg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052912-0056-0000-0000-00000459230A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009096; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039349; UDB=6.00530875; IPR=6.00818478;
 MB=3.00021357; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-29 12:03:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052912-0057-0000-0000-0000089D4736
Message-Id: <20180529120443.GE3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290138
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:09:51AM +0200, Rafael J. Wysocki wrote:
> On Fri, May 25, 2018 at 12:19 PM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > There are macros for static initializer for the three out of four
> > possible notifier types, that are:
> >         ATOMIC_NOTIFIER_HEAD()
> >         BLOCKING_NOTIFIER_HEAD()
> >         RAW_NOTIFIER_HEAD()
> >
> > This patch provides a static initilizer for the forth type to make it
> > complete.
> >
> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> I cannot apply this without an ACK from Paul.

I have both queued, but if you would prefer to take them, then for the
SRCU piece:

Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

							Thanx, Paul

> > ---
> >  include/linux/notifier.h | 34 +++++++++++++++++++++++++++++-----
> >  include/linux/srcutiny.h |  6 +++---
> >  include/linux/srcutree.h |  6 +++---
> >  3 files changed, 35 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/notifier.h b/include/linux/notifier.h
> > index 6d731110e0db..f35c7bf76143 100644
> > --- a/include/linux/notifier.h
> > +++ b/include/linux/notifier.h
> > @@ -43,9 +43,7 @@
> >   * in srcu_notifier_call_chain(): no cache bounces and no memory barriers.
> >   * As compensation, srcu_notifier_chain_unregister() is rather expensive.
> >   * SRCU notifier chains should be used when the chain will be called very
> > - * often but notifier_blocks will seldom be removed.  Also, SRCU notifier
> > - * chains are slightly more difficult to use because they require special
> > - * runtime initialization.
> > + * often but notifier_blocks will seldom be removed.
> >   */
> >
> >  struct notifier_block;
> > @@ -91,7 +89,7 @@ struct srcu_notifier_head {
> >                 (name)->head = NULL;            \
> >         } while (0)
> >
> > -/* srcu_notifier_heads must be initialized and cleaned up dynamically */
> > +/* srcu_notifier_heads must be cleaned up dynamically */
> >  extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
> >  #define srcu_cleanup_notifier_head(name)       \
> >                 cleanup_srcu_struct(&(name)->srcu);
> > @@ -104,7 +102,13 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
> >                 .head = NULL }
> >  #define RAW_NOTIFIER_INIT(name)        {                               \
> >                 .head = NULL }
> > -/* srcu_notifier_heads cannot be initialized statically */
> > +
> > +#define SRCU_NOTIFIER_INIT(name, pcpu)                         \
> > +       {                                                       \
> > +               .mutex = __MUTEX_INITIALIZER(name.mutex),       \
> > +               .head = NULL,                                   \
> > +               .srcu = __SRCU_STRUCT_INIT(name.srcu, pcpu),    \
> > +       }
> >
> >  #define ATOMIC_NOTIFIER_HEAD(name)                             \
> >         struct atomic_notifier_head name =                      \
> > @@ -116,6 +120,26 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
> >         struct raw_notifier_head name =                         \
> >                 RAW_NOTIFIER_INIT(name)
> >
> > +#ifdef CONFIG_TREE_SRCU
> > +#define _SRCU_NOTIFIER_HEAD(name, mod)                         \
> > +       static DEFINE_PER_CPU(struct srcu_data,                 \
> > +                       name##_head_srcu_data);                 \
> > +       mod struct srcu_notifier_head name =                    \
> > +                       SRCU_NOTIFIER_INIT(name, name##_head_srcu_data)
> > +
> > +#else
> > +#define _SRCU_NOTIFIER_HEAD(name, mod)                         \
> > +       mod struct srcu_notifier_head name =                    \
> > +                       SRCU_NOTIFIER_INIT(name, name)
> > +
> > +#endif
> > +
> > +#define SRCU_NOTIFIER_HEAD(name)                               \
> > +       _SRCU_NOTIFIER_HEAD(name, /* not static */)
> > +
> > +#define SRCU_NOTIFIER_HEAD_STATIC(name)                                \
> > +       _SRCU_NOTIFIER_HEAD(name, static)
> > +
> >  #ifdef __KERNEL__
> >
> >  extern int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
> > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > index 261471f407a5..f41d2fb09f87 100644
> > --- a/include/linux/srcutiny.h
> > +++ b/include/linux/srcutiny.h
> > @@ -43,7 +43,7 @@ struct srcu_struct {
> >
> >  void srcu_drive_gp(struct work_struct *wp);
> >
> > -#define __SRCU_STRUCT_INIT(name)                                       \
> > +#define __SRCU_STRUCT_INIT(name, __ignored)                            \
> >  {                                                                      \
> >         .srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),        \
> >         .srcu_cb_tail = &name.srcu_cb_head,                             \
> > @@ -56,9 +56,9 @@ void srcu_drive_gp(struct work_struct *wp);
> >   * Tree SRCU, which needs some per-CPU data.
> >   */
> >  #define DEFINE_SRCU(name) \
> > -       struct srcu_struct name = __SRCU_STRUCT_INIT(name)
> > +       struct srcu_struct name = __SRCU_STRUCT_INIT(name, name)
> >  #define DEFINE_STATIC_SRCU(name) \
> > -       static struct srcu_struct name = __SRCU_STRUCT_INIT(name)
> > +       static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name)
> >
> >  void synchronize_srcu(struct srcu_struct *sp);
> >
> > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > index 4eda108abee0..745d4ca4dd50 100644
> > --- a/include/linux/srcutree.h
> > +++ b/include/linux/srcutree.h
> > @@ -104,9 +104,9 @@ struct srcu_struct {
> >  #define SRCU_STATE_SCAN1       1
> >  #define SRCU_STATE_SCAN2       2
> >
> > -#define __SRCU_STRUCT_INIT(name)                                       \
> > +#define __SRCU_STRUCT_INIT(name, pcpu_name)                            \
> >         {                                                               \
> > -               .sda = &name##_srcu_data,                               \
> > +               .sda = &pcpu_name,                                      \
> >                 .lock = __SPIN_LOCK_UNLOCKED(name.lock),                \
> >                 .srcu_gp_seq_needed = 0 - 1,                            \
> >                 __SRCU_DEP_MAP_INIT(name)                               \
> > @@ -133,7 +133,7 @@ struct srcu_struct {
> >   */
> >  #define __DEFINE_SRCU(name, is_static)                                 \
> >         static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);\
> > -       is_static struct srcu_struct name = __SRCU_STRUCT_INIT(name)
> > +       is_static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name##_srcu_data)
> >  #define DEFINE_SRCU(name)              __DEFINE_SRCU(name, /* not static */)
> >  #define DEFINE_STATIC_SRCU(name)       __DEFINE_SRCU(name, static)
> >
> > --
> > 2.17.0
> >
> 
