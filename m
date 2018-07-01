Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B30C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432A22518E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432A22518E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933788AbeGAQZ4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:25:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33738 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965255AbeGAQZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:25:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 443D3AD8;
        Sun,  1 Jul 2018 16:25:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: [PATCH 4.9 004/101] x86/mce: Fix incorrect "Machine check from unknown source" message
Date:   Sun,  1 Jul 2018 18:20:50 +0200
Message-Id: <20180701160757.311573596@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Luck <tony.luck@intel.com>

commit 40c36e2741d7fe1e66d6ec55477ba5fd19c9c5d2 upstream.

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

[ bp: Remove unneeded severity assignment. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: stable@vger.kernel.org # 4.2
Link: http://lkml.kernel.org/r/52e049a497e86fd0b71c529651def8871c804df0.1527283897.git.tony.luck@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mcheck/mce.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1140,13 +1140,18 @@ void do_machine_check(struct pt_regs *re
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
@@ -1222,12 +1227,17 @@ void do_machine_check(struct pt_regs *re
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


