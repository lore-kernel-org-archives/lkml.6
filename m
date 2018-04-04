Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbeDDJS5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:18:57 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:56605 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbeDDJS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:18:56 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: vmlinuz: Fix compiler intrinsics location and build directly
Date: Wed, 4 Apr 2018 10:18:22 +0100
Message-ID: <1522833502-28007-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180403160728.GB3275@saruman>
References: <20180403160728.GB3275@saruman>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1522833523-452059-6216-47763-1
X-BESS-VER: 2018.4.1-r1804031856
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191678
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit "MIPS: use generic GCC library routines from lib/", MIPS
now uses the generic lib/ashldi3.c, but bswapsi.c still comes from
arch/mips/lib. The rules for including these into vmlinuz need updating
to reflect these locations.
Both objects need to be built with different CFLAGS for inclusion to
vmlinuz rather than simply including the object built for the main
kernel image. But the copy of the source C file can be avoided by simply
calling cmd,cc_o_c to build the object from the source directly. This
also removes the need for the .gitignore file to ignore the copied
files, and the extra-y rule to clean them.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/boot/compressed/.gitignore | 2 --
 arch/mips/boot/compressed/Makefile   | 8 ++++----
 2 files changed, 4 insertions(+), 6 deletions(-)
 delete mode 100644 arch/mips/boot/compressed/.gitignore

diff --git a/arch/mips/boot/compressed/.gitignore b/arch/mips/boot/compressed/.gitignore
deleted file mode 100644
index ebae133f1d00..000000000000
--- a/arch/mips/boot/compressed/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-ashldi3.c
-bswapsi.c
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index adce180f3ee4..8f04d659a915 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -46,10 +46,10 @@ $(obj)/uart-ath79.c: $(srctree)/arch/mips/ath79/early_printk.c
 
 vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o $(obj)/bswapsi.o
 
-extra-y += ashldi3.c bswapsi.c
-$(obj)/ashldi3.o $(obj)/bswapsi.o: KBUILD_CFLAGS += -I$(srctree)/arch/mips/lib
-$(obj)/ashldi3.c $(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
-	$(call cmd,shipped)
+$(obj)/ashldi3.o: $(srctree)/lib/ashldi3.c
+	$(call cmd,cc_o_c)
+$(obj)/bswapsi.o: $(srctree)/arch/mips/lib/bswapsi.c
+	$(call cmd,cc_o_c)
 
 targets := $(notdir $(vmlinuzobjs-y))
 
-- 
2.7.4
