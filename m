Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15327C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE85B2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789573;
	bh=XfX/MPy75tFDAOzxEDwKsbJVyRvpamlSAf/pGDOJ82w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HIBOTPah2QcgoinRZSkRelwJf09a/2QRcZgzBpISnBxaqEGcMDbDMg8Lk2AbTr1w5
	 t3YJEKZFqA5A8F1GJnlsQbTP7eSlUKTxePg3Xx+SHcnQUchCD/wDZFbvnTs2WQkhdc
	 6nyAUAdKRpM1sL5dbfJHNGfaczWR7fJKD4SJm/q4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE85B2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbeLNMMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:12:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731653AbeLNMMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:12:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2DA320892;
        Fri, 14 Dec 2018 12:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789569;
        bh=XfX/MPy75tFDAOzxEDwKsbJVyRvpamlSAf/pGDOJ82w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0EXTzpTfzy6MLEMh184+W9Y58e4gno23zkpZFMbgtSybpnKBhro2sj3dVtkyPl+J9
         GGjWeOokJYJXELrZXScFlUIeT8iBnFGwwgshPbnlZelsCrfYT+7lz3QMrPzUFj52ac
         Qw+7eA4ayWT8ivcsK3sSr4UoQfKeXIanllVKf/bw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Artem Savkov <asavkov@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 22/51] objtool: Fix segfault in .cold detection with -ffunction-sections
Date:   Fri, 14 Dec 2018 13:00:24 +0100
Message-Id: <20181214115715.473913882@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 22566c1603030f0a036ad564634b064ad1a55db2 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/elf.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 3616d626991e..dd4ed7c3c062 100644
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
2.19.1



