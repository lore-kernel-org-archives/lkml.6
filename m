Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B12C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA7220871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA7220871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbeKLGcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:32:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49302 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729749AbeKLFsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:01 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0000l5-Jg; Sun, 11 Nov 2018 19:58:31 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0001M6-Ed; Sun, 11 Nov 2018 19:58:31 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Andre Przywara" <andre.przywara@arm.com>,
        "Will Deacon" <will.deacon@arm.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.408140341@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 001/366] arm64: add missing data types in
 smp_load_acquire/smp_store_release
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

From: Andre Przywara <andre.przywara@arm.com>

commit 878a84d5a8a18a4ab241d40cebb791d6aedf5605 upstream.

Commit 8053871d0f7f ("smp: Fix smp_call_function_single_async()
locking") introduced a call to smp_load_acquire() with a u16 argument,
but we only cared about u32 and u64 types in that function so far.
This resulted in a compiler warning fortunately, pointing at an
uninitialized use. Due to the implementation structure the compiler
misses that bug in the smp_store_release(), though.
Add the u16 and u8 variants using ldarh/stlrh and ldarb/stlrb,
respectively. Together with the compiletime_assert_atomic_type() check
this should cover all cases now.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm64/include/asm/barrier.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -64,6 +64,14 @@ do {									\
 		{ .__val = (__force typeof(*p)) (v) }; 			\
 	compiletime_assert_atomic_type(*p);				\
 	switch (sizeof(*p)) {						\
+	case 1:								\
+		asm volatile ("stlrb %w1, %0"				\
+				: "=Q" (*p) : "r" (v) : "memory");	\
+		break;							\
+	case 2:								\
+		asm volatile ("stlrh %w1, %0"				\
+				: "=Q" (*p) : "r" (v) : "memory");	\
+		break;							\
 	case 4:								\
 		asm volatile ("stlr %w1, %0"				\
 				: "=Q" (*p)				\
@@ -84,6 +92,14 @@ do {									\
 	typeof(*p) ___p1;						\
 	compiletime_assert_atomic_type(*p);				\
 	switch (sizeof(*p)) {						\
+	case 1:								\
+		asm volatile ("ldarb %w0, %1"				\
+			: "=r" (___p1) : "Q" (*p) : "memory");		\
+		break;							\
+	case 2:								\
+		asm volatile ("ldarh %w0, %1"				\
+			: "=r" (___p1) : "Q" (*p) : "memory");		\
+		break;							\
 	case 4:								\
 		asm volatile ("ldar %w0, %1"				\
 			: "=r" (___p1) : "Q" (*p) : "memory");		\

