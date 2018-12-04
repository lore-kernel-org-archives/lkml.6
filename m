Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C35C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6314E20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="vHYNbV0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6314E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbeLDA3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:29:12 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:44903 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLDA3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=2W5StIB9rku+PygerJHJ7VTkvNmvs9lgb0rkdWIrm9Y=; b=vHYNbV0xtMz0
        BU3AorvaRl2QXCSZPZC2xMj19uinkBQ09CD1ULylchZdWkhT1dq2rlbi19gyidrwBWK0/78GbpufJ
        l8r/3ZsaACY7D/wcTY8hHP+ZxLhOdT+PaHdo+eyfLtlOoTqQWMk6XhPNz+3iCnJcww79gh4yndKz4
        UYEcBiLrmhzv6Y1z6ndG+bHZbPt2tqcSC67gH/9nOjieCxhgLghEqNYfm/ZmMBxLGbGbhPE0HvSTN
        DGSGXcBy7nIQWQKSfAbAT72mlu+NIfAjeVSGLCK3QaHlUondVPq6vS+YG5oFDxRuufNu6ZlQtZ2w/
        nREVPgfmviPHmoq8au3s+g==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gTya9-0005DG-TA; Tue, 04 Dec 2018 01:28:58 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 67236C05CD;
        Tue,  4 Dec 2018 01:28:53 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Sasha Levin <sashal@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 05/24] liblockdep: Rename "trywlock" into "trywrlock"
Date:   Mon,  3 Dec 2018 16:28:14 -0800
Message-Id: <20181204002833.55452-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181204002833.55452-1-bvanassche@acm.org>
References: <20181204002833.55452-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00404170384842)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5mCcK5qINjI5F/RzQjrWJkt602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXRlSaU0Ufx62qT0pFApPVowTvyPNezh4eXIcvclZsk4Cm6BePfuZhv66wit
 M/EawOp1vV0HXyPu+DA1NnRIKjvh7vqQSxcDUfxxw1XSsUJwD8CyCWD2go+CzOfejKjuJGKdOXXV
 Qp6v+eh7Up7l4p/YMVjYxM7BQdme6A4B2Kr024nTJYQp6P0LGGk5YcssJBljBMLLaM2KtLCkia0v
 MuKlp4JlZY5GFxcL6EXuUxMSe+KVse1sVhWabI0/+PN3sILfno2VGCQBTzV5700QuyS2nB91/WsJ
 i78ADPGYDhYdq5Txl/4H2pIk/NKx9kdZyuRMs3x71t5DHCETMYRS4C1JUuIF2yn03s7TS3ghm2vg
 Bpb5Pn6ftQZVK9K8EAjn37sUg69eDYNe2itClT3S7bjQUCo5PZJsLcY5FmNhp+JDxmImhzCOs+Do
 i9A98MTofQFPXMPn2jxw9gqzj3gEGJhZPn1u8Aa0teCaL50mskfArqCWQT4jeWsO/9zQPejqTp1v
 tczoIXo7Dnh9YhxyqPbgPd0rEuGjFyZoidhtHm+WoVkmUvIrbKAc1N/LjUK22+juyf/9FwsQjCZ/
 G16ONVA9F1Hsnni4KHvL9zJefiA2LMSXgZP6LOY/GmzmLdUgMBU4lhWEpYX3V6C9qwWgVqgrrSOI
 Ppeqwlm2NDGXIJ2x7Ic4y5lkb75GUbYAQVsMUdFh9BAPQhVPl2WQI4uiTk4Sh3uYZkcH5FfqKWFw
 GMpOs69cdUWCBzTXntizGWrlnd2ySwp4VGYo4cj/jQIuM+KHAh6iP3PCo1InPxIeYJn5vEIscsPw
 zUACJ0dbTyQp6gUnBy/PpUxgSFRPcWxJF+/b+wxIgSC8hxbpU7fDGfthR05o9e56Sj5G4XTwZDej
 9mGSwnQ8FCevmbSZnNCwEDqtIbtf63VNbf0lrvssY+k7ACPogw/bxo8y2Xa7orH7j4e7HO/V3r+P
 swMg3VJJxB50fZhZiA/IDPUGQ4tNSIYmjDA0XAoGECHs14pjPDDBgan6naiQSUkbpVs95ScaFXex
 3ivFg6NuzqPSZ59jRvh9/HPw17RyTo/iK8p1aZEnH6BkFjjwVWPNjPBAnw08jUvydDMjbgyLRGh1
 QMgntNeQBnwuDeGCnAmP1jueRUpx5Hs=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoids that the following compiler warning is reported while
compiling the lockdep unit tests:

include/liblockdep/rwlock.h: In function 'liblockdep_pthread_rwlock_trywlock':
include/liblockdep/rwlock.h:66:9: warning: implicit declaration of function 'pthread_rwlock_trywlock'; did you mean 'pthread_rwlock_trywrlock'? [-Wimplicit-function-declaration]
  return pthread_rwlock_trywlock(&lock->rwlock) == 0 ? 1 : 0;
         ^~~~~~~~~~~~~~~~~~~~~~~
         pthread_rwlock_trywrlock

Fixes: 5a52c9b480e0 ("liblockdep: Add public headers for pthread_rwlock_t implementation")
Cc: Sasha Levin <sashal@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tools/lib/lockdep/include/liblockdep/rwlock.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/lockdep/include/liblockdep/rwlock.h b/tools/lib/lockdep/include/liblockdep/rwlock.h
index a96c3bf0fef1..365762e3a1ea 100644
--- a/tools/lib/lockdep/include/liblockdep/rwlock.h
+++ b/tools/lib/lockdep/include/liblockdep/rwlock.h
@@ -60,10 +60,10 @@ static inline int liblockdep_pthread_rwlock_tryrdlock(liblockdep_pthread_rwlock_
 	return pthread_rwlock_tryrdlock(&lock->rwlock) == 0 ? 1 : 0;
 }
 
-static inline int liblockdep_pthread_rwlock_trywlock(liblockdep_pthread_rwlock_t *lock)
+static inline int liblockdep_pthread_rwlock_trywrlock(liblockdep_pthread_rwlock_t *lock)
 {
 	lock_acquire(&lock->dep_map, 0, 1, 0, 1, NULL, (unsigned long)_RET_IP_);
-	return pthread_rwlock_trywlock(&lock->rwlock) == 0 ? 1 : 0;
+	return pthread_rwlock_trywrlock(&lock->rwlock) == 0 ? 1 : 0;
 }
 
 static inline int liblockdep_rwlock_destroy(liblockdep_pthread_rwlock_t *lock)
@@ -79,7 +79,7 @@ static inline int liblockdep_rwlock_destroy(liblockdep_pthread_rwlock_t *lock)
 #define pthread_rwlock_unlock		liblockdep_pthread_rwlock_unlock
 #define pthread_rwlock_wrlock		liblockdep_pthread_rwlock_wrlock
 #define pthread_rwlock_tryrdlock	liblockdep_pthread_rwlock_tryrdlock
-#define pthread_rwlock_trywlock		liblockdep_pthread_rwlock_trywlock
+#define pthread_rwlock_trywrlock	liblockdep_pthread_rwlock_trywrlock
 #define pthread_rwlock_destroy		liblockdep_rwlock_destroy
 
 #endif
-- 
2.20.0.rc1.387.gf8505762e3-goog

