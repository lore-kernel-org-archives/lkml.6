Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224HSwxDof2AQusf5qj6Wrxe9tQKMuCQBKn8xIforFrBOmyA8sJv9uoy2QARcAR8R0oMhWJN
ARC-Seal: i=1; a=rsa-sha256; t=1518709192; cv=none;
        d=google.com; s=arc-20160816;
        b=Crg4cmysXTuM6bioXFvAJ/p8LFuOT1U0pt+6x4j0U9rMrranpljdM3ac2NOCLEfHe2
         fhlBKoJrSr7qegp3DyToVjRj/Y11l4r68dGd+dsjETYXUR2nQT5+Nn5sE9gCwiiFs/oO
         sGSL/zXIRTtNWRAG+gaU2xP+X/YzlMY3mkE1RKaO+vzCvthdseQGg8Rw1rxdfD8+g8Be
         mbZH/dzGyCxfBOy1O4VGxUDmn9aYYYp4PGC23yDUKc6foRNokEz8FLnsbzDF+uPfIWTl
         m/6ScUEbe0KAWQozZFyPlefrFhnZAuvP5MrRP6TGo4JqEhT36zgoYbgazRcTKstdVX2e
         EZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dNvsdDxQQ8TcTqNw1te6QIoTjbyz7H4I7cXoxGBj/HA=;
        b=zjvTMeiTQWticzZcOtHM9KHpd26N0WYL2hKj3sdgxI0SLpemsLVd5nEWSGpztwXjMY
         vFefrta2PhHNwAp/ZoOghHa1nl0YJ3ELmGsdMST1+w8W5J1VDKEozP+Xm2Ak/otgYTV/
         0fq6F1xmCmWbEqstfIrp9QVWnXPET/P/Uf9QpMycsnsSuAjXpIe5l2sCTBS4ld5xb2GP
         aWR6s2fFnaT8jrusE70lCEdt8q2y0ELxBhlGvMx/ugVyVrN4U69dxUBqavHrFnHGwoqK
         DBLGbegsEXttpPigMrIBbT080sHfQHfu+13MvWjIno31WeffWKjj+67ymosgRmLzqbk8
         TeZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 029/202] [Variant 3/Meltdown] arm64: cpu_errata: Add Kryo to Falkor 1003 errata
Date: Thu, 15 Feb 2018 16:15:29 +0100
Message-Id: <20180215151714.479254507@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481466109671236?=
X-GMAIL-MSGID: =?utf-8?q?1592482009867956803?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Boyd <sboyd@codeaurora.org>


Commit bb48711800e6 upstream.

The Kryo CPUs are also affected by the Falkor 1003 errata, so
we need to do the same workaround on Kryo CPUs. The MIDR is
slightly more complicated here, where the PART number is not
always the same when looking at all the bits from 15 to 4. Drop
the lower 8 bits and just look at the top 4 to see if it's '2'
and then consider those as Kryo CPUs. This covers all the
combinations without having to list them all out.

Fixes: 38fd94b0275c ("arm64: Work around Falkor erratum 1003")
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>

Conflicts:
	arch/arm64/include/asm/cputype.h
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/arm64/silicon-errata.txt |    2 +-
 arch/arm64/include/asm/cputype.h       |    2 ++
 arch/arm64/kernel/cpu_errata.c         |   21 +++++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -72,7 +72,7 @@ stable kernels.
 | Hisilicon      | Hip0{6,7}       | #161010701      | N/A                         |
 | Hisilicon      | Hip07           | #161600802      | HISILICON_ERRATUM_161600802 |
 |                |                 |                 |                             |
-| Qualcomm Tech. | Falkor v1       | E1003           | QCOM_FALKOR_ERRATUM_1003    |
+| Qualcomm Tech. | Kryo/Falkor v1  | E1003           | QCOM_FALKOR_ERRATUM_1003    |
 | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
 | Qualcomm Tech. | QDF2400 ITS     | E0065           | QCOM_QDF2400_ERRATUM_0065   |
 | Qualcomm Tech. | Falkor v{1,2}   | E1041           | QCOM_FALKOR_ERRATUM_1041    |
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -92,6 +92,7 @@
 
 #define QCOM_CPU_PART_FALKOR_V1		0x800
 #define QCOM_CPU_PART_FALKOR		0xC00
+#define QCOM_CPU_PART_KRYO		0x200
 
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
@@ -101,6 +102,7 @@
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
 #define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
 #define MIDR_QCOM_FALKOR MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR)
+#define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
 
 #ifndef __ASSEMBLY__
 
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -30,6 +30,20 @@ is_affected_midr_range(const struct arm6
 				       entry->midr_range_max);
 }
 
+static bool __maybe_unused
+is_kryo_midr(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	u32 model;
+
+	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
+
+	model = read_cpuid_id();
+	model &= MIDR_IMPLEMENTOR_MASK | (0xf00 << MIDR_PARTNUM_SHIFT) |
+		 MIDR_ARCHITECTURE_MASK;
+
+	return model == entry->midr_model;
+}
+
 static bool
 has_mismatched_cache_line_size(const struct arm64_cpu_capabilities *entry,
 				int scope)
@@ -169,6 +183,13 @@ const struct arm64_cpu_capabilities arm6
 			   MIDR_CPU_VAR_REV(0, 0),
 			   MIDR_CPU_VAR_REV(0, 0)),
 	},
+	{
+		.desc = "Qualcomm Technologies Kryo erratum 1003",
+		.capability = ARM64_WORKAROUND_QCOM_FALKOR_E1003,
+		.def_scope = SCOPE_LOCAL_CPU,
+		.midr_model = MIDR_QCOM_KRYO,
+		.matches = is_kryo_midr,
+	},
 #endif
 #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1009
 	{
