Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5ABC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7582A20866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7582A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393937AbeKVUuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:50:40 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52319 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387936AbeKVUuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:50:40 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMAASHs3743740
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 02:10:28 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMAASnr3743737;
        Thu, 22 Nov 2018 02:10:28 -0800
Date:   Thu, 22 Nov 2018 02:10:28 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-ebb53e2597e2dc7637ab213df006e99681b6ee25@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
        bp@alien8.de, riel@surriel.com, yu-cheng.yu@intel.com,
        torvalds@linux-foundation.org, tglx@linutronix.de, luto@kernel.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
          bp@alien8.de, riel@surriel.com, yu-cheng.yu@intel.com,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          luto@kernel.org, dave.hansen@linux.intel.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <9999f151d72ff352265f3274c5ab3a4105090f49.1542841400.git.luto@kernel.org>
References: <9999f151d72ff352265f3274c5ab3a4105090f49.1542841400.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/fault: Don't try to recover from an implicit
 supervisor access
Git-Commit-ID: ebb53e2597e2dc7637ab213df006e99681b6ee25
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

Commit-ID:  ebb53e2597e2dc7637ab213df006e99681b6ee25
Gitweb:     https://git.kernel.org/tip/ebb53e2597e2dc7637ab213df006e99681b6ee25
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 21 Nov 2018 15:11:23 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 22 Nov 2018 09:23:00 +0100

x86/fault: Don't try to recover from an implicit supervisor access

This avoids a situation in which we attempt to apply various fixups
that are not intended to handle implicit supervisor accesses from
user mode if we screw up in a way that causes this type of fault.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/9999f151d72ff352265f3274c5ab3a4105090f49.1542841400.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 82881bc5feef..ca38bd0472f2 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -653,6 +653,15 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	unsigned long flags;
 	int sig;
 
+	if (user_mode(regs)) {
+		/*
+		 * This is an implicit supervisor-mode access from user
+		 * mode.  Bypass all the kernel-mode recovery code and just
+		 * OOPS.
+		 */
+		goto oops;
+	}
+
 	/* Are we prepared to handle this kernel fault? */
 	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
 		/*
@@ -738,6 +747,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	if (IS_ENABLED(CONFIG_EFI))
 		efi_recover_from_page_fault(address);
 
+oops:
 	/*
 	 * Oops. The kernel tried to access some bad page. We'll have to
 	 * terminate things with extreme prejudice:
