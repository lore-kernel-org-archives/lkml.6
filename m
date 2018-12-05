Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11297C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73D420850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObUvhjBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73D420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeLEBme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:42:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33518 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeLEBme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:42:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so10658058wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 17:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9MYR1fL4LMIx7JzNK3MR85Ll1dY3Hp/rUqi3GHmQqLE=;
        b=ObUvhjBX3KdQS8ZBooFUoCSL1m+/V1krnW0L5tB8QaXp24sHBWmTSGMUsbQARuLu01
         uLkUrSAgj/+T7MKthdojXLP3a27Ny0pmoSm+OwJgWP9O3sQC6ZUK1GMz6UzpP6ie+93A
         9sjtZ7l5c3lqr8vGblsApe3LgbATTmBO42EI7IUBnePWAdk2KpQ7Rv7uZ1R54nsYoIEJ
         w+ERHMrJtlQfTEZDU5bD0tROatf48z28nRE5mkEnZxPWtcy0tgRIl3KuuQoe0DJsJaGP
         0dqglt7ZbH8oDkORW0AmHP2hlAYBiuad157tNHrdHgzbKNSHkI4WuDLRnof+yknSMFdL
         llPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9MYR1fL4LMIx7JzNK3MR85Ll1dY3Hp/rUqi3GHmQqLE=;
        b=smAZhG2zdLZyHLk0v1ekjK0fO5r9AA/V2IDkmCTG3CXFgYEKaJIutuUwqoi4KA3zri
         8OLR7gcrcJ0hPhdmyCr9Yb9AOT2Ys3wNg8vRmlu9oMgmGdFca1ane0/lKkpiuXHUaTII
         XOGa2gMdWOLCTPyQBxMJNK60G/DxQTkEii5AhyO4dqy6Cy7EI1TbPBpz5N3jmSJf8354
         /n1TD6muIGoVd82KBK5DfLre6lym03bp6T9hlrAmwmHJt+kYiP+WimxwXq/NGtPzqqlN
         W4dG8+nYEYrmtc7HOA7+2AdgmYnJRROyD2DID4sxV0P0TcmMzbwoGNUgeM/bczfizIWJ
         81fg==
X-Gm-Message-State: AA+aEWZmOB/i9mruZwxLONWt6+EvYnfWyHSLyuELWS/uR4bb2eRm5You
        ZFNlplkQUaTYh+a3P1pVRaY=
X-Google-Smtp-Source: AFSGD/VPRx8YCkGZV+pYuBcL+DwQ2v2wcepkQtBrmGNvw0iMVrqiWbtdUq7OJOffpk4TskbLuTlnDw==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr14761433wmf.38.1543974152112;
        Tue, 04 Dec 2018 17:42:32 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id b7sm15845784wrs.47.2018.12.04.17.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 17:42:31 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 1/2] ARM: Remove '-p' from LDFLAGS
Date:   Tue,  4 Dec 2018 18:42:12 -0700
Message-Id: <20181205014213.943-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option is not supported by lld:

    ld.lld: error: unknown argument: -p

This has been a no-op in binutils since 2004 (see commit dea514f51da1 in
that tree). Given that the lowest officially supported of binutils for
the kernel is 2.20, which was released in 2009, nobody needs this flag
around so just remove it. Commit 1a381d4a0a9a ("arm64: remove no-op -p
linker flag") did the same for arm64.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm/Makefile                 | 2 +-
 arch/arm/boot/compressed/Makefile | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 05a91d8b89f3..e2a0baf36766 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -10,7 +10,7 @@
 #
 # Copyright (C) 1995-2001 by Russell King
 
-LDFLAGS_vmlinux	:=-p --no-undefined -X --pic-veneer
+LDFLAGS_vmlinux	:= --no-undefined -X --pic-veneer
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux	+= --be8
 KBUILD_LDFLAGS_MODULE	+= --be8
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 1f5a5ffe7fcf..dcd07bd24b85 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -131,8 +131,6 @@ endif
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux += --be8
 endif
-# ?
-LDFLAGS_vmlinux += -p
 # Report unresolved symbol references
 LDFLAGS_vmlinux += --no-undefined
 # Delete all temporary local symbols
-- 
2.20.0.rc1

