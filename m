Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeCUL3v (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 07:29:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751915AbeCUL2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 07:28:10 -0400
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
Subject: [PATCH v2 07/11] kexec_file: Remove unneeded for-loop in kexec_purgatory_setup_sechdrs
Date: Wed, 21 Mar 2018 12:27:47 +0100
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
References: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032111-0040-0000-0000-00000443B66B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032111-0041-0000-0000-000020E6D8DB
Message-Id: <20180321112751.22196-8-prudo@linux.vnet.ibm.com>
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

To update the entry point there is an extra loop over all section headers
although this can be done in the main loop. So move it there and eliminate
the extra loop and variable to store the 'entry section index'.

Also, in the main loop, move the usual case, i.e. non-bss section, out of
the extra if-block.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 kernel/kexec_file.c | 76 +++++++++++++++++++++--------------------------------
 1 file changed, 30 insertions(+), 46 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index d1c3ec8dc6b1..4938f7aacd09 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -731,7 +731,6 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	unsigned char *buf_addr;
 	unsigned char *src;
 	Elf_Shdr *sechdrs;
-	int entry_sidx = -1;
 	int i;
 
 	sechdrs = vzalloc(pi->ehdr->e_shnum * sizeof(Elf_Shdr));
@@ -763,32 +762,11 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 						sechdrs[i].sh_offset;
 	}
 
-	/*
-	 * Identify entry point section and make entry relative to section
-	 * start.
-	 */
-	kbuf->image->start = pi->ehdr->e_entry;
-	for (i = 0; i < pi->ehdr->e_shnum; i++) {
-		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
-			continue;
-
-		if (!(sechdrs[i].sh_flags & SHF_EXECINSTR))
-			continue;
-
-		/* Make entry section relative */
-		if (sechdrs[i].sh_addr <= pi->ehdr->e_entry &&
-		    ((sechdrs[i].sh_addr + sechdrs[i].sh_size) >
-		     pi->ehdr->e_entry)) {
-			entry_sidx = i;
-			kbuf->image->start -= sechdrs[i].sh_addr;
-			break;
-		}
-	}
-
 	/* Load SHF_ALLOC sections */
 	buf_addr = kbuf->buffer;
 	load_addr = curr_load_addr = kbuf->mem;
 	bss_addr = load_addr + kbuf->bufsz;
+	kbuf->image->start = pi->ehdr->e_entry;
 
 	for (i = 0; i < pi->ehdr->e_shnum; i++) {
 		unsigned long align;
@@ -797,34 +775,40 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 			continue;
 
 		align = sechdrs[i].sh_addralign;
-		if (sechdrs[i].sh_type != SHT_NOBITS) {
-			curr_load_addr = ALIGN(curr_load_addr, align);
-			offset = curr_load_addr - load_addr;
-			/* We already modifed ->sh_offset to keep src addr */
-			src = (char *) sechdrs[i].sh_offset;
-			memcpy(buf_addr + offset, src, sechdrs[i].sh_size);
-
-			/* Store load address and source address of section */
-			sechdrs[i].sh_addr = curr_load_addr;
-
-			/*
-			 * This section got copied to temporary buffer. Update
-			 * ->sh_offset accordingly.
-			 */
-			sechdrs[i].sh_offset = (unsigned long)(buf_addr + offset);
-
-			/* Advance to the next address */
-			curr_load_addr += sechdrs[i].sh_size;
-		} else {
+
+		if (sechdrs[i].sh_type == SHT_NOBITS) {
 			bss_addr = ALIGN(bss_addr, align);
 			sechdrs[i].sh_addr = bss_addr;
 			bss_addr += sechdrs[i].sh_size;
+			continue;
+		}
+
+		curr_load_addr = ALIGN(curr_load_addr, align);
+		offset = curr_load_addr - load_addr;
+		/* We already modifed ->sh_offset to keep src addr */
+		src = (char *)sechdrs[i].sh_offset;
+		memcpy(buf_addr + offset, src, sechdrs[i].sh_size);
+
+		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
+		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
+		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
+					 + sechdrs[i].sh_size)) {
+			kbuf->image->start -= sechdrs[i].sh_addr;
+			kbuf->image->start += curr_load_addr;
 		}
-	}
 
-	/* Update entry point based on load address of text section */
-	if (entry_sidx >= 0)
-		kbuf->image->start += sechdrs[entry_sidx].sh_addr;
+		/* Store load address and source address of section */
+		sechdrs[i].sh_addr = curr_load_addr;
+
+		/*
+		 * This section got copied to temporary buffer. Update
+		 * ->sh_offset accordingly.
+		 */
+		sechdrs[i].sh_offset = (unsigned long)(buf_addr + offset);
+
+		/* Advance to the next address */
+		curr_load_addr += sechdrs[i].sh_size;
+	}
 
 	return 0;
 }
-- 
2.13.5
