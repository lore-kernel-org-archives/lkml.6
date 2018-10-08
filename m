Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3652C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54832084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54832084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJHUF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:05:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeJHUF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:05:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3E9F309174E;
        Mon,  8 Oct 2018 12:53:51 +0000 (UTC)
Received: from f28server.default (ovpn-116-135.phx2.redhat.com [10.3.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C59C61D3F;
        Mon,  8 Oct 2018 12:53:48 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Zhou Chengming <zhouchengming1@huawei.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [RFC PATCH 5/6] x86/alternative: Split text_poke_bp() into tree steps
Date:   Mon,  8 Oct 2018 14:53:04 +0200
Message-Id: <b589f216935e5a10c5fc87fb89b0749a8a55dc4a.1539001620.git.bristot@redhat.com>
In-Reply-To: <cover.1539001620.git.bristot@redhat.com>
References: <cover.1539001620.git.bristot@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 08 Oct 2018 12:53:52 +0000 (UTC)
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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Zhou Chengming <zhouchengming1@huawei.com>
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
index b9d5e7c9ef43..a4c83cb49cd0 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -763,6 +763,29 @@ int poke_int3_handler(struct pt_regs *regs)
 
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
@@ -787,27 +810,21 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
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
@@ -816,8 +833,7 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 		on_each_cpu(do_sync_core, NULL, 1);
 	}
 
-	/* patch the first byte */
-	text_poke(addr, opcode, sizeof(int3));
+	patch_first_byte(addr, opcode, int3);
 
 	on_each_cpu(do_sync_core, NULL, 1);
 	/*
-- 
2.17.1

