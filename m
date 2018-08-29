Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA4CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3832064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ihltIlPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3832064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeH2VEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:04:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58658 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbeH2VEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:04:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7TH3nIO124312;
        Wed, 29 Aug 2018 17:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=VQpPq3XK7oA7VZ4r1SAJsW5Yb9awOnZQWV8qqIFf23A=;
 b=ihltIlPtHtZwTXGU5RdGXzu46psi6JNZv8+PA4ic3zfn12CdUB4U++A1e0gPzHRqk8oc
 T4Kx8r4U3YDchLWIuBow0tpcje4vMxMtvb9F53wBIIw8e8ZzE3uQvONZKMtVpSXnPpIP
 GlBIFEjUF34fLdK+9Lr7yDbJhHZVM0QKzgLTxxZGHIDUKJNfdy9ClYlfmaa8MM75SJvJ
 foi4DZXigS3HuHzmfYOXLayHuAYwFgShTWeEaBxhggWflMZNc/mv4jL2597jD8kH0KE0
 uf/3FL4detfNchBK8O50JNSELWmX57TZwpeq0kmhcGYZ2LANN71A21yozF1iJTmJzXgt Qg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2m2yrqb1b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 17:05:59 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7TH5wsg028058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 17:05:59 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7TH5vu6007552;
        Wed, 29 Aug 2018 17:05:58 GMT
Received: from localhost (/10.175.177.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Aug 2018 10:05:56 -0700
From:   Allan Xavier <allan.x.xavier@oracle.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Allan Xavier <allan.x.xavier@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] objtool: Support multiple rodata sections.
Date:   Wed, 29 Aug 2018 18:04:12 +0100
Message-Id: <20180829170412.8248-1-allan.x.xavier@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808290174
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

Changes since v2:
- Reworked and commented mark_rodata as suggested.

Changes since v1:
 - Cleaned up section symbol check.
 - Fixed brackets.
 - Moved mark_rodata to decode_sections().
 - Excluded *.str1.[18] sections from rodata sections.

 tools/objtool/check.c | 38 ++++++++++++++++++++++++++++++++------
 tools/objtool/check.h |  4 ++--
 tools/objtool/elf.c   |  1 +
 tools/objtool/elf.h   |  3 ++-
 4 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f4a25bd1871fb..923cbf60436e2 100644
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
@@ -1197,10 +1201,33 @@ static int read_retpoline_hints(struct objtool_file *file)
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
@@ -2170,7 +2197,6 @@ int check(const char *_objname, bool orc)
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
 	file.whitelist = find_section_by_name(file.elf, ".discard.func_stack_frame_non_standard");
-	file.rodata = find_section_by_name(file.elf, ".rodata");
 	file.c_file = find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
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
index 7ec85d567598c..f7082de1ee829 100644
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

