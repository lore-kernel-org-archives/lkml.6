Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E73C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3196620855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="DuxciOwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3196620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeKJJaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:30:07 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:41545 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbeKJJaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=j6uWysnrYnmaF2J+ZFA59UILP45nhtptoViBLgER23c=; b=DuxciOwawuX5
        jc7ljDxConaPgxI9ghbjbIH/g2UF9NY2HyHotBH9xKGIWr4LQ1EfhZGzuWQpobXjr0pDyRkhHlPWC
        OJQ2HmsRCy90apCe7QwBrPXRkUBcuucWcs/i6Asra3HxHauRFg1dD/npKSXL6nA6Oq0XXcCJvRxyx
        IXxodg9KK/sdg9StsqN9/FhBLSsyEe4LQiKifInPl7wh7j9lPk4yt9NHuxhNRtJ0lZQ4K73+hf+HB
        lhAZEr0pBFNJPn9/QDN1hMoxLmOTjUuY4hvCgBVtVnfdOtgfjUHy1H7lsqmypExfFo25KHoxd46T7
        FGnpBdZE/0ogvRKmuqQnPw==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gLGUP-000F3i-KB; Sat, 10 Nov 2018 00:47:02 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 5D836C0AF4;
        Sat, 10 Nov 2018 00:46:55 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, Tejun Heo <tj@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] locking/lockdep: Add support for dynamic depmaps and keys
Date:   Fri,  9 Nov 2018 15:46:44 -0800
Message-Id: <20181109234645.10530-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181109234645.10530-1-bvanassche@acm.org>
References: <20181109234645.10530-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.05)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5lJwMmpQrQVs+T7hsKatd91602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFqIq2rgmnTfzvSnaZPSpdF4ea4rbEb5nCRA6afYiNM/uEuf+eM3l5KPnbp/eQthjVOWYHcP
 06zXqyXOojRJS4zk4NXav6KZiAP6ecc6uYm2MATJsjWw5+0eZIpQIcK9yrRZBI4MtpSGpU9W4FdB
 tQesEelBF7Ngqas1fLSi+EsXiO7J//0XCxCMJn8bXo41UD3u+ZQGpXspg4TOqv23+spbzJ3vJBBY
 vcIXZcvdbj7fjbZn+1a2iCCdPFy3WGiBkBZc+BBb+UeYFBhPAZQ65C2d4vB6Mmh6nzlzGKK4CNTd
 FmC4kGAnKNZdqPIYy5/0C0oKEgxQF7G4ajroXShVPl5s3ZvBSOdcZaQYlKee2Vxut4iZ5ZA89caf
 AqxM+VvJzb/lgTl6fJxyntEfhZCKje4ZQ0jUIEfcq3/8iFZW9aviZrI0q854skGDr1SFWz9TrEbL
 my3uPSE9vyN9HoGBpQQMs9mOAuVGeNoxAGUS1QpH0KIcRmoNU2oljXXErZz3MdU5SJeoVHj5h7lL
 06fEAVxIzKeWFsL83KrakodIBOvGMctLyBaorY+GM5EjKX/JXeFAKrW1e6SUoNwG8QnYSw1+Uoks
 aCfSH23JFY6Md8TPjYHoRQJhikEW6KsZ+zue7BC3AMAEl0rnf3CZyCzXyHvANPJxkPHiWBBpWvV/
 D/1d7+l+PmxJCFvdxzgiQpciHL7m0tbh53ymoHabC27dTg89WC5ZKuprIFAjDARGQNm57a8SMIjL
 kSeJ8usxSs6oRW0eujkNDaI1BZL4xlheqFLWgStYx12aCdmJgllbwzHk4lhd7+Z3ohEuqbhw2IGi
 K9BLVundUFjc1iJ5Hl/Q7TeMzDg6HYuTCyYgL61SIkBTYQaaIIEsvvc4Hs2Al+JCBW+Rho4Ph4F7
 35SUHIxrP601Lz/dsiahQ1DFoGJGH4QvNEG2z3H+DG8i/+nwAPUMRDNTlQhcPtKTIltiNXw4wYHH
 9itV4zOHtaDgH2x2DZDqYQ==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock validator forces to categorize multiple instances of a lock object
as the same lock class because it requires that struct lockdep_map and struct
lock_class_key instances are static objects. This can result in false
positive lockdep reports that are hard to suppress in an elegant way. Hence
add support for allocating instances of these objects dynamically.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/lockdep.h  |  2 ++
 kernel/locking/lockdep.c | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1fd82ff99c65..a10a131ccc9a 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -56,6 +56,7 @@ struct lockdep_subclass_key {
 
 struct lock_class_key {
 	struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
+	bool				dynamic:1;
 };
 
 extern struct lock_class_key __lockdep_no_validate__;
@@ -153,6 +154,7 @@ struct lockdep_map {
 	int				cpu;
 	unsigned long			ip;
 #endif
+	bool				dynamic:1;
 };
 
 static inline void lockdep_copy_map(struct lockdep_map *to,
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1efada2dd9dd..8a3d3f0b6d8d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -624,6 +624,16 @@ static int static_obj(void *obj)
 }
 #endif
 
+static bool is_valid_lockdep_map(struct lockdep_map *lock)
+{
+	return static_obj(lock) || lock->dynamic;
+}
+
+static bool is_valid_key(struct lock_class_key *key)
+{
+	return static_obj(key) || key->dynamic;
+}
+
 /*
  * To make lock name printouts unique, we calculate a unique
  * class->name_version generation counter:
@@ -716,7 +726,7 @@ static bool assign_lock_key(struct lockdep_map *lock)
 		lock->key = (void *)can_addr;
 	else if (__is_module_percpu_address(addr, &can_addr))
 		lock->key = (void *)can_addr;
-	else if (static_obj(lock))
+	else if (is_valid_lockdep_map(lock))
 		lock->key = (void *)lock;
 	else {
 		/* Debug-check: all keys must be persistent! */
@@ -752,7 +762,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	if (!lock->key) {
 		if (!assign_lock_key(lock))
 			return NULL;
-	} else if (!static_obj(lock->key)) {
+	} else if (!is_valid_key(lock->key)) {
 		return NULL;
 	}
 
@@ -3118,7 +3128,7 @@ static void __lockdep_init_map(struct lockdep_map *lock, const char *name,
 	/*
 	 * Sanity check, the lock-class key must be persistent:
 	 */
-	if (!static_obj(key)) {
+	if (!is_valid_key(key)) {
 		printk("BUG: key %px not in .data!\n", key);
 		/*
 		 * What it says above ^^^^^, I suggest you read it.
-- 
2.19.1.930.g4563a0d9d0-goog

