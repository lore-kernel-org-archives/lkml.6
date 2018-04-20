Return-Path: <DavidWang@zhaoxin.com>
X-Google-Smtp-Source: AIpwx48lkGi/O+9IQclRY4t4rSR5DSQPPhHzD3I0xtDvqgvv/wKT5puZy/82rQGAzJa4HNsfUYYP
ARC-Seal: i=1; a=rsa-sha256; t=1524212983; cv=none;
        d=google.com; s=arc-20160816;
        b=cjl1UpVAC48FBbd5PzNmlf5joh37hNYON20Y1eQU5Rc9wFnGIXYUpKHNpAY24ESCYZ
         NZIrqw92cmZST2iu3cewfO9iF9ts5Fli2TfMTOkNzX1VStkeJ2Kchw58Bgp/2OCu7j39
         3NGcPpMXKipW2+v4G+dre7hYgGt+fGlSvDLBMI3s4lod5BVKez4OwN+WTCyOR9qk8mBo
         nJHUMMlJWsYmuh+22SGa/sP+yIsDY3SNg8h73Fvx2aRhJljYFsB917CoyFtxuet+qfQP
         D6a4Tam8CXN9okvMnnY5zs3JSVlPfEsUf5siTdoxCf4DXv5UNcMhgZWM4eR89OF2N1C2
         flZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=VcYtKiNvVf9x69v8XVPmyo5uwEZZkBhPqMCLZqBrrbk=;
        b=jfGhod26CU80aZLo1lKTcOjAPVUQSZKva0FXVSGcA7E5B4XJGnnk6YQjPIWxu4wHX7
         0CXQ/R5knxZVqec4ZCSavJDTIFdFJh0kop8ewqteqBAbjMHSBbCFoz4leD3RlKBf4ZXL
         Nn5xYIdWz+xSGJO4NMTtPCJWbHpI+LOE0szIAmpY1l3yFURVD/OEBtld6Xeh34lSXqq7
         OXtNrrNVGklKCSa+NstqXu97wMsrYDTXgnkEeY2hIYU6uNC8lbQJQx8Z4NL9n+FECRRK
         IonBGQeXjT9xjlT/A5/Y8yQI+O8c1adJAWRFwPo66X8IV5yj3VdakZyir0AhGV3oIxm6
         g+Qg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 180.169.121.91 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 180.169.121.91 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
From: David Wang <davidwang@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<gregkh@linuxfoundation.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
	<qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>, <lukelin@viacpu.com>,
	<timguo@zhaoxin.com>, David Wang <davidwang@zhaoxin.com>
Subject: [PATCH v2] x86/Centaur: show more HW features in /proc/cpuinfo
Date: Fri, 20 Apr 2018 16:29:28 +0800
Message-ID: <1524212968-28998-1-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598253151735079564?=
X-GMAIL-MSGID: =?utf-8?q?1598253151735079564?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Centaur CPU has some intel compatible capabilities,include PMC and some
CPU virtualization capabilities. These capabilities should be initialized
in the centaur init function.

Signed-off-by: David Wang <davidwang@zhaoxin.com>

Changes from v1 to v2:
*1, move some defines outside the centaur_detect_vmx_virtcap;
*2, Delete some unuseful cap clear operaions in centaur_detect_vmx_virtcap;
*3, other little changes according to sugesstions from tglx;
---
 arch/x86/kernel/cpu/centaur.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index e5ec0f1..80d5110 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -18,6 +18,13 @@
 #define RNG_ENABLED	(1 << 3)
 #define RNG_ENABLE	(1 << 6)	/* MSR_VIA_RNG */
 
+#define X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW	0x00200000
+#define X86_VMX_FEATURE_PROC_CTLS_VNMI		0x00400000
+#define X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS	0x80000000
+#define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
+#define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
+#define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
+
 static void init_c3(struct cpuinfo_x86 *c)
 {
 	u32  lo, hi;
@@ -112,6 +119,31 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
 	}
 }
 
+static void centaur_detect_vmx_virtcap(struct cpuinfo_x86 *c)
+{
+	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
+
+	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
+	msr_ctl = vmx_msr_high | vmx_msr_low;
+
+	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW)
+		set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
+	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_VNMI)
+		set_cpu_cap(c, X86_FEATURE_VNMI);
+	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS) {
+		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
+		      vmx_msr_low, vmx_msr_high);
+		msr_ctl2 = vmx_msr_high | vmx_msr_low;
+		if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
+		    (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))
+			set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
+		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT)
+			set_cpu_cap(c, X86_FEATURE_EPT);
+		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
+			set_cpu_cap(c, X86_FEATURE_VPID);
+	}
+}
+
 static void init_centaur(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_X86_32
@@ -128,6 +160,19 @@ static void init_centaur(struct cpuinfo_x86 *c)
 	clear_cpu_cap(c, 0*32+31);
 #endif
 	early_init_centaur(c);
+
+	if (c->cpuid_level > 9) {
+		unsigned int eax = cpuid_eax(10);
+
+		/*
+		 * Check for version and the number of counters
+		 * Version(eax[7:0]) can't be 0;
+		 * Counters(eax[15:8]) should be greater than 1;
+		 */
+		if ((eax & 0xff) && (((eax >> 8) & 0xff) > 1))
+			set_cpu_cap(c, X86_FEATURE_ARCH_PERFMON);
+	}
+
 	switch (c->x86) {
 #ifdef CONFIG_X86_32
 	case 5:
@@ -199,6 +244,9 @@ static void init_centaur(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_64
 	set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
 #endif
+
+	if (cpu_has(c, X86_FEATURE_VMX))
+		centaur_detect_vmx_virtcap(c);
 }
 
 #ifdef CONFIG_X86_32
-- 
1.9.1
