Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C539C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9FC241EA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9FC241EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933283AbeFVMkZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:40:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42115 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932950AbeFVMkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:40:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MCeGdV069303
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 05:40:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MCeFL8069300;
        Fri, 22 Jun 2018 05:40:15 -0700
Date:   Fri, 22 Jun 2018 05:40:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Luck <tipbot@zytor.com>
Message-ID: <tip-40c36e2741d7fe1e66d6ec55477ba5fd19c9c5d2@git.kernel.org>
Cc:     tglx@linutronix.de, linux-edac@vger.kernel.org,
        dan.j.williams@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        qiuxu.zhuo@intel.com, bp@suse.de, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, ashok.raj@intel.com, tony.luck@intel.com,
          qiuxu.zhuo@intel.com, bp@suse.de, linux-kernel@vger.kernel.org,
          hpa@zytor.com, tglx@linutronix.de, dan.j.williams@intel.com,
          linux-edac@vger.kernel.org
In-Reply-To: <52e049a497e86fd0b71c529651def8871c804df0.1527283897.git.tony.luck@intel.com>
References: <52e049a497e86fd0b71c529651def8871c804df0.1527283897.git.tony.luck@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Fix incorrect "Machine check from unknown
 source" message
Git-Commit-ID: 40c36e2741d7fe1e66d6ec55477ba5fd19c9c5d2
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

Commit-ID:  40c36e2741d7fe1e66d6ec55477ba5fd19c9c5d2
Gitweb:     https://git.kernel.org/tip/40c36e2741d7fe1e66d6ec55477ba5fd19c9c5d2
Author:     Tony Luck <tony.luck@intel.com>
AuthorDate: Fri, 22 Jun 2018 11:54:23 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 14:35:50 +0200

x86/mce: Fix incorrect "Machine check from unknown source" message

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

---
 arch/x86/kernel/cpu/mcheck/mce.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 7e6f51a9d917..e93670d736a6 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1207,13 +1207,18 @@ void do_machine_check(struct pt_regs *regs, long error_code)
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
@@ -1289,12 +1294,17 @@ void do_machine_check(struct pt_regs *regs, long error_code)
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
