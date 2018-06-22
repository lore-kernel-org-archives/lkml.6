Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134C3C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5799241EE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5799241EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeFVMlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:41:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51739 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeFVMlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:41:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MCfC7e069371
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 05:41:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MCfCn4069368;
        Fri, 22 Jun 2018 05:41:12 -0700
Date:   Fri, 22 Jun 2018 05:41:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-d3d6923cd1ae61a493a405f2f001293ab62eb092@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, bp@suse.de,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: tglx@linutronix.de, bp@suse.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20180622095428.626-4-bp@alien8.de>
References: <20180622095428.626-4-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Carve out the crashing_cpu check
Git-Commit-ID: d3d6923cd1ae61a493a405f2f001293ab62eb092
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

Commit-ID:  d3d6923cd1ae61a493a405f2f001293ab62eb092
Gitweb:     https://git.kernel.org/tip/d3d6923cd1ae61a493a405f2f001293ab62eb092
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 22 Jun 2018 11:54:24 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 14:37:22 +0200

x86/mce: Carve out the crashing_cpu check

Carve out the rendezvous handler timeout avoidance check into a separate
function in order to simplify the #MC handler.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20180622095428.626-4-bp@alien8.de

---
 arch/x86/kernel/cpu/mcheck/mce.c | 64 +++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index d62201e40027..18804834dbc0 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1104,6 +1104,34 @@ static void mce_unmap_kpfn(unsigned long pfn)
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
@@ -1118,60 +1146,42 @@ static void mce_unmap_kpfn(unsigned long pfn)
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
 
