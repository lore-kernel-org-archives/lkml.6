Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753059AbeBIVNs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 16:13:48 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49568 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752904AbeBIVNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 16:13:02 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com
Subject: [PATCH v10 3/7] x86/time: read_boot_clock64() implementation
Date: Fri,  9 Feb 2018 16:11:39 -0500
Message-Id: <20180209211143.16215-4-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209211143.16215-1-pasha.tatashin@oracle.com>
References: <20180209211143.16215-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8800 signatures=668666
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090267
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read_boot_clock64() returns time of when system was started. Now, that
early boot clock is going to be available on x86 it is possible to
implement x86 specific version of read_boot_clock64() that takes advantage
of this new feature.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/time.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index 774ebafa97c4..32dff35719d9 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -15,6 +15,7 @@
 #include <linux/i8253.h>
 #include <linux/time.h>
 #include <linux/export.h>
+#include <linux/sched/clock.h>
 
 #include <asm/vsyscall.h>
 #include <asm/x86_init.h>
@@ -104,3 +105,32 @@ void __init time_init(void)
 {
 	late_time_init = x86_late_time_init;
 }
+
+/*
+ * Called once during to boot to initialize boot time.
+ * This function returns timestamp in timespec format which is sec/nsec from
+ * epoch of when boot started.
+ * We use sched_clock_cpu() that gives us nanoseconds from when this clock has
+ * been started and it happens quiet early during boot process. To calculate
+ * offset from epoch we use information provided in 'now' by the caller
+ *
+ * If sched_clock_cpu() is not available or if there is any kind of error
+ * i.e. time from epoch is smaller than boot time, we must return zeros in ts,
+ * and the caller will take care of the error: by assuming that the time when
+ * this function was called is the beginning of boot time.
+ */
+void __init read_boot_clock64(struct timespec64 *now, struct timespec64 *ts)
+{
+	u64 ns_boot = sched_clock_cpu(smp_processor_id());
+	bool valid_clock;
+	u64 ns_now;
+
+	ns_now = timespec64_to_ns(now);
+	valid_clock = ns_boot && timespec64_valid_strict(now) &&
+			(ns_now > ns_boot);
+
+	if (!valid_clock)
+		*ts = (struct timespec64){0, 0};
+	else
+		*ts = ns_to_timespec64(ns_now - ns_boot);
+}
-- 
2.16.1
