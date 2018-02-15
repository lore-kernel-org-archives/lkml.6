Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518709222-2-4370722684113488079
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518709222; b=j54KdYe/oO/Uf/kBSG7/MRDLeqBH3gbIGGtIcAMs9aKCYCe
    gOjFdZGE5EMvGKUbZZVobyPapNlVhytpBYhTaf4e3IRfy3RO6Av/QyCGfs/p0S/W
    8r9trOnOeW+3qQNf5xPwxQFfzr963rNVp9DKDgvLOtvabnfO4zoWcZ0drtSPJviZ
    yujZXdW8cd4o761afsanNXfzUN6g1pDbDJTMJpJism/Icrp3uanVUA6fQGuGXlKX
    6i/2/B71XBPo3VNpQp1MBDddzWfjehsRCflQyaJUfBSPThmvh2X/tYQJCwdVZJdm
    OEaqXPC2YN5cj1XT2XItkwOxISIWdo9EaBaENtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709222; bh=V/wfB22QHuq2mq9SPS5mNW1r2Z
    fgXiGBsIefq3xJFg8=; b=U6cPz7poSU8fzmYGlXJ1xTA6hkz0hB+rTXupLTNMcu
    0bx524mMYBmo4j+5TZM9MDR41Dh/9r3W6YFW8Fr6pFaGt2Hhr8guxO3EULqA+jg4
    qDgd26ud7eZt+T08lnwffjbC5P1bMQaMPJihUUq7wW5VweLqJXyL1xIKAn33CxfL
    hripB4HKk4HGK3GhPhQ0DuAY+bj+JZprU7qWTF82/XnENTCR94+KQgHJHcpu4Kaq
    qytp/7l157CkUlEWdtUlrS+jrSTZWC9C4QXo1KtWzb4f6fXJXnsmYL2vJuA2aSiG
    JE/riQEBizbErfww5uNlecO+nNpg2H3Jp7/IekHpGH4g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423689AbeBOPkR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:40:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60042 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423276AbeBOPkP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:40:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 037/202] [Variant 3/Meltdown] arm64: capabilities: Handle duplicate entries for a capability
Date: Thu, 15 Feb 2018 16:15:37 +0100
Message-Id: <20180215151714.969419389@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |   44 +++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1118,6 +1118,26 @@ static void __init setup_elf_hwcaps(cons
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
@@ -1181,8 +1201,9 @@ verify_local_elf_hwcaps(const struct arm
 }
 
 static void
-verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
+verify_local_cpu_features(const struct arm64_cpu_capabilities *caps_list)
 {
+	const struct arm64_cpu_capabilities *caps = caps_list;
 	for (; caps->matches; caps++) {
 		if (!cpus_have_cap(caps->capability))
 			continue;
@@ -1190,7 +1211,7 @@ verify_local_cpu_features(const struct a
 		 * If the new CPU misses an advertised feature, we cannot proceed
 		 * further, park the cpu.
 		 */
-		if (!caps->matches(caps, SCOPE_LOCAL_CPU)) {
+		if (!__this_cpu_has_cap(caps_list, caps->capability)) {
 			pr_crit("CPU%d: missing feature: %s\n",
 					smp_processor_id(), caps->desc);
 			cpu_die_early();
@@ -1272,25 +1293,6 @@ static void __init mark_const_caps_ready
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
