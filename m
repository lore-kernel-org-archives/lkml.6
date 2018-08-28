Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E494FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF0C208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF0C208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbeH1Kp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 06:45:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:38142 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbeH1Kp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 06:45:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC89AABC1;
        Tue, 28 Aug 2018 06:55:15 +0000 (UTC)
Date:   Tue, 28 Aug 2018 08:55:14 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/alternatives: lockdep-enforce text_mutex in
 text_poke*()
Message-ID: <nycvar.YFH.7.76.1808280853520.25787@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

text_poke() and text_poke_bp() must be called with text_mutex held.
Let's put proper lockdep anotation in place instead of just mentioning
the requirement in comment.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
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

-- 
Jiri Kosina
SUSE Labs

