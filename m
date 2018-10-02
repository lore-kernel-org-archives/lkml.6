Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC51C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C543206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C543206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJBSdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:33:08 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:36828 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeJBSdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:33:08 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994599AbeJBLuLnL3lM (ORCPT
        <rfc822;stable@vger.kernel.org> + 1 other);
        Tue, 2 Oct 2018 13:50:11 +0200
Date:   Tue, 2 Oct 2018 12:50:11 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 1/2] MIPS: memset: Fix CPU_DADDI_WORKAROUNDS `small_fixup'
 regression
In-Reply-To: <alpine.LFD.2.21.1810020209310.20762@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1810020249480.20762@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1810020209310.20762@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a commit 8a8158c85e1e ("MIPS: memset.S: EVA & fault support for 
small_memset") regression and remove assembly warnings:

arch/mips/lib/memset.S: Assembler messages:
arch/mips/lib/memset.S:243: Warning: Macro instruction expanded into multiple instructions in a branch delay slot

triggering with the CPU_DADDI_WORKAROUNDS option set and this code:

	PTR_SUBU	a2, t1, a0
	jr		ra
	 PTR_ADDIU	a2, 1

This is because with that option in place the DADDIU instruction, which 
the PTR_ADDIU CPP macro expands to, becomes a GAS macro, which in turn 
expands to an LI/DADDU (or actually ADDIU/DADDU) sequence:

 13c:	01a4302f 	dsubu	a2,t1,a0
 140:	03e00008 	jr	ra
 144:	24010001 	li	at,1
 148:	00c1302d 	daddu	a2,a2,at
	...

Correct this by switching off the `noreorder' assembly mode and letting 
GAS schedule this jump's delay slot, as there is nothing special about 
it that would require manual scheduling.  With this change in place 
correct code is produced:

 13c:	01a4302f 	dsubu	a2,t1,a0
 140:	24010001 	li	at,1
 144:	03e00008 	jr	ra
 148:	00c1302d 	daddu	a2,a2,at
	...

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Fixes: 8a8158c85e1e ("MIPS: memset.S: EVA & fault support for small_memset")
Cc: stable@vger.kernel.org # 4.17+
---
 arch/mips/lib/memset.S |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

linux-mips-memset-jr-ra-nodaddi-fix.patch
Index: linux-20180930-3maxp-defconfig/arch/mips/lib/memset.S
===================================================================
--- linux-20180930-3maxp-defconfig.orig/arch/mips/lib/memset.S
+++ linux-20180930-3maxp-defconfig/arch/mips/lib/memset.S
@@ -280,9 +280,11 @@
 	 * unset_bytes = end_addr - current_addr + 1
 	 *      a2     =    t1    -      a0      + 1
 	 */
+	.set		reorder
 	PTR_SUBU	a2, t1, a0
+	PTR_ADDIU	a2, 1
 	jr		ra
-	 PTR_ADDIU	a2, 1
+	.set		noreorder
 
 	.endm
 
