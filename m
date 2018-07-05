Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6A1C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA86240EC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA86240EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754005AbeGEQlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:41:21 -0400
Received: from foss.arm.com ([217.140.101.70]:53362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753459AbeGEQlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:41:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2F561595;
        Thu,  5 Jul 2018 09:41:19 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7BBA63F5BA;
        Thu,  5 Jul 2018 09:41:16 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, will.deacon@arm.com
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, hpa@zytor.com, linuxdrivers@attotech.com,
        mark.rutland@arm.com, mingo@kernel.org, mingo@redhat.com,
        parri.andrea@gmail.com, peter@hurleysoftware.com,
        tglx@linutronix.de
Subject: [PATCHv3 02/12] atomics/x86: reduce arch_cmpxchg64*() instrumentation
Date:   Thu,  5 Jul 2018 17:40:43 +0100
Message-Id: <20180705164053.10073-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180705164053.10073-1-mark.rutland@arm.com>
References: <20180705164053.10073-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently x86's arch_cmpxchg64() and arch_cmpxchg64_local() are
instrumented twice, as they call into instrumented atomics rather than
their arch_ equivalents.

A call to cmpxchg64() results in:

  cmpxchg64()
    kasan_check_write()
    arch_cmpxchg64()
      cmpxchg()
        kasan_check_write()
        arch_cmpxchg()

Let's fix this up and call the arch_ equivalents, resulting in:

  cmpxchg64()
    kasan_check_write()
    arch_cmpxchg64()
      arch_cmpxchg()

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/x86/include/asm/cmpxchg_64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index bfca3b346c74..072e5459fe2f 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -10,13 +10,13 @@ static inline void set_64bit(volatile u64 *ptr, u64 val)
 #define arch_cmpxchg64(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg((ptr), (o), (n));					\
+	arch_cmpxchg((ptr), (o), (n));					\
 })
 
 #define arch_cmpxchg64_local(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg_local((ptr), (o), (n));					\
+	arch_cmpxchg_local((ptr), (o), (n));				\
 })
 
 #define system_has_cmpxchg_double() boot_cpu_has(X86_FEATURE_CX16)
-- 
2.11.0

