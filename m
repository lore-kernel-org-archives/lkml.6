Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933122AbeEWNuY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:50:24 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:32911 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932941AbeEWNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:50:23 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] MIPS: memset.S: Add comments to fault fixup handlers
Date: Wed, 23 May 2018 14:39:59 +0100
Message-ID: <1527082799-14704-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527082799-14704-1-git-send-email-matt.redfearn@mips.com>
References: <1527082799-14704-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag03.mipstec.com (10.20.40.48) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1527083416-637138-32316-228975-1
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193286
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not immediately obvious what the expected inputs to these fault
handlers is and how they calculate the number of unset bytes. Having
stared deeply at this in order to fix some corner cases, add some
comments to assist those who follow.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

Changes in v3:
- Update comment on .Lbyte_fixup to reflect corrected behavior

Changes in v2:
- Add comments to fault handlers in new, separate, patch.

 arch/mips/lib/memset.S | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index fac26ce64b2..3a6f34ef5ff 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -232,16 +232,25 @@
 
 #ifdef CONFIG_CPU_MIPSR6
 .Lbyte_fixup\@:
+	/*
+	 * unset_bytes = (#bytes - (#unaligned bytes)) - (-#unaligned bytes remaining + 1) + 1
+	 *      a2     =             a2                -              t0                   + 1
+	 */
 	PTR_SUBU	a2, t0
 	jr		ra
 	 PTR_ADDIU	a2, 1
 #endif /* CONFIG_CPU_MIPSR6 */
 
 .Lfirst_fixup\@:
+	/* unset_bytes already in a2 */
 	jr	ra
 	 nop
 
 .Lfwd_fixup\@:
+	/*
+	 * unset_bytes = partial_start_addr +  #bytes   -     fault_addr
+	 *      a2     =         t1         + (a2 & 3f) - $28->task->BUADDR
+	 */
 	PTR_L		t0, TI_TASK($28)
 	andi		a2, 0x3f
 	LONG_L		t0, THREAD_BUADDR(t0)
@@ -250,6 +259,10 @@
 	 LONG_SUBU	a2, t0
 
 .Lpartial_fixup\@:
+	/*
+	 * unset_bytes = partial_end_addr +      #bytes     -     fault_addr
+	 *      a2     =       a0         + (a2 & STORMASK) - $28->task->BUADDR
+	 */
 	PTR_L		t0, TI_TASK($28)
 	andi		a2, STORMASK
 	LONG_L		t0, THREAD_BUADDR(t0)
@@ -258,10 +271,15 @@
 	 LONG_SUBU	a2, t0
 
 .Llast_fixup\@:
+	/* unset_bytes already in a2 */
 	jr		ra
 	 nop
 
 .Lsmall_fixup\@:
+	/*
+	 * unset_bytes = end_addr - current_addr + 1
+	 *      a2     =    t1    -      a0      + 1
+	 */
 	PTR_SUBU	a2, t1, a0
 	jr		ra
 	 PTR_ADDIU	a2, 1
-- 
2.7.4
