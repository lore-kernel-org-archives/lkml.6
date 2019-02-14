Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E75CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21669218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="nGW2AR18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387673AbfBNXCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:02:18 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:60631 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387446AbfBNXCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=j1/q+rII0y/IbluQnX94bFT7nzOieREhmjhJedayOuw=; b=nGW2AR18X4gR
        PSQocDcKI0SzGJ2kWCdeB8x6iqQOlcQ7bSN8fTPD3Mm8dsz+uEun2l36MpxqIGUv1mMb93mys6dew
        TfF6QENl5mkYkHP2IkR3Fo0OcmuN5qwNZOhGm4H2jR9M1MUWauU2t9w+Oeo6E35DyOHoK79E2bxZX
        pK5PPNkSq4YMsXN+V12cVP2nZdfwHzmL1OwmqysmxMzUbgILBQKh8CxVa9T7H3Fg0H57A6ZBk4skn
        y3CyoN6od1F6tY6LQWq3ygCxhctAJvbBVfaQxYX8Bz+I0UC95JRafX/6q0DFQbekk1VOg9iW0HQ1Z
        WsepWGM/SM7cUpym90mVkA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ12-0000xu-9k; Fri, 15 Feb 2019 00:02:00 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id E89CBC05BA;
        Fri, 15 Feb 2019 00:01:57 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v7 23/23] lockdep tests: Test dynamic key registration
Date:   Thu, 14 Feb 2019 15:00:58 -0800
Message-Id: <20190214230058.196511-24-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.000991401509681)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5sLg9EySvSJTwky689rYrkF602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFr/HXw7HB6/ASdSFy6HwS/kPXDwAtkmamZ68x0sIvfyXcDIKE+0kbt+hzad+8LmAP3D1N2U
 GbvmsuDbvpqB9SNial5u6w2P0n3AP5HxdAj+kw2FxVgE7SkvtWKxkgySOE3GN0ExaDjCWJE9qkQd
 cN59pbXtarYtexyXaspXfZHNp3TFgIfDMShmlQFqCr5hA8xy+28pF/HE/UXip0YpvmqSgtBtsvjK
 9mpXvZ581yfqNVA0hlu/NpOnaXNvrIp4mRGgQUA9iOUB9gXW15it62GvKaV7puimXuHjFEy4159w
 b450J4XCXsfFdbMPgtsajKwG2cpJ3lvOyWe43aQJV0FQAw4GDaNi9opIpCCZlwPhCSifQg48iasD
 JL+gSQdpc7Qjle0LcSTVPooEuo2QsxqqSZrgzSd/y/UPcC3OGqi0VJ9oPeZuzI4YvGloR1iXZcQ6
 rDn0tTOVcmJwqI8Ju2ne/wwIwzyV/WMPB6zTEWzEncEKJtZE3p7YZqOA3SmjVruGpS+C6BPAIEs8
 PiiVo3Eboi+cbnT5PTDQNVG9E6gOGiUCAW1FDxcZal9mohvTtVuaBo55LoXJ38umBncoBPaTGplH
 cpVCCoX989hgB8R+yBNKgbPqM+gWqiGtLl4stWpoD9FzZlLjMwJPDioYZIRv2/mae7V904kq7Np8
 rv7tR3bBteMJzAkMC43e8+sp9ik9r/0RENuxoUHLfdnX97lYWfNCwcrS0aokqY9q7nrY3hEVniih
 uDwEGDcmr6e3OPRLa16pGRvAB1MNCAVzZzPG/W30w/zDcz636yEnTyvlnRmAYWvYmazXX5mZqpPP
 J/3x4HCWypZTDeWk/ePt0rolctgzcDoFd+96Xw4QUNtTnfzp6yaSzf/mBOxmctH1xJW7ZqDnEZyA
 /o9yCJs753i5Anc+dePvuOLndsGRtxRwqudKEy7bP5gIt23U7fpAnNNWb77i3eb3c6Xj53IToZwL
 VabjergYMIEHYgna2Grb/XBEn95eECKi3gxjzXac2CKNL6Ugwa8G8LUBaMaYDRNMLxoq67wPPyTr
 tPptswtkm3vs+M4bivZGPOywGIoCFD0=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the lockdep_register_key() and lockdep_unregister_key()
