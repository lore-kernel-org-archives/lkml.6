Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B952C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432D520868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432D520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbeK3DCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:02:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbeK3DCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:02:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7E283084244;
        Thu, 29 Nov 2018 15:56:20 +0000 (UTC)
Received: from shodan.usersys.redhat.com (unknown [10.43.17.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26C417C832;
        Thu, 29 Nov 2018 15:56:20 +0000 (UTC)
Received: by shodan.usersys.redhat.com (Postfix, from userid 1000)
        id 5E7772C136D; Thu, 29 Nov 2018 16:56:19 +0100 (CET)
From:   Artem Savkov <asavkov@redhat.com>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCH v2] x86/tools/relocs: fix big section header tables
Date:   Thu, 29 Nov 2018 16:56:15 +0100
Message-Id: <20181129155615.2594-1-asavkov@redhat.com>
In-Reply-To: <20181129153258.cutmesclgfadc5gu@treble>
References: <20181129153258.cutmesclgfadc5gu@treble>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 29 Nov 2018 15:56:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case when the number of entries in the section header table is larger
then or equal to SHN_LORESERVE the size of the table is held in the sh_size
member of the initial entry in section header table instead of e_shnum.
Same with the string table index which is located in sh_link instead of
e_shstrndx.

This case is easily reproducible with KCFLAGS="-ffunction-sections",
bzImage build fails with "String table index out of bounds" error.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 arch/x86/tools/relocs.c | 58 +++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index b629f6992d9f..1f5dcec15d4e 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -11,7 +11,9 @@
 #define Elf_Shdr		ElfW(Shdr)
 #define Elf_Sym			ElfW(Sym)
 
-static Elf_Ehdr ehdr;
+static Elf_Ehdr		ehdr;
+static unsigned long	shnum;
+static unsigned int	shstrndx;
 
 struct relocs {
 	uint32_t	*offset;
@@ -241,9 +243,9 @@ static const char *sec_name(unsigned shndx)
 {
 	const char *sec_strtab;
 	const char *name;
-	sec_strtab = secs[ehdr.e_shstrndx].strtab;
+	sec_strtab = secs[shstrndx].strtab;
 	name = "<noname>";
-	if (shndx < ehdr.e_shnum) {
+	if (shndx < shnum) {
 		name = sec_strtab + secs[shndx].shdr.sh_name;
 	}
 	else if (shndx == SHN_ABS) {
@@ -271,7 +273,7 @@ static const char *sym_name(const char *sym_strtab, Elf_Sym *sym)
 static Elf_Sym *sym_lookup(const char *symname)
 {
 	int i;
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		long nsyms;
 		char *strtab;
@@ -366,6 +368,9 @@ static void read_ehdr(FILE *fp)
 	ehdr.e_shnum     = elf_half_to_cpu(ehdr.e_shnum);
 	ehdr.e_shstrndx  = elf_half_to_cpu(ehdr.e_shstrndx);
 
+	shnum = ehdr.e_shnum;
+	shstrndx = ehdr.e_shstrndx;
+
 	if ((ehdr.e_type != ET_EXEC) && (ehdr.e_type != ET_DYN)) {
 		die("Unsupported ELF header type\n");
 	}
@@ -384,7 +389,26 @@ static void read_ehdr(FILE *fp)
 	if (ehdr.e_shentsize != sizeof(Elf_Shdr)) {
 		die("Bad section header entry\n");
 	}
-	if (ehdr.e_shstrndx >= ehdr.e_shnum) {
+
+	if (shnum == SHN_UNDEF || shstrndx == SHN_XINDEX) {
+		Elf_Shdr shdr;
+
+		if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0)
+			die("Seek to %d failed: %s\n",
+				ehdr.e_shoff, strerror(errno));
+
+		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
+			die("Cannot read initial ELF section header: %s\n",
+			    strerror(errno));
+
+		if (shnum == SHN_UNDEF)
+			shnum = elf_xword_to_cpu(shdr.sh_size);
+
+		if (shstrndx == SHN_XINDEX)
+			shstrndx = elf_word_to_cpu(shdr.sh_link);
+	}
+
+	if (shstrndx >= shnum) {
 		die("String table index out of bounds\n");
 	}
 }
@@ -394,20 +418,20 @@ static void read_shdrs(FILE *fp)
 	int i;
 	Elf_Shdr shdr;
 
-	secs = calloc(ehdr.e_shnum, sizeof(struct section));
+	secs = calloc(shnum, sizeof(struct section));
 	if (!secs) {
 		die("Unable to allocate %d section headers\n",
-		    ehdr.e_shnum);
+		    shnum);
 	}
 	if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0) {
 		die("Seek to %d failed: %s\n",
 			ehdr.e_shoff, strerror(errno));
 	}
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
 			die("Cannot read ELF section headers %d/%d: %s\n",
-			    i, ehdr.e_shnum, strerror(errno));
+			    i, shnum, strerror(errno));
 		sec->shdr.sh_name      = elf_word_to_cpu(shdr.sh_name);
 		sec->shdr.sh_type      = elf_word_to_cpu(shdr.sh_type);
 		sec->shdr.sh_flags     = elf_xword_to_cpu(shdr.sh_flags);
@@ -418,7 +442,7 @@ static void read_shdrs(FILE *fp)
 		sec->shdr.sh_info      = elf_word_to_cpu(shdr.sh_info);
 		sec->shdr.sh_addralign = elf_xword_to_cpu(shdr.sh_addralign);
 		sec->shdr.sh_entsize   = elf_xword_to_cpu(shdr.sh_entsize);
-		if (sec->shdr.sh_link < ehdr.e_shnum)
+		if (sec->shdr.sh_link < shnum)
 			sec->link = &secs[sec->shdr.sh_link];
 	}
 
@@ -427,7 +451,7 @@ static void read_shdrs(FILE *fp)
 static void read_strtabs(FILE *fp)
 {
 	int i;
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		if (sec->shdr.sh_type != SHT_STRTAB) {
 			continue;
@@ -452,7 +476,7 @@ static void read_strtabs(FILE *fp)
 static void read_symtabs(FILE *fp)
 {
 	int i,j;
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		if (sec->shdr.sh_type != SHT_SYMTAB) {
 			continue;
@@ -485,7 +509,7 @@ static void read_symtabs(FILE *fp)
 static void read_relocs(FILE *fp)
 {
 	int i,j;
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		if (sec->shdr.sh_type != SHT_REL_TYPE) {
 			continue;
@@ -528,7 +552,7 @@ static void print_absolute_symbols(void)
 
 	printf("Absolute symbols\n");
 	printf(" Num:    Value Size  Type       Bind        Visibility  Name\n");
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		char *sym_strtab;
 		int j;
@@ -566,7 +590,7 @@ static void print_absolute_relocs(void)
 	else
 		format = "%08"PRIx32" %08"PRIx32" %10s %08"PRIx32"  %s\n";
 
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		struct section *sec_applies, *sec_symtab;
 		char *sym_strtab;
@@ -650,7 +674,7 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 {
 	int i;
 	/* Walk through the relocations */
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		char *sym_strtab;
 		Elf_Sym *sh_symtab;
 		struct section *sec_applies, *sec_symtab;
@@ -706,7 +730,7 @@ static Elf_Addr per_cpu_load_addr;
 static void percpu_init(void)
 {
 	int i;
-	for (i = 0; i < ehdr.e_shnum; i++) {
+	for (i = 0; i < shnum; i++) {
 		ElfW(Sym) *sym;
 		if (strcmp(sec_name(i), ".data..percpu"))
 			continue;
-- 
2.19.1

