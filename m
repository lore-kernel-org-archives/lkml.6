Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD71C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0632262E5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0632262E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965365AbeF0NTX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:19:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41027 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933051AbeF0NTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:19:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5RDIpVx2088917
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Jun 2018 06:18:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5RDIpaX2088914;
        Wed, 27 Jun 2018 06:18:51 -0700
Date:   Wed, 27 Jun 2018 06:18:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dmitry Vyukov <tipbot@zytor.com>
Message-ID: <tip-d79d0d8ad0cb3d782b41631dfeac8eb05e414bcd@git.kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        joe@perches.com, dvyukov@google.com, peterz@infradead.org
Reply-To: peterz@infradead.org, dvyukov@google.com, joe@perches.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, mingo@kernel.org
In-Reply-To: <20180627090715.28076-1-dvyukov@gmail.com>
References: <20180627090715.28076-1-dvyukov@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Clean up the printk()s in
 show_fault_oops()
Git-Commit-ID: d79d0d8ad0cb3d782b41631dfeac8eb05e414bcd
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

Commit-ID:  d79d0d8ad0cb3d782b41631dfeac8eb05e414bcd
Gitweb:     https://git.kernel.org/tip/d79d0d8ad0cb3d782b41631dfeac8eb05e414bcd
Author:     Dmitry Vyukov <dvyukov@google.com>
AuthorDate: Wed, 27 Jun 2018 11:07:15 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 27 Jun 2018 14:08:11 +0200

x86/mm: Clean up the printk()s in show_fault_oops()

- Remove 'nx_warning' and 'smep_warning', which are just pointless obfuscation.
- Also convert to pr_crit().

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180627090715.28076-1-dvyukov@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index ee85766e6329..2aafa6ab6103 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -641,11 +641,6 @@ static int is_f00f_bug(struct pt_regs *regs, unsigned long address)
 	return 0;
 }
 
-static const char nx_warning[] = KERN_CRIT
-"kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n";
-static const char smep_warning[] = KERN_CRIT
-"unable to execute userspace code (SMEP?) (uid: %d)\n";
-
 static void
 show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		unsigned long address)
@@ -664,11 +659,13 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		pte = lookup_address_in_pgd(pgd, address, &level);
 
 		if (pte && pte_present(*pte) && !pte_exec(*pte))
-			printk(nx_warning, from_kuid(&init_user_ns, current_uid()));
+			pr_crit("kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n",
+				from_kuid(&init_user_ns, current_uid()));
 		if (pte && pte_present(*pte) && pte_exec(*pte) &&
 				(pgd_flags(*pgd) & _PAGE_USER) &&
 				(__read_cr4() & X86_CR4_SMEP))
-			printk(smep_warning, from_kuid(&init_user_ns, current_uid()));
+			pr_crit("unable to execute userspace code (SMEP?) (uid: %d)\n",
+				from_kuid(&init_user_ns, current_uid()));
 	}
 
 	pr_alert("BUG: unable to handle kernel %s at %px\n",
