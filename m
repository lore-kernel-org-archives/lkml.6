Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeCULab (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 07:30:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751797AbeCUL2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 07:28:03 -0400
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
Subject: [PATCH v2 02/11] kexec_file: Remove checks in kexec_purgatory_load
Date: Wed, 21 Mar 2018 12:27:42 +0100
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
References: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032111-0008-0000-0000-000004E0B595
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032111-0009-0000-0000-00001E73D75D
Message-Id: <20180321112751.22196-3-prudo@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the purgatory is loaded several checks are done whether the ELF file
in kexec_purgatory is valid or not. These checks are incomplete. For
example they don't check for the total size of the sections defined in the
section header table or if the entry point actually points into the
purgatory.

On the other hand the purgatory, although an ELF file on its own, is part
of the kernel. Thus not trusting the purgatory means not trusting the
kernel build itself.

So remove all validity checks on the purgatory and just trust the kernel
build.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 kernel/kexec_file.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index e5bcd94c1efb..0f044457b40c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -880,22 +880,8 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
 	if (kexec_purgatory_size <= 0)
 		return -EINVAL;
 
-	if (kexec_purgatory_size < sizeof(Elf_Ehdr))
-		return -ENOEXEC;
-
 	pi->ehdr = (Elf_Ehdr *)kexec_purgatory;
 
-	if (memcmp(pi->ehdr->e_ident, ELFMAG, SELFMAG) != 0
-	    || pi->ehdr->e_type != ET_REL
-	    || !elf_check_arch(pi->ehdr)
-	    || pi->ehdr->e_shentsize != sizeof(Elf_Shdr))
-		return -ENOEXEC;
-
-	if (pi->ehdr->e_shoff >= kexec_purgatory_size
-	    || (pi->ehdr->e_shnum * sizeof(Elf_Shdr) >
-	    kexec_purgatory_size - pi->ehdr->e_shoff))
-		return -ENOEXEC;
-
 	ret = __kexec_load_purgatory(image, min, max, top_down);
 	if (ret)
 		return ret;
-- 
2.13.5
