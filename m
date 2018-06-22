Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E43C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB71923FE4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB71923FE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbeFVJym (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:54:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41296 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933164AbeFVJyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:54:37 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M2m3fKW9fiwo; Fri, 22 Jun 2018 11:54:36 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF3400329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:3400:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1681B1EC0236;
        Fri, 22 Jun 2018 11:54:36 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] x86/mce: Do not overwrite MCi_STATUS in mce_no_way_out()
Date:   Fri, 22 Jun 2018 11:54:28 +0200
Message-Id: <20180622095428.626-8-bp@alien8.de>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c
In-Reply-To: <20180622095428.626-1-bp@alien8.de>
References: <20180622095428.626-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

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
Cc: <stable@vger.kernel.org>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 5c38d1f861f2..9a16f15f79eb 100644
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
-- 
2.17.0.582.gccdcbd54c

