Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeEBXIx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 19:08:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751801AbeEBXIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 19:08:44 -0400
From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Keyrings <keyrings@vger.kernel.org>
Cc: Linux Integrity <linux-integrity@vger.kernel.org>,
        Linux Security <linux-security-module@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Subject: [PATCH v6 2/4] KEYS: Add ELF class-independent certificate insertion support
Date: Wed,  2 May 2018 19:08:09 -0400
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
References: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050223-0016-0000-0000-000008A50CBB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008959; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01026618; UDB=6.00524344; IPR=6.00805804;
 MB=3.00020894; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-02 23:08:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050223-0017-0000-0000-00003E85DDE5
Message-Id: <20180502230811.2751-3-mkayaalp@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805020192
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for handling either 32-bit or 64-bit ELF files
by moving ELF class checks to runtime. This makes it possible to compile
the script for 64-bit, and the kernel for 32-bit (e.g. make ARCH=i386 on
x86-64). Gelf/libelf is purposely not used to avoid the build dependency.

Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
---
 scripts/insert-sys-cert.c | 331 +++++++++++++++++++++++++-------------
 1 file changed, 218 insertions(+), 113 deletions(-)

diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
index 8902836c2342..10a17504dc87 100644
--- a/scripts/insert-sys-cert.c
+++ b/scripts/insert-sys-cert.c
@@ -25,6 +25,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <elf.h>
+#include <linux/types.h>
 
 #define CERT_SYM  "system_extra_cert"
 #define USED_SYM  "system_extra_cert_used"
@@ -57,6 +58,18 @@ static unsigned char endianness(void)
 		return ELFDATA2LSB;
 }
 
