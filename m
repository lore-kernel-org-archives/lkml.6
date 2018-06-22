Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D61AC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47BF241F0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47BF241F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933370AbeFVMms (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:42:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55609 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751369AbeFVMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:42:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MCgeH2069659
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 05:42:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MCgeII069656;
        Fri, 22 Jun 2018 05:42:40 -0700
Date:   Fri, 22 Jun 2018 05:42:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-d5c84ef202d7db9c838448229f62d66560b951e5@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, bp@suse.de
Reply-To: hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, bp@suse.de
In-Reply-To: <20180622095428.626-7-bp@alien8.de>
References: <20180622095428.626-7-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Cleanup __mc_scan_banks()
Git-Commit-ID: d5c84ef202d7db9c838448229f62d66560b951e5
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

Commit-ID:  d5c84ef202d7db9c838448229f62d66560b951e5
Gitweb:     https://git.kernel.org/tip/d5c84ef202d7db9c838448229f62d66560b951e5
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 22 Jun 2018 11:54:27 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 14:37:23 +0200

x86/mce: Cleanup __mc_scan_banks()

Correct comments, improve readability, simplify.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20180622095428.626-7-bp@alien8.de

---
 arch/x86/kernel/cpu/mcheck/mce.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index d23fcd8d11c9..888b51bef13d 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1143,6 +1143,7 @@ static void __mc_scan_banks(struct mce *m, struct mce *final,
 		__clear_bit(i, toclear);
 		if (!test_bit(i, valid_banks))
 			continue;
+
 		if (!mce_banks[i].ctl)
 			continue;
 
@@ -1151,39 +1152,35 @@ static void __mc_scan_banks(struct mce *m, struct mce *final,
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
 
