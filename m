Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsKQyBQXk3Bf9NsVcEoyifqcC3wkoD4GCbevdaFJfUOZb8Oj7AZA8IaBz88XY2O1OvpmRUG
ARC-Seal: i=1; a=rsa-sha256; t=1520955579; cv=none;
        d=google.com; s=arc-20160816;
        b=J3agYDOVsr82q5VXljkVCtZqjACEPlLzPdMk9GkSNGrIYiCgVDxpiNiVrbpvIJa+Hr
         sa5OXwg+7iiKQTUDG8Y9Kv1Sgjbon7rrx0Z/FBD5+VtiEVuFp4F6dUyZz3LFWhsgxcxv
         jABDVcGI11yr3/BmnX2JUAGBRgLoLVk42uQMqFQla0i4fEhIpUDtHu3ml6kUSOjN7RgK
         mYrp9/tCfjQceO559X9PHxSnKFzSPKbOAYykQlj6mbUp9TFS/EfB6XBz4n4p1aws12z6
         5gEGUmkJlzT/CzkIUoM5p2up0VP1AEl2mY7lZ0jBjzSnOKz1p20VLUWN80nAwjJ+Re2h
         xsuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0G91ZycIF0YXZ3pmSIrczha9V6JgofGFk5xGetYItb0=;
        b=xAgkssd5au2TRFCCtynETK3N6RR+++5FA1J9zRPcLulrMsBTmZyBkyqiIvH/+76GAR
         GQT9gCNSuA+YPQoML4te85MsaUrxnIQDCd10lvsQKD5Q10YMBYzG4OCt7IxMYBBcKmVx
         j9ifwbpN6wIeBosOA9+JQrMPq2oKQm0aZJYreUu3zkHzPjRghRGk4+OZCckG6zpAdVVn
         dPDjoybxgkm7ywqW6MJrRAtjsdFFLHh702sjOjquUFa6G3AOgc/NFPjsZWm+eLe9lIjB
         mQLlXy+SMHZEzDvTMvxGfmKkWjr5wyZ/nBKa8x/RZ71l5X7UrB5WX/rpLJA+6uov2e4M
         ZKIw==
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
Subject: [PATCH 4.14 098/140] x86/MCE: Serialize sysfs changes
Date: Tue, 13 Mar 2018 16:25:01 +0100
Message-Id: <20180313152504.734543146@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836939155963397?=
X-GMAIL-MSGID: =?utf-8?q?1594837517470549202?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
@@ -2083,6 +2086,7 @@ static ssize_t set_ignore_ce(struct devi
 	if (kstrtou64(buf, 0, &new) < 0)
 		return -EINVAL;
 
+	mutex_lock(&mce_sysfs_mutex);
 	if (mca_cfg.ignore_ce ^ !!new) {
 		if (new) {
 			/* disable ce features */
@@ -2095,6 +2099,8 @@ static ssize_t set_ignore_ce(struct devi
 			on_each_cpu(mce_enable_ce, (void *)1, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
 
@@ -2107,6 +2113,7 @@ static ssize_t set_cmci_disabled(struct
 	if (kstrtou64(buf, 0, &new) < 0)
 		return -EINVAL;
 
+	mutex_lock(&mce_sysfs_mutex);
 	if (mca_cfg.cmci_disabled ^ !!new) {
 		if (new) {
 			/* disable cmci */
@@ -2118,6 +2125,8 @@ static ssize_t set_cmci_disabled(struct
 			on_each_cpu(mce_enable_ce, NULL, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
 
@@ -2125,8 +2134,19 @@ static ssize_t store_int_with_restart(st
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
 
