Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvmxMYYb7Ry5rSgQLRWnKOWqhHFIcH2xv8S7hjwTJzDUuc5Cy3xR9LkgXkrQKZH2kP7L3Ly
ARC-Seal: i=1; a=rsa-sha256; t=1520824085; cv=none;
        d=google.com; s=arc-20160816;
        b=dnufvrhAQoVf8r3S7PzHfzP3YWukf+3kxw1ZJhSUwmMw5QPUktXCyjSrFIL0CGjCNw
         BuT+0pmiarH5D9H+2V0F9J5o03p4qV0FHbD4XZBsX2qYcSHUsHQVv82hGya7AHkfNqEB
         1s32IdtusAZf5tue6RruwC5Bf1fmFtMbOujXVj5G5NhkvkX118AtiELkeSg1Jsm4CbIj
         u2e4V4TvLXkPz8IRChgSNhpdmaL2DWfQJZTmsjrXDAr+eFxRkT+c2BzT3GT/mQopMngY
         JOlac32TiK0jLiua1e8PgAi/9fd1SQU9WB1YkYa9CMzZzGGtcKG5BQ71q3HXASZtblTw
         i2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=abNQd2CjSm5dSbYTmE553kVyUpLGRGmq7MhDhmp3334=;
        b=ozlRAdWNOACB6uLaiSHRN6KI+fhNzzmaUcHPCSekH7JqlNUlw+ocCqQHRFOuzVZSO6
         bszKzPybWe0TV31T1EIlNjbG2CCRQUBiS8JyDpg1csqAB93h98bTGKeO0iMRxt0VhIpv
         YINWvKFwStdr5C7YIVUWPY6tREG9FAeLF09aMEXlinfEZ7CQdnnCjLyzhX+d9wx+br5n
         vdLdzJi6VPVSV7Fj4BzzLaDv1VkyKbE14XvQwFREe3Yd1nMItkeRs7Nx6HkcHWyNO7i0
         oenYQh7PZj2Tg6lJPbTOS+118xCYHCUocaRoqpLkeAtGEbN7TcjksnfYC9Tw5QovY4cE
         Scsg==
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
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Reviewed-by: Borislav Petkov" <bp@suse.de>,
 "Paul Turner" <pjt@google.com>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Borislav Petkov" <bp@alien8.de>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Dave Hansen" <dave.hansen@intel.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.884519379@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 18/76] x86/cpu/AMD: Use LFENCE_RDTSC in preference to
 MFENCE_RDTSC
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699644547888395?=
X-GMAIL-MSGID: =?utf-8?q?1594699636158530968?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/uapi/asm/msr-index.h |  1 +
 arch/x86/kernel/cpu/amd.c             | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

--- a/arch/x86/include/uapi/asm/msr-index.h
+++ b/arch/x86/include/uapi/asm/msr-index.h
@@ -225,6 +225,7 @@
 #define MSR_FAM10H_NODE_ID		0xc001100c
 #define MSR_F10H_DECFG			0xc0011029
 #define MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT	1
+#define MSR_F10H_DECFG_LFENCE_SERIALIZE		BIT_ULL(MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT)
 
 /* K8 MSRs */
 #define MSR_K8_TOP_MEM1			0xc001001a
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -673,6 +673,9 @@ static void init_amd(struct cpuinfo_x86
 		set_cpu_cap(c, X86_FEATURE_K8);
 
 	if (cpu_has_xmm2) {
+		unsigned long long val;
+		int ret;
+
 		/*
 		 * A serializing LFENCE has less overhead than MFENCE, so
 		 * use it for execution serialization.  On families which
@@ -683,8 +686,19 @@ static void init_amd(struct cpuinfo_x86
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
