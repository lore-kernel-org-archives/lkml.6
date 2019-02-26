Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87E3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BAB20661
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OlYw8H/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfBZEDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 23:03:51 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33633 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfBZEDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 23:03:51 -0500
Received: by mail-pg1-f201.google.com with SMTP id y1so8679268pgo.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 20:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=x10LJfG0C5xfpCC8UWS+z2MD3Rfq8aeRGOdkTRz2fqU=;
        b=OlYw8H/BR6j2EDgWfSe/Hr1VsX55ESIbzvAfgkeXRMiw4Wg51BqQ10SM1vYHBr19xZ
         Qf8Fl1Kyq/bXhXCcPUcImdALPwyXfj7yodQrTI1+d3/NzTGyNjyYUK35A7z3oLcRFJjT
         RS0Omv0bHrpRPC7EcApYYxQwKIE5stEZl1N53eLA7jkjWpT1B0EcitWiOokrryv55KUD
         XsjxNHed9Tu/bgZaQAC5KLW1zfQZNf+9PRivel+kVddOpn7K992OTpx7rSXvEPWFx1ev
         CkVxvntjcfUhLlSwDhho5zHb11gqqloRBZdCB3N2lvp3HkfJI61BM7NcPpoisC2A59RM
         ZrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=x10LJfG0C5xfpCC8UWS+z2MD3Rfq8aeRGOdkTRz2fqU=;
        b=LCdOynvTJ8veezppjMasYbx4bTMzoUGBYYK7vmyGOqTiJW+X9z04SnZaiHqwyMAlwV
         3kutVDg5MVP+C6HUkZkbe4i/ucswYZOy2uKzZi3jhS1/dD/NRCRtg3kg8zd7zzCDlkQY
         fvvCDD7famH5YvgtvKs6ghb21Qk4PWqUsB+drfctKxNZq5Er7rmx+UXRg57+9Pzl94BX
         fbj/ZQcg5nvYyk/8FS/C0gDokHcwaN3WqY/HWrYUAW6A8lUqvFvY7lDuwPvN0gk4EkS8
         iIrcAHM8wC0u/p0tmt57H1n1SURcdcxDsnMPldB8Zf+q01iBn95dPKcPokm7etO6imGv
         gIJg==
X-Gm-Message-State: AHQUAuaD4pmqH53XiHIwq6QnL+TMOediMTbIOgkTiDiXNaDqtquMb+ir
        20KB2gih8NydlK8FQPWXLB5vsSzCsMDuPlYQIqg=
X-Google-Smtp-Source: AHgI3IZsHLuu1XGqP7tlD952DdIbitearB3b++EW1AFbC2NdsHx7dmTXVU/ZjAy5mSot130kfjI6TmLAkG/B47ljgmQ=
X-Received: by 2002:a63:d151:: with SMTP id c17mr1594737pgj.87.1551153829952;
 Mon, 25 Feb 2019 20:03:49 -0800 (PST)
Date:   Mon, 25 Feb 2019 20:03:42 -0800
Message-Id: <20190226040345.202047-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH] lib/raid6: use vdupq_n_u8 to avoid endianness warnings
From:   ndesaulniers@google.com
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     ard.biesheuvel@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns: vector initializers are not compatible with NEON intrinsics
in big endian mode [-Wnonportable-vector-initialization]

While this is usually the case, it's not an issue for this case since
we're initializing the uint8x16_t (16x uint8_t's) with the same value.

Instead, use vdupq_n_u8 which both compilers lower into a single movi
instruction: https://godbolt.org/z/vBrgzt

This avoids the static storage for a constant value.

Link: https://github.com/ClangBuiltLinux/linux/issues/214
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 lib/raid6/neon.uc            | 5 ++---
 lib/raid6/recov_neon_inner.c | 7 ++-----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/lib/raid6/neon.uc b/lib/raid6/neon.uc
index d5242f544551..b7c68030da4f 100644
--- a/lib/raid6/neon.uc
+++ b/lib/raid6/neon.uc
@@ -28,7 +28,6 @@
 
 typedef uint8x16_t unative_t;
 
-#define NBYTES(x) ((unative_t){x,x,x,x, x,x,x,x, x,x,x,x, x,x,x,x})
 #define NSIZE	sizeof(unative_t)
 
 /*
@@ -61,7 +60,7 @@ void raid6_neon$#_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
 	int d, z, z0;
 
 	register unative_t wd$$, wq$$, wp$$, w1$$, w2$$;
-	const unative_t x1d = NBYTES(0x1d);
+	const unative_t x1d = vdupq_n_u8(0x1d);
 
 	z0 = disks - 3;		/* Highest data disk */
 	p = dptr[z0+1];		/* XOR parity */
@@ -92,7 +91,7 @@ void raid6_neon$#_xor_syndrome_real(int disks, int start, int stop,
 	int d, z, z0;
 
 	register unative_t wd$$, wq$$, wp$$, w1$$, w2$$;
-	const unative_t x1d = NBYTES(0x1d);
+	const unative_t x1d = vdupq_n_u8(0x1d);
 
 	z0 = stop;		/* P/Q right side optimization */
 	p = dptr[disks-2];	/* XOR parity */
diff --git a/lib/raid6/recov_neon_inner.c b/lib/raid6/recov_neon_inner.c
index 8cd20c9f834a..7d00c31a6547 100644
--- a/lib/raid6/recov_neon_inner.c
+++ b/lib/raid6/recov_neon_inner.c
@@ -10,11 +10,6 @@
 
 #include <arm_neon.h>
 
-static const uint8x16_t x0f = {
-	0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f,
-	0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f,
-};
-
 #ifdef CONFIG_ARM
 /*
  * AArch32 does not provide this intrinsic natively because it does not
@@ -41,6 +36,7 @@ void __raid6_2data_recov_neon(int bytes, uint8_t *p, uint8_t *q, uint8_t *dp,
 	uint8x16_t pm1 = vld1q_u8(pbmul + 16);
 	uint8x16_t qm0 = vld1q_u8(qmul);
 	uint8x16_t qm1 = vld1q_u8(qmul + 16);
+	uint8x16_t x0f = vdupq_n_u8(0x0f);
 
 	/*
 	 * while ( bytes-- ) {
@@ -87,6 +83,7 @@ void __raid6_datap_recov_neon(int bytes, uint8_t *p, uint8_t *q, uint8_t *dq,
 {
 	uint8x16_t qm0 = vld1q_u8(qmul);
 	uint8x16_t qm1 = vld1q_u8(qmul + 16);
+	uint8x16_t x0f = vdupq_n_u8(0x0f);
 
 	/*
 	 * while (bytes--) {
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

