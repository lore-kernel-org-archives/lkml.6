Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132CCC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FBA24EB2
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FBA24EB2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbeFXLCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 07:02:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44814 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeFXLCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 07:02:09 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fX2mV-0003rL-RR; Sun, 24 Jun 2018 13:02:08 +0200
Date:   Sun, 24 Jun 2018 13:02:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] ras updates for 4.18
Message-ID: <alpine.DEB.2.21.1806241234210.8650@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest ras-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-urgent-for-linus

A set of fixes for RAS/MCE:

  - Improve the error message when the kernel cannot recover from a MCE so
    the maximum amount of information gets provided.

  - Individually check MCE recovery features on SkyLake CPUs instead of
    assuming none when the CAPID0 register does not advertise the general
    ability for recovery.

  - Prevent MCE to output inconsistent messages which first show an error
    location and then claim that the source is unknown.

  - Prevent overwriting MCi_STATUS in the attempt to gather more
    information when a fatal MCE has alreay been detected. This leads to
    empty status values in the printout and failing to react promptly on
    the fatal event.

Thanks,

	tglx

------------------>
Borislav Petkov (1):
      x86/mce: Do not overwrite MCi_STATUS in mce_no_way_out()

Tony Luck (3):
      x86/mce: Improve error message when kernel cannot recover
      x86/mce: Check for alternate indication of machine check recovery on Skylake
      x86/mce: Fix incorrect "Machine check from unknown source" message


 arch/x86/kernel/cpu/mcheck/mce-severity.c |  5 ++++
 arch/x86/kernel/cpu/mcheck/mce.c          | 44 ++++++++++++++++++++-----------
 arch/x86/kernel/quirks.c                  | 11 ++++++--
 3 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-severity.c b/arch/x86/kernel/cpu/mcheck/mce-severity.c
index 5bbd06f38ff6..f34d89c01edc 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-severity.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-severity.c
@@ -160,6 +160,11 @@ static struct severity {
 		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_INSTR),
 		USER
 		),
+	MCESEV(
+		PANIC, "Data load in unrecoverable area of kernel",
+		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_DATA),
+		KERNEL
+		),
 #endif
 	MCESEV(
 		PANIC, "Action required: unknown MCACOD",
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index cd76380af79f..e93670d736a6 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -772,23 +772,25 @@ EXPORT_SYMBOL_GPL(machine_check_poll);
 static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 			  struct pt_regs *regs)
 {
-	int i, ret = 0;
 	char *tmp;
+	int i;
 
 	for (i = 0; i < mca_cfg.banks; i++) {
 		m->status = mce_rdmsrl(msr_ops.status(i));
-		if (m->status & MCI_STATUS_VAL) {
-			__set_bit(i, validp);
-			if (quirk_no_way_out)
-				quirk_no_way_out(i, m, regs);
-		}
+		if (!(m->status & MCI_STATUS_VAL))
+			continue;
+
+		__set_bit(i, validp);
+		if (quirk_no_way_out)
+			quirk_no_way_out(i, m, regs);
 
 		if (mce_severity(m, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
+			mce_read_aux(m, i);
 			*msg = tmp;
-			ret = 1;
+			return 1;
 		}
 	}
-	return ret;
+	return 0;
 }
 
 /*
@@ -1205,13 +1207,18 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 		lmce = m.mcgstatus & MCG_STATUS_LMCES;
 
 	/*
+	 * Local machine check may already know that we have to panic.
+	 * Broadcast machine check begins rendezvous in mce_start()
 	 * Go through all banks in exclusion of the other CPUs. This way we
 	 * don't report duplicated events on shared banks because the first one
-	 * to see it will clear it. If this is a Local MCE, then no need to
-	 * perform rendezvous.
+	 * to see it will clear it.
 	 */
-	if (!lmce)
+	if (lmce) {
+		if (no_way_out)
+			mce_panic("Fatal local machine check", &m, msg);
+	} else {
 		order = mce_start(&no_way_out);
+	}
 
 	for (i = 0; i < cfg->banks; i++) {
 		__clear_bit(i, toclear);
@@ -1287,12 +1294,17 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 			no_way_out = worst >= MCE_PANIC_SEVERITY;
 	} else {
 		/*
-		 * Local MCE skipped calling mce_reign()
-		 * If we found a fatal error, we need to panic here.
+		 * If there was a fatal machine check we should have
+		 * already called mce_panic earlier in this function.
+		 * Since we re-read the banks, we might have found
+		 * something new. Check again to see if we found a
+		 * fatal error. We call "mce_severity()" again to
+		 * make sure we have the right "msg".
 		 */
-		 if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3)
-			mce_panic("Machine check from unknown source",
-				NULL, NULL);
+		if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
+			mce_severity(&m, cfg->tolerant, &msg, true);
+			mce_panic("Local fatal machine check!", &m, msg);
+		}
 	}
 
 	/*
diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 697a4ce04308..736348ead421 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -645,12 +645,19 @@ static void quirk_intel_brickland_xeon_ras_cap(struct pci_dev *pdev)
 /* Skylake */
 static void quirk_intel_purley_xeon_ras_cap(struct pci_dev *pdev)
 {
-	u32 capid0;
+	u32 capid0, capid5;
 
 	pci_read_config_dword(pdev, 0x84, &capid0);
+	pci_read_config_dword(pdev, 0x98, &capid5);
 
-	if ((capid0 & 0xc0) == 0xc0)
+	/*
+	 * CAPID0{7:6} indicate whether this is an advanced RAS SKU
+	 * CAPID5{8:5} indicate that various NVDIMM usage modes are
+	 * enabled, so memory machine check recovery is also enabled.
+	 */
+	if ((capid0 & 0xc0) == 0xc0 || (capid5 & 0x1e0))
 		static_branch_inc(&mcsafe_key);
+
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0ec3, quirk_intel_brickland_xeon_ras_cap);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2fc0, quirk_intel_brickland_xeon_ras_cap);
