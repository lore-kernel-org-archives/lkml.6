Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDF1C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9295723FE3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9295723FE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933424AbeFVJyk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:54:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41278 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932963AbeFVJyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:54:35 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UtgD7-ySIHzA; Fri, 22 Jun 2018 11:54:34 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF3400329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:3400:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F7451EC0853;
        Fri, 22 Jun 2018 11:54:34 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] x86/mce: Carve out bank scanning code
Date:   Fri, 22 Jun 2018 11:54:26 +0200
Message-Id: <20180622095428.626-6-bp@alien8.de>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c
In-Reply-To: <20180622095428.626-1-bp@alien8.de>
References: <20180622095428.626-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Carve out the scan loop into a separate function.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 134 ++++++++++++++++---------------
 1 file changed, 71 insertions(+), 63 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 05d2d15a95bd..5e834bad4eaf 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1130,6 +1130,76 @@ static bool __mc_check_crashing_cpu(int cpu)
 	return false;
 }
 
+static void __mc_scan_banks(struct mce *m, struct mce *final,
+			    unsigned long *toclear, unsigned long *valid_banks,
+			    int no_way_out, int *worst)
+{
+	struct mca_config *cfg = &mca_cfg;
+	int severity, i;
+
+	for (i = 0; i < cfg->banks; i++) {
+		__clear_bit(i, toclear);
+		if (!test_bit(i, valid_banks))
+			continue;
+		if (!mce_banks[i].ctl)
+			continue;
+
+		m->misc = 0;
+		m->addr = 0;
+		m->bank = i;
+
+		m->status = mce_rdmsrl(msr_ops.status(i));
+		if ((m->status & MCI_STATUS_VAL) == 0)
+			continue;
+
+		/*
+		 * Non uncorrected or non signaled errors are handled by
+		 * machine_check_poll. Leave them alone, unless this panics.
+		 */
+		if (!(m->status & (cfg->ser ? MCI_STATUS_S : MCI_STATUS_UC)) &&
+			!no_way_out)
+			continue;
+
+		/*
+		 * Set taint even when machine check was not enabled.
+		 */
+		add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
+
+		severity = mce_severity(m, cfg->tolerant, NULL, true);
+
+		/*
+		 * When machine check was for corrected/deferred handler don't
+		 * touch, unless we're panicing.
+		 */
+		if ((severity == MCE_KEEP_SEVERITY ||
+		     severity == MCE_UCNA_SEVERITY) && !no_way_out)
+			continue;
+		__set_bit(i, toclear);
+		if (severity == MCE_NO_SEVERITY) {
+			/*
+			 * Machine check event was not enabled. Clear, but
+			 * ignore.
+			 */
+			continue;
+		}
+
+		mce_read_aux(m, i);
+
+		/* assuming valid severity level != 0 */
+		m->severity = severity;
+
+		mce_log(m);
+
+		if (severity > *worst) {
+			*final = *m;
+			*worst = severity;
+		}
+	}
+
+	/* mce_clear_state will clear *final, save locally for use later */
+	*m = *final;
+}
+
 /*
  * The actual machine check handler. This only handles real
  * exceptions when something got corrupted coming in through int 18.
@@ -1151,8 +1221,6 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 	char *msg = "Unknown";
 	struct mce m, *final;
 	int worst = 0;
-	int severity;
-	int i;
 
 	/*
 	 * Establish sequential order between the CPUs entering the machine
@@ -1225,67 +1293,7 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 		order = mce_start(&no_way_out);
 	}
 
-	for (i = 0; i < cfg->banks; i++) {
-		__clear_bit(i, toclear);
-		if (!test_bit(i, valid_banks))
-			continue;
-		if (!mce_banks[i].ctl)
-			continue;
-
-		m.misc = 0;
-		m.addr = 0;
-		m.bank = i;
-
-		m.status = mce_rdmsrl(msr_ops.status(i));
-		if ((m.status & MCI_STATUS_VAL) == 0)
-			continue;
-
-		/*
-		 * Non uncorrected or non signaled errors are handled by
-		 * machine_check_poll. Leave them alone, unless this panics.
-		 */
-		if (!(m.status & (cfg->ser ? MCI_STATUS_S : MCI_STATUS_UC)) &&
-			!no_way_out)
-			continue;
-
-		/*
-		 * Set taint even when machine check was not enabled.
-		 */
-		add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
-
-		severity = mce_severity(&m, cfg->tolerant, NULL, true);
-
-		/*
-		 * When machine check was for corrected/deferred handler don't
-		 * touch, unless we're panicing.
-		 */
-		if ((severity == MCE_KEEP_SEVERITY ||
-		     severity == MCE_UCNA_SEVERITY) && !no_way_out)
-			continue;
-		__set_bit(i, toclear);
-		if (severity == MCE_NO_SEVERITY) {
-			/*
-			 * Machine check event was not enabled. Clear, but
-			 * ignore.
-			 */
-			continue;
-		}
-
-		mce_read_aux(&m, i);
-
-		/* assuming valid severity level != 0 */
-		m.severity = severity;
-
-		mce_log(&m);
-
-		if (severity > worst) {
-			*final = m;
-			worst = severity;
-		}
-	}
-
-	/* mce_clear_state will clear *final, save locally for use later */
-	m = *final;
+	__mc_scan_banks(&m, final, toclear, valid_banks, no_way_out, &worst);
 
 	if (!no_way_out)
 		mce_clear_state(toclear);
-- 
2.17.0.582.gccdcbd54c

