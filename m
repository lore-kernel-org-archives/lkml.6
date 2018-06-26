Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F309DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9229C26B5E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hDn/AZZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9229C26B5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754465AbeFZRkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:40:18 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44779 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbeFZRkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:40:16 -0400
Received: by mail-pf0-f194.google.com with SMTP id j3-v6so1054659pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=gXO0h9619stsONpcqKrkcnlC2fSbgLHUz3AebFkLFD4=;
        b=hDn/AZZw4DlYsN1zebZ2UlEUcSN22bdNJ7rPeJ2FVXW4mYE1pFI9G4pS4JZW9/0ncs
         GEx5oY0m8iwMc/Cvj5JSQz/jTFA5/dM5hgU40RQ/hmpnl0ZsyCAhfuJZuIvke2Dv6nVQ
         Vu4z+TsygpBj6k7/+b30ZU7omIu3GlTWf1WhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=gXO0h9619stsONpcqKrkcnlC2fSbgLHUz3AebFkLFD4=;
        b=FQ5H9pMr52p8d6oqYhArntG1+nT/CmHicSxJjFhqlwIPT7vZvZ0/TP4Yt4GMQn5wxr
         nYdjJEJArKkflM9YvRrALBeispGzPyZGDMA2tjKYikFnqGDDoTi3JiBTv1qxOJUZrYMj
         +FJzdMydrIKX4zsx0pTTUiPuWeEOBZs7gPENl0+wuPKcRGGiWIq2p76shdl6SUBHiXhv
         e5TucDPkY+FbjdIOCwPo4pDhwd2bJuQZTjtdfo44a+Kn4I6zoaE9a6uhqBNtXXxseIAZ
         B4gjlV8ykG4YhPBIqQ42BTltE+mTNp3PebFQQs/c2tr2iMY/X3X3WB874x9rWXFea1Hy
         npkQ==
X-Gm-Message-State: APt69E2Alb4NeFYTyZGEwzGaebPVXjFr51ygHYpzcZcJIXVcVkLkHaIV
        XlaP7gc/N3SW++ILjzkz9mjFzg==
X-Google-Smtp-Source: AAOMgpdtKsYtYPjgnLxeiDBJgLiH9ZJmOLRHFCxBLdIfLlMFjpHOBByhEfKQhGNFICv9/vShiE1a6g==
X-Received: by 2002:a62:6c42:: with SMTP id h63-v6mr2520237pfc.240.1530034816293;
        Tue, 26 Jun 2018 10:40:16 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s12-v6sm3301985pfm.41.2018.06.26.10.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 10:40:15 -0700 (PDT)
Date:   Tue, 26 Jun 2018 10:40:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        David Airlie <airlied@linux.ie>, linux-kbuild@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH] Makefile: globally enable VLA warning
Message-ID: <20180626174013.GA41617@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch I've got prepared now that fixes for all VLAs have been
sent to maintainers (some are still under review/adjustment, but there
aren't any unexplored cases left). My intention would be to have this land
at the end of the next merge window after all the pending VLA patches
have landed. I just wanted to get any feedback here, since it touches
a couple areas in the process and I didn't want anyone to be surprised. :)

Thanks!

-Kees

----
Now that VLAs have been removed from the kernel, enable the VLA warning
globally. The only exceptions to this are the KASan an UBSan tests which
are explicitly checking that VLAs trigger their respective tests.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Makefile                      | 3 +++
 drivers/gpu/drm/i915/Makefile | 2 +-
 lib/Makefile                  | 2 ++
 scripts/Makefile.extrawarn    | 1 -
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c9132594860b..3d5013ec4116 100644
--- a/Makefile
+++ b/Makefile
@@ -778,6 +778,9 @@ NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 # warn about C99 declaration after statement
 KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
 
+# VLAs should not be used anywhere in the kernel
+KBUILD_CFLAGS += $(call cc-option,-Wvla)
+
 # disable pointer signed / unsigned warnings in gcc 4.0
 KBUILD_CFLAGS += $(call cc-disable-warning, pointer-sign)
 
diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 4c6adae23e18..289ab5dc5712 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -12,7 +12,7 @@
 # Note the danger in using -Wall -Wextra is that when CI updates gcc we
 # will most likely get a sudden build breakage... Hopefully we will fix
 # new warnings before CI updates!
-subdir-ccflags-y := -Wall -Wextra -Wvla
+subdir-ccflags-y := -Wall -Wextra
 subdir-ccflags-y += $(call cc-disable-warning, unused-parameter)
 subdir-ccflags-y += $(call cc-disable-warning, type-limits)
 subdir-ccflags-y += $(call cc-disable-warning, missing-field-initializers)
diff --git a/lib/Makefile b/lib/Makefile
index 90dc5520b784..4720e276232e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -52,7 +52,9 @@ obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
 obj-$(CONFIG_TEST_HASH) += test_hash.o test_siphash.o
 obj-$(CONFIG_TEST_KASAN) += test_kasan.o
 CFLAGS_test_kasan.o += -fno-builtin
+CFLAGS_test_kasan.o += $(call cc-disable-warning, vla)
 obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
+CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
 UBSAN_SANITIZE_test_ubsan.o := y
 obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 8d5357053f86..24b2fb1d1297 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -52,7 +52,6 @@ warning-3 += -Wpointer-arith
 warning-3 += -Wredundant-decls
 warning-3 += -Wswitch-default
 warning-3 += $(call cc-option, -Wpacked-bitfield-compat)
-warning-3 += $(call cc-option, -Wvla)
 
 warning := $(warning-$(findstring 1, $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)))
 warning += $(warning-$(findstring 2, $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)))
-- 
2.17.1


-- 
Kees Cook
Pixel Security
