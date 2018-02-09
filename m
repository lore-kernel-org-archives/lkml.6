Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752931AbeBIVNE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 16:13:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59256 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbeBIVNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 16:13:00 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com
Subject: [PATCH v10 4/7] sched: early boot clock
Date: Fri,  9 Feb 2018 16:11:40 -0500
Message-Id: <20180209211143.16215-5-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209211143.16215-1-pasha.tatashin@oracle.com>
References: <20180209211143.16215-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8800 signatures=668666
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=918
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090267
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow sched_clock() to be used before schec_clock_init() and
sched_clock_init_late() are called. This provides us with a way to get
early boot timestamps on machines with unstable clocks.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 kernel/sched/clock.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index e086babe6c61..8bc603951c2d 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -217,6 +217,11 @@ void clear_sched_clock_stable(void)
  */
 static int __init sched_clock_init_late(void)
 {
+	/* Transition to unstable clock from early clock */
+	local_irq_disable();
+	__gtod_offset = sched_clock() + __sched_clock_offset - ktime_get_ns();
+	local_irq_enable();
+
 	sched_clock_running = 2;
 	/*
 	 * Ensure that it is impossible to not do a static_key update.
@@ -362,8 +367,9 @@ u64 sched_clock_cpu(int cpu)
 	if (sched_clock_stable())
 		return sched_clock() + __sched_clock_offset;
 
-	if (unlikely(!sched_clock_running))
-		return 0ull;
+	/* Use early clock until sched_clock_init_late() */
+	if (unlikely(sched_clock_running < 2))
+		return sched_clock() + __sched_clock_offset;
 
 	preempt_disable_notrace();
 	scd = cpu_sdc(cpu);
-- 
2.16.1
