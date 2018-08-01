Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8988BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D5D20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X7E/3doh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D5D20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733176AbeHAHxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:53:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38830 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbeHAHxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:53:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3-v6so10279671pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 23:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MGghIOIV/hyTL+6117zTSMqpOnIvXzxMAm/64zz6tBo=;
        b=X7E/3dohNr7yt/kDbigCkXJPGWAABx2c7zVyrDBKCbCifW/vnsOPisbPPEDWmFezpD
         RjrfzoQbMwEYAyxd1K7Ye8bnFcG2r7Tyrqq4N/1tOMYGWeVhAlbP4A4UxsP4Q2meZjOc
         1ZFDrCEpKmQZDCbIhgQ7AU+/zc7fOxSIfHK3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MGghIOIV/hyTL+6117zTSMqpOnIvXzxMAm/64zz6tBo=;
        b=Uisbes+Fq7wib1mvZ4gozbzw1c7gYZFP7uuO832DRI+cWwqGfXKXxe+fhVMeBK57VH
         KyhN0WvlxTqlgCZlwgHEqKCWtl4UyDGTvSVYBt7tJIkdLkip/+5o6o3MOKQKfMD1Oiy1
         xSfiSUZPexlZZ6DmINxN73nWUuXO7wCt2PuY20LlzzoAguPEf7LinQRMNwTg6ag5o7OK
         keUH/ZgXpNVys1cumzHENpxNauU65sMnGgOA149PMbepzqAYwejlp99rC5iwBHNY8C33
         TZoJRdnBPGE5qnLMIynul+SkW1GaVFZjdxXOZHGy8VH/1GX3gtl94W3iC9Ao2GMzcx4F
         Cnzg==
X-Gm-Message-State: AOUpUlHWZrMDbwwdxWG61gvIMxXDRTNOAuIbF8AhOxl5834A3SMr3M2N
        Pdb24miSsT9UEVp3tYbE4D2LdPmiUAA=
X-Google-Smtp-Source: AAOMgpeJ/UtY9owHVKsx3iXX1ARghSXxBUemxZDO7Rf81xMURgTu3UB8Lo6mBzgR6NHDDpudqws1Zw==
X-Received: by 2002:a62:c00c:: with SMTP id x12-v6mr25317180pff.216.1533103790984;
        Tue, 31 Jul 2018 23:09:50 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q21-v6sm28748206pfl.156.2018.07.31.23.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 23:09:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] test_overflow: Add shift overflow tests
Date:   Tue, 31 Jul 2018 23:09:46 -0700
Message-Id: <20180801060947.16670-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801060947.16670-1-keescook@chromium.org>
References: <20180801060947.16670-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds overflow tests for the new check_shift_overflow() helper to
validate overflow, signedness glitches, storage glitches, etc.

Co-developed-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/test_overflow.c | 198 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 197 insertions(+), 1 deletion(-)

diff --git a/lib/test_overflow.c b/lib/test_overflow.c
index 2278fe05a1b0..945e11a206b3 100644
--- a/lib/test_overflow.c
+++ b/lib/test_overflow.c
@@ -252,7 +252,8 @@ static int __init test_ ## t ## _overflow(void) {			\
 	int err = 0;							\
 	unsigned i;							\
 									\
