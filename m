Return-Path: <DavidWang@zhaoxin.com>
X-Google-Smtp-Source: AIpwx4/JhL8JdimKNikZc9xLxjMe6GkkH9ldRE2PEWbYQYUGZYq0ABSOnD9qp/wCDd7vKI3XIrBx
ARC-Seal: i=1; a=rsa-sha256; t=1524646122; cv=none;
        d=google.com; s=arc-20160816;
        b=V/wN0teMAjbLnk3ctcgF/YyPw5pmNJj67BQwKkn8KVp2hUV2JfAKMSo12td4axdCVY
         7MwXlAL8jFNlIf+o/4d63hiqpCpM97xVq0eM8XB8PyMJxIyOSp7IiTA7wUS60jtZlYnr
         4VoXGDtMF/qz/cQQFA3hU44h4V8qNRTC7anMTW9tnbH/r+H/znX5tYZMH9iRUMo5Km3Y
         STaFYkVVWoiGRWF9fKZdnghJrRVR9Xfkjpfd0RM6NtVX6rJ0twQB5HkskoasE1c5PFXY
         Nfo3e8zRzbLKW/EhMShm8IFy00dji2M3EJ8St77NQdWegS6fmvBRz6bwZ5H73FbtUFGJ
         9GrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=W+eCz26tQVo5kel/JBlO61T41c708X2jQuWMUFZZdSk=;
        b=AP53LZYxTNBlqWlcQT+1OrUHqt+htqlkY5jb9LF9Wrq5mHobeTIr2G0K7o7+hYTWBK
         ly/eL1L07QUfKDauGxp+19r+aigNzNFgNMkFTl/JBAVHAQ4OfXemVe7u7Qnf0sriiWbd
         ILSqYFKvR0Xrf2xOLckZ3yL0sqZrqeGXJKYT1eOGUbrUm7/7TN6rS1z3jGCm2eZdf/L2
         nmBUE/yRwtRZDsvH2xEu5FK8bKgfRTUOQhn00GFtrHBR6rnhWhrOXwF9CEX8zYrszIxT
         VIma/LJxmR/pAKu9AGiVlnvA/OR/QgIqcUc+suJlAuUa5ggxYQsc88WgGNheSzTetQJl
         wYRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.148.12.81 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.148.12.81 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
From: David Wang <davidwang@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<gregkh@linuxfoundation.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
	<qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>, <lukelin@viacpu.com>,
	<timguo@zhaoxin.com>, David Wang <davidwang@zhaoxin.com>
Subject: [PATCH v2] x86/centaur: report correct CPU/cache topology
Date: Wed, 25 Apr 2018 16:48:30 +0800
Message-ID: <1524646110-4808-1-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598707331736594259?=
X-GMAIL-MSGID: =?utf-8?q?1598707331736594259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Centaur CPUs enumerate the cache topology in the same way as Intel CPUs,
but the functionality is unused so far.
The Centaur init code also misses to initialize x86_info::max_cores, so
the CPU topology can't be described correctly.

Initialize x86_cpuinfo:max_core and invoke init_intel_cacheinfo() to
make CPU and cache topology information avaliable and correct.

Signed-off-by: David Wang <davidwang@zhaoxin.com>

Changes from v1 to v2:
*1 replace centaur_num_cpu_cores with early_init_centaur_mc according to 
suggestions from tglx;
*2 call cpu_detect_cache_sizes when init_intel_cacheinfo returns 0. For
some very old Centaur CPUs can't support the mechanisms defined in init_
intel_cacheinfo.
 
---
 arch/x86/kernel/cpu/centaur.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 80d5110..367540b 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -96,8 +96,25 @@ enum {
 		EAMD3D		= 1<<20,
 };
 
+static void early_init_centaur_mc(struct cpuinfo_x86 *c)
+{
+#ifdef CONFIG_SMP
+	unsigned int eax, ebx, ecx, edx;
+
+	if (c->cpuid_level < 4)
+		return;
+
+	cpuid_count(4, 0, &eax, &ebx, &ecx, &edx);
+	if (eax & 0x1f)
+		c->x86_max_cores = (eax >> 26) + 1;
+	else
+		return;
+#endif
+}
+
 static void early_init_centaur(struct cpuinfo_x86 *c)
 {
+	early_init_centaur_mc(c);
 	switch (c->x86) {
 #ifdef CONFIG_X86_32
 	case 5:
@@ -146,6 +163,7 @@ static void centaur_detect_vmx_virtcap(struct cpuinfo_x86 *c)
 
 static void init_centaur(struct cpuinfo_x86 *c)
 {
+	unsigned int l2 = 0;
 #ifdef CONFIG_X86_32
 	char *name;
 	u32  fcr_set = 0;
@@ -161,6 +179,17 @@ static void init_centaur(struct cpuinfo_x86 *c)
 #endif
 	early_init_centaur(c);
 
+	l2 = init_intel_cacheinfo(c);
+
+	/* Detect legacy cache sizes if init_intel_cacheinfo did not */
+	if (l2 == 0) {
+		cpu_detect_cache_sizes(c);
+	}
+
+#ifdef CONFIG_X86_32
+	detect_ht(c);
+#endif
+
 	if (c->cpuid_level > 9) {
 		unsigned int eax = cpuid_eax(10);
 
-- 
1.9.1
