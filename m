Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F4CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DCF24DE5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DCF24DE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933591AbeGCHzR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:55:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35379 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753364AbeGCHzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:55:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w637slM4202654
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 00:54:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w637slbE202651;
        Tue, 3 Jul 2018 00:54:47 -0700
Date:   Tue, 3 Jul 2018 00:54:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhenzhong Duan <tipbot@zytor.com>
Message-ID: <tip-4fb5f58e8d191f7c81637ad81284e4848afb4244@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, bp@alien8.de,
        zhenzhong.duan@oracle.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, luto@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, luto@kernel.org, mingo@kernel.org,
          peterz@infradead.org, zhenzhong.duan@oracle.com,
          linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
          hpa@zytor.com
In-Reply-To: <b07b6ae9-4b57-4b40-b9bc-50c2c67f1d91@default>
References: <b07b6ae9-4b57-4b40-b9bc-50c2c67f1d91@default>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm/32: Initialize the CR4 shadow before
 __flush_tlb_all()
Git-Commit-ID: 4fb5f58e8d191f7c81637ad81284e4848afb4244
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

Commit-ID:  4fb5f58e8d191f7c81637ad81284e4848afb4244
Gitweb:     https://git.kernel.org/tip/4fb5f58e8d191f7c81637ad81284e4848afb4244
Author:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
AuthorDate: Mon, 2 Jul 2018 23:49:54 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 3 Jul 2018 09:26:10 +0200

x86/mm/32: Initialize the CR4 shadow before __flush_tlb_all()

On 32-bit kernels, __flush_tlb_all() may have read the CR4 shadow before the
initialization of CR4 shadow in cpu_init().

Fix it by adding an explicit cr4_init_shadow() call into start_secondary()
which is the first function called on non-boot SMP CPUs - ahead of the
__flush_tlb_all() call.

( This is somewhat of a layering violation, but start_secondary() does
  CR4 bootstrap in the PCID case anyway. )

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: http://lkml.kernel.org/r/b07b6ae9-4b57-4b40-b9bc-50c2c67f1d91@default
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/smpboot.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c2f7d1d2a5c3..db9656e13ea0 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -221,6 +221,11 @@ static void notrace start_secondary(void *unused)
 #ifdef CONFIG_X86_32
 	/* switch away from the initial page table */
 	load_cr3(swapper_pg_dir);
+	/*
+	 * Initialize the CR4 shadow before doing anything that could
+	 * try to read it.
+	 */
+	cr4_init_shadow();
 	__flush_tlb_all();
 #endif
 	load_current_idt();
