Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75FEC282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71769217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nzdLxuQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfAWBzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:55:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58226 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfAWBzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 20:55:49 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0N1sOJW129178;
        Wed, 23 Jan 2019 01:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=0KcFEA4zMpugzkxUwFItX9K8xP98p9bxCb0gztGBazc=;
 b=nzdLxuQ2GL8MWrg84L4B1p65zMKrfoXhR7TIWYueZTdR4TqGfk02GiyQgcM6L/gu3w/A
 V0vQ15yp0M2wxEb8gEvtGrWBZKjtWtM4i4JbUhuEAl7wzbRSXQGuxwx+NV0zR+3bF2K0
 Z6ykY6j8m5w9n9jIs0nvB3PskJBd0LpQidj/HIWlXDLV4Uo9c093AwkOyIR5ylNZyM+M
 Z8cnd8Z6EVaY4lx+AfmX+LH3m6xXUUzsFRdn3yIy1GtUeU+imivT9DmiFagDwP8babWu
 H87M4fIg7p6BGDc81M/GpLzzEW5Qvo57RXC3QxOdEQyq5neKfpf3Cind0RSdGXZHzZ4S Vg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2q3uauq4mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 01:55:35 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0N1tUMH012798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 01:55:30 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0N1tTR8023814;
        Wed, 23 Jan 2019 01:55:29 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Jan 2019 17:55:29 -0800
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: [PATCH] acpi_pm: Reduce PMTMR counter read contention
Date:   Tue, 22 Jan 2019 15:23:27 +0800
Message-Id: <1548141807-25825-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=906
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a large system with many CPUs, using PMTMR as the clock source can
have a significant impact on the overall system performance because
of the following reasons:
 1) There is a single PMTMR counter shared by all the CPUs.
 2) PMTMR counter reading is a very slow operation.

Using PMTMR as the default clock source may happen when, for example,
the TSC clock calibration exceeds the allowable tolerance and HPET
disabled by nohpet on kernel command line. Sometimes the performance
slowdown can be so severe that the system may crash because of a NMI
watchdog soft lockup, logs:

[   20.181521] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,
max_idle_ns: 2085701024 ns
[   44.273786] BUG: soft lockup - CPU#48 stuck for 23s! [swapper/48:0]
[   44.279992] BUG: soft lockup - CPU#49 stuck for 23s! [migration/49:307]
[   44.285169] BUG: soft lockup - CPU#50 stuck for 23s! [migration/50:313]

Commit f99fd22e4d4b ("x86/hpet: Reduce HPET counter read contention")
fixed a similar issue for HPET, this patch adapts that design to PMTMR.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Tested-by: Kin Cho <kin.cho@oracle.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Srinivas Eeda <srinivas.eeda@oracle.com>
---
 drivers/clocksource/acpi_pm.c | 101 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
index 1961e35..8b522eb 100644
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -32,12 +32,111 @@
  */
 u32 pmtmr_ioport __read_mostly;
 
-static inline u32 read_pmtmr(void)
+static inline u32 pmtmr_readl(void)
 {
 	/* mask the output to 24 bits */
 	return inl(pmtmr_ioport) & ACPI_PM_MASK;
 }
 
+#if defined(CONFIG_SMP) && defined(CONFIG_64BIT)
+/*
+ * Reading the PMTMR counter is a very slow operation. If a large number of
+ * CPUs are trying to access the PMTMR counter simultaneously, it can cause
+ * massive delay and slow down system performance dramatically. This may
+ * happen when PMTMR is the default clock source instead of TSC. For a
+ * really large system with hundreds of CPUs, the slowdown may be so
+ * severe that it may actually crash the system because of a NMI watchdog
+ * soft lockup, for example.
+ *
+ * If multiple CPUs are trying to access the PMTMR counter at the same time,
+ * we don't actually need to read the counter multiple times. Instead, the
+ * other CPUs can use the counter value read by the first CPU in the group.
+ *
+ * This special feature is only enabled on x86-64 systems. It is unlikely
+ * that 32-bit x86 systems will have enough CPUs to require this feature
+ * with its associated locking overhead. And we also need 64-bit atomic
+ * read.
+ *
+ * The lock and the pmtmr value are stored together and can be read in a
+ * single atomic 64-bit read. It is explicitly assumed that arch_spinlock_t
+ * is 32 bits in size.
+ */
+union pmtmr_lock {
+	struct {
+		arch_spinlock_t lock;
+		u32 value;
+	};
+	u64 lockval;
+};
+
+static union pmtmr_lock pmtmr __cacheline_aligned = {
+	{ .lock = __ARCH_SPIN_LOCK_UNLOCKED, },
+};
+
+static u32 read_pmtmr(void)
+{
+	unsigned long flags;
+	union pmtmr_lock old, new;
+
+	BUILD_BUG_ON(sizeof(union pmtmr_lock) != 8);
+
+	/*
+	 * Read PMTMR directly if in NMI.
+	 */
+	if (in_nmi())
+		return (u64)pmtmr_readl();
+
+	/*
+	 * Read the current state of the lock and PMTMR value atomically.
+	 */
+	old.lockval = READ_ONCE(pmtmr.lockval);
+
+	if (arch_spin_is_locked(&old.lock))
+		goto contended;
+
+	local_irq_save(flags);
+	if (arch_spin_trylock(&pmtmr.lock)) {
+		new.value = pmtmr_readl();
+		/*
+		 * Use WRITE_ONCE() to prevent store tearing.
+		 */
+		WRITE_ONCE(pmtmr.value, new.value);
+		arch_spin_unlock(&pmtmr.lock);
+		local_irq_restore(flags);
+		return (u64)new.value;
+	}
+	local_irq_restore(flags);
+
+contended:
+	/*
+	 * Contended case
+	 * --------------
+	 * Wait until the PMTMR value change or the lock is free to indicate
+	 * its value is up-to-date.
+	 *
+	 * It is possible that old.value has already contained the latest
+	 * PMTMR value while the lock holder was in the process of releasing
+	 * the lock. Checking for lock state change will enable us to return
+	 * the value immediately instead of waiting for the next PMTMR reader
+	 * to come along.
+	 */
+	do {
+		cpu_relax();
+		new.lockval = READ_ONCE(pmtmr.lockval);
+	} while ((new.value == old.value) && arch_spin_is_locked(&new.lock));
+
+	return (u64)new.value;
+}
+#else
+/*
+ * For UP or 32-bit.
+ */
+static inline u32 read_pmtmr(void)
+{
+	return pmtmr_readl();
+}
+#endif
+
 u32 acpi_pm_read_verified(void)
 {
 	u32 v1 = 0, v2 = 0, v3 = 0;
-- 
1.8.3.1

