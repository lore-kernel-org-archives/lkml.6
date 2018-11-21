Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EECC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90716214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOhcm6z2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90716214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388716AbeKVFpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:45:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732372AbeKVFpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:45:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F483214D9;
        Wed, 21 Nov 2018 19:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827418;
        bh=2SRwGS/xRFpfceYigVJsMO2ndCRqAwXHpuV1+esd9vA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOhcm6z2MmPjP9eBfFGPHsAqwcHC0af/m0FAygwCyfbiG1bK2GXHH2y3JOnxNnwdV
         g/pbtvmoODHRyz1cmC0rnE5ou13RI5hkDbnVLVMhEIrF9u5wp+qvwAByK9jPxyFpAl
         clxyHqh1knsDBLjg8oesjttVowJP6sbOid3PD2bc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michal Marek <mmarek@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.9 22/59] kbuild: Add __cc-option macro
Date:   Wed, 21 Nov 2018 20:06:37 +0100
Message-Id: <20181121183509.124128734@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
References: <20181121183508.262873520@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 9f3f1fd299768782465cb32cdf0dd4528d11f26b upstream.

cc-option uses KBUILD_CFLAGS and KBUILD_CPPFLAGS when it determines
whether an option is supported or not. This is fine for options used to
build the kernel itself, however some components like the x86 boot code
use a different set of flags.

Add the new macro __cc-option which is a more generic version of
cc-option with additional parameters. One parameter is the compiler
with which the check should be performed, the other the compiler options
to be used instead KBUILD_C*FLAGS.

Refactor cc-option and hostcc-option to use __cc-option and move
hostcc-option to scripts/Kbuild.include.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Michal Marek <mmarek@suse.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile               |    2 +-
 scripts/Kbuild.include |   14 ++++++++++++--
 scripts/Makefile.host  |    6 ------
 3 files changed, 13 insertions(+), 9 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -303,7 +303,7 @@ CONFIG_SHELL := $(shell if [ -x "$$BASH"
 
 HOSTCC       = gcc
 HOSTCXX      = g++
-HOSTCFLAGS   = -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu89
+HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu89
 HOSTCXXFLAGS = -O2
 
 ifeq ($(shell $(HOSTCC) -v 2>&1 | grep -c "clang version"), 1)
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -109,6 +109,11 @@ as-option = $(call try-run,\
 as-instr = $(call try-run,\
 	printf "%b\n" "$(1)" | $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
 
+# __cc-option
+# Usage: MY_CFLAGS += $(call __cc-option,$(CC),$(MY_CFLAGS),-march=winchip-c6,-march=i586)
+__cc-option = $(call try-run,\
+	$(1) -Werror $(2) $(3) -c -x c /dev/null -o "$$TMP",$(3),$(4))
+
 # Do not attempt to build with gcc plugins during cc-option tests.
 # (And this uses delayed resolution so the flags will be up to date.)
 CC_OPTION_CFLAGS = $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))
@@ -116,8 +121,13 @@ CC_OPTION_CFLAGS = $(filter-out $(GCC_PL
 # cc-option
 # Usage: cflags-y += $(call cc-option,-march=winchip-c6,-march=i586)
 
-cc-option = $(call try-run,\
-	$(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
+cc-option = $(call __cc-option, $(CC),\
+	$(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS),$(1),$(2))
+
+# hostcc-option
+# Usage: cflags-y += $(call hostcc-option,-march=winchip-c6,-march=i586)
+hostcc-option = $(call __cc-option, $(HOSTCC),\
+	$(HOSTCFLAGS) $(HOST_EXTRACFLAGS),$(1),$(2))
 
 # cc-option-yn
 # Usage: flag := $(call cc-option-yn,-march=winchip-c6)
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -20,12 +20,6 @@
 # Will compile qconf as a C++ program, and menu as a C program.
 # They are linked as C++ code to the executable qconf
 
-# hostcc-option
-# Usage: cflags-y += $(call hostcc-option,-march=winchip-c6,-march=i586)
-
-hostcc-option = $(call try-run,\
-	$(HOSTCC) $(HOSTCFLAGS) $(HOST_EXTRACFLAGS) $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
-
 __hostprogs := $(sort $(hostprogs-y) $(hostprogs-m))
 host-cshlib := $(sort $(hostlibs-y) $(hostlibs-m))
 host-cxxshlib := $(sort $(hostcxxlibs-y) $(hostcxxlibs-m))


