Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeCUL2e (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 07:28:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751907AbeCUL2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 07:28:13 -0400
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
Subject: [PATCH v2 09/11] kexec_file: Remove mis-use of sh_offset field during purgatory load
Date: Wed, 21 Mar 2018 12:27:49 +0100
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
References: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032111-0020-0000-0000-00000407BAE1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032111-0021-0000-0000-0000429BD8F9
Message-Id: <20180321112751.22196-10-prudo@linux.vnet.ibm.com>
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

The current code uses the sh_offset field in purgatory_info->sechdrs to
store a pointer to the current load address of the section. Depending
whether the section will be loaded or not this is either a pointer into
purgatory_info->purgatory_buf or kexec_purgatory. This is not only a
violation of the ELF standard but also makes the code very hard to
understand as you cannot tell if the memory you are using is read-only or
not.

Remove this mis-use and store the offset of the section in
pugaroty_info->purgatory_buf in sh_offset.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 arch/x86/kernel/machine_kexec_64.c | 10 ++++++----
 kernel/kexec_file.c                | 37 +++++++------------------------------
 2 files changed, 13 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 51667c8b5c9b..41db74bdc88b 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -457,13 +457,15 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		 * rel[i].r_offset contains byte offset from beginning
 		 * of section to the storage unit affected.
 		 *
-		 * This is location to update (->sh_offset). This is temporary
-		 * buffer where section is currently loaded. This will finally
-		 * be loaded to a different address later, pointed to by
+		 * This is location to update. This is temporary buffer
+		 * where section is currently loaded. This will finally be
+		 * loaded to a different address later, pointed to by
 		 * ->sh_addr. kexec takes care of moving it
 		 *  (kexec_load_segment()).
 		 */
-		location = (void *)(section->sh_offset + rel[i].r_offset);
+		location = pi->purgatory_buf;
+		location += section->sh_offset;
+		location += rel[i].r_offset;
 
 		/* Final address of the location */
 		address = section->sh_addr + rel[i].r_offset;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 746b91e46e34..1478766c7754 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -729,6 +729,10 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	Elf_Shdr *sechdrs;
 	int i;
 
+	/*
+	 * The section headers in kexec_purgatory are read-only. In order to
+	 * have them modifiable make a temporary copy.
+	 */
 	sechdrs = vzalloc(pi->ehdr->e_shnum * sizeof(Elf_Shdr));
 	if (!sechdrs)
 		return -ENOMEM;
@@ -736,28 +740,6 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	       pi->ehdr->e_shnum * sizeof(Elf_Shdr));
 	pi->sechdrs = sechdrs;
 
-	/*
-	 * We seem to have multiple copies of sections. First copy is which
-	 * is embedded in kernel in read only section. Some of these sections
-	 * will be copied to a temporary buffer and relocated. And these
-	 * sections will finally be copied to their final destination at
-	 * segment load time.
-	 *
-	 * Use ->sh_offset to reflect section address in memory. It will
-	 * point to original read only copy if section is not allocatable.
-	 * Otherwise it will point to temporary copy which will be relocated.
-	 *
-	 * Use ->sh_addr to contain final address of the section where it
-	 * will go during execution time.
-	 */
-	for (i = 0; i < pi->ehdr->e_shnum; i++) {
-		if (sechdrs[i].sh_type == SHT_NOBITS)
-			continue;
-
-		sechdrs[i].sh_offset = (unsigned long)pi->ehdr +
-						sechdrs[i].sh_offset;
-	}
-
 	offset = 0;
 	bss_addr = kbuf->mem + kbuf->bufsz;
 	kbuf->image->start = pi->ehdr->e_entry;
@@ -786,17 +768,12 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 			kbuf->image->start += kbuf->mem + offset;
 		}
 
-		src = (void *)sechdrs[i].sh_offset;
+		src = (void *)pi->ehdr + sechdrs[i].sh_offset;
 		dst = pi->purgatory_buf + offset;
 		memcpy(dst, src, sechdrs[i].sh_size);
 
 		sechdrs[i].sh_addr = kbuf->mem + offset;
-
-		/*
-		 * This section got copied to temporary buffer. Update
-		 * ->sh_offset accordingly.
-		 */
-		sechdrs[i].sh_offset = (unsigned long)dst;
+		sechdrs[i].sh_offset = offset;
 		offset += sechdrs[i].sh_size;
 	}
 
@@ -1006,7 +983,7 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 		return -EINVAL;
 	}
 
-	sym_buf = (char *)sec->sh_offset + sym->st_value;
+	sym_buf = (char *)pi->purgatory_buf + sec->sh_offset + sym->st_value;
 
 	if (get_value)
 		memcpy((void *)buf, sym_buf, size);
-- 
2.13.5
