Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeDKHw3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 03:52:29 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:50793 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeDKHw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 03:52:28 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: Palmer Dabbelt <palmer@sifive.com>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 3/4] MIPS: vmlinuz: Use generic ashldi3
Date: Wed, 11 Apr 2018 08:50:18 +0100
Message-ID: <1523433019-17419-3-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523433019-17419-1-git-send-email-matt.redfearn@mips.com>
References: <1523433019-17419-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1523433038-321457-11089-33080-2
X-BESS-VER: 2018.4-r1804052328
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191870
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing some of the MIPS compiler intrinsics from
arch/mips/lib, first update the build of vmlinuz to use the generic
ashldi3 from lib.

Both ashldi3 and bswapsi objects need to be built with different CFLAGS
for inclusion to vmlinuz rather than simply including the object built
for the main kernel image. The objects cannot be built directly from
source, since CONFIG_MODVERSIONS changes cmd_cc_o_c to prevent this.

Split the rule to ship ashldi3 and bswapsi from the relevant source
locations.

These files make no reference to other files in their directory, so the
additional CFLAGS are apparently unnecessary - remove them as well.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

Changes in v6:
New patch to fix vmlinuz which requires ashldi3 so must be switched
to come from $(srctree)/lib before the arch/mips/ version is deleted.
This version has been build tested with every upstream defconfig since
previous versions caused problems with ci20_defconfig and
loongson1b_defconfig.

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/mips/boot/compressed/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index adce180f3ee4..e03f522c33ac 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -46,9 +46,12 @@ $(obj)/uart-ath79.c: $(srctree)/arch/mips/ath79/early_printk.c
 
 vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o $(obj)/bswapsi.o
 
-extra-y += ashldi3.c bswapsi.c
-$(obj)/ashldi3.o $(obj)/bswapsi.o: KBUILD_CFLAGS += -I$(srctree)/arch/mips/lib
-$(obj)/ashldi3.c $(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
+extra-y += ashldi3.c
+$(obj)/ashldi3.c: $(obj)/%.c: $(srctree)/lib/%.c
+	$(call cmd,shipped)
+
+extra-y += bswapsi.c
+$(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
 	$(call cmd,shipped)
 
 targets := $(notdir $(vmlinuzobjs-y))
-- 
2.7.4
