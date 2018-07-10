Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F179C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A292083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A292083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387684AbeGJS3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:29:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45240 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732459AbeGJS3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:29:11 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D8447EB8;
        Tue, 10 Jul 2018 18:28:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 35/47] x86/mce: Detect local MCEs properly
Date:   Tue, 10 Jul 2018 20:24:59 +0200
Message-Id: <20180710182338.617388540@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182337.047502999@linuxfoundation.org>
References: <20180710182337.047502999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yazen Ghannam <Yazen.Ghannam@amd.com>

commit fead35c68926682c90c995f22b48f1c8d78865c1 upstream.

Check the MCG_STATUS_LMCES bit on Intel to verify that current MCE is
local. It is always local on AMD.

Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
[ Massaged it a bit. Reflowed comments. Shut up -Wmaybe-uninitialized. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/1462019637-16474-8-git-send-email-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mcheck/mce.c |   33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -980,11 +980,12 @@ void do_machine_check(struct pt_regs *re
 	int i;
 	int worst = 0;
 	int severity;
+
 	/*
 	 * Establish sequential order between the CPUs entering the machine
 	 * check handler.
 	 */
-	int order;
+	int order = -1;
 	/*
 	 * If no_way_out gets set, there is no safe way to recover from this
 	 * MCE.  If mca_cfg.tolerant is cranked up, we'll try anyway.
@@ -1000,7 +1001,12 @@ void do_machine_check(struct pt_regs *re
 	char *msg = "Unknown";
 	u64 recover_paddr = ~0ull;
 	int flags = MF_ACTION_REQUIRED;
-	int lmce = 0;
+
+	/*
+	 * MCEs are always local on AMD. Same is determined by MCG_STATUS_LMCES
+	 * on Intel.
+	 */
+	int lmce = 1;
 
 	/* If this CPU is offline, just bail out. */
 	if (cpu_is_offline(smp_processor_id())) {
@@ -1039,19 +1045,20 @@ void do_machine_check(struct pt_regs *re
 		kill_it = 1;
 
 	/*
-	 * Check if this MCE is signaled to only this logical processor
+	 * Check if this MCE is signaled to only this logical processor,
+	 * on Intel only.
 	 */
-	if (m.mcgstatus & MCG_STATUS_LMCES)
-		lmce = 1;
-	else {
-		/*
-		 * Go through all the banks in exclusion of the other CPUs.
-		 * This way we don't report duplicated events on shared banks
-		 * because the first one to see it will clear it.
-		 * If this is a Local MCE, then no need to perform rendezvous.
-		 */
+	if (m.cpuvendor == X86_VENDOR_INTEL)
+		lmce = m.mcgstatus & MCG_STATUS_LMCES;
+
+	/*
+	 * Go through all banks in exclusion of the other CPUs. This way we
+	 * don't report duplicated events on shared banks because the first one
+	 * to see it will clear it. If this is a Local MCE, then no need to
+	 * perform rendezvous.
+	 */
+	if (!lmce)
 		order = mce_start(&no_way_out);
-	}
 
 	for (i = 0; i < cfg->banks; i++) {
 		__clear_bit(i, toclear);


