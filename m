Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeBZPsh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:48:37 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43695 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbeBZPsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:48:20 -0500
X-Google-Smtp-Source: AG47ELtSoMROgBhtVCe/ZLdx3XmvEGIzkXFqsq9lBGbkXf9Y6WWabBGK7snBbseA3JMQjwnKS2QUPw==
From: Ilya Smith <blackzert@gmail.com>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ilya Smith <blackzert@gmail.com>
Subject: [PATCH 1/1] Additional strict check on ELF file. Checks segments are followed in order of 'p_vaddr ' value ascending. It fixes erorr in total_mapping_size with computation total size. This error happens if segments in ELF file are not in order.
Date: Mon, 26 Feb 2018 18:46:59 +0300
Message-Id: <20180226154659.10218-2-blackzert@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180226154659.10218-1-blackzert@gmail.com>
References: <20180226154659.10218-1-blackzert@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ilya Smith <blackzert@gmail.com>
---
 fs/binfmt_elf.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index bdb201230bae..970b42044240 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -524,6 +524,52 @@ static inline int arch_check_elf(struct elfhdr *ehdr, bool has_interp,
 
 #endif /* !CONFIG_ARCH_BINFMT_ELF_STATE */
 
+/**
+ * elf_check_phdr() - common check ELF program header.
+ * @phdr: The program header to check
+ * @phdr_num: Count of program headers in @phdr from elf header.
+ *
+ * Checks ELF binary meets specification.
+ *
+ * Return: Zero to proceed with ELF load, non-zero to faile the ELF load
+ *		   with that return code.
+ */
+static int elf_check_phdr(struct elf_phdr *phdr, unsigned long phdr_num)
+{
+	unsigned long i;
+	struct elf_phdr *eppnt = phdr;
+	Elf64_Addr curr_vaddr;
+	Elf64_Xword curr_memsz;
+
+	/* Find first PT_LOAD entry */
+	for (i = 0; i < phdr_num && eppnt->p_type != PT_LOAD; ++i, ++eppnt)
+		;
+
+	/* no any PT_LOAD */
+	if (i == phdr_num)
+		return -EINVAL;
+
+	curr_memsz = eppnt->p_memsz;
+	curr_vaddr = eppnt->p_vaddr;
+
+	for (++i, ++eppnt; i < phdr_num; ++i, ++eppnt) {
+		if (eppnt->p_type != PT_LOAD)
+			continue;
+
+		/* Check order of vaddr */
+		if (eppnt->p_vaddr <= curr_vaddr)
+			return -EINVAL;
+
+		/* Check overlapping */
+		if (eppnt->p_vaddr < curr_vaddr + curr_memsz)
+			return -EINVAL;
+
+		curr_memsz = eppnt->p_memsz;
+		curr_vaddr = eppnt->p_vaddr;
+	}
+	return 0;
+}
+
 /* This is much more generalized than the library routine read function,
    so we keep this separate.  Technically the library read function
    is only provided so that we can read a.out libraries that have
@@ -551,6 +597,8 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 		goto out;
 	if (!interpreter->f_op->mmap)
 		goto out;
+	if (elf_check_phdr(interp_elf_phdata, interp_elf_ex->e_phnum))
+		goto out;
 
 	total_size = total_mapping_size(interp_elf_phdata,
 					interp_elf_ex->e_phnum);
@@ -733,6 +781,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (!elf_phdata)
 		goto out;
 
+	if (elf_check_phdr(&loc->elf_ex, loc->elf_ex.e_phnum))
+		goto out;
+
 	elf_ppnt = elf_phdata;
 	elf_bss = 0;
 	elf_brk = 0;
-- 
2.14.1
