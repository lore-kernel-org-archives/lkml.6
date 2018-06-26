Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9F1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D5D26B6E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JGwG4e+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D5D26B6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbeFZQV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:21:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39866 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeFZQVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:21:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5QGJDqo157903;
        Tue, 26 Jun 2018 16:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2017-10-26;
 bh=YvRu40ee90WGq6RJARX0OpSIfTm/pT+p5RXb7r2A7+Y=;
 b=JGwG4e+ckNLC/s4amlT8EVzRSKKoFp1u7IJHPblSeFQMYS9c0otik+axrSf51t4ezQ3E
 LGWT9G6CkEZSlcjp1afXY9qa/7r/S2nH/8bXPZdUvC8FJTLDpt1NoJJ/VhSzvElpKDNB
 piBvLBEPa04PKLbcLF2IH70+n3aa2RcyBAS98sTA2aS1pSpSc/mcnEZuj3B02QAC/ql0
 Bw3Jp2vfkvTuOBqQfLBgC5jWwBrcPQvwF0XMwhHfWJMeKEtsRqyHEdXKr+g0n3oat79h
 IjC9EiCeW3dTjP4uGJCBr9FwH7WtVZvHUwiDkrcRPLSf46rFfgq15nQ6mDRb8Xqwz3HB Ug== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jum57sa5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 16:21:16 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5QGLFLN005485
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 16:21:16 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5QGLFrB015074;
        Tue, 26 Jun 2018 16:21:15 GMT
Received: from localhost (/10.175.171.107)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Jun 2018 09:21:15 -0700
From:   Allan Xavier <allan.x.xavier@oracle.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Allan Xavier <allan.x.xavier@oracle.com>
Subject: [PATCH] objtool: Fix GCC 8 cold function processing without -freorder-functions
Date:   Tue, 26 Jun 2018 17:20:45 +0100
Message-Id: <20180626162045.25516-1-allan.x.xavier@oracle.com>
X-Mailer: git-send-email 2.14.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8935 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=966
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806260184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit 13810435b9a7 ("objtool: Support GCC 8's cold subfunctions")
objtool can get stuck in an infinite loop when processing cold functions
compiled without -freorder-functions. Using v4.17.2 and "gcc version
8.1.1 20180502 (Red Hat 8.1.1-1) (GCC)" from Fedora, this can be
reproduced trivially with make EXTRA_CFLAGS='-fno-reorder-functions'.

When -freorder-functions is used (enabled by default for -O2 in GCC 8)
cold functions are emitted in the .text.unlikely section.

0000000000000230 g     F .text  000000000000002c nmi_panic
00000000000002df l     F .text.unlikely 000000000000000c nmi_panic.cold.7

Without -freorder-functions, cold functions are emitted in the .text
section within the range of their parent function.

0000000000000500 g     F .text  0000000000000034 nmi_panic
0000000000000528 l     F .text  000000000000000c nmi_panic.cold.7

When objtool processes the second case it associates all of the
instructions in the parent function range 0x500-0x534 with nmi_panic
since that symbol is processed first. No instructions are associated
with nmi_panic.cold.7.

Later on, objtool iterates through the instructions in nmi_panic using
next_insn_same_func. Once it reaches the end of nmi_panic at 0x534 it
jumps to 0x528 as that's the start of nmi_panic.cold.7. However, since
the instructions starting at 0x528 are still associated with nmi_panic
objtool will get stuck in a loop, continually jumping back to 0x528
after reaching 0x534.

This doesn't happen with -freorder-functions in the first example as the
symbols don't overlap. So when 0x25c in .text is reached objtool will
jump to 0x2df in .text.unlikely where the instructions are correctly
associated with nmi_panic.cold.7.

Fix this issue by modifying decode_instructions to check whether an
instruction is associated with the parent function of the cold function
currently being processed. If so, reference the cold function rather
than the parent.

Signed-off-by: Allan Xavier <allan.x.xavier@oracle.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3a31b238f8856..2a5eea534ab3e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -314,7 +314,7 @@ static int decode_instructions(struct objtool_file *file)
 			}
 
 			func_for_each_insn(file, func, insn)
-				if (!insn->func)
+				if (!insn->func || insn->func == func->pfunc)
 					insn->func = func;
 		}
 	}
-- 
2.14.1

