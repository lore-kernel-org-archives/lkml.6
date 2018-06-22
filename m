Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ABCC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67962241EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67962241EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeFVMlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:41:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58053 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeFVMlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:41:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MCfhYh069427
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 05:41:43 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MCfhl7069424;
        Fri, 22 Jun 2018 05:41:43 -0700
Date:   Fri, 22 Jun 2018 05:41:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-45deca7d96e0e33061b7d12932b381114db18f60@git.kernel.org>
Cc:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, bp@suse.de,
          tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20180622095428.626-5-bp@alien8.de>
References: <20180622095428.626-5-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Remove !banks check
Git-Commit-ID: 45deca7d96e0e33061b7d12932b381114db18f60
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

Commit-ID:  45deca7d96e0e33061b7d12932b381114db18f60
Gitweb:     https://git.kernel.org/tip/45deca7d96e0e33061b7d12932b381114db18f60
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 22 Jun 2018 11:54:25 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 14:37:22 +0200

x86/mce: Remove !banks check

If we don't have MCA banks, we won't see machine checks anyway. Drop the
check.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20180622095428.626-5-bp@alien8.de

---
 arch/x86/kernel/cpu/mcheck/mce.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 18804834dbc0..8ac2ea2a874a 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1187,9 +1187,6 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 
 	this_cpu_inc(mce_exception_count);
 
-	if (!cfg->banks)
-		goto out;
-
 	mce_gather_info(&m, regs);
 	m.tsc = rdtsc();
 
@@ -1329,7 +1326,7 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 	if (worst > 0)
 		mce_report_event(regs);
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
-out:
+
 	sync_core();
 
 	if (worst != MCE_AR_SEVERITY && !kill_it)
