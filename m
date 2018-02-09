Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753109AbeBIVOA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 16:14:00 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55800 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752888AbeBIVN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 16:13:58 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com
Subject: [PATCH v10 2/7] time: sync read_boot_clock64() with persistent clock
Date: Fri,  9 Feb 2018 16:11:38 -0500
Message-Id: <20180209211143.16215-3-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209211143.16215-1-pasha.tatashin@oracle.com>
References: <20180209211143.16215-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8800 signatures=668666
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090268
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read_boot_clock64() returns a boot start timestamp from epoch. Some arches
may need to access the persistent clock interface in order to calculate the
epoch offset. The resolution of the persistent clock, however, might be
low.  Therefore, in order to avoid time discrepancies a new argument 'now'
is added to read_boot_clock64() parameters. Arch may decide to use it
instead of accessing persistent clock again.

Also, change read_boot_clock64() to have __init prototype since it is
accessed only during boot.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/arm/kernel/time.c      | 2 +-
 arch/s390/kernel/time.c     | 2 +-
 include/linux/timekeeping.h | 3 +--
 kernel/time/timekeeping.c   | 8 ++++++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 629f8e9981f1..5b259261a268 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -90,7 +90,7 @@ void read_persistent_clock64(struct timespec64 *ts)
 	__read_persistent_clock(ts);
 }
 
-void read_boot_clock64(struct timespec64 *ts)
+void __init read_boot_clock64(struct timespec64 *now, struct timespec64 *ts)
 {
 	__read_boot_clock(ts);
 }
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index cf561160ea88..9b0c69e3d795 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -221,7 +221,7 @@ void read_persistent_clock64(struct timespec64 *ts)
 	ext_to_timespec64(clk, ts);
 }
 
-void read_boot_clock64(struct timespec64 *ts)
+void __init read_boot_clock64(struct timespec64 *now, struct timespec64 *ts)
 {
 	unsigned char clk[STORE_CLOCK_EXT_SIZE];
 	__u64 delta;
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index b17bcce58bc4..b251fc226c00 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -206,8 +206,7 @@ extern void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot);
 extern int persistent_clock_is_local;
 
 extern void read_persistent_clock64(struct timespec64 *ts);
-extern void read_boot_clock64(struct timespec64 *ts);
+extern void read_boot_clock64(struct timespec64 *now, struct timespec64 *ts);
 extern int update_persistent_clock64(struct timespec64 now);
 
-
 #endif
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index cd03317e7b57..6894b4841b2e 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1501,9 +1501,13 @@ void __weak read_persistent_clock64(struct timespec64 *ts64)
  * Function to read the exact time the system has been started.
  * Returns a timespec64 with tv_sec=0 and tv_nsec=0 if unsupported.
  *
+ * Argument 'now' contains time from persistent clock to calculate offset from
+ * epoch. May contain zeros if persist ant clock is not available.
+ *
  *  XXX - Do be sure to remove it once all arches implement it.
  */
-void __weak read_boot_clock64(struct timespec64 *ts)
+void __weak __init read_boot_clock64(struct timespec64 *now,
+				     struct timespec64 *ts)
 {
 	ts->tv_sec = 0;
 	ts->tv_nsec = 0;
@@ -1534,7 +1538,7 @@ void __init timekeeping_init(void)
 	} else if (now.tv_sec || now.tv_nsec)
 		persistent_clock_exists = true;
 
-	read_boot_clock64(&boot);
+	read_boot_clock64(&now, &boot);
 	if (!timespec64_valid_strict(&boot)) {
 		pr_warn("WARNING: Boot clock returned invalid value!\n"
 			"         Check your CMOS/BIOS settings.\n");
-- 
2.16.1
