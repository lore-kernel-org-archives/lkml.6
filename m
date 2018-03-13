Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsUdIWg8OfIEtbeKH2za1DjAAgw336Zq7KefEPkhYX7Ai1bnVyHBospZYJsUp7POuRUM3mE
ARC-Seal: i=1; a=rsa-sha256; t=1520955027; cv=none;
        d=google.com; s=arc-20160816;
        b=obww8UxfPNFghsALLaW8FPeMsnBDvwinIDr3/KLwi39j+PN6rYugOXinFSevm4Mp+2
         QublO2Amu4CdORrzt5CfmLAXo94Nhvh8TbNXcNcoyWp+k3d6CfstpkQ/+uOuIBID+a5l
         xqJVzlcT+Wg0ZegmhiwU6Of2wHzOtqdg7gTSq79jrMQtP+Nt3rs5O1TCwttYjmGFq7Fs
         y4XZStvhj9h+MUHOqC3WNhrJ6cKv8619Vb8zW0GovJzRgBTdJsOQYrHErM5OxmnJsFy5
         1tzrFASmpJs9Fm/zn/h6m3bvH+blMezcULOs0ZK2qAzu8FxUFWXK0yUNIMeRZELL7p0q
         sB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MggX8I0DqhOznG62aVkyG2rApj0QzHa4If+c1vdM1r4=;
        b=i8L6vjwamyjnlGgd7f/c8V78A9xgmMMF9QN6kQTn4ZLIvPDvUV+uDW2aTx0JYFu4ZC
         bl8U5Dt3ZI7KGMvQwotdOdP6AvVb5H68Q5kajdKXydNJ4bxX9SvJx0dqAbwSyq0gx4yQ
         T0SlFm3uvfW23oZ/lLIaMWgMwrL2v7cx+ScQkIBHwyF1Dc/C1RJNw8XNvHg+d6bDX99j
         lKQXaBzAkj9LbcaifApmz1vDTzKPDLxwiZiIcU5bLt+hBF4mxE4bN+iB0jVwYB/I9e08
         jEAOY9UgvaKlIOsh4q3ciAC7QkSXhLcbzW7pesbwZOhB5WH0Rt3i2IPHIuv4A0KCL+2z
         vfGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Seunghun Han <kkamagui@gmail.com>,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac <linux-edac@vger.kernel.org>
Subject: [PATCH 4.15 063/146] x86/MCE: Serialize sysfs changes
Date: Tue, 13 Mar 2018 16:23:50 +0100
Message-Id: <20180313152325.538700825@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836939155963397?=
X-GMAIL-MSGID: =?utf-8?q?1594836939155963397?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -57,6 +57,9 @@
 
 static DEFINE_MUTEX(mce_log_mutex);
 
+/* sysfs synchronization */
+static DEFINE_MUTEX(mce_sysfs_mutex);
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/mce.h>
 
@@ -2080,6 +2083,7 @@ static ssize_t set_ignore_ce(struct devi
 	if (kstrtou64(buf, 0, &new) < 0)
 		return -EINVAL;
 
+	mutex_lock(&mce_sysfs_mutex);
 	if (mca_cfg.ignore_ce ^ !!new) {
 		if (new) {
 			/* disable ce features */
@@ -2092,6 +2096,8 @@ static ssize_t set_ignore_ce(struct devi
 			on_each_cpu(mce_enable_ce, (void *)1, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
 
@@ -2104,6 +2110,7 @@ static ssize_t set_cmci_disabled(struct
 	if (kstrtou64(buf, 0, &new) < 0)
 		return -EINVAL;
 
+	mutex_lock(&mce_sysfs_mutex);
 	if (mca_cfg.cmci_disabled ^ !!new) {
 		if (new) {
 			/* disable cmci */
@@ -2115,6 +2122,8 @@ static ssize_t set_cmci_disabled(struct
 			on_each_cpu(mce_enable_ce, NULL, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
 
@@ -2122,8 +2131,19 @@ static ssize_t store_int_with_restart(st
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
 
