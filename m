Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DE2C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9CD208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9CD208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933179AbeFUMk2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:40:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58744 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932764AbeFUMk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:40:27 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EcKpSMtqWsyj; Thu, 21 Jun 2018 14:40:26 +0200 (CEST)
Received: from zn.tnic (p200300EC2BD18C00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:8c00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 14CC31EC0077;
        Thu, 21 Jun 2018 14:40:26 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/mce: Do not overwrite MCi_STATUS in mce_no_way_out()
Date:   Thu, 21 Jun 2018 14:40:20 +0200
Message-Id: <20180621124020.6244-1-bp@alien8.de>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c
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

Change it to use a temporary variable and save to mce.status only when
valid. It will still overwrite the old status value if more than one
MCEs are logged, which warrants the second change in this patch:

Return immediately when severity is a panic one so that we can panic
immediately with the first fatal MCE logged.

Cc: <stable@vger.kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 5c38d1f861f2..5c0a97b2bfce 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -772,12 +772,15 @@ EXPORT_SYMBOL_GPL(machine_check_poll);
 static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 			  struct pt_regs *regs)
 {
+	u64 mci_status;
 	int i, ret = 0;
 	char *tmp;
 
 	for (i = 0; i < mca_cfg.banks; i++) {
-		m->status = mce_rdmsrl(msr_ops.status(i));
-		if (m->status & MCI_STATUS_VAL) {
+		mci_status = mce_rdmsrl(msr_ops.status(i));
+		if (mci_status & MCI_STATUS_VAL) {
+			m->status = mci_status;
+
 			__set_bit(i, validp);
 			if (quirk_no_way_out)
 				quirk_no_way_out(i, m, regs);
@@ -785,7 +788,7 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 
 		if (mce_severity(m, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
 			*msg = tmp;
-			ret = 1;
+			return 1;
 		}
 	}
 	return ret;
-- 
2.17.0.582.gccdcbd54c

