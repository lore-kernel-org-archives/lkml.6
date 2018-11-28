Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A698C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CE4206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="T6mX6bky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42CE4206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeK2Kts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:49:48 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:52395 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeK2Kr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=VLo7/ml+jiLUJTypr9UQfEC/9+2aMqGl9J47BQHZsw4=; b=T6mX6bky9vnx
        1DN1iCGex7y2cujb6090IGg3yMb83Z9zqa9YsiETlcuIBu5eUzXduQRsqbSMyowF+uVISa8A8E8a8
        sSQ9Wtsvx+sOjp36OAf9Jkid9HMbDry24XuRgV6nHxaSvbnEc/GId3PNW4/63Gf/akhL5yP7aFkLQ
        3LFkqeSHdgQia7ihS50RBKmIR1BpXgAKiu8AO5se1WqVItmHGogRfRZ02cikveQGLSbp7gZPnaghW
        zA+sN2pNyRTN8FGU4CETEP/xbe57PHhlhmmdQpR+Be2VLMKmGse3T/w75EWIUzJNNjfOQ9PZMheS7
        +aJGEHVrfIiXC7fs7mOApg==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9Un-000FjK-8i; Thu, 29 Nov 2018 00:43:54 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 72749C131F;
        Thu, 29 Nov 2018 00:43:49 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 07/27] lockdep tests: Test the lockdep_reset_lock() implementation
Date:   Wed, 28 Nov 2018 15:43:05 -0800
Message-Id: <20181128234325.110011-8-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00815687879598)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5mN/yKk1/W+KVhnva9H3DjF602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyB41b1wEpWO6ik9HITpMsqebHcXK5F5szpMR3
 ucwUCaulpCLw+Xb9GLNy0GASgpn9t8C9mOBdONdnsxgsk1D2p09kN7MM31r8n6t5T2S20aXUH3vg
 imo4KaTUunJ6Ptueq2ydL+V39l/HBScm+SV6be+d9aVwS6cHCn1lU19HAi33Iz6Zvpm8cPQnANwk
 DQ5BNCNwpGn8jfSb3NCl2WUq09dCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrUVh8zaVyj66M1
 yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2g6K04cY809V1JdCwiLdDQ
 Dow7RSjhmGOVelXQaHGaUkBvyMjbyNpr4xR6RL2C9+qlIny++hg9dJLqN5zmWqF/oNe6FVV7drXD
 mtOldfpWzeUCaRHvx+uLGHS3n3Y0pMd0ZyCgxZHINA6A5+7T9o6by6wCf9/ixXi9QE6xc2MJdJIs
 WkULIn/2FBvF31UHbsndehIqUczFWeS6sE8e1b5/UlaX0Ao5X99TlizdjWjXhcukjPvPb2ztUwUU
 F4ekbSpuNzlrea/7iuldgAMiBvdjMWNhN5DOGl3098Zkn5isC+AHmFDqewO9xyOqCYO8P1aHcsG0
 kWCiESR44kXyAcFBnvq0JaXhRWKyqy0OhbkmMxu2AdrcZPAiQvyjIZ4LQqnqqLEDUnB02oJPHAlf
 IubJYzA0XAoGECHs14pjPDDBgamvNiA5kjk+kUt44s0jst5fMfyoorpHtUG+tbhdjR8GqeITVg6Q
 TrHGofvmrHam4/RuhWzfuvHd4y0L/HyfN5U858I8R2vIYlYbA7G/CY3eeSCFRiwDn8j3yWGHtM7w
 dRonBy/PpUxgSFRPcWxJF+/beJHmCfSNEcGdfFKs5M18F1x96tlonSt5Ig9mwLw4vXsdf68W0InH
 /+bTMKNm38MHV+diwrlXuxzeO2WnJyd7g8lLLKZgdBo3YHaSgbLEg7M4I+zZPnIX6k9TnzH5sZcr
 MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes sure that the lockdep_reset_lock() function gets
tested.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tools/lib/lockdep/include/liblockdep/common.h | 1 +
 tools/lib/lockdep/include/liblockdep/mutex.h  | 1 +
 tools/lib/lockdep/tests/ABBA.c                | 3 +++
 tools/lib/lockdep/tests/ABBCCA.c              | 4 ++++
 tools/lib/lockdep/tests/ABBCCDDA.c            | 5 +++++
 tools/lib/lockdep/tests/ABCABC.c              | 4 ++++
 tools/lib/lockdep/tests/ABCDBCDA.c            | 5 +++++
 tools/lib/lockdep/tests/ABCDBDDA.c            | 5 +++++
 tools/lib/lockdep/tests/unlock_balance.c      | 2 ++
 9 files changed, 30 insertions(+)

diff --git a/tools/lib/lockdep/include/liblockdep/common.h b/tools/lib/lockdep/include/liblockdep/common.h
index 8862da80995a..d640a9761f09 100644
--- a/tools/lib/lockdep/include/liblockdep/common.h
+++ b/tools/lib/lockdep/include/liblockdep/common.h
@@ -44,6 +44,7 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 			struct lockdep_map *nest_lock, unsigned long ip);
 void lock_release(struct lockdep_map *lock, int nested,
 			unsigned long ip);
+void lockdep_reset_lock(struct lockdep_map *lock);
 extern void debug_check_no_locks_freed(const void *from, unsigned long len);
 
 #define STATIC_LOCKDEP_MAP_INIT(_name, _key) \
