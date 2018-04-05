Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeDEILs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 04:11:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:55355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751249AbeDEILo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 04:11:44 -0400
Message-ID: <1522915882.5593.3.camel@gmx.de>
Subject: Re: sched_rt_period_timer causing large latencies
From: Mike Galbraith <efault@gmx.de>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 05 Apr 2018 10:11:22 +0200
In-Reply-To: <20180405174405.175008c7@roar.ozlabs.ibm.com>
References: <20180405091138.6ef14d15@roar.ozlabs.ibm.com>
         <1522910817.8945.1.camel@gmx.de>
         <20180405174405.175008c7@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:o+rK4xix4me3DhT4uxl6oK1lgx5hz5vPOx8N0BqV5+5pXU0HXYH
 Zbz36965CF8dEcOrDgJ3fkETF5extdwB0meMZjkbHNimMzCwhyubLS4EZMCUuxBGRcyrAH0
 +aXohSZfNEWdrcCI91Gc7Df26AyR+50Hn8jeySegvb1TyO/nU7+KTQVh5mDZ0h1cO9bPBlk
 ltihPa3fr9vBaTiNEykIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dtm/0HXnNgE=:SxdXRvY1K2KP76X2m3WiFf
 IrnIz5twiWliueGmUuHX4K5fgQAPgG/BiHeEEl4sHnsj2lIJhjgY2NwYJMY7Q2rLNGI1ZPU3U
 S6HB54JBS48tLYS2K1tqIdujolxDJrfHXFThpj+BIoDoXFaY9o4AezidvF6LvcTYRUxedt4PW
 /JhvaebPOuFHdReywN53bp0YGEu/j1inG8zE0LaLYoBPOM5oNKqMkxz9+G9PPknpoJmng1YHq
 WZKGlpjgziVsv1njXcr0owZKKgSTvXG4iEBBV4sBePpoXNDPN9eCA+pjeG+OW3IZJXS8vMUot
 hoopgiEC8sz1kpkwDiSJfSN0KCfQzJ/DoxEX37dELQI8qYgigrw4hSiQf4XtSruckvvIZPmrh
 jijzDLx4Cwf6e9uqmDiwDpMDADaxkaqk61w+r/sYf0eeY8iYVCBOkKk5s+hJ3uEmnU3RhMDhb
 t70yWTpU3s9y/1tjcUXVC9wvEGFsHWFDe81fRhSPewwhlmw6l+ysxR1T0MGR76TKTsXejJ4gP
 huaE4/XXXVNQjFu4jvTJl2MteRnS2y3m587HbrvBNK8lwjKEMTXV63cPzRecIAYTENz5uDLUS
 fi9Js+tsciwghWrRE8paIy3yChZ/V1jqD7lqrKOQoBJjUJzYjYtgKOF+oNJ2MpicULXHtHqKI
 6S8vcyPMIx8KF1KmHeUzhJx3OvQDJpPPFbOqn4X/RgnFYT6Lzs/MD2l8ZvVHNrcP3BzGDbPfm
 OYOpsTPQtro4w6dO0L0MVJ2JTmioe9ehAI9dOX+QolCLY5Woymide/RCne+O/jhwxRDqEj9Lc
 OVz+bAxxvNKBqOMdEyljzlw3PE6gV0FipMTlnPMV76pcdRlEsI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-05 at 17:44 +1000, Nicholas Piggin wrote:
> 
> > My method of dealing with the throttle beast from hell for ~big box RT
> > is to stomp it flat during boot, as otherwise jitter is awful.
> 
> How do you stomp it flat?

With a size 12 boot originally from SGI.  Their extra hairy beasts
tended to grind themselves to fine powder.

---
 Documentation/admin-guide/kernel-parameters.txt |    2 ++
 kernel/sched/core.c                             |   11 +++++++++++
 2 files changed, 13 insertions(+)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2788,6 +2788,8 @@
 	noresume	[SWSUSP] Disables resume and restores original swap
 			space.
 
+	nortsched       [KNL] Disables realtime task bandwidth control.
+
 	no-scroll	[VGA] Disables scrollback.
 			This is required for the Braillex ib80-piezo Braille
 			reader made by F.H. Papenmeier (Germany).
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7091,3 +7091,14 @@ const u32 sched_prio_to_wmult[40] = {
 };
 
 #undef CREATE_TRACE_POINTS
+
+/*
+ * Bootline option to disable sched_rt_runtime.
+ */
+static int __init parse_nortsched(char *arg)
+{
+	sysctl_sched_rt_runtime = -1;
+	return 0;
+}
+early_param("nortsched", parse_nortsched);
+

> If there could be some basic detection for throttling on a per-CPU
> basis before invoking the best from hell, would that be possible to
> move this out of normal paths?

It's one beast mauling the entire box, that's the problem.  I just
consider it a debugging tool, and turn it off (if it kicks in, the RT
game was already over).  RT disables RT group scheduling, so I don't
have to care about that evilness.

> Alternatively I think most/all of the RT runtime is coming from
> kernel threads, could they be exempted so this doesn't hit? Although
> it would be sad to suddenly inflict these latencies on someone who
> starts up an RT program :)

Yup, very sad.  It should probably become percpu.

	-Mike
