Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeCUL2Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 07:28:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751888AbeCUL2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 07:28:06 -0400
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Dave Young <dyoung@redhat.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 04/11] kexec_file: Search symbols in read-only kexec_purgatory
Date: Wed, 21 Mar 2018 12:27:44 +0100
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
References: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032111-0040-0000-0000-00000425568A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032111-0041-0000-0000-00002628597A
Message-Id: <20180321112751.22196-5-prudo@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stripped purgatory does not contain a symtab. So when looking for
symbols this is done in read-only kexec_purgatory. Highlight this by
marking the corresponding variables as 'const'.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 kernel/kexec_file.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 06fc9fdd2474..2072b288ec53 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -901,20 +901,27 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
 	return ret;
 }
 
-static Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
-					    const char *name)
+/*
+ * kexec_purgatory_find_symbol - find a symbol in the purgatory
+ * @pi:		Purgatory to search in.
+ * @name:	Name of the symbol.
+ *
+ * Return: pointer to symbol in read-only symtab on success, NULL on error.
+ */
+static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
+						  const char *name)
 {
+	const Elf_Shdr *sechdrs;
 	const Elf_Ehdr *ehdr;
-	Elf_Sym *syms;
-	Elf_Shdr *sechdrs;
-	int i, k;
+	const Elf_Sym *syms;
 	const char *strtab;
+	int i, k;
 
-	if (!pi->sechdrs || !pi->ehdr)
+	if (!pi->ehdr)
 		return NULL;
 
-	sechdrs = pi->sechdrs;
 	ehdr = pi->ehdr;
+	sechdrs = (void *)ehdr + ehdr->e_shoff;
 
 	for (i = 0; i < ehdr->e_shnum; i++) {
 		if (sechdrs[i].sh_type != SHT_SYMTAB)
@@ -923,8 +930,8 @@ static Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
 		if (sechdrs[i].sh_link >= ehdr->e_shnum)
 			/* Invalid strtab section number */
 			continue;
-		strtab = (char *)sechdrs[sechdrs[i].sh_link].sh_offset;
-		syms = (Elf_Sym *)sechdrs[i].sh_offset;
+		strtab = (void *)ehdr + sechdrs[sechdrs[i].sh_link].sh_offset;
+		syms = (void *)ehdr + sechdrs[i].sh_offset;
 
 		/* Go through symbols for a match */
 		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
@@ -952,7 +959,7 @@ static Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
 void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name)
 {
 	struct purgatory_info *pi = &image->purgatory_info;
-	Elf_Sym *sym;
+	const Elf_Sym *sym;
 	Elf_Shdr *sechdr;
 
 	sym = kexec_purgatory_find_symbol(pi, name);
@@ -975,9 +982,9 @@ void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name)
 int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 				   void *buf, unsigned int size, bool get_value)
 {
-	Elf_Sym *sym;
-	Elf_Shdr *sechdrs;
 	struct purgatory_info *pi = &image->purgatory_info;
+	const Elf_Sym *sym;
+	Elf_Shdr *sec;
 	char *sym_buf;
 
 	sym = kexec_purgatory_find_symbol(pi, name);
@@ -990,16 +997,15 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 		return -EINVAL;
 	}
 
-	sechdrs = pi->sechdrs;
+	sec = pi->sechdrs + sym->st_shndx;
 
-	if (sechdrs[sym->st_shndx].sh_type == SHT_NOBITS) {
+	if (sec->sh_type == SHT_NOBITS) {
 		pr_err("symbol %s is in a bss section. Cannot %s\n", name,
 		       get_value ? "get" : "set");
 		return -EINVAL;
 	}
 
-	sym_buf = (unsigned char *)sechdrs[sym->st_shndx].sh_offset +
-					sym->st_value;
+	sym_buf = (char *)sec->sh_offset + sym->st_value;
 
 	if (get_value)
 		memcpy((void *)buf, sym_buf, size);
-- 
2.13.5
