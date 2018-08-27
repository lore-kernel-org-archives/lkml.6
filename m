Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D870DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F7A216FA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 02:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rqTpeHTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F7A216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeH0GGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 02:06:25 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:53384 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeH0GGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 02:06:25 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w7R2KX9f003473;
        Mon, 27 Aug 2018 11:20:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w7R2KX9f003473
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535336434;
        bh=VdBcHrY6rjilNe+qtXspmNYpmFgy/h6A3+CN8mUo+rk=;
        h=From:To:Cc:Subject:Date:From;
        b=rqTpeHTjquTMvVtOnzyiEX1kPoeYTnJk3ZUkcYN0tUfBo/I9DHdbgH2uPKAyvbZZ6
         +EA71BFKhG7vLQ/zKFOWXjbBMnlsztqhLm4fR/kDL8ymAAAoPYJ3Yfop0zV3vvaQsj
         n5a5W/pXYb1DAVmiUKweHSp9KQYENFDg2Fo9yh29oHTB6kbgjT9w/xWrbe35mOTN/Y
         +2J0E4OS63BMOpqym139Jt9xvKXCUOgL8+a9y1Epo6KLQayXOZNd0aYbETbwlUpbur
         Z5lNDx7mf/eEepdW3EGc6PDKdtSTnrPQEB11uhfMUSoc5XXthJ03gb4Lia+1nLeE8g
         nZqdprTMll6Pg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: remove pre-build checks for old GCC versions
Date:   Mon, 27 Aug 2018 11:20:02 +0900
Message-Id: <1535336402-10632-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
bumped the minimum GCC version to 4.6 for all architectures.

The GCC version checks in arch/powerpc/Makefile are obsolete now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/powerpc/Makefile | 38 +-------------------------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 11a1acb..57e7358 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -400,40 +400,8 @@ archclean:
 
 archprepare: checkbin
 
-# Use the file '.tmp_gas_check' for binutils tests, as gas won't output
-# to stdout and these checks are run even on install targets.
-TOUT	:= .tmp_gas_check
-
-# Check gcc and binutils versions:
-# - gcc-3.4 and binutils-2.14 are a fatal combination
-# - Require gcc 4.0 or above on 64-bit
-# - gcc-4.2.0 has issues compiling modules on 64-bit
+# Check binutils versions:
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
@@ -441,7 +409,3 @@ checkbin:
 		echo -n '*** Please use a different binutils version.' ; \
 		false ; \
 	fi
-
-
-CLEAN_FILES += $(TOUT)
-
-- 
2.7.4

