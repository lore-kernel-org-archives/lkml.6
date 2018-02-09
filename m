Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbeBIVNG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 16:13:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49562 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbeBIVNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 16:13:02 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com
Subject: [PATCH v10 5/7] x86/paravirt: add active_sched_clock to pv_time_ops
Date: Fri,  9 Feb 2018 16:11:41 -0500
Message-Id: <20180209211143.16215-6-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209211143.16215-1-pasha.tatashin@oracle.com>
References: <20180209211143.16215-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8800 signatures=668666
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=819
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090267
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early boot clock might differ from the clock that is used later on,
therefore add a new field to pv_time_ops, that shows currently active
clock. If platform supports early boot clock, this field will be changed
to use that clock early in boot, and later will be replaced with the
permanent clock.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/paravirt_types.h | 1 +
 arch/x86/kernel/paravirt.c            | 1 +
 arch/x86/xen/time.c                   | 7 ++++---
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 6ec54d01972d..96518f027c15 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -98,6 +98,7 @@ struct pv_lazy_ops {
 struct pv_time_ops {
 	unsigned long long (*sched_clock)(void);
 	unsigned long long (*steal_clock)(int cpu);
+	unsigned long long (*active_sched_clock)(void);
 } __no_randomize_layout;
 
 struct pv_cpu_ops {
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 041096bdef86..91af9e6b913b 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -320,6 +320,7 @@ struct pv_init_ops pv_init_ops = {
 struct pv_time_ops pv_time_ops = {
 	.sched_clock = native_sched_clock,
 	.steal_clock = native_steal_clock,
+	.active_sched_clock = native_sched_clock,
 };
 
 __visible struct pv_irq_ops pv_irq_ops = {
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 29163c43ebbd..d1a5f96893c8 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -505,8 +505,8 @@ static void __init xen_time_init(void)
 
 void __ref xen_init_time_ops(void)
 {
-	pv_time_ops = xen_time_ops;
-
+	pv_time_ops.sched_clock = xen_time_ops.sched_clock;
+	pv_time_ops.steal_clock = xen_time_ops.steal_clock;
 	x86_init.timers.timer_init = xen_time_init;
 	x86_init.timers.setup_percpu_clockev = x86_init_noop;
 	x86_cpuinit.setup_percpu_clockev = x86_init_noop;
@@ -547,7 +547,8 @@ void __init xen_hvm_init_time_ops(void)
 		return;
 	}
 
-	pv_time_ops = xen_time_ops;
+	pv_time_ops.sched_clock = xen_time_ops.sched_clock;
+	pv_time_ops.steal_clock = xen_time_ops.steal_clock;
 	x86_init.timers.setup_percpu_clockev = xen_time_init;
 	x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;
 
-- 
2.16.1
