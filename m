Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B63FC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A09E20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A09E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeJNXlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:41:00 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35905 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727430AbeJNXLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:50 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLe-0004cU-1M; Sun, 14 Oct 2018 16:30:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0000mz-No; Sun, 14 Oct 2018 16:30:27 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Laura Abbott" <labbott@redhat.com>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
        "John Stultz" <john.stultz@linaro.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.640491065@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 366/366] give up on gcc ilog2() constant optimizations
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 474c90156c8dcc2fa815e6716cc9394d7930cb9c upstream.

gcc-7 has an "optimization" pass that completely screws up, and
generates the code expansion for the (impossible) case of calling
ilog2() with a zero constant, even when the code gcc compiles does not
actually have a zero constant.

And we try to generate a compile-time error for anybody doing ilog2() on
a constant where that doesn't make sense (be it zero or negative).  So
now gcc7 will fail the build due to our sanity checking, because it
created that constant-zero case that didn't actually exist in the source
code.

There's a whole long discussion on the kernel mailing about how to work
around this gcc bug.  The gcc people themselevs have discussed their
"feature" in

   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=72785

but it's all water under the bridge, because while it looked at one
point like it would be solved by the time gcc7 was released, that was
not to be.

So now we have to deal with this compiler braindamage.

And the only simple approach seems to be to just delete the code that
tries to warn about bad uses of ilog2().

So now "ilog2()" will just return 0 not just for the value 1, but for
any non-positive value too.

It's not like I can recall anybody having ever actually tried to use
this function on any invalid value, but maybe the sanity check just
meant that such code never made it out in public.

Reported-by: Laura Abbott <labbott@redhat.com>
Cc: John Stultz <john.stultz@linaro.org>,
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: There's only one log2.h file]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -16,12 +16,6 @@
 #include <linux/bitops.h>
 
 /*
- * deal with unrepresentable constant logarithms
- */
-extern __attribute__((const, noreturn))
-int ____ilog2_NaN(void);
-
-/*
  * non-constant log of base 2 calculators
  * - the arch may override these in asm/bitops.h if they can be implemented
  *   more efficiently than using fls() and fls64()
@@ -85,7 +79,7 @@ unsigned long __rounddown_pow_of_two(uns
 #define ilog2(n)				\
 (						\
 	__builtin_constant_p(n) ? (		\
-		(n) < 1 ? ____ilog2_NaN() :	\
+		(n) < 2 ? 0 :			\
 		(n) & (1ULL << 63) ? 63 :	\
 		(n) & (1ULL << 62) ? 62 :	\
 		(n) & (1ULL << 61) ? 61 :	\
@@ -148,10 +142,7 @@ unsigned long __rounddown_pow_of_two(uns
 		(n) & (1ULL <<  4) ?  4 :	\
 		(n) & (1ULL <<  3) ?  3 :	\
 		(n) & (1ULL <<  2) ?  2 :	\
-		(n) & (1ULL <<  1) ?  1 :	\
-		(n) & (1ULL <<  0) ?  0 :	\
-		____ilog2_NaN()			\
-				   ) :		\
+		1 ) :				\
 	(sizeof(n) <= 4) ?			\
 	__ilog2_u32(n) :			\
 	__ilog2_u64(n)				\

