Return-Path: <DavidWang@zhaoxin.com>
X-Google-Smtp-Source: AB8JxZpDEZ3u2hUL69gNlaOTHxrV6s3CyiHFWeb51hIC8HjRGhOHPdxsw4njf5Mc89rzfw8j5EV+
ARC-Seal: i=1; a=rsa-sha256; t=1525314780; cv=none;
        d=google.com; s=arc-20160816;
        b=ZecxQrdTt+1LHiVcGDVxvO/rp71jFST6uU/8ynE+tkbQquDHArUNrEkfUDC+CUSRny
         4FXplJXeW4eYcNBoUENSjSK3xuaFxhSi/RLTNdFxBfGFxcUplFa4G6UcNlMGIS8j7S1D
         lfiu+bExQxC/pIy4CRMzIaNVHz7pi+zSj6I1ahR5zW5/CukwC6MCZiRdHUFL9vMt6yCV
         pCrgzp/ZqbnE3tPxeIsNv9ABTNel47hfe75thclGURxlBr8+i0pkIAhzOLKwe4YiFKaZ
         9X3x4bxnk7Id63PIKx1qlK2MK8EKPEeuLaB1aCHflWRC/mFjEw203NOj9ZEYAMEktg0A
         I1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=L92Zn3BtLFqJgsZVTEEl/CNX0Bh3gb1PUHteh+d9lhA=;
        b=kSZAdPKRS2gTQfGsDPwFhbR+ZZzYNI9QrMBQvoGtD7IOJ4AB0cbcsNpV8FtXc6Av4f
         Cg7SdwJxssrNu2Xbkn7P2Z/x26lcnmGzen9nHKLqFRoohy/y47uZcMc5SbSvWWEJV87y
         XXeR3iXeBPVWxne88BRjUxAopyaIQMWVvrj4S/oFUL9FFDUoUkx0MKzceychUsWWQ+cJ
         on/CpxHal4SUVY0HqVbxoPyyeN6rg3cNSUUHoHRfuPfqfN85WanK2eXSTyzpe+7tY1ec
         tz1wZPp4eM7vGj/S0rrqZGUNOeyj5N+izdXuHN3y4zTHEBz0dT9piwVkQFtt6nrwkbGO
         JJMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.148.12.82 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.148.12.82 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
From: David Wang <davidwang@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<gregkh@linuxfoundation.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
	<qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>, <lukelin@viacpu.com>,
	<timguo@zhaoxin.com>, David Wang <davidwang@zhaoxin.com>
Subject: [PATCH 1/3] x86/CPU: Replace intel_num_cpu_cores with detect_num_cpu_cores
Date: Thu, 3 May 2018 10:32:44 +0800
Message-ID: <1525314766-18910-2-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525314766-18910-1-git-send-email-davidwang@zhaoxin.com>
References: <1525314766-18910-1-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599408470681476300?=
X-GMAIL-MSGID: =?utf-8?q?1599408470681476300?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

intel_num_cpu_cores() is a static defination in intel.c which can't be used by 
other files. Define another function called detect_num_cpu_cores() in common.c
to replace this function.

Signed-off-by: David Wang <davidwang@zhaoxin.com>
---
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/kernel/cpu/common.c     | 14 ++++++++++++++
 arch/x86/kernel/cpu/intel.c      | 20 +-------------------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index e56fe7c..b0553f6 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -192,6 +192,7 @@ extern u32 get_scattered_cpuid_leaf(unsigned int level,
 				    enum cpuid_regs_idx reg);
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_amd_cacheinfo(struct cpuinfo_x86 *c);
+extern int detect_num_cpu_cores(struct cpuinfo_x86 *c);
 
 extern void detect_extended_topology(struct cpuinfo_x86 *c);
 extern void detect_ht(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8a5b185..0c80d50 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -577,6 +577,20 @@ static void get_model_name(struct cpuinfo_x86 *c)
 	*(s + 1) = '\0';
 }
 
+int detect_num_cpu_cores(struct cpuinfo_x86 *c)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	if (!IS_ENABLED(CONFIG_SMP) || c->cpuid_level < 4)
+		return 1;
+
+	cpuid_count(4, 0, &eax, &ebx, &ecx, &edx);
+	if (eax & 0x1f)
+		return (eax >> 26) + 1;
+	else
+		return 1;
+}
+
 void cpu_detect_cache_sizes(struct cpuinfo_x86 *c)
 {
 	unsigned int n, dummy, ebx, ecx, edx, l2size;
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 60d1897..f683f7d 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -453,24 +453,6 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #endif
 }
 
-/*
- * find out the number of processor cores on the die
- */
-static int intel_num_cpu_cores(struct cpuinfo_x86 *c)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	if (!IS_ENABLED(CONFIG_SMP) || c->cpuid_level < 4)
-		return 1;
-
-	/* Intel has a non-standard dependency on %ecx for this CPUID level. */
-	cpuid_count(4, 0, &eax, &ebx, &ecx, &edx);
-	if (eax & 0x1f)
-		return (eax >> 26) + 1;
-	else
-		return 1;
-}
-
 static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
 {
 	/* Intel VMX MSR indicated features */
@@ -671,7 +653,7 @@ static void init_intel(struct cpuinfo_x86 *c)
 		 * let's use the legacy cpuid vector 0x1 and 0x4 for topology
 		 * detection.
 		 */
-		c->x86_max_cores = intel_num_cpu_cores(c);
+		c->x86_max_cores = detect_num_cpu_cores(c);
 #ifdef CONFIG_X86_32
 		detect_ht(c);
 #endif
-- 
1.9.1