-	pr_info("%-3s: %zu tests\n", #t, ARRAY_SIZE(t ## _tests));	\
+	pr_info("%-3s: %zu arithmetic tests\n", #t,			\
+		ARRAY_SIZE(t ## _tests));				\
 	for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)			\
 		err |= do_test_ ## t(&t ## _tests[i]);			\
 	return err;							\
@@ -287,6 +288,200 @@ static int __init test_overflow_calculation(void)
 	return err;
 }
 
+static int __init test_overflow_shift(void)
+{
+	int err = 0;
+
+/* Args are: value, shift, type, expected result, overflow expected */
+#define TEST_ONE_SHIFT(a, s, t, expect, of) ({				\
+	int __failed = 0;						\
+	typeof(a) __a = (a);						\
+	typeof(s) __s = (s);						\
+	t __e = (expect);						\
+	t __d;								\
+	bool __of = check_shift_overflow(__a, __s, &__d);		\
+	if (__of != of) {						\
+		pr_warn("expected (%s)(%s << %s) to%s overflow\n",	\
+			#t, #a, #s, of ? "" : " not");			\
+		__failed = 1;						\
+	} else if (!__of && __d != __e) {				\
+		pr_warn("expected (%s)(%s << %s) == %s\n",		\
+			#t, #a, #s, #expect);				\
+		if ((t)-1 < 0)						\
+			pr_warn("got %lld\n", (s64)__d);		\
+		else							\
+			pr_warn("got %llu\n", (u64)__d);		\
+		__failed = 1;						\
+	}								\
+	if (!__failed)							\
+		pr_info("ok: (%s)(%s << %s) == %s\n", #t, #a, #s,	\
+			of ? "overflow" : #expect);			\
+	__failed;							\
+})
+
+	/* Sane shifts. */
+	err |= TEST_ONE_SHIFT(1, 0, u8, 1 << 0, false);
+	err |= TEST_ONE_SHIFT(1, 4, u8, 1 << 4, false);
+	err |= TEST_ONE_SHIFT(1, 7, u8, 1 << 7, false);
+	err |= TEST_ONE_SHIFT(0xF, 4, u8, 0xF << 4, false);
+	err |= TEST_ONE_SHIFT(1, 0, u16, 1 << 0, false);
+	err |= TEST_ONE_SHIFT(1, 10, u16, 1 << 10, false);
+	err |= TEST_ONE_SHIFT(1, 15, u16, 1 << 15, false);
+	err |= TEST_ONE_SHIFT(0xFF, 8, u16, 0xFF << 8, false);
+	err |= TEST_ONE_SHIFT(1, 0, int, 1 << 0, false);
+	err |= TEST_ONE_SHIFT(1, 16, int, 1 << 16, false);
+	err |= TEST_ONE_SHIFT(1, 30, int, 1 << 30, false);
+	err |= TEST_ONE_SHIFT(1, 0, s32, 1 << 0, false);
+	err |= TEST_ONE_SHIFT(1, 16, s32, 1 << 16, false);
+	err |= TEST_ONE_SHIFT(1, 30, s32, 1 << 30, false);
+	err |= TEST_ONE_SHIFT(1, 0, unsigned int, 1U << 0, false);
+	err |= TEST_ONE_SHIFT(1, 20, unsigned int, 1U << 20, false);
+	err |= TEST_ONE_SHIFT(1, 31, unsigned int, 1U << 31, false);
+	err |= TEST_ONE_SHIFT(0xFFFFU, 16, unsigned int, 0xFFFFU << 16, false);
+	err |= TEST_ONE_SHIFT(1, 0, u32, 1U << 0, false);
+	err |= TEST_ONE_SHIFT(1, 20, u32, 1U << 20, false);
+	err |= TEST_ONE_SHIFT(1, 31, u32, 1U << 31, false);
+	err |= TEST_ONE_SHIFT(0xFFFFU, 16, u32, 0xFFFFU << 16, false);
+	err |= TEST_ONE_SHIFT(1, 0, u64, 1ULL << 0, false);
+	err |= TEST_ONE_SHIFT(1, 40, u64, 1ULL << 40, false);
+	err |= TEST_ONE_SHIFT(1, 63, u64, 1ULL << 63, false);
+	err |= TEST_ONE_SHIFT(0xFFFFFFFFULL, 32, u64,
+			      0xFFFFFFFFULL << 32, false);
+
+	/* Sane shift: start and end with 0, without a too-wide shift. */
+	err |= TEST_ONE_SHIFT(0, 7, u8, 0, false);
+	err |= TEST_ONE_SHIFT(0, 15, u16, 0, false);
+	err |= TEST_ONE_SHIFT(0, 31, unsigned int, 0, false);
+	err |= TEST_ONE_SHIFT(0, 31, u32, 0, false);
+	err |= TEST_ONE_SHIFT(0, 63, u64, 0, false);
+
+	/* Sane shift: start and end with 0, without reaching signed bit. */
+	err |= TEST_ONE_SHIFT(0, 6, s8, 0, false);
+	err |= TEST_ONE_SHIFT(0, 14, s16, 0, false);
+	err |= TEST_ONE_SHIFT(0, 30, int, 0, false);
+	err |= TEST_ONE_SHIFT(0, 30, s32, 0, false);
+	err |= TEST_ONE_SHIFT(0, 62, s64, 0, false);
+
+	/* Overflow: shifted the bit off the end. */
+	err |= TEST_ONE_SHIFT(1, 8, u8, 0, true);
+	err |= TEST_ONE_SHIFT(1, 16, u16, 0, true);
+	err |= TEST_ONE_SHIFT(1, 32, unsigned int, 0, true);
+	err |= TEST_ONE_SHIFT(1, 32, u32, 0, true);
+	err |= TEST_ONE_SHIFT(1, 64, u64, 0, true);
+
+	/* Overflow: shifted into the signed bit. */
+	err |= TEST_ONE_SHIFT(1, 7, s8, 0, true);
+	err |= TEST_ONE_SHIFT(1, 15, s16, 0, true);
+	err |= TEST_ONE_SHIFT(1, 31, int, 0, true);
+	err |= TEST_ONE_SHIFT(1, 31, s32, 0, true);
+	err |= TEST_ONE_SHIFT(1, 63, s64, 0, true);
+
+	/* Overflow: high bit falls off unsigned types. */
+	/* 10010110 */
+	err |= TEST_ONE_SHIFT(150, 1, u8, 0, true);
+	/* 1000100010010110 */
+	err |= TEST_ONE_SHIFT(34966, 1, u16, 0, true);
+	/* 10000100000010001000100010010110 */
+	err |= TEST_ONE_SHIFT(2215151766U, 1, u32, 0, true);
+	err |= TEST_ONE_SHIFT(2215151766U, 1, unsigned int, 0, true);
+	/* 1000001000010000010000000100000010000100000010001000100010010110 */
+	err |= TEST_ONE_SHIFT(9372061470395238550ULL, 1, u64, 0, true);
+
+	/* Overflow: bit shifted into signed bit on signed types. */
+	/* 01001011 */
+	err |= TEST_ONE_SHIFT(75, 1, s8, 0, true);
+	/* 0100010001001011 */
+	err |= TEST_ONE_SHIFT(17483, 1, s16, 0, true);
+	/* 01000010000001000100010001001011 */
+	err |= TEST_ONE_SHIFT(1107575883, 1, s32, 0, true);
+	err |= TEST_ONE_SHIFT(1107575883, 1, int, 0, true);
+	/* 0100000100001000001000000010000001000010000001000100010001001011 */
+	err |= TEST_ONE_SHIFT(4686030735197619275LL, 1, s64, 0, true);
+
+	/* Overflow: bit shifted past signed bit on signed types. */
+	/* 01001011 */
+	err |= TEST_ONE_SHIFT(75, 2, s8, 0, true);
+	/* 0100010001001011 */
+	err |= TEST_ONE_SHIFT(17483, 2, s16, 0, true);
+	/* 01000010000001000100010001001011 */
+	err |= TEST_ONE_SHIFT(1107575883, 2, s32, 0, true);
+	err |= TEST_ONE_SHIFT(1107575883, 2, int, 0, true);
+	/* 0100000100001000001000000010000001000010000001000100010001001011 */
+	err |= TEST_ONE_SHIFT(4686030735197619275LL, 2, s64, 0, true);
+
+	/* Overflow: values larger than destination type. */
+	err |= TEST_ONE_SHIFT(0x100, 0, u8, 0, true);
+	err |= TEST_ONE_SHIFT(0xFF, 0, s8, 0, true);
+	err |= TEST_ONE_SHIFT(0x10000U, 0, u16, 0, true);
+	err |= TEST_ONE_SHIFT(0xFFFFU, 0, s16, 0, true);
+	err |= TEST_ONE_SHIFT(0x100000000ULL, 0, u32, 0, true);
+	err |= TEST_ONE_SHIFT(0x100000000ULL, 0, unsigned int, 0, true);
+	err |= TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, s32, 0, true);
+	err |= TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, int, 0, true);
+	err |= TEST_ONE_SHIFT(0xFFFFFFFFFFFFFFFFULL, 0, s64, 0, true);
+
+	/* Nonsense: negative initial value. */
+	err |= TEST_ONE_SHIFT(-1, 0, s8, 0, true);
+	err |= TEST_ONE_SHIFT(-1, 0, u8, 0, true);
+	err |= TEST_ONE_SHIFT(-5, 0, s16, 0, true);
+	err |= TEST_ONE_SHIFT(-5, 0, u16, 0, true);
+	err |= TEST_ONE_SHIFT(-10, 0, int, 0, true);
+	err |= TEST_ONE_SHIFT(-10, 0, unsigned int, 0, true);
+	err |= TEST_ONE_SHIFT(-100, 0, s32, 0, true);
+	err |= TEST_ONE_SHIFT(-100, 0, u32, 0, true);
+	err |= TEST_ONE_SHIFT(-10000, 0, s64, 0, true);
+	err |= TEST_ONE_SHIFT(-10000, 0, u64, 0, true);
+
+	/* Nonsense: negative shift values. */
+	err |= TEST_ONE_SHIFT(0, -5, s8, 0, true);
+	err |= TEST_ONE_SHIFT(0, -5, u8, 0, true);
+	err |= TEST_ONE_SHIFT(0, -10, s16, 0, true);
+	err |= TEST_ONE_SHIFT(0, -10, u16, 0, true);
+	err |= TEST_ONE_SHIFT(0, -15, int, 0, true);
+	err |= TEST_ONE_SHIFT(0, -15, unsigned int, 0, true);
+	err |= TEST_ONE_SHIFT(0, -20, s32, 0, true);
+	err |= TEST_ONE_SHIFT(0, -20, u32, 0, true);
+	err |= TEST_ONE_SHIFT(0, -30, s64, 0, true);
+	err |= TEST_ONE_SHIFT(0, -30, u64, 0, true);
+
+	/* Overflow: shifted at or beyond entire type's bit width. */
+	err |= TEST_ONE_SHIFT(0, 8, u8, 0, true);
+	err |= TEST_ONE_SHIFT(0, 9, u8, 0, true);
+	err |= TEST_ONE_SHIFT(0, 8, s8, 0, true);
+	err |= TEST_ONE_SHIFT(0, 9, s8, 0, true);
+	err |= TEST_ONE_SHIFT(0, 16, u16, 0, true);
+	err |= TEST_ONE_SHIFT(0, 17, u16, 0, true);
+	err |= TEST_ONE_SHIFT(0, 16, s16, 0, true);
+	err |= TEST_ONE_SHIFT(0, 17, s16, 0, true);
+	err |= TEST_ONE_SHIFT(0, 32, u32, 0, true);
+	err |= TEST_ONE_SHIFT(0, 33, u32, 0, true);
+	err |= TEST_ONE_SHIFT(0, 32, int, 0, true);
+	err |= TEST_ONE_SHIFT(0, 33, int, 0, true);
+	err |= TEST_ONE_SHIFT(0, 32, s32, 0, true);
+	err |= TEST_ONE_SHIFT(0, 33, s32, 0, true);
+	err |= TEST_ONE_SHIFT(0, 64, u64, 0, true);
+	err |= TEST_ONE_SHIFT(0, 65, u64, 0, true);
+	err |= TEST_ONE_SHIFT(0, 64, s64, 0, true);
+	err |= TEST_ONE_SHIFT(0, 65, s64, 0, true);
+
+	/*
+	 * Corner case: for unsigned types, we fail when we've shifted
+	 * through the entire width of bits. For signed types, we might
+	 * want to match this behavior, but that would mean noticing if
+	 * we shift through all but the signed bit, and this is not
+	 * currently detected (but we'll notice an overflow into the
+	 * signed bit). So, for now, we will test this condition but
+	 * mark it as not expected to overflow.
+	 */
+	err |= TEST_ONE_SHIFT(0, 7, s8, 0, false);
+	err |= TEST_ONE_SHIFT(0, 15, s16, 0, false);
+	err |= TEST_ONE_SHIFT(0, 31, int, 0, false);
+	err |= TEST_ONE_SHIFT(0, 31, s32, 0, false);
+	err |= TEST_ONE_SHIFT(0, 63, s64, 0, false);
+
+	return err;
+}
+
 /*
  * Deal with the various forms of allocator arguments. See comments above
  * the DEFINE_TEST_ALLOC() instances for mapping of the "bits".
@@ -397,6 +592,7 @@ static int __init test_module_init(void)
 	int err = 0;
 
 	err |= test_overflow_calculation();
+	err |= test_overflow_shift();
 	err |= test_overflow_allocation();
 
 	if (err) {
-- 
2.17.1

