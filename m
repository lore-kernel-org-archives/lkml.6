Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA22C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BEE2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297831;
	bh=n9t7cg+X3JarOsaclcYrd60U1x4swDslXbYHiXF8pgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lc64gIi/t5/6vz0Rg+T4xtnqrj02X7EkefvxwZHfwpl1oK5tuI3r5BQoEd/ew9bph
	 DZqQnocWwkkAEvjAVeyVDTVh5N7i0ww4AZAP8kcrNWq0S3P418JghwqA3ZNVPBhBNR
	 4IXtc8RjViYQaOi5c/f9cm1AcTZTKm012Qu59Fa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbeLTJXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:23:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731657AbeLTJXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:23:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 995FA218AE;
        Thu, 20 Dec 2018 09:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297822;
        bh=n9t7cg+X3JarOsaclcYrd60U1x4swDslXbYHiXF8pgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gj18UpwH8Ypuhz7jWAa88jiW0Bcdg77kaPZVPPwNPBNrmvcczfcEInucc4yoX/pWU
         9k3zR54wYd8eG9vP7u8W1LGC7lKUjaoRFgHbCy2XRU1EDQrA82jGo59XEKIQysEC7q
         efPKdGC0lRvEeG1CvxoJnTZmniU71eeGpLmuK5n4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 30/61] locking/qspinlock: Fix build for anonymous union in older GCC compilers
Date:   Thu, 20 Dec 2018 10:18:30 +0100
Message-Id: <20181220085844.938717308@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6cc65be4f6f2a7186af8f3e09900787c7912dad2 ]

One of my tests compiles the kernel with gcc 4.5.3, and I hit the
following build error:

  include/linux/semaphore.h: In function 'sema_init':
  include/linux/semaphore.h:35:17: error: unknown field 'val' specified in initializer
  include/linux/semaphore.h:35:17: warning: missing braces around initializer
  include/linux/semaphore.h:35:17: warning: (near initialization for '(anonymous).raw_lock.<anonymous>.val')

I bisected it down to:

 625e88be1f41 ("locking/qspinlock: Merge 'struct __qspinlock' into 'struct qspinlock'")

... which makes qspinlock have an anonymous union, which makes initializing it special
for older compilers. By adding strategic brackets, it makes the build
happy again.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: 625e88be1f41 ("locking/qspinlock: Merge 'struct __qspinlock' into 'struct qspinlock'")
Link: http://lkml.kernel.org/r/20180621203526.172ab5c4@vmware.local.home
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/qspinlock_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index 0763f065b975..d10f1e7d6ba8 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -63,7 +63,7 @@ typedef struct qspinlock {
 /*
  * Initializier
  */
-#define	__ARCH_SPIN_LOCK_UNLOCKED	{ .val = ATOMIC_INIT(0) }
+#define	__ARCH_SPIN_LOCK_UNLOCKED	{ { .val = ATOMIC_INIT(0) } }
 
 /*
  * Bitfields in the atomic value:
-- 
2.19.1



