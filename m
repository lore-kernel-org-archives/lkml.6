Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226lYxUCzi40jvNVNn71eO9oVlHc3ZDjMRqUkZJ2H5zuSiP91GAaCe7fdQ+Dfiru5nu6z+m0
ARC-Seal: i=1; a=rsa-sha256; t=1518709214; cv=none;
        d=google.com; s=arc-20160816;
        b=aGfBjwMqBoTLWQqFJfUeqkk/pB+KC56CTAozX3h4Di6Baot5SiNGmwTwrxbtO4yDXU
         7iy0LmlSY3F+HNCfwHPbypM7hztcaypgMK0195ryVe9jJaFeYRezKC2qGtYmm+Vb4j6k
         asNv8hg80YeS46yI4ZEW730fjtOxWy+4oFSsVyDTlW88XkUpvCEA1rm/edh0UjmKW3sx
         2TyXLTQTeiEr6dvq/sp/2vl/XBqmctMQ6ULQ2ehhDsogKBFGBR+lsoCP0v4TwAnQwFoR
         3gnKQiIsBTJunYfN38epyT+girD/0xyG8wJR1kjmeOBvb8iDnQz+8NKOE9T5oD2z/Not
         yGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4MwcmmNSsyfpuMv98DfigU1FydjePj78c5jOc8I/aVc=;
        b=I4HV3iHczEgcZfWQqtgbk6q2sROtoKcfDoI9GmmV5OPHYLjUHDcJxr3wMNfqK3DGyp
         ZAGA8uTzVJW7JYlZPEwjQYYGYu/YMgpYuCPoaq/0kpZ0jsbvYVDfM8gJeRG9EAI1Hb6N
         LSZYStt298GoQG7rTc4RixGENrStSsFgE0w5+P1kPCOOCKTcAdLIsyQiq3I2EORL5MHd
         Wwz9kJQTCuFp0UnhZxztBaZrAQzNvuRibjRVNueGctRv+9goLpI5BEgVbpVDh2O24Kls
         J3AWc/q4BIYHFyZYQY/XCaBTX6Cpy0DVzOLrkjpbsOVc7XwTiAHtGmPLqe4UMMkk/p5L
         agfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 036/202] [Variant 3/Meltdown] arm64: Take into account ID_AA64PFR0_EL1.CSV3
Date: Thu, 15 Feb 2018 16:15:36 +0100
Message-Id: <20180215151714.896334852@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481486304015991?=
X-GMAIL-MSGID: =?utf-8?q?1592482032772141018?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 179a56f6f9fb upstream.

For non-KASLR kernels where the KPTI behaviour has not been overridden
on the command line we can use ID_AA64PFR0_EL1.CSV3 to determine whether
or not we should unmap the kernel whilst running at EL0.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Conflicts:
	arch/arm64/kernel/cpufeature.c
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/sysreg.h |    1 +
 arch/arm64/kernel/cpufeature.c  |    8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -437,6 +437,7 @@
 #define ID_AA64ISAR1_DPB_SHIFT		0
 
 /* id_aa64pfr0 */
+#define ID_AA64PFR0_CSV3_SHIFT		60
 #define ID_AA64PFR0_SVE_SHIFT		32
 #define ID_AA64PFR0_GIC_SHIFT		24
 #define ID_AA64PFR0_ASIMD_SHIFT		20
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -145,6 +145,7 @@ static const struct arm64_ftr_bits ftr_i
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV3_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
 				   FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_SVE_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_GIC_SHIFT, 4, 0),
@@ -852,6 +853,8 @@ static int __kpti_forced; /* 0: not forc
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 				int __unused)
 {
+	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
+
 	/* Forced on command line? */
 	if (__kpti_forced) {
 		pr_info_once("kernel page table isolation forced %s by command line option\n",
@@ -863,7 +866,9 @@ static bool unmap_kernel_at_el0(const st
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
 		return true;
 
-	return false;
+	/* Defer to CPU feature registers */
+	return !cpuid_feature_extract_unsigned_field(pfr0,
+						     ID_AA64PFR0_CSV3_SHIFT);
 }
 
 static int __init parse_kpti(char *str)
@@ -968,6 +973,7 @@ static const struct arm64_cpu_capabiliti
 	},
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	{
+		.desc = "Kernel page table isolation (KPTI)",
 		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
 		.def_scope = SCOPE_SYSTEM,
 		.matches = unmap_kernel_at_el0,
