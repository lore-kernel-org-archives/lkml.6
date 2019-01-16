Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958F5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C80320675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1blJ79iW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbfAPC5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:57:14 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:48887 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfAPC5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:57:14 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x0G2uksR010468;
        Wed, 16 Jan 2019 11:56:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x0G2uksR010468
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547607407;
        bh=b3st7iXaosPz9TNOoCrIJxfgJyY5GuSh79BYsiKfgy0=;
        h=From:To:Cc:Subject:Date:From;
        b=1blJ79iW00qDBdbScxwA9YuKYI0cp1PNQVf/if0DjJlkMy5s2bQu6VXoBSU3S9vdy
         OLHPA5bMO1pePez6H1bE8V3eHzXI4ntBIkHa9SYE5qoXI0v4U0yB8n8hrkeTBENZfh
         HD95nQdjvJXYg+OzjgxjRFVCVEkd7HIYWvvUHOBcApmFqMaEIXSF/NHsHiOTIhBEJp
         jln1I5x5/iInK2rxZ2RqCO8XnzfqoLTtbw+6aE2uJ/pUL1cnrlR9Bk3Wbzaz3nvJF0
         grcW+0H1U9uBGSNcfW0KcxnNgWFQ2okIYOQa61+Pt1q8sGvG7hN2C+eBqFrgfuBPVh
         WXbgJllgX01WQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kbuild: skip 'addtree' and 'flags' magic for external module build
Date:   Wed, 16 Jan 2019 11:56:40 +0900
Message-Id: <1547607401-20118-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building an external module, $(obj) is the absolute path to it.

The header search paths from ccflags-y etc. should not be tweaked.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.host |  6 ++++--
 scripts/Makefile.lib  | 11 ++++++-----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 0393f75..a115259 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -67,13 +67,15 @@ _hostc_flags   = $(KBUILD_HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
 _hostcxx_flags = $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
                  $(HOSTCXXFLAGS_$(basetarget).o)
 
-ifeq ($(KBUILD_SRC),)
 __hostc_flags	= $(_hostc_flags)
 __hostcxx_flags	= $(_hostcxx_flags)
-else
+
+ifeq ($(KBUILD_EXTMOD),)
+ifneq ($(KBUILD_SRC),)
 __hostc_flags	= -I$(obj) $(call flags,_hostc_flags)
 __hostcxx_flags	= -I$(obj) $(call flags,_hostcxx_flags)
 endif
+endif
 
 hostc_flags    = -Wp,-MD,$(depfile) $(__hostc_flags)
 hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 12b88d0..ecad15b 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -137,14 +137,14 @@ _c_flags += $(if $(patsubst n%,, \
 	$(CFLAGS_KCOV))
 endif
 
-# If building the kernel in a separate objtree expand all occurrences
-# of -Idir to -I$(srctree)/dir except for absolute paths (starting with '/').
-
-ifeq ($(KBUILD_SRC),)
 __c_flags	= $(_c_flags)
 __a_flags	= $(_a_flags)
 __cpp_flags     = $(_cpp_flags)
-else
+
+# If building the kernel in a separate objtree expand all occurrences
+# of -Idir to -I$(srctree)/dir except for absolute paths (starting with '/').
+ifeq ($(KBUILD_EXTMOD),)
+ifneq ($(KBUILD_SRC),)
 
 # -I$(obj) locates generated .h files
 # $(call addtree,-I$(obj)) locates .h files in srctree, from generated .c files
@@ -155,6 +155,7 @@ __c_flags	= $(if $(obj),$(call addtree,-I$(src)) -I$(obj)) \
 __a_flags	= $(call flags,_a_flags)
 __cpp_flags     = $(call flags,_cpp_flags)
 endif
+endif
 
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 		 -include $(srctree)/include/linux/compiler_types.h       \
-- 
2.7.4

