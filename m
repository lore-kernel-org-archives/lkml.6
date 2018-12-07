Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5043EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019F720850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="bhHeUfo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019F720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbeLGBNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:13:20 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:51029 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeLGBNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=8EID5ILiylK5rpF5w/c1olKaYo7/Cy2J+W0+R0xw2qE=; b=bhHeUfo3tXml
        Qd6On7gvZW4LajLCFsuA3YH7UkdlqC5D3dOsHnF66p9Tv82TBIoPV9zaxVVX4We6dS/DXKsGqnk98
        yM3xg/ZwGS7OcYkdvpXyMvuoFkCXLdAMW/5L7b3MIgSgX3hNJfVZ8CuXFdNxf6k/QSHgcCYrNukSr
        i38Xpw4e1AsLSx09WNgJZ21gI6AZbmYp0/nBLI/yuusRrxC522AxRqlRWL+EX3UXi8PbL9L4ZYoF7
        2c/Vk4AN9KqtCsAqiHCB2jrdJI4N4LU+fzosWeIpbR4h/donJBWUiQc2FoH4YtvHbdK8AjtKg0Jx3
        ZGAP+F3MbdVOoIf3FfOBjA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gV4hK-0008n8-0B; Fri, 07 Dec 2018 02:12:54 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 4B458C0E17;
        Fri,  7 Dec 2018 02:12:48 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v3 07/24] lockdep tests: Test the lockdep_reset_lock() implementation
Date:   Thu,  6 Dec 2018 17:11:31 -0800
Message-Id: <20181207011148.251812-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181207011148.251812-1-bvanassche@acm.org>
References: <20181207011148.251812-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00519839355428)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5q2Mwg+oHhV94tyjTYkSUsd602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORqNvVzxyJ6N7PsykTph
 2RmTSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVFg5Rj2g0fgHrO2rAGaVRcnzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/3Z86X+I1ED1LLv7p/g4HOOdbYb9IXfYGRpVS/0hA4Mwp9kB6JZdl+SJy+nWImyKEy/
 zJE11ZjKQFiKV8EwnkodMjMm/D2rEPnNAuCCnt9B91Ax/uigYcgpQGDKFCrOdd8gr/U0flMcy2Vi
 /IcBgY4aVBKUAPQbBk8nfWT8Lcjyyn9ZSA9YgSwQmLSJwsFnO3lUxpF8dVvwCXY/4mE1q/c/lcBJ
 DmoxYxZqr5EVgTOQJMJt0yuwLUIeLJh6ZvcqtnoacaVzPK+YmgnafXvtoqaxX1KrFIDnIhhlHDLh
 vRwgYpikjrjEsQHYqzPksYepQjQSeP/rn+UB/EmrduGPxHj/dKsQ+WcgzL7pTOYRE2yEvlBrMyfp
 YuyanAZpMXssfrVwLrD8rqLg0SqQCDr4y/2aKvc4qaT+rOe0sbMMTAgMR99vUhlZZr/bqdHd4v9b
 cOHYhBKQrXFod+WvUUP1Uys1EcG7yIy1/E3Wa9/NTnLEueuO5TcDeKjrEmYPn2IVWRtfdRHps2br
 TOkutpvyrdmtvbYO9ASW9x0dzW2b+IEXgSV5FVT0nNNOs1IDBtijAxf8XG910biZEcomWehz4u8s
 zDg6HYuTCyYgL61SIkBTYSiCBqrB4vMmHpjmx6wTDBzk2EPy497nssgnoMkIb3rMdj8luXC7km26
 QtXP9s02LA==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes sure that the lockdep_reset_lock() function gets
tested.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
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
2.20.0.rc2.403.gdbc3b29805-goog

