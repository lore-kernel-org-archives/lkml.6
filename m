Return-Path: <kkamagui@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520022621; cv=none;
        d=google.com; s=arc-20160816;
        b=U3bYtL1KwJfC6LSVCkNffqefoyvxdGBQZ1x62q745g+m1bLq7cdt3t5DBVHjzuVSTO
         cXHMEI3g2cWY1DT70KSQNXimuwdlXEeCsBpuqW3uVlyWgOQfy0fCP+v6tVtioWFuYbG3
         c6GR6sHf4+cM8vRdicmPsRMkK0Ee37Thl+Cgqq61/yT9G/0BNHwgrdQzU+n6Nz5Cc0+T
         BM/Ugsz93lVnGR0xyQXgNy5CG/WJhZzzZCBZ3TFRSItEilutGWxsgV6WeJR8ysrczcuM
         5HTLzwEx2fKF/C5wunvU2Re0fLGOHfqSaIhI59UNqcQGeiFfXhGu4LyAZHgU6wKfZAT1
         bb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=iQblxkFK1kkjRY4xHANKMjPuyPE1MmBgMJ80VqMY5+c=;
        b=OLFnaJf/e8xapBz/K33aZ8UeRpp+76tEe9XxEZSH1EYLQ9979VnzQV6y7LEeIqiVKO
         /QYE6fUDkn60q+tXW6zvmzMw8vSKQcc8cvq4PVviaSfvXWbNF5IbnnC5Rt9FDjxC9uKU
         r8V+mlNI7tRKzolxykS7VfFm8WyxgkOFptuESVDs/+L5jsVv4fRIa8iWPffaD4CXlb28
         y+mnnJO7k8c5M6+TUq/F6pC7MTCi1FCq4tCKBvXndRSdylEbMZB/yDUMSlGJIaKZcAxp
         3X+LW9ivJK+j/FMOPKCt0pqoi+sz2O+oeRbFA00kbH9ibkvX+zPHl2UpjwwMdBrIKaM5
         k0lw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YgX0entC;
       spf=pass (google.com: domain of kkamagui@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kkamagui@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YgX0entC;
       spf=pass (google.com: domain of kkamagui@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kkamagui@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuW5SkanUcxjjzjSQVc9gM5ftWAZmbIAn8OzGRSD+gw5jV4XbzT6s4vxvSNM6vvs7cubB6YIQ==
From: Seunghun Han <kkamagui@gmail.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Seunghun Han <kkamagui@gmail.com>
Subject: [PATCH V3] x86: mce: fix kernel panic when check_interval is changed
Date: Sat,  3 Mar 2018 05:27:06 +0900
Message-Id: <20180302202706.9434-1-kkamagui@gmail.com>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593186374882748310?=
X-GMAIL-MSGID: =?utf-8?q?1593859239985076756?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I am Seunghun Han and a senior security researcher at National Security
Research Institute of South Korea.

I found a security issue which can make kernel panic in userspace. After
analyzing the issue carefully, I found that MCE driver in the kernel has a
problem which can be occurred in SMP environment.

The check_interval file in
/sys/devices/system/machinecheck/machinecheck<cpu number> directory is a
global timer value for MCE polling. If it is changed by one CPU, MCE driver
in kernel calls mce_restart() function in store_int_with_restart() function
and broadcasts the event to other CPUs to delete and restart MCE polling
timer.

The __mcheck_cpu_init_timer() function which is called by mce_restart()
function initializes the mce_timer variable, and the "lock" in mce_timer is
also reinitialized. If more than one CPU write a specific value to
check_interval file concurrently, one can initialize the "lock" in mce_timer
while the others are handling "lock" in mce_timer. This problem causes some
synchronization errors such as kernel panic and kernel hang. Other functions
such as set_ignore_ce(), set_cmci_disabled(), and mce_enable_ce() also
have synchronization problems.

It could be a security problem because the attacker could make kernel panic
by writing a value to the check_interval file in userspace, and it could be
used for Denial-of-Service (DoS) attack.

To fix this problem, I added a mce_sysfs_mutex to serialize requests for
timer and sysfs functions.

Signed-off-by: Seunghun Han <kkamagui@gmail.com>
---
Changes since v2: add a mutex to sysfs functions according to review
result.
Changes since v1: add mce_sysfs_mutex according to review result.

 arch/x86/kernel/cpu/mcheck/mce.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 706584681a4c..243f46a40efb 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -55,6 +55,7 @@
 #include "mce-internal.h"
 
 static DEFINE_MUTEX(mce_log_mutex);
+static DEFINE_MUTEX(mce_sysfs_mutex);
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mce.h>
@@ -2045,8 +2046,11 @@ static void mce_enable_ce(void *all)
 		return;
 	cmci_reenable();
 	cmci_recheck();
-	if (all)
+	if (all) {
+		mutex_lock(&mce_sysfs_mutex);
 		__mcheck_cpu_init_timer();
+		mutex_unlock(&mce_sysfs_mutex);
+	}
 }
 
 static struct bus_type mce_subsys = {
@@ -2090,6 +2094,7 @@ static ssize_t set_ignore_ce(struct device *s,
 	if (kstrtou64(buf, 0, &new) < 0)
 		return -EINVAL;
 
+	mutex_lock(&mce_sysfs_mutex);
 	if (mca_cfg.ignore_ce ^ !!new) {
 		if (new) {
 			/* disable ce features */
@@ -2102,6 +2107,8 @@ static ssize_t set_ignore_ce(struct device *s,
 			on_each_cpu(mce_enable_ce, (void *)1, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
 
@@ -2114,6 +2121,7 @@ static ssize_t set_cmci_disabled(struct device *s,
 	if (kstrtou64(buf, 0, &new) < 0)
 		return -EINVAL;
 
+	mutex_lock(&mce_sysfs_mutex);
 	if (mca_cfg.cmci_disabled ^ !!new) {
 		if (new) {
 			/* disable cmci */
@@ -2125,6 +2133,8 @@ static ssize_t set_cmci_disabled(struct device *s,
 			on_each_cpu(mce_enable_ce, NULL, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
 
@@ -2132,8 +2142,16 @@ static ssize_t store_int_with_restart(struct device *s,
 				      struct device_attribute *attr,
 				      const char *buf, size_t size)
 {
+	unsigned long old_check_interval = check_interval;
 	ssize_t ret = device_store_int(s, attr, buf, size);
+
+	if (check_interval == old_check_interval)
+		return ret;
+
+	mutex_lock(&mce_sysfs_mutex);
 	mce_restart();
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return ret;
 }
 
-- 
2.16.2
