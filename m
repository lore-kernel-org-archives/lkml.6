Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F7EC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6107208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6107208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbeG0PRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:17:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732165AbeG0PRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:17:44 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RDsL8i012972
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 09:55:41 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kg41dsrsa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 09:55:41 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <leitao@debian.org>;
        Fri, 27 Jul 2018 09:55:40 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Jul 2018 09:55:38 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6RDtbT810748360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 13:55:37 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5B15AC064;
        Fri, 27 Jul 2018 09:56:19 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69359AC05F;
        Fri, 27 Jul 2018 09:56:17 -0400 (EDT)
Received: from debra.ibm.com (unknown [9.85.149.32])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jul 2018 09:56:17 -0400 (EDT)
From:   Breno Leitao <leitao@debian.org>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH] powerpc: Wire up file system mount new syscalls
Date:   Fri, 27 Jul 2018 10:55:02 -0300
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18072713-0072-0000-0000-00000386A4C0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009438; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01066887; UDB=6.00548174; IPR=6.00844752;
 MB=3.00022353; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-27 13:55:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072713-0073-0000-0000-000048DD1589
Message-Id: <1532699702-15515-1-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the new file system mount syscalls for Powerpc. The new syscall being
contemplated by this patch are those already available in the linux-next tree:
open_tree(), move_mount(), fsopen(), fsmount(), fspick() and fsinfo().

These system calls were tested with David Howells test case[1], as some others I
wrote[2]. For testing purpose, I also made usage of the new, but yet not
integrated, fsconfig() syscall.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=mount-context&id=2bae6fd63259c5244bd9de1b46cca706c4808438
[2] https://github.com/leitao/mcontext/

CC: David Howells <dhowells@redhat.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/include/asm/systbl.h      | 6 ++++++
 arch/powerpc/include/asm/unistd.h      | 2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 01b5171ea189..68d8dc0f8338 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -394,3 +394,9 @@ SYSCALL(pkey_free)
 SYSCALL(pkey_mprotect)
 SYSCALL(rseq)
 COMPAT_SYS(io_pgetevents)
+SYSCALL(open_tree)
+SYSCALL(move_mount)
+SYSCALL(fsopen)
+SYSCALL(fsmount)
+SYSCALL(fspick)
+SYSCALL(fsinfo)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index c19379f0a32e..e6cf3bb0ed2f 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define NR_syscalls		389
+#define NR_syscalls		395
 
 #define __NR__exit __NR_exit
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 985534d0b448..89b450c6a246 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -400,5 +400,11 @@
 #define __NR_pkey_mprotect	386
 #define __NR_rseq		387
 #define __NR_io_pgetevents	388
+#define __NR_open_tree		389
+#define __NR_move_mount	390
+#define __NR_fsopen		391
+#define __NR_fsmount		392
+#define __NR_fspick		393
+#define __NR_fsinfo		394
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.16.3

