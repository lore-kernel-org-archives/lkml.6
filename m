Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18A9C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D8B20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D8B20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbeGYPq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:46:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58323 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbeGYPq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:46:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEY3ga403319
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:34:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEY32x403316;
        Wed, 25 Jul 2018 07:34:03 -0700
Date:   Wed, 25 Jul 2018 07:34:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-00d5551cc4eec0fc39c3871c25c613553acfb866@git.kernel.org>
Cc:     boqun.feng@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        mark.rutland@arm.com, will.deacon@arm.com, peterz@infradead.org,
        mingo@kernel.org, dvyukov@google.com, hpa@zytor.com
Reply-To: mark.rutland@arm.com, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          boqun.feng@gmail.com, will.deacon@arm.com, peterz@infradead.org,
          hpa@zytor.com, mingo@kernel.org, dvyukov@google.com
In-Reply-To: <20180716113017.3909-3-mark.rutland@arm.com>
References: <20180716113017.3909-3-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomics/x86: Reduce arch_cmpxchg64*()
 instrumentation
Git-Commit-ID: 00d5551cc4eec0fc39c3871c25c613553acfb866
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  00d5551cc4eec0fc39c3871c25c613553acfb866
Gitweb:     https://git.kernel.org/tip/00d5551cc4eec0fc39c3871c25c613553acfb866
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Mon, 16 Jul 2018 12:30:07 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:53:58 +0200

locking/atomics/x86: Reduce arch_cmpxchg64*() instrumentation

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
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: andy.shevchenko@gmail.com
Cc: arnd@arndb.de
Cc: aryabinin@virtuozzo.com
Cc: catalin.marinas@arm.com
Cc: glider@google.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: parri.andrea@gmail.com
Cc: peter@hurleysoftware.com
Link: http://lkml.kernel.org/r/20180716113017.3909-3-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
