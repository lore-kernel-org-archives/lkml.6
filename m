Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DE8C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C7D218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HaRwAzzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfAYO5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:57:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44896 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfAYO5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:57:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0PEnNEt173460;
        Fri, 25 Jan 2019 14:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=1hVAr1jHbK9xdBIGH3lIXe/a/YJdBQYCFBP7MZhLc6g=;
 b=HaRwAzzigoQ5CiiPXnoN5SPgs41M28QgHhMeBIJuneQKRXSKvQdAwkD28d+8B3ji1LcD
 uPpvu2Hrc3CPD1ERbNL4r9VJVjnB4gg0poTkviBal+q3CA5BUuDKtsK0nXSaSR0Q1sVQ
 zTp3jcPatDYFXAHAspTjanhoPw60Mwz0DZJ7YkuHu4yRtiifmI3Wq3eUU8iJt+C3iBed
 SfPQvsA2EE1hHISf3HKhhsU/ACqOhDD/irWcCjfrQbwd43joXshVeTyRdySb31qtbZLb
 g9cYyedMHbpwZrmk7YylonBhyg75PM0gh3TwjbApWKbW7KzQWIvyDhk3VBHY/3uaw/0E SA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2q3vhs63pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jan 2019 14:57:32 +0000
Received: from achartre-desktop.fr.oracle.com (dhcp-10-166-106-34.fr.oracle.com [10.166.106.34])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0PEvTGN003972;
        Fri, 25 Jan 2019 14:57:29 GMT
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Subject: [PATCH] x86/alternatives: check int3 breakpoint physical addresses
Date:   Fri, 25 Jan 2019 15:57:29 +0100
Message-Id: <1548428249-8258-1-git-send-email-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 1.7.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9146 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=915
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901250122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modifying multi-byte instructions is achieved by temporarily replacing
the first instruction to patch with an int3 instruction. Then, if an
int3 interrupt is raised, the int3 handler will check if the interrupt
was caused by this temporary patch by comparing the address that raises
the interrupt (the interrupt address) and the address that was patched
(the patched address).

The int3 handler compares virtual addresses of the interrupt and
patched addresses. However, this doesn't work if the code to modify
is mapped to multiple virtual addresses because, in that case, the
patched virtual address can be different from the interrupt virtual
address.

A simple solution is then to also compare physical addresses when
virtual addresses do not match. Note that we still compare virtual
addresses because that's a faster comparison than having to fully
resolve and compare physical addresses.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: x86@kernel.org
---

This is a potential issue and I don't know if it can be triggered with the
current kernel: is there any code mapped to multiple virtual addresses
which can be updated with text_poke_bp()? However as the patch is small and
simple, it might be worth applying it anyway to prevent any such issue.

Note that this issue has been observed and reproduced with a custom kernel
with some code mapped to different virtual addresses and using jump labels
As jump labels use text_poke_bp(), crashes were sometimes observed when
updating jump labels.

 arch/x86/kernel/alternative.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ebeac48..e563573 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -757,7 +757,18 @@ int poke_int3_handler(struct pt_regs *regs)
 	if (likely(!bp_patching_in_progress))
 		return 0;
 
-	if (user_mode(regs) || regs->ip != (unsigned long)bp_int3_addr)
+	if (user_mode(regs))
+		return 0;
+
+	/*
+	 * If virtual addresses are different, check if physical addresses
+	 * are the same in case we have the same code mapped to different
+	 * virtual addresses. Note that we could just compare physical
+	 * addresses, however we first compare virtual addresses because
+	 * this is much faster and very likely to succeed.
+	 */
+	if (regs->ip != (unsigned long)bp_int3_addr &&
+	    slow_virt_to_phys((void *)regs->ip) != slow_virt_to_phys(bp_int3_addr))
 		return 0;
 
 	/* set up the specified breakpoint handler */
-- 
1.7.1
