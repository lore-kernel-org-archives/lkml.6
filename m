Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5D4C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A863206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A863206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeKUEga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:36:30 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38457 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeKUEga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:36:30 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAKI5jk43062960
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Nov 2018 10:05:45 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAKI5jxc3062956;
        Tue, 20 Nov 2018 10:05:45 -0800
Date:   Tue, 20 Nov 2018 10:05:45 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Artem Savkov <tipbot@zytor.com>
Message-ID: <tip-22566c1603030f0a036ad564634b064ad1a55db2@git.kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@kernel.org, asavkov@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, torvalds@linux-foundation.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, asavkov@redhat.com, jpoimboe@redhat.com,
          tglx@linutronix.de
In-Reply-To: <910abd6b5a4945130fd44f787c24e07b9e07c8da.1542736240.git.jpoimboe@redhat.com>
References: <910abd6b5a4945130fd44f787c24e07b9e07c8da.1542736240.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Fix segfault in .cold detection with
 -ffunction-sections
Git-Commit-ID: 22566c1603030f0a036ad564634b064ad1a55db2
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

Commit-ID:  22566c1603030f0a036ad564634b064ad1a55db2
Gitweb:     https://git.kernel.org/tip/22566c1603030f0a036ad564634b064ad1a55db2
Author:     Artem Savkov <asavkov@redhat.com>
AuthorDate: Tue, 20 Nov 2018 11:52:16 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Nov 2018 18:59:00 +0100

objtool: Fix segfault in .cold detection with -ffunction-sections

Because find_symbol_by_name() traverses the same lists as
read_symbols(), changing sym->name in place without copying it affects
the result of find_symbol_by_name().  In the case where a ".cold"
function precedes its parent in sec->symbol_list, it can result in a
function being considered a parent of itself. This leads to function
length being set to 0 and other consequent side-effects including a
segfault in add_switch_table().  The effects of this bug are only
visible when building with -ffunction-sections in KCFLAGS.

Fix by copying the search string instead of modifying it in place.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 13810435b9a7 ("objtool: Support GCC 8's cold subfunctions")
Link: http://lkml.kernel.org/r/910abd6b5a4945130fd44f787c24e07b9e07c8da.1542736240.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/elf.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index e7a7ac40e045..b8f3cca8e58b 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -31,6 +31,8 @@
 #include "elf.h"
 #include "warn.h"
 
+#define MAX_NAME_LEN 128
+
 struct section *find_section_by_name(struct elf *elf, const char *name)
 {
 	struct section *sec;
@@ -298,6 +300,8 @@ static int read_symbols(struct elf *elf)
 	/* Create parent/child links for any cold subfunctions */
 	list_for_each_entry(sec, &elf->sections, list) {
 		list_for_each_entry(sym, &sec->symbol_list, list) {
+			char pname[MAX_NAME_LEN + 1];
+			size_t pnamelen;
 			if (sym->type != STT_FUNC)
 				continue;
 			sym->pfunc = sym->cfunc = sym;
@@ -305,9 +309,16 @@ static int read_symbols(struct elf *elf)
 			if (!coldstr)
 				continue;
 
-			coldstr[0] = '\0';
-			pfunc = find_symbol_by_name(elf, sym->name);
-			coldstr[0] = '.';
+			pnamelen = coldstr - sym->name;
+			if (pnamelen > MAX_NAME_LEN) {
+				WARN("%s(): parent function name exceeds maximum length of %d characters",
+				     sym->name, MAX_NAME_LEN);
+				return -1;
+			}
+
+			strncpy(pname, sym->name, pnamelen);
+			pname[pnamelen] = '\0';
+			pfunc = find_symbol_by_name(elf, pname);
 
 			if (!pfunc) {
 				WARN("%s(): can't find parent function",
