Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225mWeW2HNtuHESwdme1AlGWIuTpAcHWbG2iX53i+1g9yQGj8gLY7jXiXoT8kQ9B8MhVyPIF
ARC-Seal: i=1; a=rsa-sha256; t=1518708692; cv=none;
        d=google.com; s=arc-20160816;
        b=Yr8aD+9FjWEU5fpF4lgvVW7/NGTfhI6zseftNKPv/DUdqh/yG/zjjCU4FLdr+On5X0
         Tdt3DicMFaLV9aCBitDLYVtS//f5vohwiyP3f8hRH01dZnJXPytuKKfvjavQp2LdX3gq
         ovQZRUzOnDyuOO5z0NKzoiXijjjxnAfelZw2BqHv5AmFZEy7PdupUhcrGYlMxHHdKwn7
         eS9RIwy1KNt+2E7FSk4N539PpPZTYv3L2aSCFI74Zr2yZKUGMCIJV6yseORBPISCLdGN
         u/wmPb+ZoAJVRd+g547zJnS9Er13m/jeSBE87OI2lb9o3RtA0htOmmo3IHX1h7ryni2V
         gk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ybDRaJKukXacpHceIHP4VQPUP76yhZxpH6A09GAVaMQ=;
        b=wQ5dBG7EcRdlPaDiMTAiMryAsWH41a1vTyaOR6Lt36hAl9+aee9NdmYnUH4J8ZXmoI
         k0SC6Uk237SLnahVnoE5hmUteaW3MTIA0XYsfgYUEZPGaF3Kz6fKlxyi7UFiyg+wOJNw
         dQ5MmAvbs3eDVgaiHr1sI3Sudep8wlrbElKKG5qYkT9F3Kq2HgVGQRKq4pXGTwPulbXf
         IyTs5GyXZC1hwE0e+8eNd1y18JlunllftZ4ZZIOhVydbvHD8n51frG6DA+rdnHJb9jvW
         Aue0OYqOZlHcnGD4zcgUvty3XV1RVLe6oc3NeeiHe50dOCCz89TYtAqPOwm1Ef5d/4u0
         oBGw==
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 044/195] [Variant 3/Meltdown] arm64: Take into account ID_AA64PFR0_EL1.CSV3
Date: Thu, 15 Feb 2018 16:15:35 +0100
Message-Id: <20180215151707.956436638@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481486304015991?=
X-GMAIL-MSGID: =?utf-8?q?1592481486304015991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 179a56f6f9fb upstream.

For non-KASLR kernels where the KPTI behaviour has not been overridden
on the command line we can use ID_AA64PFR0_EL1.CSV3 to determine whether
or not we should unmap the kernel whilst running at EL0.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/sysreg.h |    1 +
 arch/arm64/kernel/cpufeature.c  |    8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -332,6 +332,7 @@
 #define ID_AA64ISAR1_DPB_SHIFT		0
 
 /* id_aa64pfr0 */
+#define ID_AA64PFR0_CSV3_SHIFT		60
 #define ID_AA64PFR0_GIC_SHIFT		24
 #define ID_AA64PFR0_ASIMD_SHIFT		20
 #define ID_AA64PFR0_FP_SHIFT		16
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -125,6 +125,7 @@ static const struct arm64_ftr_bits ftr_i
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV3_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64PFR0_GIC_SHIFT, 4, 0),
 	S_ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_ASIMD_SHIFT, 4, ID_AA64PFR0_ASIMD_NI),
 	S_ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_FP_SHIFT, 4, ID_AA64PFR0_FP_NI),
@@ -802,6 +803,8 @@ static int __kpti_forced; /* 0: not forc
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 				int __unused)
 {
+	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
+
 	/* Forced on command line? */
 	if (__kpti_forced) {
 		pr_info_once("kernel page table isolation forced %s by command line option\n",
@@ -813,7 +816,9 @@ static bool unmap_kernel_at_el0(const st
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
 		return true;
 
-	return false;
+	/* Defer to CPU feature registers */
+	return !cpuid_feature_extract_unsigned_field(pfr0,
+						     ID_AA64PFR0_CSV3_SHIFT);
 }
 
 static int __init parse_kpti(char *str)
@@ -918,6 +923,7 @@ static const struct arm64_cpu_capabiliti
 	},
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	{
+		.desc = "Kernel page table isolation (KPTI)",
 		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
 		.def_scope = SCOPE_SYSTEM,
 		.matches = unmap_kernel_at_el0,
