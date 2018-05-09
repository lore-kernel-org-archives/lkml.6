Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756209AbeEIHYt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:24:49 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:50567 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755400AbeEIHYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:24:46 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w497O36F028852
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] kallsyms: remove symbol prefix support
Date: Wed,  9 May 2018 16:23:47 +0900
Message-Id: <1525850632-10921-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
References: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX was selected by BLACKFIN, METAG.
They were removed by commit 4ba66a976072 ("arch: remove blackfin port"),
commit bb6fb6dfcc17 ("metag: Remove arch/metag/"), respectively.

No more architecture enables CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX,
hence the --symbol-prefix option is unnecessary.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kallsyms.c      | 47 +++++++++++------------------------------------
 scripts/link-vmlinux.sh |  4 ----
 2 files changed, 11 insertions(+), 40 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 5abfbf1..8041762 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -62,7 +62,6 @@ static struct sym_entry *table;
 static unsigned int table_size, table_cnt;
 static int all_symbols = 0;
 static int absolute_percpu = 0;
-static char symbol_prefix_char = '\0';
 static int base_relative = 0;
 
 int token_profit[0x10000];
@@ -75,7 +74,6 @@ unsigned char best_table_len[256];
 static void usage(void)
 {
 	fprintf(stderr, "Usage: kallsyms [--all-symbols] "
-			"[--symbol-prefix=<prefix char>] "
 			"[--base-relative] < in.map > out.S\n");
 	exit(1);
 }
@@ -113,28 +111,22 @@ static int check_symbol_range(const char *sym, unsigned long long addr,
 
 static int read_symbol(FILE *in, struct sym_entry *s)
 {
-	char str[500];
-	char *sym, stype;
+	char sym[500], stype;
 	int rc;
 
-	rc = fscanf(in, "%llx %c %499s\n", &s->addr, &stype, str);
+	rc = fscanf(in, "%llx %c %499s\n", &s->addr, &stype, sym);
 	if (rc != 3) {
-		if (rc != EOF && fgets(str, 500, in) == NULL)
+		if (rc != EOF && fgets(sym, 500, in) == NULL)
 			fprintf(stderr, "Read error or end of file.\n");
 		return -1;
 	}
-	if (strlen(str) > KSYM_NAME_LEN) {
+	if (strlen(sym) > KSYM_NAME_LEN) {
 		fprintf(stderr, "Symbol %s too long for kallsyms (%zu vs %d).\n"
 				"Please increase KSYM_NAME_LEN both in kernel and kallsyms.c\n",
-			str, strlen(str), KSYM_NAME_LEN);
+			sym, strlen(sym), KSYM_NAME_LEN);
 		return -1;
 	}
 
-	sym = str;
-	/* skip prefix char */
-	if (symbol_prefix_char && str[0] == symbol_prefix_char)
-		sym++;
-
 	/* Ignore most absolute/undefined (?) symbols. */
 	if (strcmp(sym, "_text") == 0)
 		_text = s->addr;
@@ -155,7 +147,7 @@ static int read_symbol(FILE *in, struct sym_entry *s)
 		 is_arm_mapping_symbol(sym))
 		return -1;
 	/* exclude also MIPS ELF local symbols ($L123 instead of .L123) */
-	else if (str[0] == '$')
+	else if (sym[0] == '$')
 		return -1;
 	/* exclude debugging symbols */
 	else if (stype == 'N' || stype == 'n')
@@ -163,14 +155,14 @@ static int read_symbol(FILE *in, struct sym_entry *s)
 
 	/* include the type field in the symbol name, so that it gets
 	 * compressed together */
-	s->len = strlen(str) + 1;
+	s->len = strlen(sym) + 1;
 	s->sym = malloc(s->len + 1);
 	if (!s->sym) {
 		fprintf(stderr, "kallsyms failure: "
 			"unable to allocate required amount of memory\n");
 		exit(EXIT_FAILURE);
 	}
-	strcpy((char *)s->sym + 1, str);
+	strcpy((char *)s->sym + 1, sym);
 	s->sym[0] = stype;
 
 	s->percpu_absolute = 0;
@@ -233,11 +225,6 @@ static int symbol_valid(struct sym_entry *s)
 	int i;
 	char *sym_name = (char *)s->sym + 1;
 
-	/* skip prefix char */
-	if (symbol_prefix_char && *sym_name == symbol_prefix_char)
-		sym_name++;
-
-
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
 	if (!all_symbols) {
@@ -302,15 +289,9 @@ static void read_map(FILE *in)
 
 static void output_label(char *label)
 {
-	if (symbol_prefix_char)
-		printf(".globl %c%s\n", symbol_prefix_char, label);
-	else
-		printf(".globl %s\n", label);
+	printf(".globl %s\n", label);
 	printf("\tALGN\n");
-	if (symbol_prefix_char)
-		printf("%c%s:\n", symbol_prefix_char, label);
-	else
-		printf("%s:\n", label);
+	printf("%s:\n", label);
 }
 
 /* uncompress a compressed symbol. When this function is called, the best table
@@ -768,13 +749,7 @@ int main(int argc, char **argv)
 				all_symbols = 1;
 			else if (strcmp(argv[i], "--absolute-percpu") == 0)
 				absolute_percpu = 1;
-			else if (strncmp(argv[i], "--symbol-prefix=", 16) == 0) {
-				char *p = &argv[i][16];
-				/* skip quote */
-				if ((*p == '"' && *(p+2) == '"') || (*p == '\'' && *(p+2) == '\''))
-					p++;
-				symbol_prefix_char = *p;
-			} else if (strcmp(argv[i], "--base-relative") == 0)
+			else if (strcmp(argv[i], "--base-relative") == 0)
 				base_relative = 1;
 			else
 				usage();
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 9045823..4bf811c 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -121,10 +121,6 @@ kallsyms()
 	info KSYM ${2}
 	local kallsymopt;
 
-	if [ -n "${CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX}" ]; then
-		kallsymopt="${kallsymopt} --symbol-prefix=_"
-	fi
-
 	if [ -n "${CONFIG_KALLSYMS_ALL}" ]; then
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
-- 
2.7.4
