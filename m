Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29ABC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 04:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888F921722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 04:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ndaatIai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888F921722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeH0Htf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 03:49:35 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:40458 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeH0Htf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 03:49:35 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w7R43Sia004053;
        Mon, 27 Aug 2018 13:03:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w7R43Sia004053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535342609;
        bh=QWXSE7/OQHBlT44+TGlqxkRhZ97JeJizcyopsk4jHsY=;
        h=From:To:Cc:Subject:Date:From;
        b=ndaatIailO5hoiLFnlwomC10Ew0c2977L3NOi01UukofNBoXEcec/BLZjs4FJByq3
         h1onO5yIbQQdy4ukmP+kKAfSy85VKqsss7gZ0oyGAw62kfMyn//Y1ERbdmxorFY9n0
         S45j8ZM+3RPx+oETlh3PD8OryIQODP1HYzeOSrMgbBnPx350RssdP3AYSlUy9EEujP
         HL3h7T15KEpOBn46UwMQIREh025770ah+sFED4fRIIN0dpP+mhwpWGxF+YK8f/r/DI
         PWC6WJ1GbsY++E3q/3WgMB5fqybF+QXj4o2onBDwPYFQUZcnvwu7FKTu9JGmo1x9Tv
         ZqYGcvU5gHTHw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] um: remove -fno-unit-at-a-time workaround for pre-4.0 GCC
Date:   Mon, 27 Aug 2018 13:03:04 +0900
Message-Id: <1535342584-22174-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
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

