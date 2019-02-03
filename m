Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65DEC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B725B218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfBCMhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 07:37:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33573 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfBCMhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 07:37:13 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x13Carij4190606
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 3 Feb 2019 04:36:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x13CarNe4190603;
        Sun, 3 Feb 2019 04:36:53 -0800
Date:   Sun, 3 Feb 2019 04:36:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Luck <tipbot@zytor.com>
Message-ID: <tip-d28af26faa0b1daf3c692603d46bc4687c16f19e@git.kernel.org>
Cc:     x86@kernel.org, mingo@kernel.org, tony.luck@intel.com, bp@suse.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        vishal.l.verma@intel.com, tglx@linutronix.de, mingo@redhat.com
Reply-To: x86@kernel.org, mingo@kernel.org, tony.luck@intel.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          vishal.l.verma@intel.com, bp@suse.de, tglx@linutronix.de,
          mingo@redhat.com
In-Reply-To: <20190201003341.10638-1-tony.luck@intel.com>
References: <20190201003341.10638-1-tony.luck@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/MCE: Initialize mce.bank in the case of a
 fatal error in mce_no_way_out()
Git-Commit-ID: d28af26faa0b1daf3c692603d46bc4687c16f19e
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

Commit-ID:  d28af26faa0b1daf3c692603d46bc4687c16f19e
Gitweb:     https://git.kernel.org/tip/d28af26faa0b1daf3c692603d46bc4687c16f19e
Author:     Tony Luck <tony.luck@intel.com>
AuthorDate: Thu, 31 Jan 2019 16:33:41 -0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sun, 3 Feb 2019 13:24:24 +0100

x86/MCE: Initialize mce.bank in the case of a fatal error in mce_no_way_out()

Internal injection testing crashed with a console log that said:

  mce: [Hardware Error]: CPU 7: Machine Check Exception: f Bank 0: bd80000000100134

This caused a lot of head scratching because the MCACOD (bits 15:0) of
that status is a signature from an L1 data cache error. But Linux says
that it found it in "Bank 0", which on this model CPU only reports L1
instruction cache errors.

The answer was that Linux doesn't initialize "m->bank" in the case that
it finds a fatal error in the mce_no_way_out() pre-scan of banks. If
this was a local machine check, then this partially initialized struct
mce is being passed to mce_panic().

Fix is simple: just initialize m->bank in the case of a fatal error.

Fixes: 40c36e2741d7 ("x86/mce: Fix incorrect "Machine check from unknown source" message")
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: x86-ml <x86@kernel.org>
Cc: stable@vger.kernel.org # v4.18 Note pre-v5.0 arch/x86/kernel/cpu/mce/core.c was called arch/x86/kernel/cpu/mcheck/mce.c
Link: https://lkml.kernel.org/r/20190201003341.10638-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 672c7225cb1b..6ce290c506d9 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -784,6 +784,7 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 			quirk_no_way_out(i, m, regs);
 
 		if (mce_severity(m, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
+			m->bank = i;
 			mce_read_aux(m, i);
 			*msg = tmp;
 			return 1;
