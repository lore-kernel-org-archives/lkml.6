Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeBTWB3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:01:29 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:41189 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeBTWAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:00:20 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Nicolas Pitre <nico@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 7/7] efi: disable LTO for EFI stub
Date: Tue, 20 Feb 2018 22:59:54 +0100
Message-Id: <20180220215954.4092811-8-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220215954.4092811-1-arnd@arndb.de>
References: <20180220215954.4092811-1-arnd@arndb.de>
X-Provags-ID: V03:K0:g/CEMVWePhNFebbS+t3z1ahrGqtz52H1ciUl2QfOtEWWz189hrF
 4UCDqVTe7lzPHA/3cPChJS5omNkjfn6l0U9FWwL6u6g+z43ydixs/vZgjY4Jk63ZoAtdju4
 t5ZVWikTJVzodXA8fFtI7Gw1oNKNxMCEy0RXZMY1mQiCJaV0VWRAJJJrZatxBloI2un4gRs
 mKwsxGFkipoawu2cvx6fA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qVyq8I0Ua8E=:N1BiRs+SuUxLrxbDlsW+tD
 U8aOzfvOdGyUXfeZqUyZuElzqVGyUeUzh/XHRwF9oCA35GSmwYdP73dgrJ+Bh9x4j0StXz0Ir
 ogrKmNS1zGPhSBAFdBxsA+EuZkhwJp6/AsNJ2cY3Hexrm7AMS+nf/ncVSWgdOsnmynne+Kcud
 y2wEBexYipchH9F+9nT74oTh9E0sI+h3khlwXA5+Dcwj3xL1ZOWaOVGXSnf5GkV5+sm3KHebD
 YXAnDhicFcx23CADmra77KV4cLuM9c45n25VfVGjcOL5/k6kzWxsN+8ablblcHRHkEKRivRcK
 A5xGdJVNWhxIxkakN4d2oNsVzydgcnkK39A/sBUFpu5ZnnbH57TRo3sd78XymheYIxLkS8Kbi
 TtB6fDw2gXvuvKWsAXuR2QTa66bJ/jHdLvu2ssxfsA4Ot1tiaifz6vRofBX0c5V8B3Y8bTnJO
 n5ZfH0yYZDH73hpBBvwWdx42foqMxZJdL6LV/XcvXYuIL5xrrMNg8M0j07ddX6eae0TWkuuzA
 /0uusBtLo93Pu7LQvO0C+sZUgAlX23aGTE3Iavat/CfutbLBFX0t2HyYYT1/uIGmRBgIp/Cbb
 YLwiyyjdeE/RLRoFjGJKPdwjN9o5V8pdRPPsKfCCMPmQk/nVIOpBksGwiRikGQHP/xvVy9/nj
 J3EUcJpO9HzungfLoNxPiFyIA1bdkWZ9KS7bWkhAxrHkexrXGNRx8h6HJ/XDffOBSMQbxPA4U
 MrAmGGjzkwRQJppxelHtEy+ChKQ7OrFavAPWJw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the EFI stub on 32-bit ARM with LTO resulted in a build error:

arm-linux-gnueabi-ld: drivers/firmware/efi/libstub/arm-stub.stub.o: plugin needed to handle lto object
arch/arm/boot/compressed/head.o: In function `efi_stub_entry':

Locally disabling LTO for this directory seems to do the trick.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/efi/libstub/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 7b3ba40f0745..cc4c53f1ff0a 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -20,7 +20,9 @@ cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -D__NO_FORTIFY \
 				   $(call cc-option,-ffreestanding) \
-				   $(call cc-option,-fno-stack-protector)
+				   $(call cc-option,-fno-stack-protector) \
+				   $(DISABLE_LTO)
+
 
 GCOV_PROFILE			:= n
 KASAN_SANITIZE			:= n
-- 
2.9.0
