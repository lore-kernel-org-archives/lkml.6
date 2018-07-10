Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E899C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9552083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9552083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933364AbeGJAvm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:51:42 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40383 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933015AbeGJAve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:51:34 -0400
Received: by mail-qk0-f194.google.com with SMTP id c126-v6so1982683qkd.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 17:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WB9pcwnvGIOQfaIcEEDBnltbglxMrlBjMgr/jK4qBNU=;
        b=LGsKu+hd49UNcEoTH091PdhdhBVbI/MWcT90EQ6wqm/N1orkhPiEb0qflTPKwAV5TW
         kr3Ca9iA0rHH5zTn0LFyfd6bR/X5TiSwGRYOyMEUGVitDnoLqvoQJGT5v4NGA+jm9kN+
         l/8pHM21aq+M+XBkRhCdo7/9BmNJ3S9LYj5zo5VYdi0R9gPNykFJIqZgun90c7NyYvxW
         npe4lQrGiknidW6yE4q2QhKA7uN2U26+67hpoPFzqG+IPfrPLDh5W4QwAdBWmZbGqXgi
         JhNO5NH8aSs+88zDJnqXcHr/ZTaomRJwzLUxJ5E0GWcgGWyJk6aSiW0ToilQAySHp9SD
         afbA==
X-Gm-Message-State: APt69E3dKY40QnDKUnxFEONDn74E+UgUtlabWLoLXqicNcK8aLlRj8Pl
        xPpZ4EsriguogJ298yUyhAd18Q==
X-Google-Smtp-Source: AAOMgpc/WLd93vs8C0XkDEtFsYeftg1bRNLsxC2NVI7DZ7fGsr2D4W8uLKq6KOq3tjXX2KzxunNsrA==
X-Received: by 2002:a37:15da:: with SMTP id 87-v6mr19538874qkv.67.1531183893604;
        Mon, 09 Jul 2018 17:51:33 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::1941])
        by smtp.gmail.com with ESMTPSA id d12-v6sm4086190qtp.6.2018.07.09.17.51.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 17:51:32 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Will Deacon <will.deacon@arm.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2] Revert "arm64: Use aarch64elf and aarch64elfb emulation mode variants"
Date:   Mon,  9 Jul 2018 17:51:27 -0700
Message-Id: <20180710005127.22883-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 38fc42486775 ("arm64: Use aarch64elf and aarch64elfb emulation mode
variants") unfortunately breaks with some toolchains:

  CHK     include/generated/compile.h
  LD [M]  arch/arm64/crypto/sha512-ce.o
aarch64-linux-gnu-ld: cannot open linker script file ldscripts/aarch64elf.xr: No such file or directory
make[1]: *** [scripts/Makefile.build:530: arch/arm64/crypto/sha512-ce.o] Error 1
make: *** [Makefile:1029: arch/arm64/crypto] Error 2

If the distribution doesn't package the associated linker strips from
binutils, this will fail. Both Fedora and Debian currently fall into
this category so just revert it.

Fixes: 38fc42486775 ("arm64: Use aarch64elf and aarch64elfb emulation mode variants")
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Tweaked the commit text to be a bit clearer about what the
underlying problem is.
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

