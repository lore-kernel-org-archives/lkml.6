Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2A2C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F71208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="er0ZiGzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F71208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933176AbeGITwJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:52:09 -0400
Received: from mail.efficios.com ([167.114.142.138]:59932 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932893AbeGITwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:52:02 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C004F232616;
        Mon,  9 Jul 2018 15:52:01 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id tZMrQZyzvsY5; Mon,  9 Jul 2018 15:52:01 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 51859232609;
        Mon,  9 Jul 2018 15:52:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 51859232609
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1531165921;
        bh=odgn/Ki32hpE1ojK6TAUv30y8KdwsZfbbXSrAHaQbv8=;
        h=From:To:Date:Message-Id;
        b=er0ZiGzEz/lBPlYTCQpv5ucu0jATfzOJ1/WS9oqrWpO52ZkHPCAkwyh76B5i+QLVx
         kTbc0npQXtVfTM+4jcBNXMZWGjP8pQflDBEULI7ENZuCS6GTUObNyPjh6oj/rNO4Sa
         lz70uF4S8MN4HLq7HyRWD7qtYTXLJOtm6Ya6uuZgL8+JDpAvvtyBfIz6BdeMnbuPws
         dlIHRoeL/0LSHZtdrnjRn7vZPevK/CF7KEBl2UHo2X+FG9c8Tv9K9kpJikV8gmiR0+
         Ai8aBgqHtAWca7GAdFVkbtDeMD4+lQph3JylVzgj73DckMTsmd6SWhMmZ3wAPuxeVG
         HRqUkacLdwwzw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id uWNwrtjkNxUN; Mon,  9 Jul 2018 15:52:01 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id E7BA52325F9;
        Mon,  9 Jul 2018 15:52:00 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH for 4.18 5/6] rseq: remove unused types_32_64.h uapi header
Date:   Mon,  9 Jul 2018 15:51:54 -0400
Message-Id: <20180709195155.7654-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180709195155.7654-1-mathieu.desnoyers@efficios.com>
References: <20180709195155.7654-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header was introduced in the 4.18 merge window, and rseq does
not need it anymore. Nuke it before the final release.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Paul Turner <pjt@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andi Kleen <andi@firstfloor.org>
CC: Dave Watson <davejwatson@fb.com>
CC: Chris Lameter <cl@linux.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ben Maurer <bmaurer@fb.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: linux-api@vger.kernel.org
---
 include/uapi/linux/types_32_64.h | 50 ----------------------------------------
 1 file changed, 50 deletions(-)
 delete mode 100644 include/uapi/linux/types_32_64.h

diff --git a/include/uapi/linux/types_32_64.h b/include/uapi/linux/types_32_64.h
deleted file mode 100644
index 0a87ace34a57..000000000000
--- a/include/uapi/linux/types_32_64.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
-#ifndef _UAPI_LINUX_TYPES_32_64_H
-#define _UAPI_LINUX_TYPES_32_64_H
-
-/*
- * linux/types_32_64.h
- *
- * Integer type declaration for pointers across 32-bit and 64-bit systems.
- *
- * Copyright (c) 2015-2018 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
- */
-
-#ifdef __KERNEL__
-# include <linux/types.h>
-#else
-# include <stdint.h>
-#endif
-
-#include <asm/byteorder.h>
-
-#ifdef __BYTE_ORDER
-# if (__BYTE_ORDER == __BIG_ENDIAN)
-#  define LINUX_BYTE_ORDER_BIG_ENDIAN
-# else
-#  define LINUX_BYTE_ORDER_LITTLE_ENDIAN
-# endif
-#else
-# ifdef __BIG_ENDIAN
-#  define LINUX_BYTE_ORDER_BIG_ENDIAN
-# else
-#  define LINUX_BYTE_ORDER_LITTLE_ENDIAN
-# endif
-#endif
-
-#ifdef __LP64__
-# define LINUX_FIELD_u32_u64(field)			__u64 field
-# define LINUX_FIELD_u32_u64_INIT_ONSTACK(field, v)	field = (intptr_t)v
-#else
-# ifdef LINUX_BYTE_ORDER_BIG_ENDIAN
-#  define LINUX_FIELD_u32_u64(field)	__u32 field ## _padding, field
-#  define LINUX_FIELD_u32_u64_INIT_ONSTACK(field, v)	\
-	field ## _padding = 0, field = (intptr_t)v
-# else
-#  define LINUX_FIELD_u32_u64(field)	__u32 field, field ## _padding
-#  define LINUX_FIELD_u32_u64_INIT_ONSTACK(field, v)	\
-	field = (intptr_t)v, field ## _padding = 0
-# endif
-#endif
-
-#endif /* _UAPI_LINUX_TYPES_32_64_H */
-- 
2.11.0

