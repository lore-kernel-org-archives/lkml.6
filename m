Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A91C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F490206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="QpmBbBj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F490206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeK2Krz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:47:55 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:59715 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbeK2Krx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=mcUvMjoYe3PeH3YzeCRQeNkb9nVP6UyQiX031dtXHfw=; b=QpmBbBj5iVTz
        0IsRiM4AEqe41R6s+VYM8GokT0M0bKGzQc3Wmo0x7mdMMMG5A9QmpL45Kf5Kaeh8aumLVX0VnnwD1
        ojIvUOzh1W7yoxTI4X0rPLDdg8UORylLuKWuTGhY7EHukA/9OSpev+qHXzZhthXeU5JKcKzauoKkD
        r6MKGyhNuUqiWg1mWdwoxYvXmDziMZpcisayAxr8TyofiKAMyd/pLpggjV6zdLe1c/c9NA1ZVPtDB
        n8q125hlBCqrhZUCBOOGLhpB73RwVss2VB1PvsCBC+hFCGho1szWAIHI+N63NxMKpX7nIGOzGnfDK
        9dI0VtN52hKeytPdB+wIpQ==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9VJ-000Fm0-AM; Thu, 29 Nov 2018 00:44:25 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 316C0C1235;
        Thu, 29 Nov 2018 00:44:23 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 27/27] lockdep tests: Test dynamic key registration
Date:   Wed, 28 Nov 2018 15:43:25 -0800
Message-Id: <20181128234325.110011-28-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181128234325.110011-1-bvanassche@acm.org>
References: <20181128234325.110011-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00147027635519)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5h5KxyMl6wMjMQAJSbWPT/B602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyB41b1wEpWO6ik9HITpMsqebHcXK5F5szpMR3
 ucwUCaulpCLw+Xb9GLNy0GASgpn9t8C9mOBdONdnsxgsk1D2p09kN7MM31r8n6t5T2S20aXt4Z/Z
 A/b0vwYEnDdnyRMpq2ydL+V39l/HBScm+SV6be+d9aVwS6cHCn1lU19HAi33Iz6Zvpm8cPQnANwk
 DQ5BNCNwpGn8jfSb3NCl2WUq09dCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrUVh8zaVyj66M1
 yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2g6K04cY809V1JdCwiLdDQ
 Dow7RSjhmGOVelXQaHGaUkBvyMjbyNpr4xR6RL2C9+qlIny++hg9dJLqN5zmWqF/oNe6FVV7drXD
 mtOldfpWzeUCaRHvx+uLGHS3n3Y0pMd0ZyCgxZHINA6A5+7T9o6by6wCf9/ixXi9QE6xc2MJdJIs
 WkULIn/2FBvF31UHbsndehIqUczFWeS6sE8e1b5/UlaX0Ao5X99TlizdjWjXhcukjPvPb2ztUwUU
 F4ekbSpuNzlrea/7iuldgAMiBvdjMSLFyWVVGDLjLtLLMFFx8O0HmFDqewO9xyOqCYO8P1aHcsG0
 kWCiESR44kXyAcFBnvq0JaXhRWKyqy0OhbkmMxu2AdrcZPAiQvyjIZ4LQqnqqLEDUnB02oJPHAlf
 IubJYzA0XAoGECHs14pjPDDBgamvNiA5kjk+kUt44s0jst5fr31tEQH03yNqct6Xqa5I+n5W0k4Q
 x9aozXEd9vD1qTZuhWzfuvHd4y0L/HyfN5U858I8R2vIYlYbA7G/CY3eeSCFRiwDn8j3yWGHtM7w
 dRonBy/PpUxgSFRPcWxJF+/beJHmCfSNEcGdfFKs5M18F1x96tlonSt5Ig9mwLw4vXsdf68W0InH
 /+bTMKNm38MHV+diwrlXuxzeO2WnJyd7g8lLLKZgdBo3YHaSgbLEg7M4I+zZPnIX6k9TnzH5sZcr
 MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the lockdep_register_key() and lockdep_unregister_key()
code is tested when running the lockdep tests.

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
2.20.0.rc0.387.gc7a69e6b6c-goog

