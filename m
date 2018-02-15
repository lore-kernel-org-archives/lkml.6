Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825685-1518708742-2-7547495625022063095
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518708741; b=uqHAkkcFNKRQFEwQtIzMEvSuTp/EiawtNV0tI7goOaQhQ/a
    cKoc19htJh0PvWf13XZ0OS0qVpl0WwKOd8X/jykyX4lhx9NK0xkBmj6q2bXjSueu
    8uXTa8FQtW8uqScCMfDJyvAbyDcoaBCMM2FsyezWvq80/5DGwOdvEnX6KHdK3Daa
    9KkhQWaCTMoru8jJsHKP4w4MvNw5OIy8PcXX2ypmjHqPMGQewuPm95qoDLkEf0Y5
    tA3wC1zIboXTE4UjqB7iQa51IGTuQfb8EysYsKFuSiDOymA2dCZfVkrqRhhgAkWN
    XsDPjb9W08RgEfvYbbKPjAQAuPGvnhOh9DRptYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708741; bh=IGk5RfYG1fM8tcpT28Zqpedptz
    x4Aeg+Z9FIWsopnS4=; b=AjHlsQce38R6iQfaHXoRATU6ehBt8o0HtQf8NPKzp/
    26vczEste2Yotz2EJTJ8Knt/63mR3bG1w93S3f6JKdoIU/7r2MAPuwLpdYnSLijf
    dRjzPoQm67y8EIb/ORD2tG6Fh79Zyokm6/hSTSxofVUkl3+VeY9yHXfUK/qRofA1
    3eDkppu10XMiJpmIIWxZljbyEiA1fzdwktTjIZC/3fqAtQGtGM4N5dpKV+brE8t6
    GQp1OQvBdOGmAWjvpEzKsrZcJbrth+z7bXtFOtL/LafkIYN6f+uiCURkeHKCaD/E
    crp5CackrduYEY0phdkRNalmidRdR3qfF56yYEjG+Iag==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164491AbeBOPcS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:32:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56326 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164581AbeBOPcP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:32:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 062/195] [Variant 1/Spectre-v1] arm64: uaccess: Dont bother eliding access_ok checks in __{get, put}_user
Date: Thu, 15 Feb 2018 16:15:53 +0100
Message-Id: <20180215151708.826805101@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 84624087dd7e upstream.

access_ok isn't an expensive operation once the addr_limit for the current
thread has been loaded into the cache. Given that the initial access_ok
check preceding a sequence of __{get,put}_user operations will take
the brunt of the miss, we can make the __* variants identical to the
full-fat versions, which brings with it the benefits of address masking.

The likely cost in these sequences will be from toggling PAN/UAO, which
we can address later by implementing the *_unsafe versions.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/uaccess.h |   54 +++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 22 deletions(-)

--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -294,28 +294,33 @@ do {									\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 } while (0)
 
-#define __get_user(x, ptr)						\
+#define __get_user_check(x, ptr, err)					\
 ({									\
-	int __gu_err = 0;						\
-	__get_user_err((x), (ptr), __gu_err);				\
-	__gu_err;							\
+	__typeof__(*(ptr)) __user *__p = (ptr);				\
+	might_fault();							\
+	if (access_ok(VERIFY_READ, __p, sizeof(*__p))) {		\
+		__p = uaccess_mask_ptr(__p);				\
+		__get_user_err((x), __p, (err));			\
+	} else {							\
+		(x) = 0; (err) = -EFAULT;				\
+	}								\
 })
 
 #define __get_user_error(x, ptr, err)					\
 ({									\
-	__get_user_err((x), (ptr), (err));				\
+	__get_user_check((x), (ptr), (err));				\
 	(void)0;							\
 })
 
-#define get_user(x, ptr)						\
+#define __get_user(x, ptr)						\
 ({									\
-	__typeof__(*(ptr)) __user *__p = (ptr);				\
-	might_fault();							\
-	access_ok(VERIFY_READ, __p, sizeof(*__p)) ?			\
-		__p = uaccess_mask_ptr(__p), __get_user((x), __p) :	\
-		((x) = 0, -EFAULT);					\
+	int __gu_err = 0;						\
+	__get_user_check((x), (ptr), __gu_err);				\
+	__gu_err;							\
 })
 
+#define get_user	__get_user
+
 #define __put_user_asm(instr, alt_instr, reg, x, addr, err, feature)	\
 	asm volatile(							\
 	"1:"ALTERNATIVE(instr "     " reg "1, [%2]\n",			\
@@ -358,28 +363,33 @@ do {									\
 	uaccess_disable_not_uao();					\
 } while (0)
 
-#define __put_user(x, ptr)						\
+#define __put_user_check(x, ptr, err)					\
 ({									\
-	int __pu_err = 0;						\
-	__put_user_err((x), (ptr), __pu_err);				\
-	__pu_err;							\
+	__typeof__(*(ptr)) __user *__p = (ptr);				\
+	might_fault();							\
+	if (access_ok(VERIFY_WRITE, __p, sizeof(*__p))) {		\
+		__p = uaccess_mask_ptr(__p);				\
+		__put_user_err((x), __p, (err));			\
+	} else	{							\
+		(err) = -EFAULT;					\
+	}								\
 })
 
 #define __put_user_error(x, ptr, err)					\
 ({									\
-	__put_user_err((x), (ptr), (err));				\
+	__put_user_check((x), (ptr), (err));				\
 	(void)0;							\
 })
 
-#define put_user(x, ptr)						\
+#define __put_user(x, ptr)						\
 ({									\
-	__typeof__(*(ptr)) __user *__p = (ptr);				\
-	might_fault();							\
-	access_ok(VERIFY_WRITE, __p, sizeof(*__p)) ?			\
-		__p = uaccess_mask_ptr(__p), __put_user((x), __p) :	\
-		-EFAULT;						\
+	int __pu_err = 0;						\
+	__put_user_check((x), (ptr), __pu_err);				\
+	__pu_err;							\
 })
 
+#define put_user	__put_user
+
 extern unsigned long __must_check __arch_copy_from_user(void *to, const void __user *from, unsigned long n);
 #define raw_copy_from_user __arch_copy_from_user
 extern unsigned long __must_check __arch_copy_to_user(void __user *to, const void *from, unsigned long n);
