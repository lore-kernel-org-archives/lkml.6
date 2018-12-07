Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06727C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9AA20850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="CKId2JSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9AA20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeLGBNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:13:23 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:32895 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeLGBNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=Oy+hgOuYPa5qeXDHS0T0SGCKtoc6mzEO4V6APpBiBvQ=; b=CKId2JSHqAkM
        k823d/0q9k1MefD/OqYzsaobN7N9G9piDuzDLxdNQszoXXAaWSAK4kxqImnWMM9ntAR1qKkFNOiNo
        5kpxM2LzV0I/QdYSi+mQINnq92PGziqd9KIQ2oxQQ4FkNehooRQow2y33h6pHwGwWkwckCOJzpeCV
        7JSr2RUo6T2pRRgem0WIEqCWaAKdPSH5jFSMcbR3jB83+kmbzDxbremV0BenGs1nxA17on79CoTfE
        zgX0cEDS65keg+4YUp43bPfTKkE7bb9cuug8tk8ujrYmN+uq5YuVZAVRnxXuvXDjO0DjBPXcactXW
        aI38+u2dcR1GoIwxa1pSNA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gV4hO-0008o7-CS; Fri, 07 Dec 2018 02:12:59 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 97C86C0787;
        Fri,  7 Dec 2018 02:12:55 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v3 10/24] locking/lockdep: Introduce lock_class_cache_is_registered()
Date:   Thu,  6 Dec 2018 17:11:34 -0800
Message-Id: <20181207011148.251812-11-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5kNGTiBqqmF2scKIjEN2QEt602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORoWFSMrAXbPAlcpxW/G
 OJyASNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVFg5Rj2g0fgHrO2rAGaVRcnzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/1fKPQPEuPra72LpiTN2rUT6Y9xm3kmEG6YzhU+GhpkbBQllJXXeGX8fAMzPNqrCG8d
 f68W0InH/+bTMKNm38MHmfnhF9U/dVeZ9xbDBH3UiCDt3yfQxlhCaKc8coJFU+8pOMQJvQ/Ck3ii
 U+4DQAj38VcpxSBd167NiiR0DMS/T4GvZUhi7BJ7QOeRk66G/m8FNKZFrpMP+RrTJ6+mm5EZw/m1
 ikF23aSFvH9adizXnKsHiHIe1x2Om8LPxgheDBmqltsYPx2OGpapJQwbU6lxiSPQp1QN34zBsoOP
 LAVTMEsOC75ReJHeVybconOP07vieGH1wwKQhUuVJ6kr80wTGaiTXW7z2lMqAnbumOwh0pBt+CpM
 AQh13vqug5h3DxwhfoZDeMYzozGeIwTnk7Sq7TOCBgxtg8zRW79gqq9KTZIAiDKO1d3jsySf+J0s
 zc3volzWZu5fe7ghC/HzOt6Mfqb5R4VemuUI6bcEARsm0JyPNwoZFF/BeruF9IPYgMLyX2cd5RrN
 VWdImRunoKaV5Izq4VabSfIGUY8RJ38dSGEP+JYPRX76oPSBtBBPLYw1mZQfhvSXPX1npIQpGBE7
 MnJiHvQ8gQs8eCOaG4DvtrnB4hxWBV/7jCqhcJq0hur2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not change any functionality but makes the
lockdep_reset_lock() function easier to read.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 50 ++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b5c8fcb6c070..81388d028ac7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4201,13 +4201,33 @@ void lockdep_free_key_range(void *start, unsigned long size)
 	 */
 }
 
-void lockdep_reset_lock(struct lockdep_map *lock)
+/*
+ * Check whether any element of the @lock->class_cache[] array refers to a
+ * registered lock class. The caller must hold either the graph lock or the
+ * RCU read lock.
+ */
+static bool lock_class_cache_is_registered(struct lockdep_map *lock)
 {
 	struct lock_class *class;
 	struct hlist_head *head;
-	unsigned long flags;
 	int i, j;
-	int locked;
+
+	for (i = 0; i < CLASSHASH_SIZE; i++) {
+		head = classhash_table + i;
+		hlist_for_each_entry_rcu(class, head, hash_entry) {
+			for (j = 0; j < NR_LOCKDEP_CACHING_CLASSES; j++)
+				if (lock->class_cache[j] == class)
+					return true;
+		}
+	}
+	return false;
+}
+
+void lockdep_reset_lock(struct lockdep_map *lock)
+{
+	struct lock_class *class;
+	unsigned long flags;
+	int j, locked;
 
 	raw_local_irq_save(flags);
 
@@ -4227,24 +4247,14 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 	 * be gone.
 	 */
 	locked = graph_lock();
-	for (i = 0; i < CLASSHASH_SIZE; i++) {
-		head = classhash_table + i;
-		hlist_for_each_entry_rcu(class, head, hash_entry) {
-			int match = 0;
-
-			for (j = 0; j < NR_LOCKDEP_CACHING_CLASSES; j++)
-				match |= class == lock->class_cache[j];
-
-			if (unlikely(match)) {
-				if (debug_locks_off_graph_unlock()) {
-					/*
-					 * We all just reset everything, how did it match?
-					 */
-					WARN_ON(1);
-				}
-				goto out_restore;
-			}
+	if (unlikely(lock_class_cache_is_registered(lock))) {
+		if (debug_locks_off_graph_unlock()) {
+			/*
+			 * We all just reset everything, how did it match?
+			 */
+			WARN_ON(1);
 		}
+		goto out_restore;
 	}
 	if (locked)
 		graph_unlock();
-- 
2.20.0.rc2.403.gdbc3b29805-goog

