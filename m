Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A61DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AD920659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nUcDnLH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AD920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeLEL3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:29:23 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:58256 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbeLEL3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:29:22 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wB5BSBlW028064;
        Wed, 5 Dec 2018 20:28:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wB5BSBlW028064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544009292;
        bh=H36yvD8LOqrJ4DjVGlwvJ7B2rd10VOZDsz4ulX8ISz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUcDnLH0CqUfD05RzSYxzCgBpv1ctmbz+Nvtqu/kBHV441FxN5rG1c9VHyi92EmGe
         YtIAoHxKvFy7Jrx7YUphXGLquRTXkrsCmSWAv8KMZ0mutCzYSt5UuqVtxFMaIRJ6QU
         SIq57KMcQRQX+MHu646R1r5JtAE3aKqe5JHwCWd3e48XrveCukWIYqlSIl7VUju+8B
         g07upgCR78yaz9Q2fvr/X6UCLhlYUs+AUyHTzsXA1SLdo/KIObYY34a36I34kIGl0g
         DqT1h7SFcFhm9o5ss3XUTJidJ0c4mm5pjyeyqsQx3mi26pmcTP83p8zNgKFAGDCLRt
         5R9VMjYqnWvHQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH 2/3] kbuild: generate asm-generic wrappers if mandatory headers are missing
Date:   Wed,  5 Dec 2018 20:28:05 +0900
Message-Id: <1544009286-15705-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544009286-15705-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544009286-15705-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some time ago, Sam pointed out a certain degree of overwrap between
generic-y and mandatory-y. (https://lkml.org/lkml/2017/7/10/121)

I a bit tweaked the meaning of mandatory-y; now it defines the minimum
set of ASM headers that all architectures must have.

If arch does not have specific implementation of a mandatory header,
Kbuild will let it fallback to the asm-generic one by automatically
generating a wrapper. This will allow to drop lots of redundant
generic-y defines.

Previously, "mandatory" was used in the context of UAPI, but I guess
this can be extended to kernel space ASM headers.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/kbuild/makefiles.txt | 9 ++++++---
 scripts/Makefile.asm-generic       | 3 +++
 scripts/Makefile.headersinst       | 7 -------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 8da26c6..bf28c47 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -1296,9 +1296,12 @@ See subsequent chapter for the syntax of the Kbuild file.
 
 --- 7.4 mandatory-y
 
-	mandatory-y is essentially used by include/uapi/asm-generic/Kbuild.asm
-	to define the minimum set of headers that must be exported in
-	include/asm.
+	mandatory-y is essentially used by include/(uapi/)asm-generic/Kbuild.asm
+	to define the minimum set of ASM headers that all architectures must have.
+
+	This works like optional generic-y. If a mandatory header is missing
+	in arch/$(ARCH)/include/(uapi/)/asm, Kbuild will automatically generate
+	a wrapper of the asm-generic one.
 
 	The convention is to list one subdir per line and
 	preferably in alphabetic order.
diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generic
index 760323e..c7cd23d 100644
--- a/scripts/Makefile.asm-generic
+++ b/scripts/Makefile.asm-generic
@@ -14,6 +14,9 @@ src := $(subst /generated,,$(obj))
 
 include scripts/Kbuild.include
 
+# If arch does not implement mandatory headers, fallback to asm-generic ones.
+generic-y   += $(foreach f, $(mandatory-y), $(if $(wildcard $(srctree)/$(src)/$(f)),,$(f)))
+
 generic-y   := $(addprefix $(obj)/, $(generic-y))
 generated-y := $(addprefix $(obj)/, $(generated-y))
 
diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index d5e1314..0d4a96d 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -57,13 +57,6 @@ check-file    := $(installdir)/.check
 all-files     := $(header-files) $(genhdr-files)
 output-files  := $(addprefix $(installdir)/, $(all-files))
 
-ifneq ($(mandatory-y),)
-missing       := $(filter-out $(all-files),$(mandatory-y))
-ifneq ($(missing),)
-$(error Some mandatory headers ($(missing)) are missing in $(obj))
-endif
-endif
-
 # Work out what needs to be removed
 oldheaders    := $(patsubst $(installdir)/%,%,$(wildcard $(installdir)/*.h))
 unwanted      := $(filter-out $(all-files),$(oldheaders))
-- 
2.7.4

