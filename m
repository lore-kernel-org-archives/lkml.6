Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FB0C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94AB208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XYEbT49L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94AB208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932795AbeGIMsC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:48:02 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:46295 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932654AbeGIMr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:47:59 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8948C24E248F;
        Mon,  9 Jul 2018 05:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531140479; bh=ziHDFDYHe0Z2FwUlEMEpP1JMKGmT2D926phKTo+loW4=;
        h=From:To:Cc:Subject:Date:From;
        b=XYEbT49LdavnOCkLitIUjMVlSdlG03ZUOUgxdQSjuBA4gNTzkUWKWWzi3wdl2QaSA
         H0eXHX97QWRe5pqb+Di2V78mADtlvO3W9h4ZtRdrCHxlBIDy7YHvooA5iOKkcVvg+7
         Jnro+Zhh6cGz3gj2nWzPJ5JzVfgm7Sk+SyWy/FzvE9nRMamZMhNlTyL4Hu4XNEshzU
         cRPizXtQ95WGvPv7e626WQcGWnjZsCmW2K8dP9X3C2/lQnDXIO4xbhBhDjZx2Fe//h
         c191gBSnB9w2ZTMLP7ZDgtWYDBBCLTvOY5sXV38cBaIeE8CoHAXM4d6RKgqy6RVETZ
         Lly0FySu/g8pA==
Received: from abrodkin-7480l.internal.synopsys.com (unknown [10.121.8.87])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5B22F5F2C;
        Mon,  9 Jul 2018 05:47:51 -0700 (PDT)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] atomic{64}_t: Explicitly specify data storage length and alignment
Date:   Mon,  9 Jul 2018 15:47:41 +0300
Message-Id: <20180709124741.21037-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atomic instructions require data they operate on to be aligned
according to data size. I.e. 32-bit atomic values must be 32-bit
aligned while 64-bit values must be 64-bit aligned.

Otherwise even if CPU may handle not-aligend normal data access,
still atomic instructions fail and typically raise an exception
leaving us dead in the water.

This came-up during lengthly discussion here:
http://lists.infradead.org/pipermail/linux-snps-arc/2018-July/004022.html

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/atomic.h                                 | 2 +-
 include/asm-generic/atomic64.h                                | 2 +-
 include/linux/types.h                                         | 4 ++--
 tools/include/linux/types.h                                   | 2 +-
 tools/testing/selftests/futex/include/atomic.h                | 2 +-
 .../rcutorture/formal/srcu-cbmc/include/linux/types.h         | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 66d0e215a773..2ed6d7cf1407 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -267,7 +267,7 @@ ATOMIC_OPS(xor, ^=, eor)
 
 #ifndef CONFIG_GENERIC_ATOMIC64
 typedef struct {
-	long long counter;
+	u64 __aligned(8) counter;
 } atomic64_t;
 
 #define ATOMIC64_INIT(i) { (i) }
diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 8d28eb010d0d..b94b749b5952 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -13,7 +13,7 @@
 #define _ASM_GENERIC_ATOMIC64_H
 
 typedef struct {
-	long long counter;
+	u64 __aligned(8) counter;
 } atomic64_t;
 
 #define ATOMIC64_INIT(i)	{ (i) }
diff --git a/include/linux/types.h b/include/linux/types.h
index 9834e90aa010..e2f631782621 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -174,12 +174,12 @@ typedef phys_addr_t resource_size_t;
 typedef unsigned long irq_hw_number_t;
 
 typedef struct {
-	int counter;
+	u32 __aligned(4) counter;
 } atomic_t;
 
 #ifdef CONFIG_64BIT
 typedef struct {
-	long counter;
+	u64 __aligned(8) counter;
 } atomic64_t;
 #endif
 
diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index 154eb4e3ca7c..c913e26ea4eb 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -59,7 +59,7 @@ typedef __u64 __bitwise __le64;
 typedef __u64 __bitwise __be64;
 
 typedef struct {
-	int counter;
+	u32 __aligned(4) counter;
 } atomic_t;
 
 #ifndef __aligned_u64
diff --git a/tools/testing/selftests/futex/include/atomic.h b/tools/testing/selftests/futex/include/atomic.h
index f861da3e31ab..34e14295e492 100644
--- a/tools/testing/selftests/futex/include/atomic.h
+++ b/tools/testing/selftests/futex/include/atomic.h
@@ -23,7 +23,7 @@
 #define _ATOMIC_H
 
 typedef struct {
-	volatile int val;
+	volatile u32 __aligned(4) val;
 } atomic_t;
 
 #define ATOMIC_INITIALIZER { 0 }
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h
index 891ad13e95b2..32ce965187b3 100644
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h
+++ b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h
@@ -100,12 +100,12 @@ typedef phys_addr_t resource_size_t;
 typedef unsigned long irq_hw_number_t;
 
 typedef struct {
-	int counter;
+	u32 __aligned(4) counter;
 } atomic_t;
 
 #ifdef CONFIG_64BIT
 typedef struct {
-	long counter;
+	u64 __aligned(8) counter;
 } atomic64_t;
 #endif
 
-- 
2.17.1