code is tested when running the lockdep tests.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tools/lib/lockdep/include/liblockdep/common.h |  2 ++
 tools/lib/lockdep/include/liblockdep/mutex.h  | 11 ++++++-----
 tools/lib/lockdep/tests/ABBA.c                |  9 +++++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/lib/lockdep/include/liblockdep/common.h b/tools/lib/lockdep/include/liblockdep/common.h
index d640a9761f09..a81d91d4fc78 100644
--- a/tools/lib/lockdep/include/liblockdep/common.h
+++ b/tools/lib/lockdep/include/liblockdep/common.h
@@ -45,6 +45,8 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 void lock_release(struct lockdep_map *lock, int nested,
 			unsigned long ip);
 void lockdep_reset_lock(struct lockdep_map *lock);
+void lockdep_register_key(struct lock_class_key *key);
+void lockdep_unregister_key(struct lock_class_key *key);
 extern void debug_check_no_locks_freed(const void *from, unsigned long len);
 
 #define STATIC_LOCKDEP_MAP_INIT(_name, _key) \
diff --git a/tools/lib/lockdep/include/liblockdep/mutex.h b/tools/lib/lockdep/include/liblockdep/mutex.h
index 2073d4e1f2f0..783dd0df06f9 100644
--- a/tools/lib/lockdep/include/liblockdep/mutex.h
+++ b/tools/lib/lockdep/include/liblockdep/mutex.h
@@ -7,6 +7,7 @@
 
 struct liblockdep_pthread_mutex {
 	pthread_mutex_t mutex;
+	struct lock_class_key key;
 	struct lockdep_map dep_map;
 };
 
@@ -27,11 +28,10 @@ static inline int __mutex_init(liblockdep_pthread_mutex_t *lock,
 	return pthread_mutex_init(&lock->mutex, __mutexattr);
 }
 
-#define liblockdep_pthread_mutex_init(mutex, mutexattr)		\
-({								\
-	static struct lock_class_key __key;			\
-								\
-	__mutex_init((mutex), #mutex, &__key, (mutexattr));	\
+#define liblockdep_pthread_mutex_init(mutex, mutexattr)			\
+({									\
+	lockdep_register_key(&(mutex)->key);				\
+	__mutex_init((mutex), #mutex, &(mutex)->key, (mutexattr));	\
 })
 
 static inline int liblockdep_pthread_mutex_lock(liblockdep_pthread_mutex_t *lock)
@@ -55,6 +55,7 @@ static inline int liblockdep_pthread_mutex_trylock(liblockdep_pthread_mutex_t *l
 static inline int liblockdep_pthread_mutex_destroy(liblockdep_pthread_mutex_t *lock)
 {
 	lockdep_reset_lock(&lock->dep_map);
+	lockdep_unregister_key(&lock->key);
 	return pthread_mutex_destroy(&lock->mutex);
 }
 
diff --git a/tools/lib/lockdep/tests/ABBA.c b/tools/lib/lockdep/tests/ABBA.c
index 623313f54720..543789bc3e37 100644
--- a/tools/lib/lockdep/tests/ABBA.c
+++ b/tools/lib/lockdep/tests/ABBA.c
@@ -14,4 +14,13 @@ void main(void)
 
 	pthread_mutex_destroy(&b);
 	pthread_mutex_destroy(&a);
+
+	pthread_mutex_init(&a, NULL);
+	pthread_mutex_init(&b, NULL);
+
+	LOCK_UNLOCK_2(a, b);
+	LOCK_UNLOCK_2(b, a);
+
+	pthread_mutex_destroy(&b);
+	pthread_mutex_destroy(&a);
 }
-- 
2.21.0.rc0.258.g878e2cd30e-goog

