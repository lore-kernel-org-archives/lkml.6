Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeCYVd4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 17:33:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44327 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeCYVdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 17:33:53 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Rik van Riel <riel@surriel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
Date: Sun, 25 Mar 2018 23:34:14 +0200
Message-ID: <5810003.D8QGLjubHr@aspire.rjw.lan>
In-Reply-To: <1522008952.6308.46.camel@surriel.com>
References: <3111105.SmgpqUHPkp@aspire.rjw.lan> <4731938.EeADOapqQb@aspire.rjw.lan> <1522008952.6308.46.camel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, March 25, 2018 10:15:52 PM CEST Rik van Riel wrote:
> 
> --=-e8yLbs0aoH4SrxOskwwl
> Content-Type: text/plain; charset="UTF-8"
> Content-Transfer-Encoding: quoted-printable
> 
> On Thu, 2018-03-22 at 18:09 +0100, Rafael J. Wysocki wrote:
> >=20
> > +++ linux-pm/drivers/cpuidle/poll_state.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/sched/idle.h>
> > =20
> >  #define POLL_IDLE_TIME_LIMIT	(TICK_NSEC / 16)
> > +#define POLL_IDLE_COUNT		1000
> > =20
> >  static int __cpuidle poll_idle(struct cpuidle_device *dev,
> >  			       struct cpuidle_driver *drv, int
> > index)
> > @@ -18,9 +19,14 @@ static int __cpuidle poll_idle(struct cp
> > =20
> >  	local_irq_enable();
> >  	if (!current_set_polling_and_test()) {
> > +		unsigned int loop_count =3D 0;
> > +
> >  		while (!need_resched()) {
> >  			cpu_relax();
> > +			if (loop_count++ < POLL_IDLE_COUNT)
> > +				continue;
> > =20
> > +			loop_count =3D 0;
> >  			if (local_clock() - time_start >
> > POLL_IDLE_TIME_LIMIT)
> >  				break;
> >  		}
> 
> OK, I am still seeing a performance
> degradation with the above, though
> not throughout the entire workload.
> 
> It appears that making the idle loop
> do anything besides cpu_relax() for
> a significant amount of time slows
> things down.

I see.

> I plan to try two more things:
> 
> 1) Disable polling on SMT systems, with
>    the idea that putting one thread to
>    sleep with monitor/mwait in C1 will
>    allow the other thread to run faster.

Sounds plausible.

> 2) Insert more cpu_relax() calls into the
>    main loop, so the CPU core spends more
>    of its time in cpu_relax() and less
>    time doing other things:

Well, maybe it's a matter of doing cpu_relax() between any other bits of
significant computation in there:


---
 drivers/cpuidle/poll_state.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/poll_state.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/poll_state.c
+++ linux-pm/drivers/cpuidle/poll_state.c
@@ -10,6 +10,7 @@
 #include <linux/sched/idle.h>
 
 #define POLL_IDLE_TIME_LIMIT	(TICK_NSEC / 16)
+#define POLL_IDLE_COUNT		200
 
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
@@ -18,11 +19,21 @@ static int __cpuidle poll_idle(struct cp
 
 	local_irq_enable();
 	if (!current_set_polling_and_test()) {
+		unsigned int loop_count = 0;
+
 		while (!need_resched()) {
 			cpu_relax();
-
+			if (loop_count++ < POLL_IDLE_COUNT) {
+				cpu_relax();
+				continue;
+			}
+			cpu_relax();
+			loop_count = 0;
+			cpu_relax();
 			if (local_clock() - time_start > POLL_IDLE_TIME_LIMIT)
 				break;
+
+			cpu_relax();
 		}
 	}
 	current_clr_polling();
