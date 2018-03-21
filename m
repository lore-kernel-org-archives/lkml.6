Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeCUL2a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 07:28:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751923AbeCUL2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 07:28:11 -0400
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
Subject: [PATCH v2 08/11] kexec_file: Remove unneeded variables in kexec_purgatory_setup_sechdrs
Date: Wed, 21 Mar 2018 12:27:48 +0100
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
References: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032111-0012-0000-0000-000005C1B406
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032111-0013-0000-0000-0000193DD663
Message-Id: <20180321112751.22196-9-prudo@linux.vnet.ibm.com>
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

The main loop currently uses quite a lot of variables to update the section
headers. Some of them are unnecessary. So clean them up a little.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 kernel/kexec_file.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 4938f7aacd09..746b91e46e34 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -724,12 +724,8 @@ static int kexec_purgatory_setup_kbuf(struct purgatory_info *pi,
 static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 					 struct kexec_buf *kbuf)
 {
-	unsigned long curr_load_addr;
-	unsigned long load_addr;
 	unsigned long bss_addr;
 	unsigned long offset;
-	unsigned char *buf_addr;
-	unsigned char *src;
 	Elf_Shdr *sechdrs;
 	int i;
 
@@ -762,20 +758,18 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 						sechdrs[i].sh_offset;
 	}
 
-	/* Load SHF_ALLOC sections */
-	buf_addr = kbuf->buffer;
-	load_addr = curr_load_addr = kbuf->mem;
-	bss_addr = load_addr + kbuf->bufsz;
+	offset = 0;
+	bss_addr = kbuf->mem + kbuf->bufsz;
 	kbuf->image->start = pi->ehdr->e_entry;
 
 	for (i = 0; i < pi->ehdr->e_shnum; i++) {
 		unsigned long align;
+		void *src, *dst;
 
 		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
 			continue;
 
 		align = sechdrs[i].sh_addralign;
-
 		if (sechdrs[i].sh_type == SHT_NOBITS) {
 			bss_addr = ALIGN(bss_addr, align);
 			sechdrs[i].sh_addr = bss_addr;
@@ -783,31 +777,27 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 			continue;
 		}
 
-		curr_load_addr = ALIGN(curr_load_addr, align);
-		offset = curr_load_addr - load_addr;
-		/* We already modifed ->sh_offset to keep src addr */
-		src = (char *)sechdrs[i].sh_offset;
-		memcpy(buf_addr + offset, src, sechdrs[i].sh_size);
-
+		offset = ALIGN(offset, align);
 		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
 		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
 		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
 					 + sechdrs[i].sh_size)) {
 			kbuf->image->start -= sechdrs[i].sh_addr;
-			kbuf->image->start += curr_load_addr;
+			kbuf->image->start += kbuf->mem + offset;
 		}
 
-		/* Store load address and source address of section */
-		sechdrs[i].sh_addr = curr_load_addr;
+		src = (void *)sechdrs[i].sh_offset;
+		dst = pi->purgatory_buf + offset;
+		memcpy(dst, src, sechdrs[i].sh_size);
+
+		sechdrs[i].sh_addr = kbuf->mem + offset;
 
 		/*
 		 * This section got copied to temporary buffer. Update
 		 * ->sh_offset accordingly.
 		 */
-		sechdrs[i].sh_offset = (unsigned long)(buf_addr + offset);
-
-		/* Advance to the next address */
-		curr_load_addr += sechdrs[i].sh_size;
+		sechdrs[i].sh_offset = (unsigned long)dst;
+		offset += sechdrs[i].sh_size;
 	}
 
 	return 0;
-- 
2.13.5
