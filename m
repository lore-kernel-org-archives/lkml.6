Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932619AbeCIVfB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 16:35:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751211AbeCIVfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 16:35:00 -0500
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, mpe@ellerman.id.au, jeyu@kernel.org
Cc: npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/64: Fix section mismatch warnings for early boot symbols
Date: Fri,  9 Mar 2018 18:34:50 -0300
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1520628111-1361-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1520628111-1361-1-git-send-email-mauricfo@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18030921-0024-0000-0000-0000180EAB2B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008642; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01000693; UDB=6.00509028; IPR=6.00780023;
 MB=3.00019945; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-09 21:34:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030921-0025-0000-0000-00004F0A3E3C
Message-Id: <1520631290-5340-1-git-send-email-mauricfo@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803090255
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

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
v2: fix missing close parenthesis in conditional (wrong patch file, sorry)

 scripts/mod/modpost.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 9917f92..c65d5e2 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1174,8 +1174,15 @@ static const struct sectioncheck *section_mismatch(
  *   fromsec = text section
  *   refsymname = *.constprop.*
  *
+ * Pattern 6:
+ *   powerpc64 has boot functions that reference init, but must remain in text.
+ *   This pattern is identified by
+ *   tosec   = init section
+ *   fromsym = <function list>
+ *
  **/
-static int secref_whitelist(const struct sectioncheck *mismatch,
+static int secref_whitelist(const struct elf_info *elf,
+			    const struct sectioncheck *mismatch,
 			    const char *fromsec, const char *fromsym,
 			    const char *tosec, const char *tosym)
 {
@@ -1212,6 +1219,17 @@ static int secref_whitelist(const struct sectioncheck *mismatch,
 	    match(fromsym, optim_symbols))
 		return 0;
 
+	/* Check for pattern 6 */
+	if (elf->hdr->e_machine == EM_PPC64)
+		if (match(tosec, init_sections) &&
+		    (!strncmp(fromsym, "__boot_from_prom",
+				strlen("__boot_from_prom")) ||
+		     !strncmp(fromsym, "start_here_multiplatform",
+				strlen("start_here_multiplatform")) ||
+		     !strncmp(fromsym, "start_here_common",
+				strlen("start_here_common"))))
+			return 0;
+
 	return 1;
 }
 
@@ -1552,7 +1570,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	tosym = sym_name(elf, to);
 
 	/* check whitelist - we may ignore it */
-	if (secref_whitelist(mismatch,
+	if (secref_whitelist(elf, mismatch,
 			     fromsec, fromsym, tosec, tosym)) {
 		report_sec_mismatch(modname, mismatch,
 				    fromsec, r->r_offset, fromsym,
-- 
1.8.3.1
