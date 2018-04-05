Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbeDEPuu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:50:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751195AbeDEPut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:50:49 -0400
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, jeyu@kernel.org
Cc: jeyu@redhat.com, akpm@linux-foundation.org, mpe@ellerman.id.au,
        npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] powerpc/64: Fix section mismatch warnings for early boot symbols
Date: Thu,  5 Apr 2018 12:50:39 -0300
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18040515-0056-0000-0000-00000437EDA2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008808; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01013521; UDB=6.00516626; IPR=6.00792781;
 MB=3.00020432; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-05 15:50:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040515-0057-0000-0000-0000087A02CF
Message-Id: <1522943439-26235-1-git-send-email-mauricfo@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804050164
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the boot code located at the start of kernel text is "init"
class, in that it only runs at boot time, however marking it as normal
init code is problematic because that puts it into a different section
located at the very end of kernel text.

e.g., in case the TOC is not set up, we may not be able to tolerate a
branch trampoline to reach the init function.

Credits: code and message are based on 2016 patch by Nicholas Piggin,
and slightly modified so not to rename the powerpc code/symbol names.

    Subject: [PATCH] powerpc/64: quieten section mismatch warnings
    From: Nicholas Piggin <npiggin at gmail.com>
    Date: Fri Dec 23 00:14:19 AEDT 2016

This resolves the following section mismatch warnings:

    WARNING: vmlinux.o(.text+0x2fa8): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init()
    The function __boot_from_prom() references
    the function __init prom_init().
    This is often because __boot_from_prom lacks a __init
    annotation or the annotation of prom_init is wrong.

    WARNING: vmlinux.o(.text+0x3238): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup()
    The function start_here_multiplatform() references
    the function __init early_setup().
    This is often because start_here_multiplatform lacks a __init
    annotation or the annotation of early_setup is wrong.

    WARNING: vmlinux.o(.text+0x326c): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel()
    The function start_here_common() references
    the function __init start_kernel().
    This is often because start_here_common lacks a __init
    annotation or the annotation of start_kernel is wrong.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
v3: reword some comments and include errors in commit message
v2: fix build error due to missing parenthesis
 scripts/mod/modpost.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 4ff08a0..d10c9d8 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1173,8 +1173,15 @@ static const struct sectioncheck *section_mismatch(
  *   fromsec = text section
  *   refsymname = *.constprop.*
  *
+ * Pattern 6:
+ *   powerpc64 has boot functions that reference init, but must remain in text.
+ *   This pattern is identified by
+ *   tosec   = init section
+ *   fromsym = __boot_from_prom, start_here_common, start_here_multiplatform
+ *
  **/
-static int secref_whitelist(const struct sectioncheck *mismatch,
+static int secref_whitelist(const struct elf_info *elf,
+			    const struct sectioncheck *mismatch,
 			    const char *fromsec, const char *fromsym,
 			    const char *tosec, const char *tosym)
 {
@@ -1211,6 +1218,17 @@ static int secref_whitelist(const struct sectioncheck *mismatch,
 	    match(fromsym, optim_symbols))
 		return 0;
 
+	/* Check for pattern 6 */
+	if (elf->hdr->e_machine == EM_PPC64)
+		if (match(tosec, init_sections) &&
+		    (!strncmp(fromsym, "__boot_from_prom",
+				strlen("__boot_from_prom")) ||
+		     !strncmp(fromsym, "start_here_common",
+				strlen("start_here_common")) ||
+		     !strncmp(fromsym, "start_here_multiplatform",
+				strlen("start_here_multiplatform"))))
+			return 0;
+
 	return 1;
 }
 
@@ -1551,7 +1569,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	tosym = sym_name(elf, to);
 
 	/* check whitelist - we may ignore it */
-	if (secref_whitelist(mismatch,
+	if (secref_whitelist(elf, mismatch,
 			     fromsec, fromsym, tosec, tosym)) {
 		report_sec_mismatch(modname, mismatch,
 				    fromsec, r->r_offset, fromsym,
-- 
1.8.3.1
