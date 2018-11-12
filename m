Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC26C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EE12087F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FA91h4yJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3EE12087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbeKLM3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:29:11 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:65080 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbeKLM3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:29:10 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAC2ZqVT015801;
        Mon, 12 Nov 2018 11:35:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAC2ZqVT015801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541990154;
        bh=QWXSE7/OQHBlT44+TGlqxkRhZ97JeJizcyopsk4jHsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FA91h4yJOyJENTGNyr75p88tfVsNiDXhOMInZzw3/rfJHw3x2OV/RH4xPefEqEaYm
         MMbVZ+9LlRjnCfqRP6SZkAN3jWbpeIXY6mVbMysyQb3V2luFgTIZ9a6ZyOohJ7S5gb
         qacupi+SvN7TZKLquE9qfBWONdhDg17n4E29ZLrf/D7cJpcXkmR1eGBVhM1hyDt2o+
         AjH8sy8Ce37kZUPq3C5aveDOJEd97a9B7WcuQ6e51EK3Y5PTKwKDoWRuyPYQYqv0f3
         7v76VVz5fBrTNXvRcFY2nZjdizkP7wsi05HlCt2KDNMb4o2YrD7ksjhX6SlUH5fBiF
         fBwr7zq78p25A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Richard Weinberger <richard@sigma-star.at>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] um: remove -fno-unit-at-a-time workaround for pre-4.0 GCC
Date:   Mon, 12 Nov 2018 11:35:19 +0900
Message-Id: <1541990120-9643-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
References: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
bumped the minimum GCC version to 4.6 for all architectures.

'$(call cc-option,-fno-unit-at-a-time)' is now dead code since
'$(cc-version) -lt 0400' is always false.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/Makefile.um | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 91085a0..577976b 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -26,12 +26,8 @@ cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
 # an unresolved reference.
 cflags-y += -ffreestanding
 
-# Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
-# a lot more stack due to the lack of sharing of stacklots.  Also, gcc
-# 4.3.0 needs -funit-at-a-time for extern inline functions.
-KBUILD_CFLAGS += $(shell if [ $(cc-version) -lt 0400 ] ; then \
-			echo $(call cc-option,-fno-unit-at-a-time); \
-			else echo $(call cc-option,-funit-at-a-time); fi ;)
+# gcc 4.3.0 needs -funit-at-a-time for extern inline functions.
+KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
 
 KBUILD_CFLAGS += $(cflags-y)
 
-- 
2.7.4

