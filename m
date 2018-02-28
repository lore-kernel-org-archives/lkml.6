Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932451AbeB1PIN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:08:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60315 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932422AbeB1PIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:08:06 -0500
Date: Wed, 28 Feb 2018 07:07:38 -0800
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-1402fd8ed7e5bda1b3e7613b70780b0db392d1e6@git.kernel.org>
Cc: peterz@infradead.org, mingo@kernel.org, jpoimboe@redhat.com,
        arnd@arndb.de, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: arnd@arndb.de, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com
In-Reply-To: <d7c8853022ad47d158cb81e953a40469fc08a95e.1519784382.git.jpoimboe@redhat.com>
References: <d7c8853022ad47d158cb81e953a40469fc08a95e.1519784382.git.jpoimboe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] objtool: Fix another switch table detection issue
Git-Commit-ID: 1402fd8ed7e5bda1b3e7613b70780b0db392d1e6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1402fd8ed7e5bda1b3e7613b70780b0db392d1e6
Gitweb:     https://git.kernel.org/tip/1402fd8ed7e5bda1b3e7613b70780b0db392d1e6
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 28 Feb 2018 07:19:21 -0600
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 16:03:19 +0100

objtool: Fix another switch table detection issue

Continue the switch table detection whack-a-mole.  Add a check to
distinguish KASAN data reads from switch data reads.  The switch jump
tables in .rodata have relocations associated with them.

This fixes the following warning:

  crypto/asymmetric_keys/x509_cert_parser.o: warning: objtool: x509_note_pkey_algo()+0xa4: sibling call from callable instruction with modified stack frame

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/d7c8853022ad47d158cb81e953a40469fc08a95e.1519784382.git.jpoimboe@redhat.com

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
