Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AF1C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 04:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A349720823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 04:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QMIHH3VI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A349720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeJ3NPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 09:15:30 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:36722 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeJ3NPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 09:15:30 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w9U4LgZK000764;
        Tue, 30 Oct 2018 13:21:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w9U4LgZK000764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540873303;
        bh=U06X4wzGUcKfpT3rd6eTAurlLB8yHi+i7Y+oD+BqWGI=;
        h=From:To:Cc:Subject:Date:From;
        b=QMIHH3VIc22lCyApk6nAwVLVVVeGu5tpxb0dOTThkGDf2WyypYKO8jE7lypabKmVp
         beRCiYw0UDlfLYtD8ksbR2gtf6c9QSAv41ijLHfJBrWbIMt8fOYrQz8Mky5n5ypcby
         ivcuUn34IkFJxRon5eCgL0VeT0yQSGhXq7GcVlW2A9hCszA/bAxAYpKMk1F0gb1vMp
         1aFUsTYRLzRxovPIsEbJmtQLNQf/cqiDrJwp8nx9R49r8XUsJfVd8tLe3LBFBklaQg
         cgfnRry5me4+5DGjfz/Wb2LC/0QJeOzeHIqOwl6NX+hxO1tD0gmNPlDihoNO3HFpQH
         HGqmmbzoKb7og==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Paul Mackerras <paulus@samba.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] kbuild: replace cc-name test with CONFIG_CC_IS_CLANG
Date:   Tue, 30 Oct 2018 13:21:32 +0900
Message-Id: <1540873293-29817-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Evaluating cc-name invokes the compiler every time even when you are
not compiling anything, like 'make help'. This is not efficient.

The compiler type has been already detected in the Kconfig stage.
Use CONFIG_CC_IS_CLANG, instead.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                   | 2 +-
 arch/mips/Makefile         | 2 +-
 arch/mips/vdso/Makefile    | 2 +-
 arch/powerpc/Makefile      | 4 ++--
 scripts/Makefile.extrawarn | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 0a42d06..bd93bc3 100644
--- a/Makefile
+++ b/Makefile
@@ -707,7 +707,7 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
 
 KBUILD_CFLAGS += $(stackp-flags-y)
 
-ifeq ($(cc-name),clang)
+ifeq ($(CONFIG_CC_IS_CLANG),y)
 KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 15a84cf..ad1c418 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -128,7 +128,7 @@ cflags-y += -ffreestanding
 # clang's output will be based upon the build machine. So for clang we simply
 # unconditionally specify -EB or -EL as appropriate.
 #
-ifeq ($(cc-name),clang)
+ifeq ($(CONFIG_CC_IS_CLANG),y)
 cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= -EB
 cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -EL
 else
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 34605ca..e2b055e 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -10,7 +10,7 @@ ccflags-vdso := \
 	$(filter -march=%,$(KBUILD_CFLAGS)) \
 	-D__VDSO__
 
-ifeq ($(cc-name),clang)
+ifeq ($(CONFIG_CC_IS_CLANG),y)
 ccflags-vdso += $(filter --target=%,$(KBUILD_CFLAGS))
 endif
 
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 17be664..338e827 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -96,7 +96,7 @@ aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
 aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mabi=elfv2
 endif
 
-ifneq ($(cc-name),clang)
+ifneq ($(CONFIG_CC_IS_CLANG),y)
   cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mno-strict-align
 endif
 
@@ -175,7 +175,7 @@ endif
 # Work around gcc code-gen bugs with -pg / -fno-omit-frame-pointer in gcc <= 4.8
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44199
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52828
-ifneq ($(cc-name),clang)
+ifneq ($(CONFIG_CC_IS_CLANG),y)
 CC_FLAGS_FTRACE	+= $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
 endif
 endif
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 24b2fb1..88129e5 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -64,7 +64,7 @@ endif
 KBUILD_CFLAGS += $(warning)
 else
 
-ifeq ($(cc-name),clang)
+ifeq ($(CONFIG_CC_IS_CLANG),y)
 KBUILD_CFLAGS += $(call cc-disable-warning, initializer-overrides)
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-value)
 KBUILD_CFLAGS += $(call cc-disable-warning, format)
-- 
2.7.4

