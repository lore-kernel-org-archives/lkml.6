Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4949ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDCE2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDCE2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbeIRLOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 07:14:15 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:39967 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbeIRLOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 07:14:15 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42DsNC01kDz9ttC9;
        Tue, 18 Sep 2018 07:43:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1ir1sIESTdFS; Tue, 18 Sep 2018 07:43:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42DsNB6fbYz9ttC0;
        Tue, 18 Sep 2018 07:43:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 95A938B7C0;
        Tue, 18 Sep 2018 07:43:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pjOuamxH9lHJ; Tue, 18 Sep 2018 07:43:17 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5690F8B74C;
        Tue, 18 Sep 2018 07:43:17 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1A7C96BDA7; Tue, 18 Sep 2018 05:43:17 +0000 (UTC)
Message-Id: <82bbb913ffd8bdc040a012152ee968cd0c6ccf4e.1537218487.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/makefile: remove check on obsolete GCC versions
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Sep 2018 05:43:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit cafa0010cd51 ("Raise the minimum required gcc version
to 4.6"), it is not possible to build kernel with GCC lower than 4.6

This patch removes checkbin tests addressing older versions of GCC.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Makefile | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 8397c7bd5880..b33083bad840 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -405,35 +405,7 @@ archprepare: checkbin
 TOUT	:= .tmp_gas_check
 
 # Check gcc and binutils versions:
-# - gcc-3.4 and binutils-2.14 are a fatal combination
-# - Require gcc 4.0 or above on 64-bit
-# - gcc-4.2.0 has issues compiling modules on 64-bit
 checkbin:
-	@if test "$(cc-name)" != "clang" \
-	    && test "$(cc-version)" = "0304" ; then \
-		if ! /bin/echo mftb 5 | $(AS) -v -mppc -many -o $(TOUT) >/dev/null 2>&1 ; then \
-			echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build '; \
-			echo 'correctly with gcc-3.4 and your version of binutils.'; \
-			echo '*** Please upgrade your binutils or downgrade your gcc'; \
-			false; \
-		fi ; \
-	fi
-	@if test "$(cc-name)" != "clang" \
-	    && test "$(cc-version)" -lt "0400" \
-	    && test "x${CONFIG_PPC64}" = "xy" ; then \
-                echo -n "Sorry, GCC v4.0 or above is required to build " ; \
-                echo "the 64-bit powerpc kernel." ; \
-                false ; \
-        fi
-	@if test "$(cc-name)" != "clang" \
-	    && test "$(cc-fullversion)" = "040200" \
-	    && test "x${CONFIG_MODULES}${CONFIG_PPC64}" = "xyy" ; then \
-		echo -n '*** GCC-4.2.0 cannot compile the 64-bit powerpc ' ; \
-		echo 'kernel with modules enabled.' ; \
-		echo -n '*** Please use a different GCC version or ' ; \
-		echo 'disable kernel modules' ; \
-		false ; \
-	fi
 	@if test "x${CONFIG_CPU_LITTLE_ENDIAN}" = "xy" \
 	    && $(LD) --version | head -1 | grep ' 2\.24$$' >/dev/null ; then \
 		echo -n '*** binutils 2.24 miscompiles weak symbols ' ; \
-- 
2.13.3

