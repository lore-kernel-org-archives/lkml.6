Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165939AbeE1OpI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161079AbeE1KaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:30:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 089/329] arm64: spinlock: Fix theoretical trylock() A-B-A with LSE atomics
Date: Mon, 28 May 2018 12:00:18 +0200
Message-Id: <20180528100250.166780224@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 202fb4ef81e3ec765c23bd1e6746a5c25b797d0e ]

If the spinlock "next" ticket wraps around between the initial LDR
and the cmpxchg in the LSE version of spin_trylock, then we can erroneously
think that we have successfuly acquired the lock because we only check
whether the next ticket return by the cmpxchg is equal to the owner ticket
in our updated lock word.

This patch fixes the issue by performing a full 32-bit check of the lock
word when trying to determine whether or not the CASA instruction updated
memory.

Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/spinlock.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -141,8 +141,8 @@ static inline int arch_spin_trylock(arch
 	"	cbnz	%w1, 1f\n"
 	"	add	%w1, %w0, %3\n"
 	"	casa	%w0, %w1, %2\n"
-	"	and	%w1, %w1, #0xffff\n"
-	"	eor	%w1, %w1, %w0, lsr #16\n"
+	"	sub	%w1, %w1, %3\n"
+	"	eor	%w1, %w1, %w0\n"
 	"1:")
 	: "=&r" (lockval), "=&r" (tmp), "+Q" (*lock)
 	: "I" (1 << TICKET_SHIFT)
