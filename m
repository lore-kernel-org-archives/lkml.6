Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB9FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B61208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B61208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933278AbeGIUKG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:10:06 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42339 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933149AbeGIUKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:10:04 -0400
Received: by mail-qk0-f193.google.com with SMTP id u62-v6so10376573qkf.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 13:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5ZvllqU+yCoIfEg1F3pN8YU4kBCsy97ZTGsd2ONb0xM=;
        b=MMXhXejJPD/MWADSpwyJ/I2Fngq48KMuS/qO9YyuilwUx/ue0uqPJg1/WQt8mXabId
         /yrEVWQO2ZF3KiJovNfYYNfd4Ogggc3oDnfd01PV6Lv5ts6ALPPNfDRJ4nx3UE75IZRs
         tAnewuJfjiQBp1Bgq4vOZc59miU36X0NfxsBa5MVgkBqVu0iU44pzcsU1TyqmQZQqlVD
         v6EAGESffk3qLU/1KwougdOoMqZiBjUeac/iJIlCbOfrdva7jE3Sc2itPjHwlXclo714
         jzmR4fJC8vUYXkJWF0pzVLYEU+vhDF3yXCoLl8RNO7MuhVEokFeqSUADt1wPruEB1D2a
         5HIA==
X-Gm-Message-State: AOUpUlHo/1ertvL1w58iqWWCw/YZ4dfkorEXiaoxaAXsX5rTsxMShhqR
        biA94CmBqwY+mKtMB1+rAjF+Kg==
X-Google-Smtp-Source: AAOMgpe+EXSigwBf5yaIsdESePm7jkBqZobIH80kTg1uN62KNcGDNdHSkRKq8Rh5fAJ2f9JUWShLAw==
X-Received: by 2002:a37:6b03:: with SMTP id g3-v6mr7895010qkc.107.1531167003541;
        Mon, 09 Jul 2018 13:10:03 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::1941])
        by smtp.gmail.com with ESMTPSA id a66-v6sm2149001qkf.96.2018.07.09.13.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 13:10:02 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Will Deacon <will.deacon@arm.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "arm64: Use aarch64elf and aarch64elfb emulation mode variants"
Date:   Mon,  9 Jul 2018 13:09:56 -0700
Message-Id: <20180709200956.31158-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 38fc4248677552ce35efc09902fdcb06b61d7ef9.

This breaks compilation with Fedora gcc-8 tool chains:

  CHK     include/generated/compile.h
  LD [M]  arch/arm64/crypto/sha512-ce.o
aarch64-linux-gnu-ld: cannot open linker script file ldscripts/aarch64elf.xr: No such file or directory
make[1]: *** [scripts/Makefile.build:530: arch/arm64/crypto/sha512-ce.o] Error 1
make: *** [Makefile:1029: arch/arm64/crypto] Error 2

Fixes: 38fc42486775 ("arm64: Use aarch64elf and aarch64elfb emulation mode variants")
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
A bit rushed and I'm still debugging but I wanted to send this out
before anyone else gets hit since it is -rc4. Seeing this on both native
and cross compiles.
---
 arch/arm64/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 7976d2d242fa..f476d52ad8d6 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -60,13 +60,13 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
 AS		+= -EB
-LDFLAGS		+= -EB -maarch64elfb
+LDFLAGS		+= -EB -maarch64linuxb
 UTS_MACHINE	:= aarch64_be
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__AARCH64EL__
 AS		+= -EL
-LDFLAGS		+= -EL -maarch64elf
+LDFLAGS		+= -EL -maarch64linux
 UTS_MACHINE	:= aarch64
 endif
 
-- 
2.17.1

