Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0089C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92560208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92560208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389361AbeHWMlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:41:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57328 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbeHWMlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:41:52 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B3247C50;
        Thu, 23 Aug 2018 09:13:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Allan Xavier <allan.x.xavier@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 163/324] objtool: Support GCC 8 -fnoreorder-functions
Date:   Thu, 23 Aug 2018 09:53:49 +0200
Message-Id: <20180823075004.221525510@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

[ Upstream commit 08b393d01c88aff27347ed2b1b354eb4db2f1532 ]

Since the following commit:

  cd77849a69cf ("objtool: Fix GCC 8 cold subfunction detection for aliased functions")

... if the kernel is built with EXTRA_CFLAGS='-fno-reorder-functions',
objtool can get stuck in an infinite loop.

That flag causes the new GCC 8 cold subfunctions to be placed in .text
instead of .text.unlikely.  But it also has an unfortunate quirk: in the
symbol table, the subfunction (e.g., nmi_panic.cold.7) is nested inside
the parent (nmi_panic).

That function overlap confuses objtool, and causes it to get into an
infinite loop in next_insn_same_func().  Here's Allan's description of
the loop:

  "Objtool iterates through the instructions in nmi_panic using
  next_insn_same_func. Once it reaches the end of nmi_panic at 0x534 it
  jumps to 0x528 as that's the start of nmi_panic.cold.7. However, since
  the instructions starting at 0x528 are still associated with nmi_panic
  objtool will get stuck in a loop, continually jumping back to 0x528
  after reaching 0x534."

Fix it by shortening the length of the parent function so that the
functions no longer overlap.

Reported-and-analyzed-by: Allan Xavier <allan.x.xavier@oracle.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Allan Xavier <allan.x.xavier@oracle.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/9e704c52bee651129b036be14feda317ae5606ae.1530136978.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/objtool/elf.c |   37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -302,19 +302,34 @@ static int read_symbols(struct elf *elf)
 				continue;
 			sym->pfunc = sym->cfunc = sym;
 			coldstr = strstr(sym->name, ".cold.");
-			if (coldstr) {
-				coldstr[0] = '\0';
-				pfunc = find_symbol_by_name(elf, sym->name);
-				coldstr[0] = '.';
+			if (!coldstr)
+				continue;
+
+			coldstr[0] = '\0';
+			pfunc = find_symbol_by_name(elf, sym->name);
+			coldstr[0] = '.';
+
+			if (!pfunc) {
+				WARN("%s(): can't find parent function",
+				     sym->name);
+				goto err;
+			}
 
-				if (!pfunc) {
-					WARN("%s(): can't find parent function",
-					     sym->name);
-					goto err;
-				}
+			sym->pfunc = pfunc;
+			pfunc->cfunc = sym;
 
-				sym->pfunc = pfunc;
-				pfunc->cfunc = sym;
+			/*
+			 * Unfortunately, -fnoreorder-functions puts the child
+			 * inside the parent.  Remove the overlap so we can
+			 * have sane assumptions.
+			 *
+			 * Note that pfunc->len now no longer matches
+			 * pfunc->sym.st_size.
+			 */
+			if (sym->sec == pfunc->sec &&
+			    sym->offset >= pfunc->offset &&
+			    sym->offset + sym->len == pfunc->offset + pfunc->len) {
+				pfunc->len -= sym->len;
 			}
 		}
 	}


