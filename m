Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38920C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F354020850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="AfhG0Wv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F354020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeLDAae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:30:34 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:51367 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeLDA3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=3l8Jcl4/XNWcFHzP/iRs+BlcyQS3yGxupv9/mq0KTWU=; b=AfhG0Wv+gHy4
        S5h38OJde0BHcMl0/2zi3IuWr8/1iiZUroPoLZzeGnYIPI6pCprqjMTUFUgEMoOxfBiF3spr+xL28
        QRS/min5X+qyvgDIS+yBEaUvc3D7aMzSCu+yZdNzpTNJ1i/hWSPtiZ59SDmnBT5k1YXViDuP4tWCI
        WSE8CdDDBqXgZMQlHMNyAU3y/X3RRvzuRuLJNSuenFUwQadk/CuGHApLilx2DHkHCIM1ZdOJp1ACv
        biS8SpaOtKV9coJOvmUOTdHlYwzZq7K0ab5v/a4zsWAyaEA16HuJGcmZ5AX83jKduNbFKSvpGkrQ+
        KS0jQPeCjFaMnbVq+tvkaw==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gTyaQ-00087E-Sm; Tue, 04 Dec 2018 01:29:15 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 4714EC05CD;
        Tue,  4 Dec 2018 01:29:12 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 13/24] locking/lockdep: Stop using RCU primitives to access all_lock_classes
Date:   Mon,  3 Dec 2018 16:28:22 -0800
Message-Id: <20181204002833.55452-14-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5p/ySBd5G5CteI26imFMaIN602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORoJP7aP9n3Z83EPmPem
 4T4+SNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVFg5Rj2g0fgHrO2rAGaVRcnzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/1fKPQPEuPra72LpiTN2rUT6Y9xm3kmEG6YzhU+GhpkbBQllJXXeGX8fAMzPNqrCG8d
 f68W0InH/+bTMKNm38MHmfnhF9U/dVeZ9xbDBH3UiCDt3yfQxlhCaKc8coJFU+8pOMQJvQ/Ck3ii
 U+4DQAj38VcpxSBd167NiiR0DMS/T4GvZUhi7BJ7QOeRk66G/m8FNKZFrpMP+RrTJ6+mm5EZLqv4
 0CQYuZ2e/1jowBYTt7jbuiqoegAUIkqF7XCkxWWqltsYPx2OGpapJQwbU6lxiSPQp1QN34zBsoOP
 LAVTMEsOC75ReJHeVybconOP07vieGH1wwKQhUuVJ6kr80wTGaiTXW7z2lMqAnbumOwh0pBt+CpM
 AQh13vqug5h3DxxS3/f4PoWo0KaqELFP2GV38kUGdXblYoaaDOxTGD5hbpIAiDKO1d3jsySf+J0s
 zc3volzWZu5fe7ghC/HzOt6Mfqb5R4VemuUI6bcEARsm0JyPNwoZFF/BeruF9IPYgMLyX2cd5RrN
 VWdImRunoKaV5Izq4VabSfIGUY8RJ38dSGEP+JYPRX76oPSBtBBPLYw1mZQfhvSXPX1npIQpGBE7
 MnJiHvQ8gQs8eCOaG4DvtrnB4hxWBV/7jCqhcJq0hur2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the previous patch all code that accesses the 'all_lock_classes'
list holds the graph lock. Hence use regular list primitives instead of
their RCU variants to access this list.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e78623819184..5c837a537273 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -629,7 +629,8 @@ static int static_obj(void *obj)
 
 /*
  * To make lock name printouts unique, we calculate a unique
- * class->name_version generation counter:
+ * class->name_version generation counter. The caller must hold the graph
+ * lock.
  */
 static int count_matching_names(struct lock_class *new_class)
 {
@@ -639,7 +640,7 @@ static int count_matching_names(struct lock_class *new_class)
 	if (!new_class->name)
 		return 0;
 
-	list_for_each_entry_rcu(class, &all_lock_classes, lock_entry) {
+	list_for_each_entry(class, &all_lock_classes, lock_entry) {
 		if (new_class->key - new_class->subclass == class->key)
 			return class->name_version;
 		if (class->name && !strcmp(class->name, new_class->name))
@@ -803,7 +804,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	/*
 	 * Add it to the global list of classes:
 	 */
-	list_add_tail_rcu(&class->lock_entry, &all_lock_classes);
+	list_add_tail(&class->lock_entry, &all_lock_classes);
 
 	if (verbose(class)) {
 		graph_unlock();
@@ -4122,6 +4123,9 @@ void lockdep_reset(void)
 	raw_local_irq_restore(flags);
 }
 
+/*
+ * Remove all references to a lock class. The caller must hold the graph lock.
+ */
 static void zap_class(struct lock_class *class)
 {
 	int i;
@@ -4138,7 +4142,7 @@ static void zap_class(struct lock_class *class)
 	 * Unhash the class and remove it from the all_lock_classes list:
 	 */
 	hlist_del_rcu(&class->hash_entry);
-	list_del_rcu(&class->lock_entry);
+	list_del(&class->lock_entry);
 
 	RCU_INIT_POINTER(class->key, NULL);
 	RCU_INIT_POINTER(class->name, NULL);
-- 
2.20.0.rc1.387.gf8505762e3-goog

