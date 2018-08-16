Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C74EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1641421473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1641421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbeHPVop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:44:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56552 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbeHPVoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:44:44 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C635BD02;
        Thu, 16 Aug 2018 18:44:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH 4.9 04/15] kasan: dont emit builtin calls when sanitization is off
Date:   Thu, 16 Aug 2018 20:41:57 +0200
Message-Id: <20180816171626.307647594@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171625.340082081@linuxfoundation.org>
References: <20180816171625.340082081@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Konovalov <andreyknvl@google.com>

commit 0e410e158e5baa1300bdf678cea4f4e0cf9d8b94 upstream.

With KASAN enabled the kernel has two different memset() functions, one
with KASAN checks (memset) and one without (__memset).  KASAN uses some
macro tricks to use the proper version where required.  For example
memset() calls in mm/slub.c are without KASAN checks, since they operate
on poisoned slab object metadata.

The issue is that clang emits memset() calls even when there is no
memset() in the source code.  They get linked with improper memset()
implementation and the kernel fails to boot due to a huge amount of KASAN
reports during early boot stages.

The solution is to add -fno-builtin flag for files with KASAN_SANITIZE :=
n marker.

Link: http://lkml.kernel.org/r/8ffecfffe04088c52c42b92739c2bd8a0bcb3f5e.1516384594.git.andreyknvl@google.com
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[ Sami: Backported to 4.9 avoiding c5caf21ab0cf8 and e7c52b84fb ]
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile               |    3 ++-
 scripts/Makefile.kasan |    3 +++
 scripts/Makefile.lib   |    2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -417,7 +417,8 @@ export MAKE AWK GENKSYMS INSTALLKERNEL P
 export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
-export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE CFLAGS_KASAN CFLAGS_UBSAN
+export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
+export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN
 export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
 export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
 export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -28,4 +28,7 @@ else
         CFLAGS_KASAN := $(CFLAGS_KASAN_MINIMAL)
     endif
 endif
+
+CFLAGS_KASAN_NOSANITIZE := -fno-builtin
+
 endif
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -127,7 +127,7 @@ endif
 ifeq ($(CONFIG_KASAN),y)
 _c_flags += $(if $(patsubst n%,, \
 		$(KASAN_SANITIZE_$(basetarget).o)$(KASAN_SANITIZE)y), \
-		$(CFLAGS_KASAN))
+		$(CFLAGS_KASAN), $(CFLAGS_KASAN_NOSANITIZE))
 endif
 
 ifeq ($(CONFIG_UBSAN),y)


