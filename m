Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeB1NT3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:19:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752206AbeB1NT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:19:27 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: Fix another switch table detection issue
Date: Wed, 28 Feb 2018 07:19:21 -0600
Message-Id: <d7c8853022ad47d158cb81e953a40469fc08a95e.1519784382.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continue the switch table detection whack-a-mole.  Add a check to
distinguish KASAN data reads from switch data reads.  The switch jump
tables in .rodata have relocations associated with them.

This fixes the following warning:

  crypto/asymmetric_keys/x509_cert_parser.o: warning: objtool: x509_note_pkey_algo()+0xa4: sibling call from callable instruction with modified stack frame

Reported-and-tested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 472e64e95891..46c1d239cc1b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -925,7 +925,11 @@ static struct rela *find_switch_table(struct objtool_file *file,
 		if (find_symbol_containing(file->rodata, text_rela->addend))
 			continue;
 
-		return find_rela_by_dest(file->rodata, text_rela->addend);
+		rodata_rela = find_rela_by_dest(file->rodata, text_rela->addend);
+		if (!rodata_rela)
+			continue;
+
+		return rodata_rela;
 	}
 
 	return NULL;
-- 
2.14.3
