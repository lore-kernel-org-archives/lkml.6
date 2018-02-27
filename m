Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeB0Ety (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 23:49:54 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35910 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbeB0EtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 23:49:00 -0500
X-Google-Smtp-Source: AH8x227iRE/quI/l4eKroa2qtjtoAkgTmB1BVdTN4vmG78njAO8eZG8Z1NQr/Ejhx6JWioM6R7EG/w==
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: dyoung@redhat.com, vgoyal@redhat.com, bhe@redhat.com,
        mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com,
        prudo@linux.vnet.ibm.com
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 4/7] x86: kexec_file: remove X86_64 dependency from prepare_elf64_headers()
Date: Tue, 27 Feb 2018 13:48:11 +0900
Message-Id: <20180227044814.24808-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180227044814.24808-1-takahiro.akashi@linaro.org>
References: <20180227044814.24808-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code guarded by CONFIG_X86_64 is necessary on some architectures
which have a dedicated kernel mapping outside of linear memory mapping.
(arm64 is among those.)

In this patch, an additional argument, kernel_map, is added to enable/
disable the code removing #ifdef.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 2123fa0efc17..913fd8021f8a 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -347,7 +347,7 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 	return 0;
 }
 
-static int prepare_elf64_headers(struct crash_elf_data *ced,
+static int prepare_elf64_headers(struct crash_elf_data *ced, int kernel_map,
 		void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
@@ -414,17 +414,17 @@ static int prepare_elf64_headers(struct crash_elf_data *ced,
 	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
 	(ehdr->e_phnum)++;
 
-#ifdef CONFIG_X86_64
 	/* Prepare PT_LOAD type program header for kernel text region */
-	phdr = (Elf64_Phdr *)bufp;
-	bufp += sizeof(Elf64_Phdr);
-	phdr->p_type = PT_LOAD;
-	phdr->p_flags = PF_R|PF_W|PF_X;
-	phdr->p_vaddr = (Elf64_Addr)_text;
-	phdr->p_filesz = phdr->p_memsz = _end - _text;
-	phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-	(ehdr->e_phnum)++;
-#endif
+	if (kernel_map) {
+		phdr = (Elf64_Phdr *)bufp;
+		bufp += sizeof(Elf64_Phdr);
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (Elf64_Addr)_text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		(ehdr->e_phnum)++;
+	}
 
 	/* Go through all the ranges in cmem->ranges[] and prepare phdr */
 	for (i = 0; i < cmem->nr_ranges; i++) {
@@ -477,7 +477,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  prepare_elf64_headers(ced, addr, sz);
+	ret =  prepare_elf64_headers(ced,
+				(int)IS_ENABLED(CONFIG_X86_64), addr, sz);
 	if (ret)
 		goto out;
 
-- 
2.16.2
