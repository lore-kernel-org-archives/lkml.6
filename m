Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A727C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99A620869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99A620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbeKLGcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:32:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49310 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729751AbeKLFsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:01 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0000l6-Kw; Sun, 11 Nov 2018 19:58:31 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0001MA-Fi; Sun, 11 Nov 2018 19:58:31 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Matthias Kaehlcke" <mka@chromium.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will.deacon@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.191103422@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 002/366] arm64: ensure extension of smp_store_release
 value
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit 994870bead4ab19087a79492400a5478e2906196 upstream.

When an inline assembly operand's type is narrower than the register it
is allocated to, the least significant bits of the register (up to the
operand type's width) are valid, and any other bits are permitted to
contain any arbitrary value. This aligns with the AAPCS64 parameter
passing rules.

Our __smp_store_release() implementation does not account for this, and
implicitly assumes that operands have been zero-extended to the width of
the type being stored to. Thus, we may store unknown values to memory
when the value type is narrower than the pointer type (e.g. when storing
a char to a long).

This patch fixes the issue by casting the value operand to the same
width as the pointer operand in all cases, which ensures that the value
is zero-extended as we expect. We use the same union trickery as
__smp_load_acquire and {READ,WRITE}_ONCE() to avoid GCC complaining that
pointers are potentially cast to narrower width integers in unreachable
paths.

A whitespace issue at the top of __smp_store_release() is also
corrected.

No changes are necessary for __smp_load_acquire(). Load instructions
implicitly clear any upper bits of the register, and the compiler will
only consider the least significant bits of the register as valid
regardless.

Fixes: 47933ad41a86 ("arch: Introduce smp_load_acquire(), smp_store_release()")
Fixes: 878a84d5a8a1 ("arm64: add missing data types in smp_load_acquire/smp_store_release")
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[bwh: The same upstream commit was already backported to 3.16, but we
 didn't have the 1-byte and 2-byte cases then so I dropped that part.
 Now that we do, pick up that part again.]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm64/include/asm/barrier.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -66,11 +66,15 @@ do {									\
 	switch (sizeof(*p)) {						\
 	case 1:								\
 		asm volatile ("stlrb %w1, %0"				\
-				: "=Q" (*p) : "r" (v) : "memory");	\
+				: "=Q" (*p)				\
+				: "r" (*(__u8 *)__u.__c)		\
+				: "memory");				\
 		break;							\
 	case 2:								\
 		asm volatile ("stlrh %w1, %0"				\
-				: "=Q" (*p) : "r" (v) : "memory");	\
+				: "=Q" (*p)				\
+				: "r" (*(__u16 *)__u.__c)		\
+				: "memory");				\
 		break;							\
 	case 4:								\
 		asm volatile ("stlr %w1, %0"				\

