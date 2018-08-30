Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3417AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B3F2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B3F2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeH3PI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:08:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41055 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbeH3PI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:08:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7UB6t9g1731384
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Aug 2018 04:06:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7UB6tf21731381;
        Thu, 30 Aug 2018 04:06:55 -0700
Date:   Thu, 30 Aug 2018 04:06:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Kosina <tipbot@zytor.com>
Message-ID: <tip-9222f606506c5f8ca2c8b8c939d59ed3e6ac4148@git.kernel.org>
Cc:     jkosina@suse.cz, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, luto@kernel.org, tglx@linutronix.de
Reply-To: jkosina@suse.cz, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          mhiramat@kernel.org, luto@kernel.org, tglx@linutronix.de
In-Reply-To: <nycvar.YFH.7.76.1808280853520.25787@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1808280853520.25787@cbobk.fhfr.pm>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/alternatives: Lockdep-enforce text_mutex in
 text_poke*()
Git-Commit-ID: 9222f606506c5f8ca2c8b8c939d59ed3e6ac4148
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

Commit-ID:  9222f606506c5f8ca2c8b8c939d59ed3e6ac4148
Gitweb:     https://git.kernel.org/tip/9222f606506c5f8ca2c8b8c939d59ed3e6ac4148
Author:     Jiri Kosina <jkosina@suse.cz>
AuthorDate: Tue, 28 Aug 2018 08:55:14 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 30 Aug 2018 13:02:30 +0200

x86/alternatives: Lockdep-enforce text_mutex in text_poke*()

text_poke() and text_poke_bp() must be called with text_mutex held.

Put proper lockdep anotation in place instead of just mentioning the
requirement in a comment.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/nycvar.YFH.7.76.1808280853520.25787@cbobk.fhfr.pm

---
 arch/x86/kernel/alternative.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 014f214da581..b9d5e7c9ef43 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -684,8 +684,6 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
  * It means the size must be writable atomically and the address must be aligned
  * in a way that permits an atomic write. It also makes sure we fit on a single
  * page.
- *
- * Note: Must be called under text_mutex.
  */
 void *text_poke(void *addr, const void *opcode, size_t len)
 {
@@ -700,6 +698,8 @@ void *text_poke(void *addr, const void *opcode, size_t len)
 	 */
 	BUG_ON(!after_bootmem);
 
+	lockdep_assert_held(&text_mutex);
+
 	if (!core_kernel_text((unsigned long)addr)) {
 		pages[0] = vmalloc_to_page(addr);
 		pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
@@ -782,8 +782,6 @@ int poke_int3_handler(struct pt_regs *regs)
  *	- replace the first byte (int3) by the first byte of
  *	  replacing opcode
  *	- sync cores
- *
- * Note: must be called under text_mutex.
  */
 void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 {
@@ -792,6 +790,9 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 	bp_int3_handler = handler;
 	bp_int3_addr = (u8 *)addr + sizeof(int3);
 	bp_patching_in_progress = true;
+
+	lockdep_assert_held(&text_mutex);
+
 	/*
 	 * Corresponding read barrier in int3 notifier for making sure the
 	 * in_progress and handler are correctly ordered wrt. patching.
