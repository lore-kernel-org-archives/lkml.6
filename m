Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id V8yFJJs8GVvZNQAAmS7hNA
	; Thu, 07 Jun 2018 14:09:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 859F26063F; Thu,  7 Jun 2018 14:09:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 00677607DC;
	Thu,  7 Jun 2018 14:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00677607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933153AbeFGOJ2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:09:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39233 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933003AbeFGOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:04 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0005Zl-8k; Thu, 07 Jun 2018 15:09:02 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0002ox-70; Thu, 07 Jun 2018 15:08:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Max Filippov" <jcmvbkbc@gmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.600727229@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 096/410] xtensa: fix futex_atomic_cmpxchg_inatomic
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit ca47480921587ae30417dd234a9f79af188e3666 upstream.

Return 0 if the operation was successful, not the userspace memory
value. Check that userspace value equals passed oldval, not itself.
Don't update *uval if the value wasn't read from userspace memory.

This fixes process hang due to infinite loop in futex_lock_pi.
It also fixes a bunch of glibc tests nptl/tst-mutexpi*.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/xtensa/include/asm/futex.h | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

--- a/arch/xtensa/include/asm/futex.h
+++ b/arch/xtensa/include/asm/futex.h
@@ -109,7 +109,6 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 			      u32 oldval, u32 newval)
 {
 	int ret = 0;
-	u32 prev;
 
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
@@ -120,26 +119,24 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 
 	__asm__ __volatile__ (
 	"	# futex_atomic_cmpxchg_inatomic\n"
-	"1:	l32i	%1, %3, 0\n"
-	"	mov	%0, %5\n"
-	"	wsr	%1, scompare1\n"
-	"2:	s32c1i	%0, %3, 0\n"
-	"3:\n"
+	"	wsr	%5, scompare1\n"
+	"1:	s32c1i	%1, %4, 0\n"
+	"	s32i	%1, %6, 0\n"
+	"2:\n"
 	"	.section .fixup,\"ax\"\n"
 	"	.align 4\n"
-	"4:	.long	3b\n"
-	"5:	l32r	%1, 4b\n"
-	"	movi	%0, %6\n"
+	"3:	.long	2b\n"
+	"4:	l32r	%1, 3b\n"
+	"	movi	%0, %7\n"
 	"	jx	%1\n"
 	"	.previous\n"
 	"	.section __ex_table,\"a\"\n"
-	"	.long 1b,5b,2b,5b\n"
+	"	.long 1b,4b\n"
 	"	.previous\n"
-	: "+r" (ret), "=&r" (prev), "+m" (*uaddr)
-	: "r" (uaddr), "r" (oldval), "r" (newval), "I" (-EFAULT)
+	: "+r" (ret), "+r" (newval), "+m" (*uaddr), "+m" (*uval)
+	: "r" (uaddr), "r" (oldval), "r" (uval), "I" (-EFAULT)
 	: "memory");
 
-	*uval = prev;
 	return ret;
 }
 
