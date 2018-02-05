Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224nC9l6V5SqWJpeHgO4iB4sXGAkgeL0PUHlCd0PE5o8NIGtp5HNHhv8YH0JoRb0YCetLaE0
ARC-Seal: i=1; a=rsa-sha256; t=1517855152; cv=none;
        d=google.com; s=arc-20160816;
        b=jsieYzQ4SwDMiOd6w7E0I7te9+gGDMVhhJPhVMFtbhnHf84IqokiG2ZuevbtEFXUZ3
         q3qBZJTnCDGq0FmRRVF6XpJ/PJ0u53F7Q09UnIvsaCYpU3NTxr+QiVW7sSzP9JkWHhVa
         Vrfs8y8RIip4K79nZzfzdas6c+drZ08ahxBYYSCqQPPk+Pc2GLZDNXUsRMThoPNG0TnC
         +8qnuanKq6GJUHuH41gW0OKcQlNHbIjAdQzGmTpqu8zCyOWnxqezhasep9h/Negy4ICB
         JBHZ7+C2BUy5BiKPaQQqNEWo62Kv7mALuOtSZXB6BS7FfxqLnOzP61plB7FE6l8gwAc+
         csAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9rZGbRa39u3f+GfUMz5sjegZ0dbVPMp/EBcsHr1MLIU=;
        b=LgyMFr5wTdPvGDexKDSf9WPoiHtNoLlNHjjwK4CMu8B14JXNmUPAU9N1Z748zPNUOk
         C7vkZAyU98sWNlsYrwPe/2VIblIZcWgNnXokRAW/nizuKJgZSrvzne9zHqR9HAGCsnCC
         quOawNCw3ZmCgaRpr/fjdtc63sl9jU2Mr2tFqSYqNzlbLpKfikP22sgSJDnLUzYFFQzE
         Or/hcWyX9YgNvxrKsu3Y0BX/s6hJTq8nZQ1wtQR9a/EwQNUpbMUwhNBNcXVqgAM8SDP+
         twQEmWabZGS4eMXUXQCfQe7JUePo426G5WwpDt5V1K0aolDwuDaIv4C8GUUjIDBCwGda
         CYKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	karahmed@amazon.de,
	peterz@infradead.org,
	bp@alien8.de
Subject: [PATCH 4.15 45/60] x86/cpuid: Fix up "virtual" IBRS/IBPB/STIBP feature bits on Intel
Date: Mon,  5 Feb 2018 10:23:18 -0800
Message-Id: <20180205182215.828953926@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586391485405299?=
X-GMAIL-MSGID: =?utf-8?q?1591586483846874098?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse dwmw@amazon.co.uk

commit 7fcae1118f5fd44a862aa5c3525248e35ee67c3b

Despite the fact that all the other code there seems to be doing it, just
using set_cpu_cap() in early_intel_init() doesn't actually work.

For CPUs with PKU support, setup_pku() calls get_cpu_cap() after
c->c_init() has set those feature bits. That resets those bits back to what
was queried from the hardware.

Turning the bits off for bad microcode is easy to fix. That can just use
setup_clear_cpu_cap() to force them off for all CPUs.

I was less keen on forcing the feature bits *on* that way, just in case
of inconsistencies. I appreciate that the kernel is going to get this
utterly wrong if CPU features are not consistent, because it has already
applied alternatives by the time secondary CPUs are brought up.

But at least if setup_force_cpu_cap() isn't being used, we might have a
chance of *detecting* the lack of the corresponding bit and either
panicking or refusing to bring the offending CPU online.

So ensure that the appropriate feature bits are set within get_cpu_cap()
regardless of how many extra times it's called.

Fixes: 2961298e ("x86/cpufeatures: Clean up Spectre v2 related CPUID flags")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: karahmed@amazon.de
Cc: peterz@infradead.org
Cc: bp@alien8.de
Link: https://lkml.kernel.org/r/1517322623-15261-1-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kernel/cpu/common.c |   21 +++++++++++++++++++++
 arch/x86/kernel/cpu/intel.c  |   27 ++++++++-------------------
 2 files changed, 29 insertions(+), 19 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -750,6 +750,26 @@ static void apply_forced_caps(struct cpu
 	}
 }
 
+static void init_speculation_control(struct cpuinfo_x86 *c)
+{
+	/*
+	 * The Intel SPEC_CTRL CPUID bit implies IBRS and IBPB support,
+	 * and they also have a different bit for STIBP support. Also,
+	 * a hypervisor might have set the individual AMD bits even on
+	 * Intel CPUs, for finer-grained selection of what's available.
+	 *
+	 * We use the AMD bits in 0x8000_0008 EBX as the generic hardware
+	 * features, which are visible in /proc/cpuinfo and used by the
+	 * kernel. So set those accordingly from the Intel bits.
+	 */
+	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
+		set_cpu_cap(c, X86_FEATURE_IBRS);
+		set_cpu_cap(c, X86_FEATURE_IBPB);
+	}
+	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))
+		set_cpu_cap(c, X86_FEATURE_STIBP);
+}
+
 void get_cpu_cap(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
@@ -844,6 +864,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_8000_000A_EDX] = cpuid_edx(0x8000000a);
 
 	init_scattered_cpuid_features(c);
+	init_speculation_control(c);
 
 	/*
 	 * Clear/Set all flags overridden by options, after probe.
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -175,28 +175,17 @@ static void early_init_intel(struct cpui
 	if (c->x86 >= 6 && !cpu_has(c, X86_FEATURE_IA64))
 		c->microcode = intel_get_microcode_revision();
 
-	/*
-	 * The Intel SPEC_CTRL CPUID bit implies IBRS and IBPB support,
-	 * and they also have a different bit for STIBP support. Also,
-	 * a hypervisor might have set the individual AMD bits even on
-	 * Intel CPUs, for finer-grained selection of what's available.
-	 */
-	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
-		set_cpu_cap(c, X86_FEATURE_IBRS);
-		set_cpu_cap(c, X86_FEATURE_IBPB);
-	}
-	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))
-		set_cpu_cap(c, X86_FEATURE_STIBP);
-
 	/* Now if any of them are set, check the blacklist and clear the lot */
-	if ((cpu_has(c, X86_FEATURE_IBRS) || cpu_has(c, X86_FEATURE_IBPB) ||
+	if ((cpu_has(c, X86_FEATURE_SPEC_CTRL) ||
+	     cpu_has(c, X86_FEATURE_INTEL_STIBP) ||
+	     cpu_has(c, X86_FEATURE_IBRS) || cpu_has(c, X86_FEATURE_IBPB) ||
 	     cpu_has(c, X86_FEATURE_STIBP)) && bad_spectre_microcode(c)) {
 		pr_warn("Intel Spectre v2 broken microcode detected; disabling Speculation Control\n");
-		clear_cpu_cap(c, X86_FEATURE_IBRS);
-		clear_cpu_cap(c, X86_FEATURE_IBPB);
-		clear_cpu_cap(c, X86_FEATURE_STIBP);
-		clear_cpu_cap(c, X86_FEATURE_SPEC_CTRL);
-		clear_cpu_cap(c, X86_FEATURE_INTEL_STIBP);
+		setup_clear_cpu_cap(X86_FEATURE_IBRS);
+		setup_clear_cpu_cap(X86_FEATURE_IBPB);
+		setup_clear_cpu_cap(X86_FEATURE_STIBP);
+		setup_clear_cpu_cap(X86_FEATURE_SPEC_CTRL);
+		setup_clear_cpu_cap(X86_FEATURE_INTEL_STIBP);
 	}
 
 	/*
