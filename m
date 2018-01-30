Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbeA3EBb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 23:01:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752708AbeA3EB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 23:01:27 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/4] objtool: Don't print '.tmp_' prefix for .o files
Date: Mon, 29 Jan 2018 22:00:42 -0600
Message-Id: <3788b5aec1c279184b78cdbd8b520903c0fb8a80.1517284349.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1517284349.git.jpoimboe@redhat.com>
References: <cover.1517284349.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the following commit:

  2a0098d70640 ("objtool: Fix seg fault with gold linker")

... objtool warnings started showing the modversions '.tmp_' prefix in
the .o file name, like:

  arch/x86/mm/.tmp_mem_encrypt_boot.o: warning: objtool: sme_encrypt_execute()+0x48: indirect call found in RETPOLINE build

The prefix is confusing.  Remove it from the printed 'objname' variable.

Fixes: 2a0098d70640 ("objtool: Fix seg fault with gold linker")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9cd028aa1509..0bf61db0498a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1978,6 +1978,25 @@ static void cleanup(struct objtool_file *file)
 	elf_close(file->elf);
 }
 
+/*
+ * With CONFIG_MODVERSIONS, the object name has '.tmp_' prepended to it.
+ * After the file has been opened, remove the prefix so warnings will look
+ * sensible.
+ */
+static void fix_objname(void)
+{
+	char *s;
+
+	s = strstr(objname, ".tmp_");
+	if (!s)
+		return;
+
+	for (; s[5]; s++)
+		s[0] = s[5];
+
+	s[0] = 0;
+}
+
 int check(const char *_objname, bool _no_fp, bool no_unreachable, bool orc)
 {
 	struct objtool_file file;
@@ -1990,6 +2009,8 @@ int check(const char *_objname, bool _no_fp, bool no_unreachable, bool orc)
 	if (!file.elf)
 		return 1;
 
+	fix_objname();
+
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
 	file.whitelist = find_section_by_name(file.elf, ".discard.func_stack_frame_non_standard");
-- 
2.14.3
