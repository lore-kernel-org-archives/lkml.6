Return-Path: <kkamagui@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519849903; cv=none;
        d=google.com; s=arc-20160816;
        b=ME60vmohveopalW9QjRXzZe1P1aJzXIi1rRKgnU035+GcQtH4pDoyANhoQZWVED5Gx
         G2Q/qZ80KwvGmdJQxOWJj1O1hGK1Tdho5klhDtQFqJLoT5t0Y7VMiWKY+8URtIwXliqf
         lc/Oe7+10UhJ6V5bJ9TR0EGTaKcLnrtLq/mwSCYIuEs9rF0suSTfINOWWdTAMf35aqXD
         FHCacEDmJf3Hc7HW3SLhfWw/fO7gec/klATrihEACi6SnMnHybNqQravvY67NH+/gjeD
         ALODSdMgQ3nO/09z4aSJEt83ZR2kSXLusLKHg/NTUAnN5SgAIZwgUhdWlaMt1HcBXbVi
         eVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=hf2Z5V6JSGyVPbid2pfabIGyulMtCJAalxlrd4giEx8=;
        b=kV3WEyr0RvfbFHgVdVeQB7di3C7TEofVjwPodUlZZNC8ncafJp/UGqk44YSZ5LGlJ5
         qPQkgnRoiXEAHgCHVrl92vdSv7Hs2A//Qroung4N7Hlhy3WGzTL3qOtHOeoR8ygQ/Hm9
         hJbFW4MhNMU/HwyOYNf2t+o9o5PKFgmjywXe2Kzaxt6eEBUXdD/VsJB/S1QW4doplukZ
         6VV45aM1Ui7XcKzZqJ2+1omKYS+oJ9RkGFSusJBxu125ralPD3UiyhxexGrKpFOJt9CN
         RAk+IrwxPT5CXVdg+elwSyMZKv6/TaHMvYy+8lIJyKm6Cy27tTlct8A+mVkQJUAGEsCz
         eLsg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=f7Bo4NR3;
       spf=pass (google.com: domain of kkamagui@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kkamagui@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=f7Bo4NR3;
       spf=pass (google.com: domain of kkamagui@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kkamagui@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224hE2fYPh6Im9LBF+g8BOjTYqbiOkokVmuaoL9oPpztItef1bCs0C18bj0jJlmFHd2aCCE9wg==
From: Seunghun Han <kkamagui@gmail.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Seunghun Han <kkamagui@gmail.com>
Subject: [PATCH V2] x86: mce: fix kernel panic when check_interval is changed
Date: Thu,  1 Mar 2018 05:31:31 +0900
Message-Id: <20180228203131.3176-1-kkamagui@gmail.com>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593186374882748310?=
X-GMAIL-MSGID: =?utf-8?q?1593678132194799669?=
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
in kernel calls mce_restart() function and broadcasts the event to other
CPUs to delete and restart MCE polling timer.

The __mcheck_cpu_init_timer() function which is called by mce_restart()
function initializes the mce_timer variable, and the "lock" in mce_timer is
also reinitialized. If more than one CPU write a specific value to
check_interval file concurrently, one can initialize the "lock" in mce_timer
while the others are handling "lock" in mce_timer. This problem causes some
synchronization errors such as kernel panic and kernel hang.

It is a security problem because the attacker can make kernel panic by
writing a value to the check_interval file in userspace, and it can be used
for Denial-of-Service (DoS) attack.

To fix this problem, I added a mce_sysfs_mutex to serialize requests.

Signed-off-by: Seunghun Han <kkamagui@gmail.com>
---
Changes since v1: add mce_sysfs_mutex according to review result.

 arch/x86/kernel/cpu/mcheck/mce.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 706584681a4c..bee0795a3b8c 100644
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
@@ -2132,8 +2136,14 @@ static ssize_t store_int_with_restart(struct device *s,
 				      struct device_attribute *attr,
 				      const char *buf, size_t size)
 {
+	unsigned long old_check_interval = check_interval;
 	ssize_t ret = device_store_int(s, attr, buf, size);
+
+	if (check_interval == old_check_interval)
+		return ret;
+	mutex_lock(&mce_sysfs_mutex);
 	mce_restart();
+	mutex_unlock(&mce_sysfs_mutex);
 	return ret;
 }
 
-- 
2.16.2
