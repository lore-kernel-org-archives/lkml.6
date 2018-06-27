Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268F8C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8187253F3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8187253F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966307AbeF0WEB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 18:04:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966248AbeF0WEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 18:04:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B399687A80;
        Wed, 27 Jun 2018 22:03:59 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-92.rdu2.redhat.com [10.10.120.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74FA21C672;
        Wed, 27 Jun 2018 22:03:59 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Allan Xavier <allan.x.xavier@oracle.com>
Subject: [PATCH] objtool: Support GCC 8 '-fnoreorder-functions'
Date:   Wed, 27 Jun 2018 17:03:45 -0500
Message-Id: <9e704c52bee651129b036be14feda317ae5606ae.1530136978.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 27 Jun 2018 22:03:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 27 Jun 2018 22:03:59 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
-- 
2.17.0

