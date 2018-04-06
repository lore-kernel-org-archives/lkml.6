Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/xKhAcugLP+7euFsTe3lwBEjG4quLg6kFEfk0TycRTO7i0pRoHW6citnWHHtlfVyLmx9o0
ARC-Seal: i=1; a=rsa-sha256; t=1523021769; cv=none;
        d=google.com; s=arc-20160816;
        b=LUoBr4Dm+VtEB4O8mCC8NCcwBCxFdy8jOkXRJk/GjpZWd05r9VqJ4/ixsXRB4/fTS0
         5DpNlueoq988lGLrsi4Mwi9QvxJLRwsSL2UjVhgBrVJ/DmbsaQAXXefmBDZlXHQS+JHc
         80H2H2YvpN6o6Wm/9sG1ympxd5ePR/k1dHqHbME4opHCYthNvH+SGlYzAXZ9LcduMsBZ
         33OhKwJOZq7gzTMxVDNUWXdmvOMz08keaz1RlhzyRT4v3CSX4G9oGxb091FA+I/Ly/NT
         RUCH9tK+gC/j4+MNSTIj2/Uk7HbFDdR4vkLeHxVZxUkNyTPtzef/SJvRJjwUVN17KI2Y
         MQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Pqnl96G2SvEmTKLa0HJaFX0skUSrHtCwmwDfIsqWVBE=;
        b=PeXlsUX73Bo5r4H6Py9i2e83z0Y4Uy/iUuR6EJKFiTH2nqWd5ILTSrc/ic68oy3gIx
         prfTZcy93arZownv1rK1Raamli40CX9F5omRCZHUxpyVw46SmGCGYxZ/eRmuQHdC1m1s
         dxI55apHmr6sl10vN3OFFwlPMAa7SKqKVglXLhrLZ3YsP9wGMuq21krYmlvHOJp85UzF
         KO20WGQyGvnYqcwNdXUA7QJNXQ40a+uLDguQNEBoQfPh+LmZuKVsp5DCCmPf7s1lxOPY
         d2nbqeUER1KdFo7+Sm2qHkjwMk46WVeb4uOmISqj3HWGfTXxRxK2xv5HNmCn3vGj3MVD
         GVHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Alex Shi <alex.shi@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 067/102] arm64: Take into account ID_AA64PFR0_EL1.CSV3
Date: Fri,  6 Apr 2018 15:23:48 +0200
Message-Id: <20180406084340.929989915@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004075069112100?=
X-GMAIL-MSGID: =?utf-8?q?1597004075069112100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 179a56f6f9fb upstream.

For non-KASLR kernels where the KPTI behaviour has not been overridden
on the command line we can use ID_AA64PFR0_EL1.CSV3 to determine whether
or not we should unmap the kernel whilst running at EL0.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[Alex: s/read_sanitised_ftr_reg/read_system_reg/ to match v4.9 naming]
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
[Mark: correct zero bits in ftr_id_aa64pfr0 to account for CSV3]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/sysreg.h |    1 +
 arch/arm64/kernel/cpufeature.c  |   10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -117,6 +117,7 @@
 #define ID_AA64ISAR0_AES_SHIFT		4
 
 /* id_aa64pfr0 */
+#define ID_AA64PFR0_CSV3_SHIFT		60
 #define ID_AA64PFR0_GIC_SHIFT		24
 #define ID_AA64PFR0_ASIMD_SHIFT		20
 #define ID_AA64PFR0_FP_SHIFT		16
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -93,7 +93,8 @@ static const struct arm64_ftr_bits ftr_i
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
+	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV3_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 28, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64PFR0_GIC_SHIFT, 4, 0),
 	S_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_ASIMD_SHIFT, 4, ID_AA64PFR0_ASIMD_NI),
@@ -752,6 +753,8 @@ static int __kpti_forced; /* 0: not forc
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 				int __unused)
 {
+	u64 pfr0 = read_system_reg(SYS_ID_AA64PFR0_EL1);
+
 	/* Forced on command line? */
 	if (__kpti_forced) {
 		pr_info_once("kernel page table isolation forced %s by command line option\n",
@@ -763,7 +766,9 @@ static bool unmap_kernel_at_el0(const st
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
 		return true;
 
-	return false;
+	/* Defer to CPU feature registers */
+	return !cpuid_feature_extract_unsigned_field(pfr0,
+						     ID_AA64PFR0_CSV3_SHIFT);
 }
 
 static int __init parse_kpti(char *str)
@@ -865,6 +870,7 @@ static const struct arm64_cpu_capabiliti
 	},
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	{
+		.desc = "Kernel page table isolation (KPTI)",
 		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
 		.def_scope = SCOPE_SYSTEM,
 		.matches = unmap_kernel_at_el0,
