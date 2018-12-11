Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B7DC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BB12084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="HZYdef96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BB12084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeLKWOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:14:19 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:45031 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbeLKWOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=UZoG194aBJ7sHcNC5H8KVXV2i6xwEoOpvzj5vNSCG+s=; b=HZYdef96yz9a
        7bXXeh+Zl3q/j3P9o85RaMTSOceOGp9vaTp2J37OOQ5ckqKypC6cjhAkDD62GciSnQ/tDvEuN3j7m
        6AYIdCg1o03mCwLcmFo0p5d5AftmoKTNcLE9BBLJ0GsD4w/cv7vHmgWZavceM2aN9Sxl9lEFYEa4L
        ZGocXzRL0CfuPJvas6smXjX3fIFx1R5aQunGiCWBxJW0bgwwQ6cfVR0IgbhERRhdmWgQRVXsX4XNa
        6UI9KRc2YU/5JZq5rmimJvM35NoO/QeKSySza2jNLf+W0twCmZPKcJQ1istNmOxD4+7LGZSVYXJx6
        qvB8Z808nmKMht6VYaWAyw==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gWqI1-0006rW-UX; Tue, 11 Dec 2018 23:14:06 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 2B3ABC075C;
        Tue, 11 Dec 2018 23:14:04 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v4 15/15] lockdep tests: Test dynamic key registration
Date:   Tue, 11 Dec 2018 14:13:21 -0800
Message-Id: <20181211221321.196536-16-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181211221321.196536-1-bvanassche@acm.org>
References: <20181211221321.196536-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00118768740315)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5scN3eVin8QtvHVNPTCnXw5602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORqoT8X8WGp9uxzSEy7z
 Vrj5SNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVH6GzPz+r852EXXeYX4ImMyzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/3Z86X+I1ED1LLv7p/g4HOOdbYb9IXfYGRpVS/0hA4Mwp9kB6JZdl+SJy+nWImyKEy/
 zJE11ZjKQFiKV8EwnkodMjMm/D2rEPnNAuCCnt9B91Ax/uigYcgpQGDKFCrOdd8gr/U0flMcy2Vi
 /IcBgY4aVBKUAPQbBk8nfWT8Lcjyyn9ZSA9YgSwQmLSJwsFnO3lUxpF8dVvwCXY/4mE1q/c/E53d
 gi3vLmcjfrrMypRHny1o2QTlkt6ia1M0QrCozRRHqFRVEYbUSOWpJ4cGbvMqX1KrFIDnIhhlHDLh
 vRwgYpikjrjEsQHYqzPksYepQjQSeP/rn+UB/EmrduGPxHj/dKsQ+WcgzL7pTOYRE2yEvlBrMyfp
 YuyanAZpMXssfrVwLrD8rqLg0SqQCDr4y/2adc+aNdkwNSAlM6tp/FgYCxayDu9UA1qrxQU1IoP+
 ZgDYhBKQrXFod+WvUUP1Uys1EcG7yIy1/E3Wa9/NTnLEueuO5TcDeKjrEmYPn2IVWRtfdRHps2br
 TOkutpvyrdmtvbYO9ASW9x0dzW2b+IEXgSV5FVT0nNNOs1IDBtijAxf8XG910biZEcomWehz4u8s
 zDg6HYuTCyYgL61SIkBTYSiCBqrB4vMmHpjmx6wTDBzk2EPy497nssgnoMkIb3rMdj8luXC7km26
 QtXP9s02LA==
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
2.20.0.rc2.403.gdbc3b29805-goog

