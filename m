Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224Bw3XOjsYLT8XSkltL75wGOQPgH3ZX/Rfqzu6tdnj65f2355jtjF1Acg8rJz3Kt5AI7J1/
ARC-Seal: i=1; a=rsa-sha256; t=1518708695; cv=none;
        d=google.com; s=arc-20160816;
        b=lrQF7hPTb32s0V7XEDbu6sZDnK7f+iHO5YHPTum7RI52XXmtberDGma40njo4yenlV
         ixu4AB5Mq9/6nktTh5eLqFneVmzx39M9CZOLNjDYXjO1DFRoVgTi9k0tiWhbwAFS6V0P
         lUwbzC2hmgVBjyJpT49wIUqA9j1k7LhqdJu06rA1b2VaylIUvf4Y+Cjd/+C8tpvdIKdg
         6hXxfUTQZomMaeunJ5gfdPeg03+/PmPl5YuCAplRfle+xVofBdRdmm8G+87MEYvp0slq
         y81w07jgzMfeJGarJMTqNd1LmdhCae5uxM6zcHdzqMIOfYj3WHNnxGazoghnsEqdcF6h
         II1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0zcUhgodgae+/xqhbVM2sIZ81isZt8LVqm/Mn5SJzMA=;
        b=aaoc4VUFXC05/BXTVsvyx3uXvwnaYApOA5G8kbXTUP2otLm0AA5b+s99hIHllCkVz2
         SQJ5aNztUVk9P6t+6zPe4nSX1ox/oxMhk/owp7vB1ZbxZd68LjQUJV6uAhwVHGg6iFTS
         MNUVDP/WlNxweQg5hUAY8vvbJFMrrOGvESQvy0DaQtltDEsQZtzTBbrbRGg4EklWOymK
         vfmJzRWur9YfpXhmmrusP31o6Mw1RO2pK7LhODxBZHi1/V6RxhTP4FpRnZ6YQc7vBTL1
         26yp8513UiKvW8G8o1rVWu/J2JiH31cT2hXbWfI21m421OB1RV3IyoNWE7AylioSdx2h
         u6rg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 045/195] [Variant 3/Meltdown] arm64: capabilities: Handle duplicate entries for a capability
Date: Thu, 15 Feb 2018 16:15:36 +0100
Message-Id: <20180215151707.993743572@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481488921961437?=
X-GMAIL-MSGID: =?utf-8?q?1592481488921961437?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suzuki K Poulose <suzuki.poulose@arm.com>


Commit 67948af41f2e upstream.

Sometimes a single capability could be listed multiple times with
differing matches(), e.g, CPU errata for different MIDR versions.
This breaks verify_local_cpu_feature() and this_cpu_has_cap() as
we stop checking for a capability on a CPU with the first
entry in the given table, which is not sufficient. Make sure we
run the checks for all entries of the same capability. We do
this by fixing __this_cpu_has_cap() to run through all the
entries in the given table for a match and reuse it for
verify_local_cpu_feature().

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |   44 +++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1047,6 +1047,26 @@ static void __init setup_elf_hwcaps(cons
 			cap_set_elf_hwcap(hwcaps);
 }
 
+/*
+ * Check if the current CPU has a given feature capability.
+ * Should be called from non-preemptible context.
+ */
+static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
+			       unsigned int cap)
+{
+	const struct arm64_cpu_capabilities *caps;
+
+	if (WARN_ON(preemptible()))
+		return false;
+
+	for (caps = cap_array; caps->desc; caps++)
+		if (caps->capability == cap &&
+		    caps->matches &&
+		    caps->matches(caps, SCOPE_LOCAL_CPU))
+			return true;
+	return false;
+}
+
 void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info)
 {
@@ -1125,8 +1145,9 @@ verify_local_elf_hwcaps(const struct arm
 }
 
 static void
-verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
+verify_local_cpu_features(const struct arm64_cpu_capabilities *caps_list)
 {
+	const struct arm64_cpu_capabilities *caps = caps_list;
 	for (; caps->matches; caps++) {
 		if (!cpus_have_cap(caps->capability))
 			continue;
@@ -1134,7 +1155,7 @@ verify_local_cpu_features(const struct a
 		 * If the new CPU misses an advertised feature, we cannot proceed
 		 * further, park the cpu.
 		 */
-		if (!caps->matches(caps, SCOPE_LOCAL_CPU)) {
+		if (!__this_cpu_has_cap(caps_list, caps->capability)) {
 			pr_crit("CPU%d: missing feature: %s\n",
 					smp_processor_id(), caps->desc);
 			cpu_die_early();
@@ -1195,25 +1216,6 @@ static void __init mark_const_caps_ready
 	static_branch_enable(&arm64_const_caps_ready);
 }
 
-/*
- * Check if the current CPU has a given feature capability.
- * Should be called from non-preemptible context.
- */
-static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
-			       unsigned int cap)
-{
-	const struct arm64_cpu_capabilities *caps;
-
-	if (WARN_ON(preemptible()))
-		return false;
-
-	for (caps = cap_array; caps->desc; caps++)
-		if (caps->capability == cap && caps->matches)
-			return caps->matches(caps, SCOPE_LOCAL_CPU);
-
-	return false;
-}
-
 extern const struct arm64_cpu_capabilities arm64_errata[];
 
 bool this_cpu_has_cap(unsigned int cap)
