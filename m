Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48EFr2b3SKPBRdFyqKhEMXzoEE0ApBz08jlRVpqJg3avzrhKK/6izyZShOYs0GNTGEXjIU8
ARC-Seal: i=1; a=rsa-sha256; t=1523021832; cv=none;
        d=google.com; s=arc-20160816;
        b=poYUcPEvDLdXQxIDsGWwEXu55zeBt85mn67R5vDPSy2KZ9uzZOwyKuxScUbexKjEy7
         PU8gHbLFgMXKMdSd408jugaHn2f76JhPF6l8AYT0xLwG2SKCjjlrAFXyMxVYeoVq7hSK
         yhicaqgdbDMSF4BzE+GbibsBEyKZO/l/LbtSvop3CElnPgAnrGJuAFi8OqM0tcBHLT4Q
         zHdCjce/QJO/cWI9Hp3RL4yfA8dJ9zVGEaNnhR8zeNtC6KrBWOrKyQxltygWQ0CBtRSK
         wrquEU0qRwIF5tQ6sHXlf8jPLt+Al85w8z+cGr5Mj9NimTfkQ9GTQ49NqmGpkqlweuR6
         GpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mDzLJi7GjLM7nUkyH2I3Lp9zn7ahVKjEG68ld7dwTMI=;
        b=whYuNCCNW2+rs8G2hg1LJ9Iy0aQaMXcikNW3yKYLHxM64hmuT1BC0ZrqyJChM99AbB
         8wAl45dvzwrq7SGDwu2IPbFfxDxSmfpTK30IThHHqZXdPIWn1t08ppQ43tej8zFWv1/K
         a93GCvdLLP/RE8PwiX9SW7rgbg6e2My06sghiVBxLgzxR7nPDBDKcJhdKVLBos+vdsrA
         pEOwpDCI4OEbly2Ixkuq+5YXMGzVwUVkHLZ5C/texoWC4J0P0BM2JJ4ojLYkQZ2H6DVN
         bblsXlAHfe/uaajBDAl6ospKZR0bLXoTLe7Q3pXtMbT4zzWRIDEskX/c0WI1zUK5gHsA
         7gjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 4.9 069/102] arm64: capabilities: Handle duplicate entries for a capability
Date: Fri,  6 Apr 2018 15:23:50 +0200
Message-Id: <20180406084341.167811426@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004140451466226?=
X-GMAIL-MSGID: =?utf-8?q?1597004140451466226?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit 67948af41f2e upstream.

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
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |   44 +++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -969,6 +969,26 @@ static void __init setup_elf_hwcaps(cons
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
@@ -1037,8 +1057,9 @@ verify_local_elf_hwcaps(const struct arm
 }
 
 static void
-verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
+verify_local_cpu_features(const struct arm64_cpu_capabilities *caps_list)
 {
+	const struct arm64_cpu_capabilities *caps = caps_list;
 	for (; caps->matches; caps++) {
 		if (!cpus_have_cap(caps->capability))
 			continue;
@@ -1046,7 +1067,7 @@ verify_local_cpu_features(const struct a
 		 * If the new CPU misses an advertised feature, we cannot proceed
 		 * further, park the cpu.
 		 */
-		if (!caps->matches(caps, SCOPE_LOCAL_CPU)) {
+		if (!__this_cpu_has_cap(caps_list, caps->capability)) {
 			pr_crit("CPU%d: missing feature: %s\n",
 					smp_processor_id(), caps->desc);
 			cpu_die_early();
@@ -1099,25 +1120,6 @@ static void __init setup_feature_capabil
 	enable_cpu_capabilities(arm64_features);
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
