Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeCIUmD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 15:42:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751211AbeCIUmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 15:42:02 -0500
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, mpe@ellerman.id.au, jeyu@kernel.org
Cc: npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64: Fix section mismatch warnings for early boot symbols
Date: Fri,  9 Mar 2018 17:41:51 -0300
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18030920-0048-0000-0000-00000247A927
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008642; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01000675; UDB=6.00509017; IPR=6.00780006;
 MB=3.00019944; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-09 20:41:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030920-0049-0000-0000-000044634352
Message-Id: <1520628111-1361-1-git-send-email-mauricfo@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803090245
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
+				strlen("start_here_common")))
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
