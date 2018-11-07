Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8AEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3C42086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3C42086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeKHHRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:17:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbeKHHRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:17:45 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C069630821EB;
        Wed,  7 Nov 2018 21:45:28 +0000 (UTC)
Received: from shodan.usersys.redhat.com (unknown [10.43.17.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A14F18BA2;
        Wed,  7 Nov 2018 21:45:28 +0000 (UTC)
Received: by shodan.usersys.redhat.com (Postfix, from userid 1000)
        id E15712C1A13; Wed,  7 Nov 2018 22:45:27 +0100 (CET)
From:   Artem Savkov <asavkov@redhat.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Artem Savkov <asavkov@redhat.com>
Subject: [PATCH v2] objtool: fix .cold. functions parent symbols search
Date:   Wed,  7 Nov 2018 22:45:15 +0100
Message-Id: <20181107214515.9183-1-asavkov@redhat.com>
In-Reply-To: <20181107202942.s24ej5mnh4b3mflw@treble>
References: <20181107202942.s24ej5mnh4b3mflw@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 07 Nov 2018 21:45:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because find_symbol_by_name() traverses the same lists as read_symbols()
changing sym->name in place without copying it affects the result of
find_symbol_by_name() and, in case when ".cold" function precedes it's
parent in sec->symbol_list, can result in function being considered a
parent of itself. This leads to function length being set to 0 and other
consequent side-effects including a segfault in add_switch_table().
The effects of this bug are only visible when building with
-ffunction-sections in KCFLAGS.

Fix by copying the search string instead of modifying it in place.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 tools/objtool/elf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 6dbb9fae0f9d..781c8afb29b9 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -298,6 +298,7 @@ static int read_symbols(struct elf *elf)
 	/* Create parent/child links for any cold subfunctions */
 	list_for_each_entry(sec, &elf->sections, list) {
 		list_for_each_entry(sym, &sec->symbol_list, list) {
+			char *pname;
 			if (sym->type != STT_FUNC)
 				continue;
 			sym->pfunc = sym->cfunc = sym;
@@ -305,9 +306,9 @@ static int read_symbols(struct elf *elf)
 			if (!coldstr)
 				continue;
 
-			coldstr[0] = '\0';
-			pfunc = find_symbol_by_name(elf, sym->name);
-			coldstr[0] = '.';
+			pname = strndup(sym->name, coldstr - sym->name);
+			pfunc = find_symbol_by_name(elf, pname);
+			free(pname);
 
 			if (!pfunc) {
 				WARN("%s(): can't find parent function",
-- 
2.17.2

