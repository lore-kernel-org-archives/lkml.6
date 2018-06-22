Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097CAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02B423FD4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02B423FD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933645AbeFVJ4P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:56:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41288 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754585AbeFVJye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:54:34 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C1y2P0oGXhXl; Fri, 22 Jun 2018 11:54:33 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF3400329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:3400:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E2B0B1EC0236;
        Fri, 22 Jun 2018 11:54:32 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] x86/mce: Carve out the crashing_cpu check
Date:   Fri, 22 Jun 2018 11:54:24 +0200
Message-Id: <20180622095428.626-4-bp@alien8.de>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c
In-Reply-To: <20180622095428.626-1-bp@alien8.de>
References: <20180622095428.626-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Carve out the rendezvous handler timeout avoidance check into a separate
function in order to simplify the #MC handler.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 64 ++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index c3d08a69194d..ea1521ec7e5b 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1102,6 +1102,34 @@ static void mce_unmap_kpfn(unsigned long pfn)
 }
 #endif
 
+
+/*
+ * Cases where we avoid rendezvous handler timeout:
+ * 1) If this CPU is offline.
+ *
+ * 2) If crashing_cpu was set, e.g. we're entering kdump and we need to
+ *  skip those CPUs which remain looping in the 1st kernel - see
+ *  crash_nmi_callback().
+ *
+ * Note: there still is a small window between kexec-ing and the new,
+ * kdump kernel establishing a new #MC handler where a broadcasted MCE
+ * might not get handled properly.
+ */
+static bool __mc_check_crashing_cpu(int cpu)
+{
+	if (cpu_is_offline(cpu) ||
+	    (crashing_cpu != -1 && crashing_cpu != cpu)) {
+		u64 mcgstatus;
+
+		mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
+		if (mcgstatus & MCG_STATUS_RIPV) {
+			mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
+			return true;
+		}
+	}
+	return false;
+}
+
 /*
  * The actual machine check handler. This only handles real
  * exceptions when something got corrupted coming in through int 18.
@@ -1116,60 +1144,42 @@ static void mce_unmap_kpfn(unsigned long pfn)
  */
 void do_machine_check(struct pt_regs *regs, long error_code)
 {
+	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
+	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
 	struct mca_config *cfg = &mca_cfg;
+	int cpu = smp_processor_id();
+	char *msg = "Unknown";
 	struct mce m, *final;
-	int i;
 	int worst = 0;
 	int severity;
+	int i;
 
 	/*
 	 * Establish sequential order between the CPUs entering the machine
 	 * check handler.
 	 */
 	int order = -1;
+
 	/*
 	 * If no_way_out gets set, there is no safe way to recover from this
 	 * MCE.  If mca_cfg.tolerant is cranked up, we'll try anyway.
 	 */
 	int no_way_out = 0;
+
 	/*
 	 * If kill_it gets set, there might be a way to recover from this
 	 * error.
 	 */
 	int kill_it = 0;
-	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
-	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
-	char *msg = "Unknown";
 
 	/*
 	 * MCEs are always local on AMD. Same is determined by MCG_STATUS_LMCES
 	 * on Intel.
 	 */
 	int lmce = 1;
-	int cpu = smp_processor_id();
-
-	/*
-	 * Cases where we avoid rendezvous handler timeout:
-	 * 1) If this CPU is offline.
-	 *
-	 * 2) If crashing_cpu was set, e.g. we're entering kdump and we need to
-	 *  skip those CPUs which remain looping in the 1st kernel - see
-	 *  crash_nmi_callback().
-	 *
-	 * Note: there still is a small window between kexec-ing and the new,
-	 * kdump kernel establishing a new #MC handler where a broadcasted MCE
-	 * might not get handled properly.
-	 */
-	if (cpu_is_offline(cpu) ||
-	    (crashing_cpu != -1 && crashing_cpu != cpu)) {
-		u64 mcgstatus;
 
-		mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
-		if (mcgstatus & MCG_STATUS_RIPV) {
-			mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
-			return;
-		}
-	}
+	if (__mc_check_crashing_cpu(cpu))
+		return;
 
 	ist_enter(regs);
 
-- 
2.17.0.582.gccdcbd54c