+struct elf {
+	unsigned char *base;
+	int size;
+	unsigned char eclass;
+	unsigned char data;
+	unsigned long shoff;
+	unsigned long shnum;
+	unsigned long shentsize;
+	unsigned char *shstart;
+	unsigned long shsize;
+};
+
 struct sym {
 	char *name;
 	unsigned long address;
@@ -65,24 +78,92 @@ struct sym {
 	int size;
 };
 
-static unsigned long get_offset_from_address(Elf_Ehdr *hdr, unsigned long addr)
+static int read_elf_data(struct elf *elf, char *base, int size)
 {
-	Elf_Shdr *x;
-	unsigned int i, num_sections;
+	unsigned char *e_ident;
+	Elf32_Ehdr *e32 = (Elf32_Ehdr *)base;
+	Elf64_Ehdr *e64 = (Elf64_Ehdr *)base;
 
-	x = (void *)hdr + hdr->e_shoff;
-	if (hdr->e_shnum == SHN_UNDEF)
-		num_sections = x[0].sh_size;
-	else
-		num_sections = hdr->e_shnum;
+	elf->base = (unsigned char *)base;
+	elf->size = size;
+
+	if (size < EI_NIDENT) {
+		err("Invalid file size for ELF format.\n");
+		return -1;
+	}
+	e_ident = (unsigned char *)base;
+	if (e_ident[EI_MAG0] != ELFMAG0 || e_ident[EI_MAG1] != ELFMAG1 ||
+	    e_ident[EI_MAG2] != ELFMAG2 || e_ident[EI_MAG3] != ELFMAG3) {
+		err("Invalid ELF magic.\n");
+		return -1;
+	}
+	elf->eclass = e_ident[EI_CLASS];
+	if (elf->eclass != ELFCLASS32 && elf->eclass != ELFCLASS64) {
+		err("Invalid ELF class.\n");
+		return -1;
+	}
+	elf->data = e_ident[EI_DATA];
+	if (elf->data != endianness()) {
+		err("ELF endian mismatch.\n");
+		return -1;
+	}
+	if (e_ident[EI_VERSION] != EV_CURRENT) {
+		err("Invalid ELF file version.\n");
+		return -1;
+	}
+	if (elf->eclass == ELFCLASS32) {
+		elf->shoff = e32->e_shoff;
+		elf->shnum = e32->e_shnum;
+		elf->shentsize = e32->e_shentsize;
+	} else {
+		elf->shoff = e64->e_shoff;
+		elf->shnum = e64->e_shnum;
+		elf->shentsize = e64->e_shentsize;
+	}
+	if (elf->shoff == 0 || elf->shoff > size) {
+		err("Could not find section header.\n");
+		exit(EXIT_FAILURE);
+	}
+	elf->shstart = elf->base + elf->shoff;
+	elf->shsize = elf->shnum * elf->shentsize;
+	return 0;
+}
 
-	for (i = 1; i < num_sections; i++) {
-		unsigned long start = x[i].sh_addr;
-		unsigned long end = start + x[i].sh_size;
-		unsigned long offset = x[i].sh_offset;
+static char *get_elf_string(struct elf *elf, unsigned long link,
+			    unsigned long namendx)
+{
+	unsigned char *p = elf->shstart + link * elf->shentsize;
+	Elf32_Shdr *s32 = (Elf32_Shdr *)p;
+	Elf64_Shdr *s64 = (Elf64_Shdr *)p;
 
+	if (elf->eclass == ELFCLASS32)
+		return (char *)elf->base + s32->sh_offset + namendx;
+	else
+		return (char *)elf->base + s64->sh_offset + namendx;
+}
+
+static unsigned long get_offset_from_address(struct elf *elf,
+					     unsigned long addr)
+{
+	unsigned long start, end, offset;
+	unsigned char *p = elf->shstart;
+
+	while (p < elf->shstart + elf->shsize) {
+		Elf32_Shdr *s32 = (Elf32_Shdr *)p;
+		Elf64_Shdr *s64 = (Elf64_Shdr *)p;
+
+		if (elf->eclass == ELFCLASS32) {
+			start = s32->sh_addr;
+			end = start + s32->sh_size;
+			offset = s32->sh_offset;
+		} else {
+			start = s64->sh_addr;
+			end = start + s64->sh_size;
+			offset = s64->sh_offset;
+		}
 		if (addr >= start && addr <= end)
 			return addr - start + offset;
+		p += elf->shentsize;
 	}
 	return 0;
 }
@@ -90,7 +171,7 @@ static unsigned long get_offset_from_address(Elf_Ehdr *hdr, unsigned long addr)
 
 #define LINE_SIZE 100
 
-static void get_symbol_from_map(Elf_Ehdr *hdr, FILE *f, char *name,
+static void get_symbol_from_map(struct elf *elf, FILE *f, char *name,
 				struct sym *s)
 {
 	char l[LINE_SIZE];
@@ -125,76 +206,108 @@ static void get_symbol_from_map(Elf_Ehdr *hdr, FILE *f, char *name,
 	s->address = strtoul(l, NULL, 16);
 	if (s->address == 0)
 		return;
-	s->offset = get_offset_from_address(hdr, s->address);
+	s->offset = get_offset_from_address(elf, s->address);
 	s->name = name;
-	s->content = (void *)hdr + s->offset;
+	s->content = elf->base + s->offset;
 }
 
-static Elf_Sym *find_elf_symbol(Elf_Ehdr *hdr, Elf_Shdr *symtab, char *name)
-{
-	Elf_Sym *sym, *symtab_start;
-	char *strtab, *symname;
-	unsigned int link;
-	Elf_Shdr *x;
-	int i, n;
-
-	x = (void *)hdr + hdr->e_shoff;
-	link = symtab->sh_link;
-	symtab_start = (void *)hdr + symtab->sh_offset;
-	n = symtab->sh_size / symtab->sh_entsize;
-	strtab = (void *)hdr + x[link].sh_offset;
-
-	for (i = 0; i < n; i++) {
-		sym = &symtab_start[i];
-		symname = strtab + sym->st_name;
-		if (strcmp(symname, name) == 0)
-			return sym;
-	}
-	err("Unable to find symbol: %s\n", name);
-	return NULL;
-}
-
-static void get_symbol_from_table(Elf_Ehdr *hdr, Elf_Shdr *symtab,
+static void get_symbol_from_table(struct elf *elf, unsigned char *symtab,
 				  char *name, struct sym *s)
 {
-	Elf_Shdr *sec;
-	int secndx;
-	Elf_Sym *elf_sym;
-	Elf_Shdr *x;
+	Elf32_Shdr *s32 = (Elf32_Shdr *)symtab;
+	Elf64_Shdr *s64 = (Elf64_Shdr *)symtab;
+	unsigned char *p;
+	unsigned long address;
+	unsigned long offset;
+	unsigned long size;
+	unsigned long entsize;
+	unsigned long link;
+	unsigned long shndx;
+	char *symname;
+	int found = 0;
 
-	x = (void *)hdr + hdr->e_shoff;
 	s->size = 0;
 	s->address = 0;
 	s->offset = 0;
-	elf_sym = find_elf_symbol(hdr, symtab, name);
-	if (!elf_sym)
-		return;
-	secndx = elf_sym->st_shndx;
-	if (!secndx)
+
+	if (elf->eclass == ELFCLASS32) {
+		offset = s32->sh_offset;
+		size = s32->sh_size;
+		entsize = s32->sh_entsize;
+		link = s32->sh_link;
+	} else {
+		offset = s64->sh_offset;
+		size = s64->sh_size;
+		entsize = s64->sh_entsize;
+		link = s64->sh_link;
+	}
+
+	p = elf->base + offset;
+	while (p < elf->base + offset + size) {
+		Elf32_Sym *sym32 = (Elf32_Sym *)p;
+		Elf64_Sym *sym64 = (Elf64_Sym *)p;
+		unsigned long namendx;
+
+		if (elf->eclass == ELFCLASS32) {
+			namendx = sym32->st_name;
+			shndx = sym32->st_shndx;
+		} else {
+			namendx = sym64->st_name;
+			shndx = sym64->st_shndx;
+		}
+
+		symname = get_elf_string(elf, link, namendx);
+		if (strcmp(symname, name) == 0 && shndx) {
+			found = 1;
+			if (elf->eclass == ELFCLASS32) {
+				s->size = sym32->st_size;
+				s->address = sym32->st_value;
+			} else {
+				s->size = sym64->st_size;
+				s->address = sym64->st_value;
+			}
+			break;
+		}
+		p += entsize;
+	}
+
+	if (!found)
 		return;
-	sec = &x[secndx];
-	s->size = elf_sym->st_size;
-	s->address = elf_sym->st_value;
-	s->offset = s->address - sec->sh_addr
-			       + sec->sh_offset;
+
+	p = elf->shstart + shndx * elf->shentsize;
+	s32 = (Elf32_Shdr *)p;
+	s64 = (Elf64_Shdr *)p;
+
+	if (elf->eclass == ELFCLASS32) {
+		offset = s32->sh_offset;
+		address = s32->sh_addr;
+	} else {
+		offset = s64->sh_offset;
+		address = s64->sh_addr;
+	}
+
+	s->offset = s->address - address + offset;
 	s->name = name;
-	s->content = (void *)hdr + s->offset;
+	s->content = elf->base + s->offset;
 }
 
-static Elf_Shdr *get_symbol_table(Elf_Ehdr *hdr)
+static unsigned char *get_symbol_table(struct elf *elf)
 {
-	Elf_Shdr *x;
-	unsigned int i, num_sections;
-
-	x = (void *)hdr + hdr->e_shoff;
-	if (hdr->e_shnum == SHN_UNDEF)
-		num_sections = x[0].sh_size;
-	else
-		num_sections = hdr->e_shnum;
-
-	for (i = 1; i < num_sections; i++)
-		if (x[i].sh_type == SHT_SYMTAB)
-			return &x[i];
+	unsigned char *p = elf->shstart;
+
+	while (p < elf->shstart + elf->shsize) {
+		Elf32_Shdr *s32 = (Elf32_Shdr *)p;
+		Elf64_Shdr *s64 = (Elf64_Shdr *)p;
+
+		if (elf->eclass == ELFCLASS32) {
+			if (s32->sh_type == SHT_SYMTAB)
+				return p;
+		} else {
+			if (s64->sh_type == SHT_SYMTAB)
+				return p;
+		}
+		p += elf->shentsize;
+	}
 	return NULL;
 }
 
@@ -257,7 +370,7 @@ static char *read_file(char *file_name, int *size)
 	return buf;
 }
 
-static void print_sym(Elf_Ehdr *hdr, struct sym *s)
+static void print_sym(struct sym *s)
 {
 	info("sym:    %s\n", s->name);
 	info("addr:   0x%lx\n", s->address);
@@ -277,14 +390,14 @@ int main(int argc, char **argv)
 	char *cert_file = NULL;
 	int vmlinux_size;
 	int cert_size;
-	Elf_Ehdr *hdr;
+	char *vmlinux;
 	char *cert;
 	FILE *system_map;
-	unsigned long *lsize;
 	int *used;
 	int opt;
-	Elf_Shdr *symtab = NULL;
 	struct sym cert_sym, lsize_sym, used_sym;
+	struct elf elf;
+	unsigned char *symtab = NULL;
 
 	while ((opt = getopt(argc, argv, "b:c:s:")) != -1) {
 		switch (opt) {
@@ -311,39 +424,16 @@ int main(int argc, char **argv)
 	if (!cert)
 		exit(EXIT_FAILURE);
 
-	hdr = map_file(vmlinux_file, &vmlinux_size);
-	if (!hdr)
+	vmlinux = map_file(vmlinux_file, &vmlinux_size);
+	if (!vmlinux)
 		exit(EXIT_FAILURE);
 
-	if (vmlinux_size < sizeof(*hdr)) {
-		err("Invalid ELF file.\n");
-		exit(EXIT_FAILURE);
-	}
-
-	if ((hdr->e_ident[EI_MAG0] != ELFMAG0) ||
-	    (hdr->e_ident[EI_MAG1] != ELFMAG1) ||
-	    (hdr->e_ident[EI_MAG2] != ELFMAG2) ||
-	    (hdr->e_ident[EI_MAG3] != ELFMAG3)) {
-		err("Invalid ELF magic.\n");
+	if (read_elf_data(&elf, vmlinux, vmlinux_size)) {
+		err("Unable to read ELF file.\n");
 		exit(EXIT_FAILURE);
 	}
 
-	if (hdr->e_ident[EI_CLASS] != CURRENT_ELFCLASS) {
-		err("ELF class mismatch.\n");
-		exit(EXIT_FAILURE);
-	}
-
-	if (hdr->e_ident[EI_DATA] != endianness()) {
-		err("ELF endian mismatch.\n");
-		exit(EXIT_FAILURE);
-	}
-
-	if (hdr->e_shoff > vmlinux_size) {
-		err("Could not find section header.\n");
-		exit(EXIT_FAILURE);
-	}
-
-	symtab = get_symbol_table(hdr);
+	symtab = get_symbol_table(&elf);
 	if (!symtab) {
 		warn("Could not find the symbol table.\n");
 		if (!system_map_file) {
@@ -357,27 +447,28 @@ int main(int argc, char **argv)
 			perror(system_map_file);
 			exit(EXIT_FAILURE);
 		}
-		get_symbol_from_map(hdr, system_map, CERT_SYM, &cert_sym);
-		get_symbol_from_map(hdr, system_map, USED_SYM, &used_sym);
-		get_symbol_from_map(hdr, system_map, LSIZE_SYM, &lsize_sym);
+		get_symbol_from_map(&elf, system_map, CERT_SYM, &cert_sym);
+		get_symbol_from_map(&elf, system_map, USED_SYM, &used_sym);
+		get_symbol_from_map(&elf, system_map, LSIZE_SYM, &lsize_sym);
 		cert_sym.size = used_sym.address - cert_sym.address;
 	} else {
 		info("Symbol table found.\n");
 		if (system_map_file)
 			warn("System.map is ignored.\n");
-		get_symbol_from_table(hdr, symtab, CERT_SYM, &cert_sym);
-		get_symbol_from_table(hdr, symtab, USED_SYM, &used_sym);
-		get_symbol_from_table(hdr, symtab, LSIZE_SYM, &lsize_sym);
+		get_symbol_from_table(&elf, symtab, CERT_SYM, &cert_sym);
+		get_symbol_from_table(&elf, symtab, USED_SYM, &used_sym);
+		get_symbol_from_table(&elf, symtab, LSIZE_SYM, &lsize_sym);
 	}
 
-	if (!cert_sym.offset || !lsize_sym.offset || !used_sym.offset)
+	if (!cert_sym.offset || !lsize_sym.offset || !used_sym.offset) {
+		err("Unable to find symbols.\n");
 		exit(EXIT_FAILURE);
+	}
 
-	print_sym(hdr, &cert_sym);
-	print_sym(hdr, &used_sym);
-	print_sym(hdr, &lsize_sym);
+	print_sym(&cert_sym);
+	print_sym(&used_sym);
+	print_sym(&lsize_sym);
 
-	lsize = (unsigned long *)lsize_sym.content;
 	used = (int *)used_sym.content;
 
 	if (cert_sym.size < cert_size) {
@@ -400,11 +491,25 @@ int main(int argc, char **argv)
 		memset(cert_sym.content + cert_size,
 			0, cert_sym.size - cert_size);
 
-	*lsize = *lsize + cert_size - *used;
+	if (elf.eclass == ELFCLASS64) {
+		u64 *lsize;
+
+		lsize = (u64 *)lsize_sym.content;
+		*lsize = *lsize + cert_size - *used;
+	} else {
+		u32 *lsize;
+
+		lsize = (u32 *)lsize_sym.content;
+		*lsize = *lsize + cert_size - *used;
+	}
 	*used = cert_size;
 	info("Inserted the contents of %s into %lx.\n", cert_file,
 						cert_sym.address);
 	info("Used %d bytes out of %d bytes reserved.\n", *used,
 						 cert_sym.size);
+	if (munmap(vmlinux, vmlinux_size) == -1) {
+		perror(vmlinux_file);
+		exit(EXIT_FAILURE);
+	}
 	exit(EXIT_SUCCESS);
 }
-- 
2.17.0
