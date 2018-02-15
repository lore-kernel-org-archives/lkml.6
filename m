Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518710600-2-2824745914217963228
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710599; b=i5P/wkuE8Z7vUuAxparuoT2g/MyfrSLBIrb9uOYS2vy6cwI
    LThAVSxkhGWdmrCsvUuhy/9+1fDEyEpSRXYZqo0Z5vdbIGfiZX4vrb7KKWixfDgi
    ntzBUycp4QePLlj2hXfT+725fxxaUxu6fddIDNJejmQhidNtSBk6xiW6MUW6+bJs
    wCK/3UgRNVGq5oyM8P8BHxtjaxrAy540yTj63Lr7bYxHzuGfa/5hDDweQtW/N5VP
    70RULGf/GkPJKZvpDUsSg8JjTt5IBVxoxgsT4EpL5dSWvCSfqaB5y8wDcSAnZQSj
    45TqN23GTOYSSBeJVWCTVy675s45SPjV4TNhvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710599; bh=7eZekoUN+QK+9pok6fMrR/vgIy
    8wNet0OPks2INjT0I=; b=ABKu0olFa2vVNDkzbIA4isvGhU9YG4ZsGsKA3hZsic
    PBZ+qoYChPLeJzUlorhFM6/cfDfbuOT/WAo6mpSFLMHsSpVjegouDGBG9MHePYQh
    zUgzJ9EMOoH4C0x5vr1iaPLvn4iJoZ7TgUcAEZCTyF/AQtX+F3av1UeYEsaYMcA9
    BRWyvvftD8/NSlDUW8klOk5APTArdQSB8Ko0B3QicoqhqopJ5Yeh6Yl6KnG5esNv
    KkDj3UTqx7FFJh9HpFgz7WNXC++zWckiwJRRZPDPUuzpqVLUtJX2cjUgvj7pnd4s
    3TaVfIHQORA/nSobqBYYSH/BMlmZj3JTWOe6xal3nnkg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425132AbeBOQCn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 11:02:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35734 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424686AbeBOPqc (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:46:32 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.15 173/202] xtensa: fix futex_atomic_cmpxchg_inatomic
Date: Thu, 15 Feb 2018 16:17:53 +0100
Message-Id: <20180215151721.902899501@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit ca47480921587ae30417dd234a9f79af188e3666 upstream.

Return 0 if the operation was successful, not the userspace memory
value. Check that userspace value equals passed oldval, not itself.
Don't update *uval if the value wasn't read from userspace memory.

This fixes process hang due to infinite loop in futex_lock_pi.
It also fixes a bunch of glibc tests nptl/tst-mutexpi*.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/include/asm/futex.h |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

--- a/arch/xtensa/include/asm/futex.h
+++ b/arch/xtensa/include/asm/futex.h
@@ -92,7 +92,6 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 			      u32 oldval, u32 newval)
 {
 	int ret = 0;
-	u32 prev;
 
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
@@ -103,26 +102,24 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 
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
 
