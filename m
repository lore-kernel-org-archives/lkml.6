Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CEDC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E252E23FE3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E252E23FE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933308AbeFVJyi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:54:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41288 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933139AbeFVJyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:54:36 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V3_xr_g3FPoz; Fri, 22 Jun 2018 11:54:35 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF3400329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:3400:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DAE51EC0236;
        Fri, 22 Jun 2018 11:54:35 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] x86/mce: Cleanup __mc_scan_banks()
Date:   Fri, 22 Jun 2018 11:54:27 +0200
Message-Id: <20180622095428.626-7-bp@alien8.de>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c
In-Reply-To: <20180622095428.626-1-bp@alien8.de>
References: <20180622095428.626-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Correct comments, improve readability, simplify.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 5e834bad4eaf..5c38d1f861f2 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1141,6 +1141,7 @@ static void __mc_scan_banks(struct mce *m, struct mce *final,
 		__clear_bit(i, toclear);
 		if (!test_bit(i, valid_banks))
 			continue;
+
 		if (!mce_banks[i].ctl)
 			continue;
 
@@ -1149,39 +1150,35 @@ static void __mc_scan_banks(struct mce *m, struct mce *final,
 		m->bank = i;
 
 		m->status = mce_rdmsrl(msr_ops.status(i));
-		if ((m->status & MCI_STATUS_VAL) == 0)
+		if (!(m->status & MCI_STATUS_VAL))
 			continue;
 
 		/*
-		 * Non uncorrected or non signaled errors are handled by
-		 * machine_check_poll. Leave them alone, unless this panics.
+		 * Corrected or non-signaled errors are handled by
+		 * machine_check_poll(). Leave them alone, unless this panics.
 		 */
 		if (!(m->status & (cfg->ser ? MCI_STATUS_S : MCI_STATUS_UC)) &&
 			!no_way_out)
 			continue;
 
-		/*
-		 * Set taint even when machine check was not enabled.
-		 */
+		/* Set taint even when machine check was not enabled. */
 		add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
 		severity = mce_severity(m, cfg->tolerant, NULL, true);
 
 		/*
 		 * When machine check was for corrected/deferred handler don't
-		 * touch, unless we're panicing.
+		 * touch, unless we're panicking.
 		 */
 		if ((severity == MCE_KEEP_SEVERITY ||
 		     severity == MCE_UCNA_SEVERITY) && !no_way_out)
 			continue;
+
 		__set_bit(i, toclear);
-		if (severity == MCE_NO_SEVERITY) {
-			/*
-			 * Machine check event was not enabled. Clear, but
-			 * ignore.
-			 */
+
+		/* Machine check event was not enabled. Clear, but ignore. */
+		if (severity == MCE_NO_SEVERITY)
 			continue;
-		}
 
 		mce_read_aux(m, i);
 
-- 
2.17.0.582.gccdcbd54c