diff --git a/tools/lib/lockdep/include/liblockdep/mutex.h b/tools/lib/lockdep/include/liblockdep/mutex.h
index a80ac39f966e..2073d4e1f2f0 100644
--- a/tools/lib/lockdep/include/liblockdep/mutex.h
+++ b/tools/lib/lockdep/include/liblockdep/mutex.h
@@ -54,6 +54,7 @@ static inline int liblockdep_pthread_mutex_trylock(liblockdep_pthread_mutex_t *l
 
 static inline int liblockdep_pthread_mutex_destroy(liblockdep_pthread_mutex_t *lock)
 {
+	lockdep_reset_lock(&lock->dep_map);
 	return pthread_mutex_destroy(&lock->mutex);
 }
 
diff --git a/tools/lib/lockdep/tests/ABBA.c b/tools/lib/lockdep/tests/ABBA.c
index 1460afd33d71..623313f54720 100644
--- a/tools/lib/lockdep/tests/ABBA.c
+++ b/tools/lib/lockdep/tests/ABBA.c
@@ -11,4 +11,7 @@ void main(void)
 
 	LOCK_UNLOCK_2(a, b);
 	LOCK_UNLOCK_2(b, a);
+
+	pthread_mutex_destroy(&b);
+	pthread_mutex_destroy(&a);
 }
diff --git a/tools/lib/lockdep/tests/ABBCCA.c b/tools/lib/lockdep/tests/ABBCCA.c
index a54c1b2af118..48446129d496 100644
--- a/tools/lib/lockdep/tests/ABBCCA.c
+++ b/tools/lib/lockdep/tests/ABBCCA.c
@@ -13,4 +13,8 @@ void main(void)
 	LOCK_UNLOCK_2(a, b);
 	LOCK_UNLOCK_2(b, c);
 	LOCK_UNLOCK_2(c, a);
+
+	pthread_mutex_destroy(&c);
+	pthread_mutex_destroy(&b);
+	pthread_mutex_destroy(&a);
 }
diff --git a/tools/lib/lockdep/tests/ABBCCDDA.c b/tools/lib/lockdep/tests/ABBCCDDA.c
index aa5d194e8869..3570bf7b3804 100644
--- a/tools/lib/lockdep/tests/ABBCCDDA.c
+++ b/tools/lib/lockdep/tests/ABBCCDDA.c
@@ -15,4 +15,9 @@ void main(void)
 	LOCK_UNLOCK_2(b, c);
 	LOCK_UNLOCK_2(c, d);
 	LOCK_UNLOCK_2(d, a);
+
+	pthread_mutex_destroy(&d);
+	pthread_mutex_destroy(&c);
+	pthread_mutex_destroy(&b);
+	pthread_mutex_destroy(&a);
 }
diff --git a/tools/lib/lockdep/tests/ABCABC.c b/tools/lib/lockdep/tests/ABCABC.c
index b54a08e60416..a1c4659894cd 100644
--- a/tools/lib/lockdep/tests/ABCABC.c
+++ b/tools/lib/lockdep/tests/ABCABC.c
@@ -13,4 +13,8 @@ void main(void)
 	LOCK_UNLOCK_2(a, b);
 	LOCK_UNLOCK_2(c, a);
 	LOCK_UNLOCK_2(b, c);
+
+	pthread_mutex_destroy(&c);
+	pthread_mutex_destroy(&b);
+	pthread_mutex_destroy(&a);
 }
diff --git a/tools/lib/lockdep/tests/ABCDBCDA.c b/tools/lib/lockdep/tests/ABCDBCDA.c
index a56742250d86..335af1c90ab5 100644
--- a/tools/lib/lockdep/tests/ABCDBCDA.c
+++ b/tools/lib/lockdep/tests/ABCDBCDA.c
@@ -15,4 +15,9 @@ void main(void)
 	LOCK_UNLOCK_2(c, d);
 	LOCK_UNLOCK_2(b, c);
 	LOCK_UNLOCK_2(d, a);
+
+	pthread_mutex_destroy(&d);
+	pthread_mutex_destroy(&c);
+	pthread_mutex_destroy(&b);
+	pthread_mutex_destroy(&a);
 }
diff --git a/tools/lib/lockdep/tests/ABCDBDDA.c b/tools/lib/lockdep/tests/ABCDBDDA.c
index 238a3353f3c3..3c5972863049 100644
--- a/tools/lib/lockdep/tests/ABCDBDDA.c
+++ b/tools/lib/lockdep/tests/ABCDBDDA.c
@@ -15,4 +15,9 @@ void main(void)
 	LOCK_UNLOCK_2(c, d);
 	LOCK_UNLOCK_2(b, d);
 	LOCK_UNLOCK_2(d, a);
+
+	pthread_mutex_destroy(&d);
+	pthread_mutex_destroy(&c);
+	pthread_mutex_destroy(&b);
+	pthread_mutex_destroy(&a);
 }
diff --git a/tools/lib/lockdep/tests/unlock_balance.c b/tools/lib/lockdep/tests/unlock_balance.c
index 34cf32f689de..dba25064b50a 100644
--- a/tools/lib/lockdep/tests/unlock_balance.c
+++ b/tools/lib/lockdep/tests/unlock_balance.c
@@ -10,4 +10,6 @@ void main(void)
 	pthread_mutex_lock(&a);
 	pthread_mutex_unlock(&a);
 	pthread_mutex_unlock(&a);
+
+	pthread_mutex_destroy(&a);
 }
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

