Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1D1C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F792081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfBDUAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:00:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbfBDUAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:00:51 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7AB43653C7;
        Mon,  4 Feb 2019 20:00:50 +0000 (UTC)
Received: from t460s.bristot.redhat.com (ovpn-117-55.phx2.redhat.com [10.3.117.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16C839EF91;
        Mon,  4 Feb 2019 20:00:44 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bristot@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: [PATCH V4 5/9] x86/alternative: Split text_poke_bp() into tree steps
Date:   Mon,  4 Feb 2019 20:58:58 +0100
Message-Id: <cf7096ad15708be48f3ea62b4e903f6ef29e2838.1549308412.git.bristot@redhat.com>
In-Reply-To: <cover.1549308412.git.bristot@redhat.com>
References: <cover.1549308412.git.bristot@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 04 Feb 2019 20:00:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

text_poke_bp() updates instructions on live kernel on SMP in three steps:
 1) add a int3 trap to the address that will be patched
 2) update all but the first byte of the patched range
 3) replace the first byte (int3) by the first byte of

This patch creates one function for each of these steps.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Chris von Recklinghausen <crecklin@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Scott Wood <swood@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/alternative.c | 38 +++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d458c7973c56..202af29c43c0 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -767,6 +767,29 @@ int poke_int3_handler(struct pt_regs *regs)
 
 }
 
+static void text_poke_bp_set_handler(void *addr, void *handler,
+				     unsigned char int3)
+{
+	bp_int3_handler = handler;
+	bp_int3_addr = (u8 *)addr + sizeof(int3);
+	text_poke(addr, &int3, sizeof(int3));
+}
+
+static void patch_all_but_first_byte(void *addr, const void *opcode,
+				     size_t len, unsigned char int3)
+{
+	/* patch all but the first byte */
+	text_poke((char *)addr + sizeof(int3),
+		  (const char *) opcode + sizeof(int3),
+		  len - sizeof(int3));
+}
+
+static void patch_first_byte(void *addr, const void *opcode, unsigned char int3)
+{
+	/* patch the first byte */
+	text_poke(addr, opcode, sizeof(int3));
+}
+
 /**
  * text_poke_bp() -- update instructions on live kernel on SMP
  * @addr:	address to patch
@@ -791,27 +814,21 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 {
 	unsigned char int3 = 0xcc;
 
-	bp_int3_handler = handler;
-	bp_int3_addr = (u8 *)addr + sizeof(int3);
-	bp_patching_in_progress = true;
-
 	lockdep_assert_held(&text_mutex);
 
+	bp_patching_in_progress = true;
 	/*
 	 * Corresponding read barrier in int3 notifier for making sure the
 	 * in_progress and handler are correctly ordered wrt. patching.
 	 */
 	smp_wmb();
 
-	text_poke(addr, &int3, sizeof(int3));
+	text_poke_bp_set_handler(addr, handler, int3);
 
 	on_each_cpu(do_sync_core, NULL, 1);
 
 	if (len - sizeof(int3) > 0) {
-		/* patch all but the first byte */
-		text_poke((char *)addr + sizeof(int3),
-			  (const char *) opcode + sizeof(int3),
-			  len - sizeof(int3));
+		patch_all_but_first_byte(addr, opcode, len, int3);
 		/*
 		 * According to Intel, this core syncing is very likely
 		 * not necessary and we'd be safe even without it. But
@@ -820,8 +837,7 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 		on_each_cpu(do_sync_core, NULL, 1);
 	}
 
-	/* patch the first byte */
-	text_poke(addr, opcode, sizeof(int3));
+	patch_first_byte(addr, opcode, int3);
 
 	on_each_cpu(do_sync_core, NULL, 1);
 	/*
-- 
2.17.1

