Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A589C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4869921479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4869921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbeKUUpS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:45:18 -0500
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:54581 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKUUpR (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Wed, 21 Nov 2018 15:45:17 -0500
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Wed, 21 Nov 2018 03:11:28 -0700
Message-Id: <5BF52F4D02000078001FE5C1@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Wed, 21 Nov 2018 03:11:25 -0700
From:   "Jan Beulich" <JBeulich@suse.com>
To:     <mingo@elte.hu>, <tglx@linutronix.de>, <hpa@zytor.com>
Cc:     "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] x86: modernize sync_bitops.h
References: <5B30C2C302000078001CD6D1@prv1-mh.provo.novell.com>
 <5B30C2C302000000000FA99B@prv1-mh.provo.novell.com>
 <5B30C2C302000078001FE5A0@prv1-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing insn suffixes and use rmwcc.h just like was (more or less)
recently done for bitops.h as well.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
v2: Re-base over rmwcc.h changes.
---
 arch/x86/include/asm/sync_bitops.h |   31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

--- 4.20-rc3/arch/x86/include/asm/sync_bitops.h
+++ 4.20-rc3-x86-sync-bitops-insn-suffixes/arch/x86/include/asm/sync_bitops.h
@@ -14,6 +14,8 @@
  * bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
  */
 
+#include <asm/rmwcc.h>
+
 #define ADDR (*(volatile long *)addr)
 
 /**
@@ -29,7 +31,7 @@
  */
 static inline void sync_set_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("lock; bts %1,%0"
+	asm volatile("lock; " __ASM_SIZE(bts) " %1,%0"
 		     : "+m" (ADDR)
 		     : "Ir" (nr)
 		     : "memory");
@@ -47,7 +49,7 @@ static inline void sync_set_bit(long nr,
  */
 static inline void sync_clear_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("lock; btr %1,%0"
+	asm volatile("lock; " __ASM_SIZE(btr) " %1,%0"
 		     : "+m" (ADDR)
 		     : "Ir" (nr)
 		     : "memory");
@@ -64,7 +66,7 @@ static inline void sync_clear_bit(long n
  */
 static inline void sync_change_bit(long nr, volatile unsigned long *addr)
 {
-	asm volatile("lock; btc %1,%0"
+	asm volatile("lock; " __ASM_SIZE(btc) " %1,%0"
 		     : "+m" (ADDR)
 		     : "Ir" (nr)
 		     : "memory");
@@ -78,14 +80,9 @@ static inline void sync_change_bit(long
  * This operation is atomic and cannot be reordered.
  * It also implies a memory barrier.
  */
-static inline int sync_test_and_set_bit(long nr, volatile unsigned long *addr)
+static inline bool sync_test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	unsigned char oldbit;
-
-	asm volatile("lock; bts %2,%1\n\tsetc %0"
-		     : "=qm" (oldbit), "+m" (ADDR)
-		     : "Ir" (nr) : "memory");
-	return oldbit;
+	return GEN_BINARY_RMWcc("lock; " __ASM_SIZE(bts), *addr, c, "Ir", nr);
 }
 
 /**
@@ -98,12 +95,7 @@ static inline int sync_test_and_set_bit(
  */
 static inline int sync_test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	unsigned char oldbit;
-
-	asm volatile("lock; btr %2,%1\n\tsetc %0"
-		     : "=qm" (oldbit), "+m" (ADDR)
-		     : "Ir" (nr) : "memory");
-	return oldbit;
+	return GEN_BINARY_RMWcc("lock; " __ASM_SIZE(btr), *addr, c, "Ir", nr);
 }
 
 /**
@@ -116,12 +108,7 @@ static inline int sync_test_and_clear_bi
  */
 static inline int sync_test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	unsigned char oldbit;
-
-	asm volatile("lock; btc %2,%1\n\tsetc %0"
-		     : "=qm" (oldbit), "+m" (ADDR)
-		     : "Ir" (nr) : "memory");
-	return oldbit;
+	return GEN_BINARY_RMWcc("lock; " __ASM_SIZE(btc), *addr, c, "Ir", nr);
 }
 
 #define sync_test_bit(nr, addr) test_bit(nr, addr)



