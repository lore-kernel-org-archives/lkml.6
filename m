Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258CCC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B966820855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B966820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeIHPWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:22:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34985 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeIHPWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:22:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w88AarnV1058249
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 8 Sep 2018 03:36:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w88Aarma1058246;
        Sat, 8 Sep 2018 03:36:53 -0700
Date:   Sat, 8 Sep 2018 03:36:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Allan Xavier <tipbot@zytor.com>
Message-ID: <tip-4a60aa05a0634241ce17f957bf9fb5ac1eed6576@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        allan.x.xavier@oracle.com, mingo@kernel.org, jpoimboe@redhat.com
Reply-To: hpa@zytor.com, mingo@kernel.org, allan.x.xavier@oracle.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          jpoimboe@redhat.com
In-Reply-To: <099bdc375195c490dda04db777ee0b95d566ded1.1536325914.git.jpoimboe@redhat.com>
References: <099bdc375195c490dda04db777ee0b95d566ded1.1536325914.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/objtool] objtool: Support per-function rodata sections
Git-Commit-ID: 4a60aa05a0634241ce17f957bf9fb5ac1eed6576
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

Commit-ID:  4a60aa05a0634241ce17f957bf9fb5ac1eed6576
Gitweb:     https://git.kernel.org/tip/4a60aa05a0634241ce17f957bf9fb5ac1eed6576
Author:     Allan Xavier <allan.x.xavier@oracle.com>
AuthorDate: Fri, 7 Sep 2018 08:12:01 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 8 Sep 2018 12:33:01 +0200

objtool: Support per-function rodata sections

Add support for processing switch jump tables in objects with multiple
.rodata sections, such as those created by '-ffunction-sections' and
'-fdata-sections'.  Currently, objtool always looks in .rodata for jump
table information, which results in many "sibling call from callable
instruction with modified stack frame" warnings with objects compiled
using those flags.

The fix is comprised of three parts:

1. Flagging all .rodata sections when importing ELF information for
   easier checking later.

2. Keeping a reference to the section each relocation is from in order
   to get the list_head for the other relocations in that section.

3. Finding jump tables by following relocations to .rodata sections,
   rather than always referencing a single global .rodata section.

The patch has been tested without data sections enabled and no
differences in the resulting orc unwind information were seen.

Note that as objtool adds terminators to end of each .text section the
unwind information generated between a function+data sections build and
a normal build aren't directly comparable. Manual inspection suggests
that objtool is now generating the correct information, or at least
making more of an effort to do so than it did previously.

Signed-off-by: Allan Xavier <allan.x.xavier@oracle.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/099bdc375195c490dda04db777ee0b95d566ded1.1536325914.git.jpoimboe@redhat.com

---
 tools/objtool/check.c | 38 ++++++++++++++++++++++++++++++++------
 tools/objtool/check.h |  4 ++--
 tools/objtool/elf.c   |  1 +
 tools/objtool/elf.h   |  3 ++-
 4 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2928939b98ec..0414a0d52262 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -836,7 +836,7 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
 	struct symbol *pfunc = insn->func->pfunc;
 	unsigned int prev_offset = 0;
 
