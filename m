Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51011C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A082075A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GTdHyPEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfBTEYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:24:05 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:26323 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfBTEYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 23:24:05 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1K4NxgV027325;
        Wed, 20 Feb 2019 13:23:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1K4NxgV027325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550636640;
        bh=CalrtVHXcO2JrNtJtgEYVmX+OuO2Eqf+H4VMUdwBRg0=;
        h=From:To:Cc:Subject:Date:From;
        b=GTdHyPEbaX4qaOEI5AcPNYxHOxrzYQZ9KmTu4UXc9sHIzHDzJZ0HCfAliKQzrtQ77
         PAh9lqUfJeN7RJOswBMZzC5YivWaoZq1zexg4Uoq+Te2gr89kIcPv54PQXwstCfNu1
         DrZikJavjw9ywWIV21zcFkWqOAgHmh9xcCVgt3JVJqGmQT4xGSjnqNV64dpP7ybG7t
         qkUtEqgY3x8/XE82orhylu4aKKLn3mEKjDNZ/mTmAGqP2qXLutGhAfYhoBlkWbgltv
         jgSZ6x2vxpFollL03blrQEK+i/GNKtjpyrjsrwOWvp8oaZNamrIYAxy1gZSj13uDJv
         FkW8G2yoE33bA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: refactor cc-cross-prefix implementation
Date:   Wed, 20 Feb 2019 13:23:56 +0900
Message-Id: <1550636636-25367-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - $(word 1, <text>) is equivalent to $(firstword, <text>)

 - hardcode "gcc" instead of $(CC)

 - minimize the shell script part

A little more notes since $(filter-out -%, ...) is not clear.

arch/mips/Makefile passes prefixes depending on the configuration.

CROSS_COMPILE := $(call cc-cross-prefix, $(tool-archpref)-linux- \
    $(tool-archpref)-linux-gnu- $(tool-archpref)-unknown-linux-gnu-)

In the Kconfig stage (e.g. when you run 'make defconfig'), neither
CONFIG_32BIT nor CONFIG_64BIT is defined. So, $(tool-archpref) is
empty. As a result, "-linux -linux-gnu- -unknown-linux-gnu" is passed
into cc-cross-prefix. The command 'which' assumes arguments starting
with a hyphen as command options, then emits the following messages:

  Illegal option -l
  Illegal option -l
  Illegal option -u

I think it is wrong to define CROSS_COMPILE depending on the CONFIG
options since you need to feed $(CC) to Kconfig, but it is how MIPS
Makefile currently works. Anyway, it would not hurt to filter-out
invalid strings beforehand.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Kbuild.include | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index d93250b..c1e15a4 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -71,14 +71,10 @@ endef
 
 # cc-cross-prefix
 # Usage: CROSS_COMPILE := $(call cc-cross-prefix, m68k-linux-gnu- m68k-linux-)
-# Return first prefix where a prefix$(CC) is found in PATH.
-# If no $(CC) found in PATH with listed prefixes return nothing
-cc-cross-prefix =  \
-	$(word 1, $(foreach c,$(1),                                   \
-		$(shell set -e;                                       \
-		if (which $(strip $(c))$(CC)) > /dev/null 2>&1 ; then \
-			echo $(c);                                    \
-		fi)))
+# Return first <prefix> where a <prefix>gcc is found in PATH.
+# If no gcc found in PATH with listed prefixes return nothing
+cc-cross-prefix = $(firstword $(foreach c, $(filter-out -%, $(1)), \
+					$(if $(shell which $(c)gcc), $(c))))
 
 # output directory for tests below
 TMPOUT := $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/)
-- 
2.7.4

