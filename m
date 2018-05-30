Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753033AbeE3L0D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:26:03 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33303 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753285AbeE3LYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:24:54 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Borislav Petkov" <bp@suse.de>,
        "Tony Luck" <tony.luck@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-edac" <linux-edac@vger.kernel.org>,
        "Seunghun Han" <kkamagui@gmail.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.906535654@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 020/153] x86/MCE: Serialize sysfs changes
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Seunghun Han <kkamagui@gmail.com>

commit b3b7c4795ccab5be71f080774c45bbbcc75c2aaf upstream.

The check_interval file in

  /sys/devices/system/machinecheck/machinecheck<cpu number>

directory is a global timer value for MCE polling. If it is changed by one
CPU, mce_restart() broadcasts the event to other CPUs to delete and restart
the MCE polling timer and __mcheck_cpu_init_timer() reinitializes the
mce_timer variable.

If more than one CPU writes a specific value to the check_interval file
concurrently, mce_timer is not protected from such concurrent accesses and
all kinds of explosions happen. Since only root can write to those sysfs
variables, the issue is not a big deal security-wise.

However, concurrent writes to these configuration variables is void of
reason so the proper thing to do is to serialize the access with a mutex.

Boris:

 - Make store_int_with_restart() use device_store_ulong() to filter out
   negative intervals
 - Limit min interval to 1 second
 - Correct locking
 - Massage commit message

Signed-off-by: Seunghun Han <kkamagui@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180302202706.9434-1-kkamagui@gmail.com
[bwh: Backported to 3.2:
 - MCE device is a sysdev here
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -52,6 +52,9 @@ static DEFINE_MUTEX(mce_chrdev_read_mute
 			      rcu_read_lock_sched_held() || \
 			      lockdep_is_held(&mce_chrdev_read_mutex))
 
+/* sysfs synchronization */
+static DEFINE_MUTEX(mce_sysfs_mutex);
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/mce.h>
 
@@ -1883,6 +1886,7 @@ static ssize_t set_ignore_ce(struct sys_
 	if (strict_strtoull(buf, 0, &new) < 0)
 		return -EINVAL;
 
+	mutex_lock(&mce_sysfs_mutex);
 	if (mce_ignore_ce ^ !!new) {
 		if (new) {
 			/* disable ce features */
@@ -1895,6 +1899,8 @@ static ssize_t set_ignore_ce(struct sys_
 			on_each_cpu(mce_enable_ce, (void *)1, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
 
@@ -1907,6 +1913,7 @@ static ssize_t set_cmci_disabled(struct
 	if (strict_strtoull(buf, 0, &new) < 0)
 		return -EINVAL;
 
+	mutex_lock(&mce_sysfs_mutex);
 	if (mce_cmci_disabled ^ !!new) {
 		if (new) {
 			/* disable cmci */
@@ -1918,6 +1925,8 @@ static ssize_t set_cmci_disabled(struct
 			on_each_cpu(mce_enable_ce, NULL, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
 
@@ -1925,8 +1934,19 @@ static ssize_t store_int_with_restart(st
 				      struct sysdev_attribute *attr,
 				      const char *buf, size_t size)
 {
-	ssize_t ret = sysdev_store_int(s, attr, buf, size);
+	unsigned long old_check_interval = check_interval;
+	ssize_t ret = sysdev_store_ulong(s, attr, buf, size);
+
+	if (check_interval == old_check_interval)
+		return ret;
+
+	if (check_interval < 1)
+		check_interval = 1;
+
+	mutex_lock(&mce_sysfs_mutex);
 	mce_restart();
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return ret;
 }
 
