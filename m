Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D7AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBAE2084A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfBAAdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 19:33:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:45304 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfBAAdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 19:33:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 16:33:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,546,1539673200"; 
   d="scan'208";a="315372119"
Received: from agluck-desk.sc.intel.com ([10.3.52.160])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2019 16:33:42 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mce: Initialize "bank" when we find a fatal error in mce_no_way_out()
Date:   Thu, 31 Jan 2019 16:33:41 -0800
Message-Id: <20190201003341.10638-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internal injection testing crashed with a console log that said:

mce: [Hardware Error]: CPU 7: Machine Check Exception: f Bank 0: bd80000000100134

This caused a lot of head scratching because the MCACOD (bits 15:0) of that
status is a signature from an L1 data cache error. But Linux says that it found
it in "Bank 0", which on this model CPU only reports L1 instruction cache errors.

The answer was that Linux doesn't initialize "m->bank" in the case that it finds
a fatal error in the mce_no_way_out() pre-scan of banks. If this was a local machine
check, then we pass this partially initialized "struct mce" to mce_panic().

Fix is simple. Just initialize m->bank in the case that we found a fatal error.

Fixes: 40c36e2741d7 ("x86/mce: Fix incorrect "Machine check from unknown source" message")
Cc: stable@vger.kernel.org # v4.18 Note pre-v5.0 arch/x86/kernel/cpu/mce/core.c was called arch/x86/kernel/cpu/mcheck/mce.c
Signed-off-by: Tony Luck <tony.luck@intel.com>
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
-- 
2.19.1

