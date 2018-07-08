Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C461C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 09:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56611208D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 09:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56611208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754161AbeGHJnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 05:43:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58222 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753945AbeGHJnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 05:43:16 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fc6Dq-0003W8-VZ; Sun, 08 Jul 2018 11:43:15 +0200
Date:   Sun, 8 Jul 2018 11:43:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] core udpates for 4.18
Message-ID: <alpine.DEB.2.21.1807081140110.1589@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

A single fix for objtool to address a bug in handling the cold subfunction
detection for aliased functions which was added recently. The bug causes
objtool to enter an infinite loop.

Thanks,

	tglx

------------------>
Josh Poimboeuf (1):
      objtool: Support GCC 8 '-fnoreorder-functions'


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
