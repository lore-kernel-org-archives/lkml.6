Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CD8C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E0B2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E0B2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbeKLGFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:05:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53032 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731085AbeKLGFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:05:07 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsy-0000oG-W4; Sun, 11 Nov 2018 19:59:09 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0001cG-Kd; Sun, 11 Nov 2018 19:58:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@suse.de>, "Tony Luck" <tony.luck@intel.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.591714971@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 182/366] x86/mce: Do not overwrite MCi_STATUS in
 mce_no_way_out()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 1f74c8a64798e2c488f86efc97e308b85fb7d7aa upstream.

mce_no_way_out() does a quick check during #MC to see whether some of
the MCEs logged would require the kernel to panic immediately. And it
passes a struct mce where MCi_STATUS gets written.

However, after having saved a valid status value, the next iteration
of the loop which goes over the MCA banks on the CPU, overwrites the
valid status value because we're using struct mce as storage instead of
a temporary variable.

Which leads to MCE records with an empty status value:

  mce: [Hardware Error]: CPU 0: Machine Check Exception: 6 Bank 0: 0000000000000000
  mce: [Hardware Error]: RIP 10:<ffffffffbd42fbd7> {trigger_mce+0x7/0x10}

In order to prevent the loss of the status register value, return
immediately when severity is a panic one so that we can panic
immediately with the first fatal MCE logged. This is also the intention
of this function and not to noodle over the banks while a fatal MCE is
already logged.

Tony: read the rest of the MCA bank to populate the struct mce fully.

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20180622095428.626-8-bp@alien8.de
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -666,23 +666,25 @@ EXPORT_SYMBOL_GPL(machine_check_poll);
 static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 			  struct pt_regs *regs)
 {
-	int i, ret = 0;
 	char *tmp;
+	int i;
 
 	for (i = 0; i < mca_cfg.banks; i++) {
 		m->status = mce_rdmsrl(MSR_IA32_MCx_STATUS(i));
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
 
 		if (mce_severity(m, mca_cfg.tolerant, &tmp) >= MCE_PANIC_SEVERITY) {
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

