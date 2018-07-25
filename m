Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3368C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4EF20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A2TbNae+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4EF20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeGYPae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:30:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42142 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbeGYPae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:30:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6PEETWN111322;
        Wed, 25 Jul 2018 14:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=jh4lsQUv4p9OJjClZ9u/ZU0mkY2yl+oH9D5m+D7zPo4=;
 b=A2TbNae+K3L2tT8tmq47Oy0KaJ4mfT58gadatE0nb452E8eitZdk9k/7s6QE07IKA5KM
 YB4H40WFxP2Znyy737/QUKYEsyQzDi4ml6obITaFk/1J82JJ+aUYd+pvP7Evs3JqItqF
 jhhRM+fTyZrAEMav6z5gVIxGFSwwc7WcUrvbk7dBdBWnWXU9FenoOSYjOyFWENznJ3/A
 g+UQlK/WJqBbD4M7dCQpoNM97q0KHCVX+fzBYpU2IgkaGfNa6tmOk5azftTtaKXciUCk
 +rQeiIJ5PTXl1hnOfuD6QczWH/XhdBeIcaUw+KsN7YJ57AgUERf8ct7CuySu3gLYhWln Fg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2kbv8t5mhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 14:18:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6PEI9Ck016101
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 14:18:09 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6PEI8vG007036;
        Wed, 25 Jul 2018 14:18:08 GMT
Received: from localhost (/10.175.197.233)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Jul 2018 07:18:08 -0700
From:   Allan Xavier <allan.x.xavier@oracle.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Allan Xavier <allan.x.xavier@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: Support multiple rodata sections.
Date:   Wed, 25 Jul 2018 15:17:53 +0100
Message-Id: <20180725141754.29644-1-allan.x.xavier@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8964 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807250154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for processing switch jump tables in objects
with multiple .rodata sections, such as those created when using
-ffunction-sections and -fdata-sections.  Currently, objtool always
looks in .rodata for jump table information which results in many
"sibling call from callable instruction with modified stack frame"
warnings with objects compiled using those flags.

The fix is comprised of three parts:

1. Flagging all .rodata sections when importing elf information for
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
---
 tools/objtool/check.c | 30 ++++++++++++++++++++++++------
 tools/objtool/check.h |  4 ++--
 tools/objtool/elf.c   |  1 +
 tools/objtool/elf.h   |  3 ++-
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3a31b238f8856..9f13c7a018528 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -813,7 +813,7 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
 	struct symbol *pfunc = insn->func->pfunc;
 	unsigned int prev_offset = 0;
 
-	list_for_each_entry_from(rela, &file->rodata->rela->rela_list, list) {
+	list_for_each_entry_from(rela, &table->rela_sec->rela_list, list) {
 		if (rela == next_table)
 			break;
 
@@ -903,6 +903,7 @@ static struct rela *find_switch_table(struct objtool_file *file,
 {
 	struct rela *text_rela, *rodata_rela;
 	struct instruction *orig_insn = insn;
+	struct section *rodata_sec;
 	unsigned long table_offset;
 
 	/*
@@ -930,10 +931,13 @@ static struct rela *find_switch_table(struct objtool_file *file,
 		/* look for a relocation which references .rodata */
 		text_rela = find_rela_by_dest_range(insn->sec, insn->offset,
 						    insn->len);
-		if (!text_rela || text_rela->sym != file->rodata->sym)
+		if (!text_rela || !text_rela->sym->sec->rodata
+			       || text_rela->sym != text_rela->sym->sec->sym)
 			continue;
 
 		table_offset = text_rela->addend;
+		rodata_sec = text_rela->sym->sec;
+
 		if (text_rela->type == R_X86_64_PC32)
 			table_offset += 4;
 
@@ -941,10 +945,10 @@ static struct rela *find_switch_table(struct objtool_file *file,
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
@@ -1029,7 +1033,7 @@ static int add_switch_table_alts(struct objtool_file *file)
 	struct symbol *func;
 	int ret;
 
-	if (!file->rodata || !file->rodata->rela)
+	if (!file->rodata)
 		return 0;
 
 	for_each_sec(file, sec) {
@@ -2133,6 +2137,20 @@ static void cleanup(struct objtool_file *file)
 	elf_close(file->elf);
 }
 
+static bool mark_rodata(struct objtool_file *file)
+{
+	struct section *sec;
+	bool found = false;
+
+	for_each_sec(file, sec)
+		if (strstr(sec->name, ".rodata") == sec->name) {
+			sec->rodata = true;
+			found = true;
+		}
+
+	return found;
+}
+
 int check(const char *_objname, bool orc)
 {
 	struct objtool_file file;
@@ -2147,10 +2165,10 @@ int check(const char *_objname, bool orc)
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
 	file.whitelist = find_section_by_name(file.elf, ".discard.func_stack_frame_non_standard");
-	file.rodata = find_section_by_name(file.elf, ".rodata");
 	file.c_file = find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
+	file.rodata = mark_rodata(&file);
 
 	arch_initial_func_cfi_state(&initial_func_cfi);
 
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index c6b68fcb926ff..a039521b67530 100644
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
index 4e60e105583ee..7241afdecda33 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -364,6 +364,7 @@ static int read_relas(struct elf *elf)
 			rela->offset = rela->rela.r_offset;
 			symndx = GELF_R_SYM(rela->rela.r_info);
 			rela->sym = find_symbol_by_index(elf, symndx);
+			rela->rela_sec = sec;
 			if (!rela->sym) {
 				WARN("can't find rela entry symbol %d for %s",
 				     symndx, sec->name);
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index de5cd2ddded98..bc97ed86b9cd8 100644
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
-- 
2.18.0