-	list_for_each_entry_from(rela, &file->rodata->rela->rela_list, list) {
+	list_for_each_entry_from(rela, &table->rela_sec->rela_list, list) {
 		if (rela == next_table)
 			break;
 
@@ -926,6 +926,7 @@ static struct rela *find_switch_table(struct objtool_file *file,
 {
 	struct rela *text_rela, *rodata_rela;
 	struct instruction *orig_insn = insn;
+	struct section *rodata_sec;
 	unsigned long table_offset;
 
 	/*
@@ -953,10 +954,13 @@ static struct rela *find_switch_table(struct objtool_file *file,
 		/* look for a relocation which references .rodata */
 		text_rela = find_rela_by_dest_range(insn->sec, insn->offset,
 						    insn->len);
-		if (!text_rela || text_rela->sym != file->rodata->sym)
+		if (!text_rela || text_rela->sym->type != STT_SECTION ||
+		    !text_rela->sym->sec->rodata)
 			continue;
 
 		table_offset = text_rela->addend;
+		rodata_sec = text_rela->sym->sec;
+
 		if (text_rela->type == R_X86_64_PC32)
 			table_offset += 4;
 
@@ -964,10 +968,10 @@ static struct rela *find_switch_table(struct objtool_file *file,
 		 * Make sure the .rodata address isn't associated with a
 		 * symbol.  gcc jump tables are anonymous data.
 		 */
-		if (find_symbol_containing(file->rodata, table_offset))
+		if (find_symbol_containing(rodata_sec, table_offset))
 			continue;
 
-		rodata_rela = find_rela_by_dest(file->rodata, table_offset);
+		rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
 		if (rodata_rela) {
 			/*
 			 * Use of RIP-relative switch jumps is quite rare, and
@@ -1052,7 +1056,7 @@ static int add_switch_table_alts(struct objtool_file *file)
 	struct symbol *func;
 	int ret;
 
-	if (!file->rodata || !file->rodata->rela)
+	if (!file->rodata)
 		return 0;
 
 	for_each_sec(file, sec) {
@@ -1198,10 +1202,33 @@ static int read_retpoline_hints(struct objtool_file *file)
 	return 0;
 }
 
+static void mark_rodata(struct objtool_file *file)
+{
+	struct section *sec;
+	bool found = false;
+
+	/*
+	 * This searches for the .rodata section or multiple .rodata.func_name
+	 * sections if -fdata-sections is being used. The .str.1.1 and .str.1.8
+	 * rodata sections are ignored as they don't contain jump tables.
+	 */
+	for_each_sec(file, sec) {
+		if (!strncmp(sec->name, ".rodata", 7) &&
+		    !strstr(sec->name, ".str1.")) {
+			sec->rodata = true;
+			found = true;
+		}
+	}
+
+	file->rodata = found;
+}
+
 static int decode_sections(struct objtool_file *file)
 {
 	int ret;
 
+	mark_rodata(file);
+
 	ret = decode_instructions(file);
 	if (ret)
 		return ret;
@@ -2171,7 +2198,6 @@ int check(const char *_objname, bool orc)
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
 	file.whitelist = find_section_by_name(file.elf, ".discard.func_stack_frame_non_standard");
-	file.rodata = find_section_by_name(file.elf, ".rodata");
 	file.c_file = find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 95700a2bcb7c..e6e8a655b556 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -60,8 +60,8 @@ struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 16);
-	struct section *rodata, *whitelist;
-	bool ignore_unreachables, c_file, hints;
+	struct section *whitelist;
+	bool ignore_unreachables, c_file, hints, rodata;
 };
 
 int check(const char *objname, bool orc);
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 7ec85d567598..f7082de1ee82 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -379,6 +379,7 @@ static int read_relas(struct elf *elf)
 			rela->offset = rela->rela.r_offset;
 			symndx = GELF_R_SYM(rela->rela.r_info);
 			rela->sym = find_symbol_by_index(elf, symndx);
+			rela->rela_sec = sec;
 			if (!rela->sym) {
 				WARN("can't find rela entry symbol %d for %s",
 				     symndx, sec->name);
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index de5cd2ddded9..bc97ed86b9cd 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -48,7 +48,7 @@ struct section {
 	char *name;
 	int idx;
 	unsigned int len;
-	bool changed, text;
+	bool changed, text, rodata;
 };
 
 struct symbol {
@@ -68,6 +68,7 @@ struct rela {
 	struct list_head list;
 	struct hlist_node hash;
 	GElf_Rela rela;
+	struct section *rela_sec;
 	struct symbol *sym;
 	unsigned int type;
 	unsigned long offset;
