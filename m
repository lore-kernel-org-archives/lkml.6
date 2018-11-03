Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93727C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 20:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDF12082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 20:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHNcsXva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDF12082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeKDF1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 01:27:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42521 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeKDF1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 01:27:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id y15-v6so5293210wru.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NREQVr5KgJehgLF/BScZ5U0wiAbtn6VndNn8zDfpXog=;
        b=EHNcsXvarxApF/5r3qevYe7HGJY4ACyzxRuSuNtJwjBHJurrlm1V27gyM0alIB77IJ
         peZom8p9YE+w2n5A5duX6EQxSKkL/NBmA8Um4DcD3WNjLn8pN92qMRKJQdAIQsvgzyVa
         1ektA5djHqChM9JXYDlggrriWJPvjVZ+W6/7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NREQVr5KgJehgLF/BScZ5U0wiAbtn6VndNn8zDfpXog=;
        b=iiIt/JRt9bM25I4LPsHCswjcw/iyw/VN0Ti8OPzWDMDCgh5y//zvI9AL2q7CWNivkR
         9KqFLY8tIJEFJRAksryTEwN0T/BjlHvX9rNQTH6hFAqGEcNMKvdDXFs2kS+GEGwYsZ7+
         HSUeoI8ghuZId7RXIRT+dCA9K6T/VrVPaGEh8NAw6INSG2YucH1LcrwNlcjm6vJcjBPv
         LjiqWg0cRV4eXlYZu/HPzh2C8bLvn9XqiRw+npe4T0GaX3jciVNenXKDoYznhiwx8WSy
         zxFjYoyH7+zrvMGx8YRMBhi1xlvZEbYmzU0BVycOhp/nwqYmc9ark6CHwZuWdbXkswTq
         P7Vg==
X-Gm-Message-State: AGRZ1gKeuekgWZeT4Cl3Xx0PRVCOxV8hTKd2XSq9wj/hAydkhS9s8fmD
        HbcqObIaN0CsWkjJ8ZJU5bNrAsl+nIU=
X-Google-Smtp-Source: AJdET5cFI7fqWq70TydsEIBykZajTF//re/fwRPIwl4mUpQTRJ92NtSGwUiY2e49CXQtUjeN0O1Rhw==
X-Received: by 2002:adf:a386:: with SMTP id l6-v6mr13037936wrb.110.1541276122781;
        Sat, 03 Nov 2018 13:15:22 -0700 (PDT)
Received: from harold.home ([2a01:cb1d:112:6f00:9584:c078:6527:8480])
        by smtp.gmail.com with ESMTPSA id o126-v6sm24910616wmo.3.2018.11.03.13.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 13:15:21 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     michal.lkml@markovi.net, yamada.masahiro@socionext.com,
        riku.voipio@linaro.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] Revert "kbuild: add --include-dir flag only for out-of-tree build"
Date:   Sat,  3 Nov 2018 21:15:04 +0100
Message-Id: <20181103201504.29413-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 80463f1b7bf9f822fd3495139bcf3ef254fdca10, because
it breaks the bindeb-pkg build target in the following way:

  ...
    LD [M]  sound/soc/rockchip/snd-soc-rk3399-gru-sound.ko
    LD [M]  sound/soc/rockchip/snd-soc-rockchip-pcm.ko
    LD [M]  sound/soc/rockchip/snd-soc-rockchip-rt5645.ko
    LD [M]  sound/soc/rockchip/snd-soc-rockchip-spdif.ko
    LD [M]  sound/soc/sh/rcar/snd-soc-rcar.ko
   fakeroot -u debian/rules binary
  make KERNELRELEASE=4.19.0-12677-g19beffaf7a99-dirty ARCH=arm64 KBUILD_SRC= intdeb-pkg
  /bin/bash /home/ard/linux/scripts/package/builddeb
  Makefile:600: include/config/auto.conf: No such file or directory
  ***
  *** Configuration file ".config" not found!
  ***
  *** Please run some configurator (e.g. "make oldconfig" or
  *** "make menuconfig" or "make xconfig").
  ***
  make[12]: *** [syncconfig] Error 1
  make[11]: *** [syncconfig] Error 2
  make[10]: *** [include/config/auto.conf] Error 2
  make[9]: *** [__sub-make] Error 2
  cp: cannot stat '/home/ard/linux/scripts/kconfig/Makefile:69: recipe for target '\''syncconfig'\'' failed'$'\n''/home/ard/linux/Makefile:544: recipe for target '\''syncconfig'\'' failed'$'\n''Makefile:640: recipe for target '\''include/config/auto.conf'\'' failed'$'\n''Makefile:15: recipe for target '\''__sub-make'\'' failed': No such file or directory
  /home/ard/linux/scripts/package/Makefile:83: recipe for target 'intdeb-pkg' failed
  make[8]: *** [intdeb-pkg] Error 1
  /home/ard/linux/Makefile:1399: recipe for target 'intdeb-pkg' failed
  make[7]: *** [intdeb-pkg] Error 2
  Makefile:152: recipe for target 'sub-make' failed
  make[6]: *** [sub-make] Error 2
  Makefile:15: recipe for target '__sub-make' failed
  make[5]: *** [__sub-make] Error 2
  debian/rules:7: recipe for target 'binary-arch' failed
  make[4]: *** [binary-arch] Error 2
  dpkg-buildpackage: error: fakeroot -u debian/rules binary gave error exit status 2
  /home/ard/linux/scripts/package/Makefile:79: recipe for target 'bindeb-pkg' failed
  make[3]: *** [bindeb-pkg] Error 2
  /home/ard/linux/Makefile:1399: recipe for target 'bindeb-pkg' failed
  make[2]: *** [bindeb-pkg] Error 2
  Makefile:152: recipe for target 'sub-make' failed
  make[1]: *** [sub-make] Error 2
  Makefile:15: recipe for target '__sub-make' failed
  make: *** [__sub-make] Error 2

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Makefile | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 9aa352b38815..f9d7af9e5146 100644
--- a/Makefile
+++ b/Makefile
@@ -15,9 +15,10 @@ NAME = "People's Front"
 PHONY := _all
 _all:
 
-# Do not use make's built-in rules and variables
-# (this increases performance and avoids hard-to-debug behaviour)
-MAKEFLAGS += -rR
+# o Do not use make's built-in rules and variables
+#   (this increases performance and avoids hard-to-debug behaviour);
+# o Look for make include files relative to root of kernel src
+MAKEFLAGS += -rR --include-dir=$(CURDIR)
 
 # Avoid funny character set dependencies
 unexport LC_ALL
@@ -135,13 +136,6 @@ KBUILD_OUTPUT := $(shell mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) \
 $(if $(KBUILD_OUTPUT),, \
      $(error failed to create output directory "$(saved-output)"))
 
-# Look for make include files relative to root of kernel src
-#
-# This does not become effective immediately because MAKEFLAGS is re-parsed
-# once after the Makefile is read.  It is OK since we are going to invoke
-# 'sub-make' below.
-MAKEFLAGS += --include-dir=$(CURDIR)
-
 PHONY += $(MAKECMDGOALS) sub-make
 
 $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
-- 
2.19.1

