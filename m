Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D40C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FF4241F1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FF4241F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933214AbeFVMmU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:42:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57019 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeFVMmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:42:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MCgCEL069622
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 05:42:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MCgCqs069619;
        Fri, 22 Jun 2018 05:42:12 -0700
Date:   Fri, 22 Jun 2018 05:42:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-f35565e3986dcc5dde52649d461543cde1b745cd@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, bp@suse.de
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, bp@suse.de
In-Reply-To: <20180622095428.626-6-bp@alien8.de>
References: <20180622095428.626-6-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Carve out bank scanning code
Git-Commit-ID: f35565e3986dcc5dde52649d461543cde1b745cd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f35565e3986dcc5dde52649d461543cde1b745cd
Gitweb:     https://git.kernel.org/tip/f35565e3986dcc5dde52649d461543cde1b745cd
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 22 Jun 2018 11:54:26 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 14:37:23 +0200

x86/mce: Carve out bank scanning code

Carve out the scan loop into a separate function.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20180622095428.626-6-bp@alien8.de

---
 arch/x86/kernel/cpu/mcheck/mce.c | 134 +++++++++++++++++++++------------------
 1 file changed, 71 insertions(+), 63 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 8ac2ea2a874a..d23fcd8d11c9 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1132,6 +1132,76 @@ static bool __mc_check_crashing_cpu(int cpu)
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
@@ -1153,8 +1223,6 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 	char *msg = "Unknown";
 	struct mce m, *final;
 	int worst = 0;
-	int severity;
-	int i;
 
 	/*
 	 * Establish sequential order between the CPUs entering the machine
@@ -1227,67 +1295,7 @@ void do_machine_check(struct pt_regs *regs, long error_code)
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
