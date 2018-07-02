Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651D7C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A03825229
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A03825229
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbeGBHrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:47:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46513 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753815AbeGBHrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:47:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w627k2xT3996351
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Jul 2018 00:46:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w627k28J3996347;
        Mon, 2 Jul 2018 00:46:02 -0700
Date:   Mon, 2 Jul 2018 00:46:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-08b393d01c88aff27347ed2b1b354eb4db2f1532@git.kernel.org>
Cc:     dvlasenk@redhat.com, luto@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com, jpoimboe@redhat.com,
        torvalds@linux-foundation.org, bp@alien8.de,
        allan.x.xavier@oracle.com, tglx@linutronix.de, brgerst@gmail.com,
        mingo@kernel.org
Reply-To: torvalds@linux-foundation.org, bp@alien8.de, mingo@kernel.org,
          brgerst@gmail.com, tglx@linutronix.de, allan.x.xavier@oracle.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          dvlasenk@redhat.com, luto@kernel.org, hpa@zytor.com,
          jpoimboe@redhat.com
In-Reply-To: <9e704c52bee651129b036be14feda317ae5606ae.1530136978.git.jpoimboe@redhat.com>
References: <9e704c52bee651129b036be14feda317ae5606ae.1530136978.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Support GCC 8 '-fnoreorder-functions'
Git-Commit-ID: 08b393d01c88aff27347ed2b1b354eb4db2f1532
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

Commit-ID:  08b393d01c88aff27347ed2b1b354eb4db2f1532
Gitweb:     https://git.kernel.org/tip/08b393d01c88aff27347ed2b1b354eb4db2f1532
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 27 Jun 2018 17:03:45 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 2 Jul 2018 09:42:11 +0200

objtool: Support GCC 8 '-fnoreorder-functions'

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
---
 tools/objtool/elf.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4e60e105583e..0d1acb704f64 100644
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
-
-				if (!pfunc) {
-					WARN("%s(): can't find parent function",
-					     sym->name);
-					goto err;
-				}
-
-				sym->pfunc = pfunc;
-				pfunc->cfunc = sym;
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
+
+			sym->pfunc = pfunc;
+			pfunc->cfunc = sym;
+
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
