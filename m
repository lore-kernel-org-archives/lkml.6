Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AG47ELuF2lECh0SvIg+0XVHCLNRLLuLYtDCzUo26g7SMhKwg8oaDsko8aD8DskCw8cDUCVYNmmSX
ARC-Seal: i=1; a=rsa-sha256; t=1520520028; cv=none;
        d=google.com; s=arc-20160816;
        b=sCM0as2NnTzAwitJeJRHoOzMsGbhRJa1eBWW3FPjQ122oDS7uetO+3kSpm6RbNCTfS
         XAZbkfNpx3ZPx5U1UaOiTxVH3ogC6VnGYHzLFndfxlfQjB73Qa7YyS9LG/pLC1Gr+D5O
         V9ZQ8Bx8uqgKP/oGtD3A+TXXc73SMu0roj7glyDzPvmrnhhLIuTnbhMcgpnZeFgz/R0Y
         ClelaG6PzSsyJv1t4g0wnTGwooP7rmtK+443mAgAtHOQWkGfBStw950/3dms9Xu70c8z
         V5lnUkSv4db4yS22dXd/NrjYgvvDtugwTohMCcDLCU9Q//wzs+frVE+LOQDi1Imv3r4O
         VEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=H0nifbRMpGDAXWboFTB/0e238gyjpcDv6PKHLFMaIlc=;
        b=xMyCDdBTFWB2sETYLuWZzDGQesFGFDrgFee165LK5x9+oStSt6ZNw/7NY8a/i+VgEP
         z1hFH8G/OcOKjGctO+iLkvqM4yHoiWzTfXV5AiAFpLW2PBCahS4ALsITTYOCQVBvB/H2
         F9AyIPymESSwwzzGjAsyZigW01+GQFgOCNSlKmf2pGsH72a8WnCKtzrO69VqbyoMeTVr
         UXWmg3q34J/akiybBGZso2ldErQ/spfWgbqoDZJafcBbix5OxN7PTlB4HKBBZPVM4ZTZ
         nfY/BLUTm3EJnbv0feXh4klypWyD/Bhc7x3EiSNWzRbypliPMuFgazrx/hJkxjhCwSc0
         tN5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Thu, 8 Mar 2018 06:40:20 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Seunghun Han <tipbot@zytor.com>
Message-ID: <tip-b3b7c4795ccab5be71f080774c45bbbcc75c2aaf@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, kkamagui@gmail.com, tony.luck@intel.com,
        tglx@linutronix.de, bp@suse.de, hpa@zytor.com,
        linux-edac@vger.kernel.org, mingo@kernel.org,
        gregkh@linuxfoundation.org
Reply-To: hpa@zytor.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        linux-edac@vger.kernel.org, tony.luck@intel.com, kkamagui@gmail.com,
        linux-kernel@vger.kernel.org, bp@suse.de, tglx@linutronix.de
In-Reply-To: <20180302202706.9434-1-kkamagui@gmail.com>
References: <20180302202706.9434-1-kkamagui@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:ras/urgent] x86/MCE: Serialize sysfs changes
Git-Commit-ID: b3b7c4795ccab5be71f080774c45bbbcc75c2aaf
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594380809723141993?=
X-GMAIL-MSGID: =?utf-8?q?1594380809723141993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  b3b7c4795ccab5be71f080774c45bbbcc75c2aaf
Gitweb:     https://git.kernel.org/tip/b3b7c4795ccab5be71f080774c45bbbcc75c2aaf
Author:     Seunghun Han <kkamagui@gmail.com>
AuthorDate: Tue, 6 Mar 2018 15:21:43 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 15:36:27 +0100

x86/MCE: Serialize sysfs changes

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
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180302202706.9434-1-kkamagui@gmail.com
---
 arch/x86/kernel/cpu/mcheck/mce.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index b3323cab9139..466f47301334 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -56,6 +56,9 @@
 
 static DEFINE_MUTEX(mce_log_mutex);
 
+/* sysfs synchronization */
+static DEFINE_MUTEX(mce_sysfs_mutex);
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/mce.h>
 
@@ -2088,6 +2091,7 @@ static ssize_t set_ignore_ce(struct device *s,
 	if (kstrtou64(buf, 0, &new) < 0)
 		return -EINVAL;
 
+	mutex_lock(&mce_sysfs_mutex);
 	if (mca_cfg.ignore_ce ^ !!new) {
 		if (new) {
 			/* disable ce features */
@@ -2100,6 +2104,8 @@ static ssize_t set_ignore_ce(struct device *s,
 			on_each_cpu(mce_enable_ce, (void *)1, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
 
@@ -2112,6 +2118,7 @@ static ssize_t set_cmci_disabled(struct device *s,
 	if (kstrtou64(buf, 0, &new) < 0)
 		return -EINVAL;
 
+	mutex_lock(&mce_sysfs_mutex);
 	if (mca_cfg.cmci_disabled ^ !!new) {
 		if (new) {
 			/* disable cmci */
@@ -2123,6 +2130,8 @@ static ssize_t set_cmci_disabled(struct device *s,
 			on_each_cpu(mce_enable_ce, NULL, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
 
@@ -2130,8 +2139,19 @@ static ssize_t store_int_with_restart(struct device *s,
 				      struct device_attribute *attr,
 				      const char *buf, size_t size)
 {
-	ssize_t ret = device_store_int(s, attr, buf, size);
+	unsigned long old_check_interval = check_interval;
+	ssize_t ret = device_store_ulong(s, attr, buf, size);
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
 
