Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043D5C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41F223FE0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41F223FE0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933162AbeFVJyf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:54:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41278 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754651AbeFVJyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:54:33 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sCXb7w6UaWTl; Fri, 22 Jun 2018 11:54:32 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF3400329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:3400:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21D4E1EC0236;
        Fri, 22 Jun 2018 11:54:32 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] x86/mce: Fix incorrect "Machine check from unknown source" message
Date:   Fri, 22 Jun 2018 11:54:23 +0200
Message-Id: <20180622095428.626-3-bp@alien8.de>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c
In-Reply-To: <20180622095428.626-1-bp@alien8.de>
References: <20180622095428.626-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

Some injection testing resulted in the following console log:

  mce: [Hardware Error]: CPU 22: Machine Check Exception: f Bank 1: bd80000000100134
  mce: [Hardware Error]: RIP 10:<ffffffffc05292dd> {pmem_do_bvec+0x11d/0x330 [nd_pmem]}
  mce: [Hardware Error]: TSC c51a63035d52 ADDR 3234bc4000 MISC 88
  mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1526502199 SOCKET 0 APIC 38 microcode 2000043
  mce: [Hardware Error]: Run the above through 'mcelog --ascii'
  Kernel panic - not syncing: Machine check from unknown source

This confused everybody because the first line quite clearly shows
that we found a logged error in "Bank 1", while the last line says
"unknown source".

The problem is that the Linux code doesn't do the right thing
for a local machine check that results in a fatal error.

It turns out that we know very early in the handler whether the
machine check is fatal. The call to mce_no_way_out() has checked
all the banks for the CPU that took the local machine check. If
it says we must crash, we can do so right away with the right
messages.

We do scan all the banks again. This means that we might initially
not see a problem, but during the second scan find something fatal.
If this happens we print a slightly different message (so I can
see if it actually every happens).

Signed-off-by: Tony Luck <tony.luck@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Cc: stable@vger.kernel.org # 4.2
Link: http://lkml.kernel.org/r/52e049a497e86fd0b71c529651def8871c804df0.1527283897.git.tony.luck@intel.com
[ Remove unneeded severity assignment. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index b887415652ed..c3d08a69194d 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1205,13 +1205,18 @@ void do_machine_check(struct pt_regs *regs, long error_code)
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
@@ -1287,12 +1292,17 @@ void do_machine_check(struct pt_regs *regs, long error_code)
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
-- 
2.17.0.582.gccdcbd54c

