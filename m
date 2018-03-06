Return-Path: <bp@alien8.de>
X-Google-Smtp-Source: AG47ELsxGqivqQTjR6k06xESxiAVuTlS9XHrSvDKWVS397YA9ofPYrUs7m/dTKc8xNweT7e1WiMx
ARC-Seal: i=1; a=rsa-sha256; t=1520333011; cv=none;
        d=google.com; s=arc-20160816;
        b=S8q4cuZNgeWnMs5U/3icxMNxrWxr5FXmCoeJTusUU3Qyk0eDS+NG4BaVbQopoCY3v2
         2BMwwiamHzlGJOJtnrBbkcZNW954yj7CYlYtlp/26xS9J1C1fTWUoruVnn2HhxU1juHL
         96XxLOlM1g/TNDIBfYuviJWUJUDzE+FaI5AtpzOIpsPNJEPuoBjTAcQ83LACAIw7KEuw
         dpB1VwpJFddw+d5pN8BYvCya91QreYtoTkxrPi1q8Mwov+cvl7UvldLo+BbHPpNDqjiV
         jetdBrdf2AU5KofnpP8Dg6iQHKQy2IP3pKQSqZvhcsRICuPWGacYMTwg+PtYIM6GOraE
         fxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=YYDGOg3nBvelunCycOz22PZcpJBC8156Se7LB1nwJ2g=;
        b=MnD5GLcV8JgcEMC5BU1cZZg4kXDBJhUX4watLHeHm59BwP2j/ZJKR1XN+sudwd0IOz
         BYLm6MvF0vEsH8i/7TnuPg1I0sZqdrBQXvCHiBBHblklbe3gLvr8xWDTmk2ipYndEZfn
         Q/WJW+fi07KXQFlU+rN+wTsblroPtr0kCTxXMYw67QcU4Plv2WXCYwA9PGKhyNc6p+ss
         D7+nSGnSQ33FZct6QzDJz/5JuHS9sLFa1RSPGNb+uCdHO7eVMb555E2e1AbQDgs6+Ril
         ebJfNVi5fmKecEOwGKzOh3DjAHKs/Y3nny3odddq94DgqCBz4ejjK1E0h04kWAaDqDzu
         L4eA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 5.9.137.197 as permitted sender) smtp.mailfrom=bp@alien8.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 5.9.137.197 as permitted sender) smtp.mailfrom=bp@alien8.de
Date: Tue, 6 Mar 2018 11:43:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: Seunghun Han <kkamagui@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3] x86: mce: fix kernel panic when check_interval is
 changed
Message-ID: <20180306104320.GB11535@pd.tnic>
References: <20180302202706.9434-1-kkamagui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180302202706.9434-1-kkamagui@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593186374882748310?=
X-GMAIL-MSGID: =?utf-8?q?1594184707796161178?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 03, 2018 at 05:27:06AM +0900, Seunghun Han wrote:
> I am Seunghun Han and a senior security researcher at National Security
> Research Institute of South Korea.
> 
> I found a security issue which can make kernel panic in userspace. After
> analyzing the issue carefully, I found that MCE driver in the kernel has a
> problem which can be occurred in SMP environment.
> 
> The check_interval file in
> /sys/devices/system/machinecheck/machinecheck<cpu number> directory is a
> global timer value for MCE polling. If it is changed by one CPU, MCE driver
> in kernel calls mce_restart() function in store_int_with_restart() function
> and broadcasts the event to other CPUs to delete and restart MCE polling
> timer.
> 
> The __mcheck_cpu_init_timer() function which is called by mce_restart()
> function initializes the mce_timer variable, and the "lock" in mce_timer is
> also reinitialized. If more than one CPU write a specific value to
> check_interval file concurrently, one can initialize the "lock" in mce_timer
> while the others are handling "lock" in mce_timer. This problem causes some
> synchronization errors such as kernel panic and kernel hang. Other functions
> such as set_ignore_ce(), set_cmci_disabled(), and mce_enable_ce() also
> have synchronization problems.
> 
> It could be a security problem because the attacker could make kernel panic
> by writing a value to the check_interval file in userspace, and it could be
> used for Denial-of-Service (DoS) attack.
> 
> To fix this problem, I added a mce_sysfs_mutex to serialize requests for
> timer and sysfs functions.
> 
> Signed-off-by: Seunghun Han <kkamagui@gmail.com>
> ---
> Changes since v2: add a mutex to sysfs functions according to review
> result.
> Changes since v1: add mce_sysfs_mutex according to review result.

Thanks, I've committed the patch below. Scream if there's still
something not in order:

---
From: Seunghun Han <kkamagui@gmail.com>
Date: Sat, 3 Mar 2018 05:27:06 +0900
Subject: [PATCH] x86/MCE: Synchronize sysfs changes

The check_interval file in

  /sys/devices/system/machinecheck/machinecheck<cpu number>

directory is a global timer value for MCE polling. If it is changed by
one CPU, mce_restart() broadcasts the event to other CPUs to delete
and restart the MCE polling timer and __mcheck_cpu_init_timer()
reinitializes the mce_timer variable.

If more than one CPU writes a specific value to the check_interval file
concurrently, mce_timer is not protected from such concurrent accesses
and all kinds of explosions happen.

Since only root can write to those sysfs variables, the issue is not a
big deal security-wise.

However, concurrent writes to these configuration variables is
void of reason so the proper thing to do is to "slow" accesses
down by synchronizing them with a mutex and thus take care of the
synchronization issue too.

Boris:

 - make store_int_with_restart() use device_store_ulong() to filter out
   negative intervals
 - limit min interval to 1 second
 - correct locking
 - massage commit message

Signed-off-by: Seunghun Han <kkamagui@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/20180302202706.9434-1-kkamagui@gmail.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 181f6cf25895..21962c48dad7 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -56,6 +56,9 @@
 
 static DEFINE_MUTEX(mce_log_mutex);
 
+/* sysfs synchronization */
+static DEFINE_MUTEX(mce_sysfs_mutex);
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/mce.h>
 
@@ -2104,6 +2107,7 @@ static ssize_t set_ignore_ce(struct device *s,
 	if (kstrtou64(buf, 0, &new) < 0)
 		return -EINVAL;
 
+	mutex_lock(&mce_sysfs_mutex);
 	if (mca_cfg.ignore_ce ^ !!new) {
 		if (new) {
 			/* disable ce features */
@@ -2116,6 +2120,8 @@ static ssize_t set_ignore_ce(struct device *s,
 			on_each_cpu(mce_enable_ce, (void *)1, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
 
@@ -2128,6 +2134,7 @@ static ssize_t set_cmci_disabled(struct device *s,
 	if (kstrtou64(buf, 0, &new) < 0)
 		return -EINVAL;
 
+	mutex_lock(&mce_sysfs_mutex);
 	if (mca_cfg.cmci_disabled ^ !!new) {
 		if (new) {
 			/* disable cmci */
@@ -2139,6 +2146,8 @@ static ssize_t set_cmci_disabled(struct device *s,
 			on_each_cpu(mce_enable_ce, NULL, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
 
@@ -2146,8 +2155,19 @@ static ssize_t store_int_with_restart(struct device *s,
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
 
-- 
2.13.0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
