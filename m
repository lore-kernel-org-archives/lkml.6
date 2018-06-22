Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBBEC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDAF241E8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EDAF241E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932885AbeFVMj5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:39:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42925 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbeFVMjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:39:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MCdlJG069239
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 05:39:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MCdks5069236;
        Fri, 22 Jun 2018 05:39:46 -0700
Date:   Fri, 22 Jun 2018 05:39:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-1f74c8a64798e2c488f86efc97e308b85fb7d7aa@git.kernel.org>
Cc:     stable@vger.kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, bp@suse.de, tglx@linutronix.de,
        hpa@zytor.com, tony.luck@intel.com
Reply-To: tony.luck@intel.com, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, bp@suse.de, mingo@kernel.org,
          stable@vger.kernel.org
In-Reply-To: <20180622095428.626-8-bp@alien8.de>
References: <20180622095428.626-8-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Do not overwrite MCi_STATUS in
 mce_no_way_out()
Git-Commit-ID: 1f74c8a64798e2c488f86efc97e308b85fb7d7aa
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

Commit-ID:  1f74c8a64798e2c488f86efc97e308b85fb7d7aa
Gitweb:     https://git.kernel.org/tip/1f74c8a64798e2c488f86efc97e308b85fb7d7aa
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 22 Jun 2018 11:54:28 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 14:35:50 +0200

x86/mce: Do not overwrite MCi_STATUS in mce_no_way_out()

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
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20180622095428.626-8-bp@alien8.de

---
 arch/x86/kernel/cpu/mcheck/mce.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index cd76380af79f..7e6f51a9d917 100644
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
