Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965090AbeE2QPw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:15:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:58647 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934877AbeE2QPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:15:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="43700611"
Date: Tue, 29 May 2018 09:15:49 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3 V2] x86/mce: Fix incorrect "Machine check from unknown
 source" message
Message-ID: <20180529161549.GB935@agluck-desk>
References: <cover.1527283897.git.tony.luck@intel.com>
 <52e049a497e86fd0b71c529651def8871c804df0.1527283897.git.tony.luck@intel.com>
 <20180528204923.GB30792@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528204923.GB30792@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
If this happens we print a different message (so I can see if it
actually every happens).

Cc: stable@vger.kernel.org # 4.2
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

V2: Boris:
	1) make the "different message" more descriptive. 
	2) don't bother reassigning "severity" variable.

 arch/x86/kernel/cpu/mcheck/mce.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 42cf2880d0ed..f013d97abd5f 100644
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
+			severity = mce_severity(&m, cfg->tolerant, &msg, true);
+			mce_panic("Local fatal machine check!", &m, msg);
+		}
 	}
 
 	/*
-- 
2.17.0
