Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914BDC46465
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C01520894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CndNQqkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C01520894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732884AbeHABne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 21:43:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35941 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732852AbeHABnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 21:43:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so1687860pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 17:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6X4NL+xZ68781bFDu+c8qxX3R+MWFhAGmxNAPuvdkgs=;
        b=CndNQqkBdadBvDf121EyHrYcVvrn/ZTCMDustDWpCkrnqLmHlWesI6rTbtB6UcOW/I
         65+CCdsVFgHghaK9tyy+7cPTjJZx7PGP8t5OL0snPrN95rmFNaidutd0CYB3yvOuRqO2
         uHuN2qCmHBGzgybudzjPi6ePm5WNZWVyIBY1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6X4NL+xZ68781bFDu+c8qxX3R+MWFhAGmxNAPuvdkgs=;
        b=Prj9YNuDP0OeMN0k8Sy/HaTF3HvDTGAF9TsxiXfBQ3vlwL/1/UT0Sj5VVPA/r8HZIC
         TNpeMCBOkZEJJWl3homqTO8zUOXypLnIifmtWBm+i8iyb2gCEmWb0fGOb/rEFIYmSaRc
         9K+k9mZM31S6da2T59IDr0DEN/BFULmHwJOSrRwBfzmrd6d2fRVIRsFtG+r0vFG2xrnw
         3iNrwtaXUo04jhCn5ATGT+AlLM54raHdIC7x3BgGxtcev59EFNcnM4lX4BAbBrCYdfVw
         M158O5bWRp1VkMhOfy0tlm4OevymlA7f7ELRDfFQXwDQBY5i17rMPxt2Q9MkV1KRuXaM
         Of3g==
X-Gm-Message-State: AOUpUlGDuK1Q9UkvInHfC2VaoTISiY8I9BZdmpQy/1yap2+ojyBRMfpP
        1axV8mC/7EGonPJB0RSUdD/aRA==
X-Google-Smtp-Source: AAOMgpevOnIqcRNiiGl3iwXRBWwKM2xz+Fo3WnMG4xsY157iph1OxjXKmgk2DU89ifjU8jSQSynRaw==
X-Received: by 2002:a63:5fc1:: with SMTP id t184-v6mr21605937pgb.183.1533081646338;
        Tue, 31 Jul 2018 17:00:46 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id p66-v6sm27517848pfd.65.2018.07.31.17.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 17:00:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] test_overflow: Add shift overflow tests
Date:   Tue, 31 Jul 2018 17:00:38 -0700
Message-Id: <20180801000039.44314-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801000039.44314-1-keescook@chromium.org>
References: <20180801000039.44314-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds overflow tests for the new check_shift_overflow() helper to
validate overflow, signedness glitches, storage glitches, etc.

Co-developed-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/test_overflow.c | 140 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 1 deletion(-)

diff --git a/lib/test_overflow.c b/lib/test_overflow.c
index 2278fe05a1b0..face66e8aa37 100644
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
@@ -287,6 +288,142 @@ static int __init test_overflow_calculation(void)
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
+	/* Sane shifts */
+	err |= TEST_ONE_SHIFT(1, 4, u8, 1 << 4, false);
+	err |= TEST_ONE_SHIFT(1, 7, u8, 1 << 7, false);
+	err |= TEST_ONE_SHIFT(1, 10, u16, 1 << 10, false);
+	err |= TEST_ONE_SHIFT(1, 15, u16, 1 << 15, false);
+	err |= TEST_ONE_SHIFT(1, 30, int, 1 << 30, false);
+	err |= TEST_ONE_SHIFT(1, 30, s32, 1 << 30, false);
+	err |= TEST_ONE_SHIFT(1, 20, unsigned int, 1U << 20, false);
+	err |= TEST_ONE_SHIFT(1, 31, unsigned int, 1U << 31, false);
+	err |= TEST_ONE_SHIFT(1, 20, u32, 1U << 20, false);
+	err |= TEST_ONE_SHIFT(1, 31, u32, 1U << 31, false);
+	err |= TEST_ONE_SHIFT(1, 40, u64, 1ULL << 40, false);
+	err |= TEST_ONE_SHIFT(1, 63, u64, 1ULL << 63, false);
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
+	/* Overflow: high bit falls off. */
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
+	/* Nonsense: negative initial value. */
+	err |= TEST_ONE_SHIFT(-1, 0, s8, 0, true);
+	err |= TEST_ONE_SHIFT(-5, 0, s16, 0, true);
+	err |= TEST_ONE_SHIFT(-10, 0, int, 0, true);
+	err |= TEST_ONE_SHIFT(-100, 0, s32, 0, true);
+	err |= TEST_ONE_SHIFT(-10000, 0, s64, 0, true);
+
+	/* Nonsense: negative shift values. */
+	err |= TEST_ONE_SHIFT(0, -5, s8, 0, true);
+	err |= TEST_ONE_SHIFT(0, -10, s16, 0, true);
+	err |= TEST_ONE_SHIFT(0, -15, int, 0, true);
+	err |= TEST_ONE_SHIFT(0, -20, s32, 0, true);
+	err |= TEST_ONE_SHIFT(0, -30, s64, 0, true);
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
+	/* Overflow: shifted into signed bit. */
+	err |= TEST_ONE_SHIFT(1, 7, s8, 0, true);
+	err |= TEST_ONE_SHIFT(1, 15, s16, 0, true);
+	err |= TEST_ONE_SHIFT(1, 31, int, 0, true);
+	err |= TEST_ONE_SHIFT(1, 31, s32, 0, true);
+	err |= TEST_ONE_SHIFT(1, 63, s64, 0, true);
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
@@ -397,6 +534,7 @@ static int __init test_module_init(void)
 	int err = 0;
 
 	err |= test_overflow_calculation();
+	err |= test_overflow_shift();
 	err |= test_overflow_allocation();
 
 	if (err) {
-- 
2.17.1

