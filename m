Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79541C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7B520851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zv6UQOYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7B520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbeKTLdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:33:21 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:34062 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732133AbeKTLdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:33:14 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wAK15ZEg029284;
        Tue, 20 Nov 2018 10:05:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wAK15ZEg029284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542675943;
        bh=Gseq30r3u/E8mjPjZAPFpPP9wW2F4by4Djgv+EJRb08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zv6UQOYEnXX5OYGVqkmb+ymgIFfJUyds4IPOeVtyYP2Q/kZTtj7YDCRf76tdno4B5
         p9DODhSNQzzrInKxZZLNSUhxLIg21NS8sXNuPJhLt+zj0XY3QKqSD3AX3VCF4Nu5Vl
         YPx/uXBYmRbsr+WSciMuA1espMi99uPwrQv0o/4TekrGKv/u2Jbfvrf2ZQWp0KSeFi
         0DX6OjGPAFOPhAZfZxjMp8LcXr2id92svbBPkfDGiJg3bVnDosxO5Qh2Aq5Ix0cQkG
         CSA8Xq69KQeDmPrUaDZ0RWV5xEUPo/AITm7g0IiR+HBrzZiITLhrgQ9gUIErEj1o4a
         RzZZDv1ifuRdw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] kbuild: remove redundant 'set -e' from cmd_* defines
Date:   Tue, 20 Nov 2018 10:05:30 +0900
Message-Id: <1542675930-21114-10-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These three cmd_* are invoked in the $(call cmd,*) form.

Now that 'set -e' moved to the 'cmd' macro, they do not need to
explicitly give 'set -e'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 scripts/Makefile.build   | 2 --
 scripts/package/Makefile | 1 -
 2 files changed, 3 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 3bad2aa..d589d57 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -134,7 +134,6 @@ cmd_gensymtypes_c =                                                         \
 
 quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
 cmd_cc_symtypes_c =                                                         \
-    set -e;                                                                 \
     $(call cmd_gensymtypes_c,true,$@) >/dev/null;                           \
     test -s $@ || rm -f $@
 
@@ -337,7 +336,6 @@ cmd_gensymtypes_S =                                                         \
 
 quiet_cmd_cc_symtypes_S = SYM $(quiet_modtag) $@
 cmd_cc_symtypes_S =                                                         \
-    set -e;                                                                 \
     $(call cmd_gensymtypes_S,true,$@) >/dev/null;                           \
     test -s $@ || rm -f $@
 
diff --git a/scripts/package/Makefile b/scripts/package/Makefile
index 73503eb..453fece 100644
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -33,7 +33,6 @@ MKSPEC     := $(srctree)/scripts/package/mkspec
 
 quiet_cmd_src_tar = TAR     $(2).tar.gz
       cmd_src_tar = \
-set -e; \
 if test "$(objtree)" != "$(srctree)"; then \
 	echo >&2; \
 	echo >&2 "  ERROR:"; \
-- 
2.7.4

