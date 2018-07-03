Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BC0C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C5B21915
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rSN8E8tE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C5B21915
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753713AbeGCBYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:24:41 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:46553 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbeGCBYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:24:36 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w631MU1o030863;
        Tue, 3 Jul 2018 10:22:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w631MU1o030863
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530580952;
        bh=N9EXVCIJOLVxm2JVzHsecjGPLiJubDV/StdikSRFzdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rSN8E8tEUJWwBuH+4+H1SebS283QsLAeq8ZEYW4/0B7y8IH2dlsTeHX00wWqXGeYF
         VZgLg0J5iBck6aGrpmJheEO8e+cfIYudGZr0GtluYRXzMAE9L1h+4oop5vL3Q7uApR
         OErzBKW/MLvBDibcQ1dClfqh44qg6hZ2Jnki3+4ASsstnCpL1JBESm3sd7JVimdQ5T
         Z5tCVhsnj6bkA4iKi/0O8VR+Lca97CgKOnh4OMmonqaLJwYfYp2jRxNhE2vVvO9u/l
         a3dUOekqvv7mEhrxetnbANx23nmALTnGUAQrMWCbD9XPclmNY2hLKtnNzVkjkZRbj/
         bZj9NT+jpAOQw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michal Simek <monstr@monstr.eu>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: add endianness option to LDFLAGS instead of LD
Date:   Tue,  3 Jul 2018 10:21:59 +0900
Message-Id: <1530580921-23340-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the recent syntax extension, Kconfig is now able to evaluate the
compiler / toolchain capability.

However, accumulating flags to 'LD' is not compatible with the way
it works; 'LD' must be passed to Kconfig to call $(ld-option,...)
from Kconfig files.  If you tweak 'LD' in arch Makefile depending on
CONFIG_CPU_BIG_ENDIAN, this would end up with circular dependency
between Makefile and Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index fc26c3d..62ebeae 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -46,12 +46,12 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__ARMEB__
 AS		+= -EB
-LD		+= -EB
+LDFLAGS		+= -EB
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__ARMEL__
 AS		+= -EL
-LD		+= -EL
+LDFLAGS		+= -EL
 endif
 
 #
-- 
2.7.4

