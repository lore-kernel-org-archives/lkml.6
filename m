Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9276BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61158218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="AEtR8c6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfBNXC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:02:27 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:60245 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfBNXCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=kfr7id1NFdRpxtRur4K+vdmaup9LK2yIVvKIYK9pqIg=; b=AEtR8c6oWKsr
        PmtFoLD+o+3xadHtTNuh9HwGJdRoIXboWiM5GkgSliXRp3ne6+uJ+L0IZVDw56UUyUlE2KDhva+O2
        d8V+HuVw7TskuNUyFCy/jTZ21itm3lUfdC/gSAkXtctrJTeDvpGqBbwHLhLLiUfCV32+JsXfiDnrO
        wWO1OzdQfUroP8SX8YzSN1oklIUEyBIRWiAikAfmsf0O/cDs60HYBhwm9JNIxcPV6LDfmpOj1gJZX
        0HDMiunfg9OR1Yut6UzOh9yLzzepZpmOmoPx/Kl6dy12SZ2zgzJ/3Yqbg/k0pcpRTOc3RjiN8VPeL
        4YrKYz45QrxrSj358HWABw==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ0w-000Dd6-2U; Fri, 15 Feb 2019 00:01:54 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id BE74CC08FC;
        Fri, 15 Feb 2019 00:01:51 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v7 20/23] locking/spinlock: Introduce spin_lock_init_key()
Date:   Thu, 14 Feb 2019 15:00:55 -0800
Message-Id: <20190214230058.196511-21-bvanassche@acm.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190214230058.196511-1-bvanassche@acm.org>
References: <20190214230058.196511-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5hX/Wrib/usrnszFCZujtnF602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvK+f2oRoAeRYfhT0
 +8ZeHlx1CKYQGsVUBBIZvPR6O9VM6rIjfaqh/FYC/2cUShU7IQTLJUggAnaZmGvuFMlbxH3zno4t
 3kssqrr3QsvSu8BVvwE6RONajYdk25wJKkcGEf+Bu4/uGdQrw1B0vCxVYohcSv/qU9FFqqWjPxOZ
 4rS96wsSk3gbli5Hn3p/ES2Us4SYjNUoBCz9aTu56OA1tEt5/6v7c9QHckE3f/XVZktw2usqskBf
 h9gLNBvEVVkgjgCZ3lN0dg693VokPoLlNvu19yPULOCRMJQ2BgM/Wut6cO9MNpwkpncXgB6bffaX
 7wPgNeCyAe+JQX6HyL0UqxNDRJrRpr7wz+EXB5mEk9jY7DfoFpGsYUD/WPNQ3/98n4KjRNu1YZ/l
 EUppyk7SLUs0Ap+3lJq6hj+TDSWdnPTqSG28AwmnHdnFfy/mdAqN6jfCih+mdOWF1qNLH8rBe68i
 Mb3pZ89YO5o3V69sgaEHpAEntM8yKElR+Y84QVlpY4ecbMuUSayzGENEZXNjbGtvbdRuq0FZjQOw
 DKXnhaC6dkwF9ybSMhHO+IPM0C985aNe1vwE2plJLdOGZ2rsAWd09R2dJuKgmYAsxRKZESmGW/aZ
 YtwsQg10dqBtocMJjzZCrDpoDhUL0I3BfC1fec/RjdK3JtbOY4V5u4SqNrbdsHmo+uYudJKJ8bi5
 x3tbpVe1tYplSdI2hY2i9VueMrstymTkYtdXvfzLSd6oTHyuz1unP8YfeJe/r67ghB7sIlC/LbdJ
 ldJ8xntHMcYfWXYLHEUqA0HsPdIz4jG3/VaOCTVlANdF8UcA/VNZaGzv6Y6P7jhGKMUK7BDxSFIm
 db601qKl4q2edefpeoXVxlIT5moBQVJdOWbQTYSAYXMZehUCar8gDuIJmtL2cW+BVZq2BmRxGQKe
 gzOmzXDxmXJaKd3cILoszTB9fNTo7r2to4OcNN9j0+DgTGfrIwdUqr5nIKDFkcg0DoDn7tP2jpvL
 Mtc3J05Nr8zytbLx/Z1cJZbCh/CoCwVhCcESd3XFnv9w5tp7B/pchUzTTXJqm5O4MS+4ayUpOtEh
 dxekWDmK9g==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some code uses nested locking of different spinlocks that share a
lock class. That results in false positives because spin_lock_init()
forces these instances to share a lock class. Make it possible to
avoid these false positives by allowing spinlock users to specify
the lock class at runtime.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/spinlock.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index e089157dcf97..09b3e27ed21d 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -99,10 +99,19 @@ do {								\
 								\
 	__raw_spin_lock_init((lock), #lock, &__key);		\
 } while (0)
+#define raw_spin_lock_init_key(lock, key)			\
+	__raw_spin_lock_init((lock), #lock, key)
 
 #else
+
 # define raw_spin_lock_init(lock)				\
 	do { *(lock) = __RAW_SPIN_LOCK_UNLOCKED(lock); } while (0)
+static inline void raw_spin_lock_init_key(struct raw_spinlock *lock,
+					  struct lock_class_key *key)
+{
+	*(lock) = __RAW_SPIN_LOCK_UNLOCKED(lock);
+}
+
 #endif
 
 #define raw_spin_is_locked(lock)	arch_spin_is_locked(&(lock)->raw_lock)
@@ -324,6 +333,12 @@ do {							\
 	raw_spin_lock_init(&(_lock)->rlock);		\
 } while (0)
 
+#define spin_lock_init_key(_lock, _key)			\
+do {							\
+	spinlock_check(_lock);				\
+	raw_spin_lock_init_key(&(_lock)->rlock, _key);	\
+} while (0)
+
 static __always_inline void spin_lock(spinlock_t *lock)
 {
 	raw_spin_lock(&lock->rlock);
-- 
2.21.0.rc0.258.g878e2cd30e-goog

