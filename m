Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A202AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DD220871
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="b7bapJhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DD220871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932634AbeGIMIl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:08:41 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:57320 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932419AbeGIMIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:08:40 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w69C7Q0F015897;
        Mon, 9 Jul 2018 21:07:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w69C7Q0F015897
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531138047;
        bh=X2phr6qz0G7n0ftCA6Ct++HZBF6ihoO5XRU6HmPFOsQ=;
        h=From:To:Cc:Subject:Date:From;
        b=b7bapJhEvrZlOsMv7xPy3ZDXiuOHfUu5C6VtF3iBX1/coYSMUzQ9yi27xzuOJ6zq9
         9l+JEJaKNGYVV6waAxCohURE9Zhe3I5Y00Mh/Be96QnrMCX19sB5IOpOk9qJM/t9uE
         OHAIguRbrgo9IqLWjM6tpKCnhCEbyiK9qc2moyc8FFMhPiUREzdtrccCSiR3/Yscpg
         BeqZWF/GBSve5lSgsYUeMM+7Ti92cmxK3UgfX+1X4i8dsYeriozwmnlpjeSpZBEEhS
         vnGquwiDW4tPP+UT9CorwwckIgWlMOWVfxgxZR5DRkLHH/VY2rvR9VHImP/SurOrxy
         A+hVpeOIFPeUw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/build: remove code effective only for GCC older than 4.0
Date:   Mon,  9 Jul 2018 21:07:21 +0900
Message-Id: <1531138041-24200-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e501ce957a78 ("x86: Force asm-goto") bumped the minimum GCC
version to 4.5 for building the x86 kernel.

arch/x86/Makefile no longer needs to take care of older GCC versions.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index a08e828..7e3c07d 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -80,11 +80,6 @@ ifeq ($(CONFIG_X86_32),y)
         # alignment instructions.
         KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align4))
 
-        # Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
-        # a lot more stack due to the lack of sharing of stacklots:
-        KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0400, \
-				$(call cc-option,-fno-unit-at-a-time))
-
         # CPU-specific tuning. Anything which can be shared with UML should go here.
         include arch/x86/Makefile_32.cpu
         KBUILD_CFLAGS += $(cflags-y)
-- 
2.7.4

