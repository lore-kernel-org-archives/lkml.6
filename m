Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu8DhWHe+UpMfgCykc/ZtA6k/Ny2L0nkztiEKAVi0kj2jdTJhxOIeRTigpOQdMktMINvwQP
ARC-Seal: i=1; a=rsa-sha256; t=1521214258; cv=none;
        d=google.com; s=arc-20160816;
        b=QMsJFfocxkNt3j9zS6/8QmxnuwQK1kZrc/VIkvFHUycCXcjHHeEd/L5qTBiPISv+iW
         3qMLeKjpiHkoR2AKu+QqIWen1xmgyCyrAvKnmT7wke8FJSLt2KDqnzoHZSJI4tM1ylnG
         IW9OkybohPz1X/CSSQukjo1qmS6xcTZtXr6ws3v35HfCiuCqUvv0le6J1Or6HBXU2LnC
         0o8ghOH2Yq1O4NCtSuq39+XxMpWwTi06A+gABUulD/T4DYgeNsUI9ScC2+Z3wu1rhXy8
         gxlK4outSLK4niRbWqJ1BPuLy2bsKt2V/O5Vv0ct3PwzBQGRV803ov0XFHre9JPDgY8i
         aHag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5u3vjJ3Jm3jUU5CM536draNIQsLpICMwElIfVmkGdQc=;
        b=apeQn/YHfHjdCXY+F9CC9Y+pzvAC9Trfg+gdb2PlXHIVDn4qxpX3h5YLwQukDxVODx
         lQDW9rEQwQH2qkhpQ7G9Nd23MeuXfDUUdJRwLmw64XtIGupZSLuh1biKZrWFz9+14Fje
         7IPIdWHYVodYibSaiBwX/zEnk36/vFVhktQPwO0cvySHrb7clUTC/2ySbTk0vP0+GYFj
         UrRiNm/c5rNsp/VflNmWyePqi37Y+orIBJy3JRzbT1tZdx0ap8p5laQehgMrHgZ9tNzn
         C4M/iEsLviBpCHYmNYQh2SOPR1xvYBJBD3j4L/PHgPmZLQR3QBCqMTb8jxWTJnennl2y
         vBPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Seunghun Han <kkamagui@gmail.com>,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac <linux-edac@vger.kernel.org>
Subject: [PATCH 4.9 28/86] x86/MCE: Serialize sysfs changes
Date: Fri, 16 Mar 2018 16:22:51 +0100
Message-Id: <20180316152319.335748145@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108292811892931?=
X-GMAIL-MSGID: =?utf-8?q?1595108762294509343?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180302202706.9434-1-kkamagui@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mcheck/mce.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -61,6 +61,9 @@ static DEFINE_MUTEX(mce_chrdev_read_mute
 	smp_load_acquire(&(p)); \
 })
 
+/* sysfs synchronization */
+static DEFINE_MUTEX(mce_sysfs_mutex);
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/mce.h>
 
@@ -2308,6 +2311,7 @@ static ssize_t set_ignore_ce(struct devi
 	if (kstrtou64(buf, 0, &new) < 0)
 		return -EINVAL;
 
+	mutex_lock(&mce_sysfs_mutex);
 	if (mca_cfg.ignore_ce ^ !!new) {
 		if (new) {
 			/* disable ce features */
@@ -2320,6 +2324,8 @@ static ssize_t set_ignore_ce(struct devi
 			on_each_cpu(mce_enable_ce, (void *)1, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
 
@@ -2332,6 +2338,7 @@ static ssize_t set_cmci_disabled(struct
 	if (kstrtou64(buf, 0, &new) < 0)
 		return -EINVAL;
 
+	mutex_lock(&mce_sysfs_mutex);
 	if (mca_cfg.cmci_disabled ^ !!new) {
 		if (new) {
 			/* disable cmci */
@@ -2343,6 +2350,8 @@ static ssize_t set_cmci_disabled(struct
 			on_each_cpu(mce_enable_ce, NULL, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
 
@@ -2350,8 +2359,19 @@ static ssize_t store_int_with_restart(st
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
 
