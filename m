Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C74CC46463
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396E1206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396E1206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbeKUEXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:23:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbeKUEXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:23:33 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24F5A3082B54;
        Tue, 20 Nov 2018 17:53:12 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-214.rdu2.redhat.com [10.10.122.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 786CE2634A;
        Tue, 20 Nov 2018 17:53:11 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Artem Savkov <asavkov@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/2] objtool: Fix seg fault in .cold detection with -ffunction-sections
Date:   Tue, 20 Nov 2018 11:52:16 -0600
Message-Id: <910abd6b5a4945130fd44f787c24e07b9e07c8da.1542736240.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1542736240.git.jpoimboe@redhat.com>
References: <cover.1542736240.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 20 Nov 2018 17:53:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artem Savkov <asavkov@redhat.com>

Because find_symbol_by_name() traverses the same lists as
read_symbols(), changing sym->name in place without copying it affects
the result of find_symbol_by_name().  In the case where a ".cold"
function precedes its parent in sec->symbol_list, it can result in a
function being considered a parent of itself. This leads to function
length being set to 0 and other consequent side-effects including a
segfault in add_switch_table().  The effects of this bug are only
visible when building with -ffunction-sections in KCFLAGS.

Fix by copying the search string instead of modifying it in place.

Fixes: 13810435b9a7 ("objtool: Support GCC 8's cold subfunctions")
Signed-off-by: Artem Savkov <asavkov@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
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
-- 
2.17.2

