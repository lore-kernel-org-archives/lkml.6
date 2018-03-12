Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELv8yylWCWY0NZMycob0ARzpWmpCFxbw1Qlv9OS3wQ6rA9RlUNZ3sWbCt5rAaRK/N+2ug3Lf
ARC-Seal: i=1; a=rsa-sha256; t=1520824093; cv=none;
        d=google.com; s=arc-20160816;
        b=Q4o5nrOMls+ff+xQP6nhsqvkmFpyDC+lvkqBrqDOsldfd1WftdkNMPLZZVC0InGlrq
         3qYREsG9+rn0NKIhQCsvzzNJungAvlaZoXcEIGhrAx41VbrmyMaVXu/3i4dFbN613IMX
         GpzyM3ClnLWrYuyFKzja/UWQk3AH2sb+5/WPh9/KilAtkS0OXkXFlAgiRQqEEEANx//U
         ZmfIglEA9EkSqQrKMtmgzDxCs0uLDIbb+P152cO9d/WGNKxIfCP5cZ4q5oDxsEArFDPS
         pCoxGUnXtO8Sl2rQOGVxoDhybEJxpuhoYVFNVFEOVzDRAkp+arLB4qKJowXLvKU/KQqe
         UxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=FuWdDJsmHHWetW993nk2r3K+VIKjpeTdSJk3ZasDKpM=;
        b=t/n0ngtV5gCivMqGLdbme1syof9CyNvZ2dWc45AYt9Mku7r99PQsIjG+1g80TCmrrt
         E0XFE3JEfwqdy1ZbMSlQCwnlQxevHF0Vgl+4ZsEZr7Fi1n2GlPczBNlY5N2S2PsHsWA1
         qgU1qbDz8slAvrm1Ks2OBoxixuftBoxzPSRRmybI27OVniKM3QFiml2K29Kuy0hj+xKK
         Q084JMLmQhUtYpszlK5mMTSpOb+S04LuC+hz63k1MUHQAOvE5G1PE+ty1RD9/lcf7jrh
         9bVviUohpPrCdBeWZDGXDEi5mtOBiXHKlTkN5m3yKOk/2xcS9NzYt9fxMX00jIKBqkyO
         MuGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Paul Turner" <pjt@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Reviewed-by: Borislav Petkov" <bp@suse.de>,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.245389119@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 054/104] x86/cpu/AMD: Use LFENCE_RDTSC in preference
 to MFENCE_RDTSC
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699644547888395?=
X-GMAIL-MSGID: =?utf-8?q?1594699644547888395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Lendacky <thomas.lendacky@amd.com>

commit 9c6a73c75864ad9fa49e5fa6513e4c4071c0e29f upstream.

With LFENCE now a serializing instruction, use LFENCE_RDTSC in preference
to MFENCE_RDTSC.  However, since the kernel could be running under a
hypervisor that does not support writing that MSR, read the MSR back and
verify that the bit has been set successfully.  If the MSR can be read
and the bit is set, then set the LFENCE_RDTSC feature, otherwise set the
MFENCE_RDTSC feature.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/20180108220932.12580.52458.stgit@tlendack-t1.amdoffice.net
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/kernel/cpu/amd.c        | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -152,6 +152,7 @@
 #define MSR_FAM10H_NODE_ID		0xc001100c
 #define MSR_F10H_DECFG			0xc0011029
 #define MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT	1
+#define MSR_F10H_DECFG_LFENCE_SERIALIZE		BIT_ULL(MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT)
 
 /* K8 MSRs */
 #define MSR_K8_TOP_MEM1			0xc001001a
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -641,6 +641,9 @@ static void __cpuinit init_amd(struct cp
 		set_cpu_cap(c, X86_FEATURE_K8);
 
 	if (cpu_has_xmm2) {
+		unsigned long long val;
+		int ret;
+
 		/*
 		 * A serializing LFENCE has less overhead than MFENCE, so
 		 * use it for execution serialization.  On families which
@@ -651,8 +654,19 @@ static void __cpuinit init_amd(struct cp
 		msr_set_bit(MSR_F10H_DECFG,
 			    MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT);
 
-		/* MFENCE stops RDTSC speculation */
-		set_cpu_cap(c, X86_FEATURE_MFENCE_RDTSC);
+		/*
+		 * Verify that the MSR write was successful (could be running
+		 * under a hypervisor) and only then assume that LFENCE is
+		 * serializing.
+		 */
+		ret = rdmsrl_safe(MSR_F10H_DECFG, &val);
+		if (!ret && (val & MSR_F10H_DECFG_LFENCE_SERIALIZE)) {
+			/* A serializing LFENCE stops RDTSC speculation */
+			set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
+		} else {
+			/* MFENCE stops RDTSC speculation */
+			set_cpu_cap(c, X86_FEATURE_MFENCE_RDTSC);
+		}
 	}
 
 #ifdef CONFIG_X86_64
