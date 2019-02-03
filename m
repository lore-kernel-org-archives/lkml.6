Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3617C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F30420815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfBCODG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:03:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53016 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727998AbfBCNtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:46 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Y-0003wE-3K; Sun, 03 Feb 2019 13:49:44 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Y-0006xX-3P; Sun, 03 Feb 2019 14:49:44 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "John David Anglin" <dave.anglin@bell.net>,
        "Helge Deller" <deller@gmx.de>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.569719936@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 096/305] parisc: Fix address in HPMC IVA
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: John David Anglin <dave.anglin@bell.net>

commit 1138b6718ff74d2a934459643e3754423d23b5e2 upstream.

Helge noticed that the address of the os_hpmc handler was not being
correctly calculated in the hpmc macro.  As a result, PDCE_CHECK would
fail to call os_hpmc:

<Cpu2> e800009802e00000  0000000000000000  CC_ERR_CHECK_HPMC
<Cpu2> 37000f7302e00000  8040004000000000  CC_ERR_CPU_CHECK_SUMMARY
<Cpu2> f600105e02e00000  fffffff0f0c00000  CC_MC_HPMC_MONARCH_SELECTED
<Cpu2> 140003b202e00000  000000000000000b  CC_ERR_HPMC_STATE_ENTRY
<Cpu2> 5600100b02e00000  00000000000001a0  CC_MC_OS_HPMC_LEN_ERR
<Cpu2> 5600106402e00000  fffffff0f0438e70  CC_MC_BR_TO_OS_HPMC_FAILED
<Cpu2> e800009802e00000  0000000000000000  CC_ERR_CHECK_HPMC
<Cpu2> 37000f7302e00000  8040004000000000  CC_ERR_CPU_CHECK_SUMMARY
<Cpu2> 4000109f02e00000  0000000000000000  CC_MC_HPMC_INITIATED
<Cpu2> 4000101902e00000  0000000000000000  CC_MC_MULTIPLE_HPMCS
<Cpu2> 030010d502e00000  0000000000000000  CC_CPU_STOP

The address problem can be seen by dumping the fault vector:

0000000040159000 <fault_vector_20>:
    40159000:   63 6f 77 73     stb r15,-2447(dp)
    40159004:   20 63 61 6e     ldil L%b747000,r3
    40159008:   20 66 6c 79     ldil L%-1c3b3000,r3
        ...
    40159020:   08 00 02 40     nop
    40159024:   20 6e 60 02     ldil L%15d000,r3
    40159028:   34 63 00 00     ldo 0(r3),r3
    4015902c:   e8 60 c0 02     bv,n r0(r3)
    40159030:   08 00 02 40     nop
    40159034:   00 00 00 00     break 0,0
    40159038:   c0 00 70 00     bb,*< r0,sar,40159840 <fault_vector_20+0x840>
    4015903c:   00 00 00 00     break 0,0

Location 40159038 should contain the physical address of os_hpmc:

000000004015d000 <os_hpmc>:
    4015d000:   08 1a 02 43     copy r26,r3
    4015d004:   01 c0 08 a4     mfctl iva,r4
    4015d008:   48 85 00 68     ldw 34(r4),r5

This patch moves the address setup into initialize_ivt to resolve the
above problem.  I tested the change by dumping the HPMC entry after setup:

0000000040209020:  8000240
0000000040209024: 206a2004
0000000040209028: 34630ac0
000000004020902c: e860c002
0000000040209030:  8000240
0000000040209034: 1bdddce6
0000000040209038:   15d000
000000004020903c:      1a0

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/parisc/kernel/entry.S | 2 +-
 arch/parisc/kernel/traps.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -176,7 +176,7 @@
 	bv,n	0(%r3)
 	nop
 	.word	0		/* checksum (will be patched) */
-	.word	PA(os_hpmc)	/* address of handler */
+	.word	0		/* address of handler */
 	.word	0		/* length of handler */
 	.endm
 
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -833,7 +833,8 @@ int __init check_ivt(void *iva)
 	for (i = 0; i < 8; i++)
 	    *ivap++ = 0;
 
-	/* Compute Checksum for HPMC handler */
+	/* Setup IVA and compute checksum for HPMC handler */
+	ivap[6] = (u32)__pa(os_hpmc);
 	length = os_hpmc_size;
 	ivap[7] = length;
 

