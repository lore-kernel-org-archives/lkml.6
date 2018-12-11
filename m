Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C46BC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521942084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="q4Nhyw5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521942084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeLKWPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:15:38 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:57443 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbeLKWOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=c8s0M20p1/CbFrHVNww9eD30asLNx5c3Ivo4SuU75XA=; b=q4Nhyw5vPV45
        c8vkFonJ4cHvhZ2HigtTDnrDyDT9TxiqK8DP2LDCCxwCDYpWKSfJUAdmjwGCWWkIkSvhFEq4W/5U7
        ZOM+ZXcZAf7ZNdUOXl8JAKbiy/5eTavzpPw+Ebeq5MCDrR5LiobXcew7pX4c5hkLmxQ7avdZR64xY
        4VOEyPGQBfgsT7gbdr66WNlDOouecKKBT042f0wiJxT7I+YHc9mYyAF1sMxAGQ42EQMcwji0wMk1B
        TkH0Jj1QeSoV5ckNyWL+KaacKuEfXuyr27XbOD/TRZJn4yqT7zXGHOPNNal2KQENHrnYKyRjX6TDV
        XZH3n5jaXN2AXvsHx3sXOg==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gWqHu-0006r0-3u; Tue, 11 Dec 2018 23:13:58 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 9799DC0776;
        Tue, 11 Dec 2018 23:13:43 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v4 04/15] locking/lockdep: Initialize the locks_before and locks_after lists earlier
Date:   Tue, 11 Dec 2018 14:13:10 -0800
Message-Id: <20181211221321.196536-5-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5sKMkD89WZfXwDtXMbgLygh602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORqid7t7vRH68+t6blEV
 gZZXSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVH6GzPz+r852EXXeYX4ImMyzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/1fKPQPEuPra72LpiTN2rUT6Y9xm3kmEG6YzhU+GhpkbBQllJXXeGX8fAMzPNqrCG8d
 f68W0InH/+bTMKNm38MHmfnhF9U/dVeZ9xbDBH3UiCDt3yfQxlhCaKc8coJFU+8pOMQJvQ/Ck3ii
 U+4DQAj38VcpxSBd167NiiR0DMS/T4GvZUhi7BJ7QOeRk66G/m8jRjgifve2wm5/91NPphLvS3MO
 GrFsxo36HWRZdhjK7SFeETgDl3PwKvXCHlDl/OyqltsYPx2OGpapJQwbU6lxiSPQp1QN34zBsoOP
 LAVTMEsOC75ReJHeVybconOP07vieGH1wwKQhUuVJ6kr80wTGaiTXW7z2lMqAnbumOwh0pBt+CpM
 AQh13vqug5h3Dxw+dPgQqdM/6DS1RduEf/sJggftsSSoQnvZBPLP/RwQt5IAiDKO1d3jsySf+J0s
 zc3volzWZu5fe7ghC/HzOt6Mfqb5R4VemuUI6bcEARsm0JyPNwoZFF/BeruF9IPYgMLyX2cd5RrN
 VWdImRunoKaV5Izq4VabSfIGUY8RJ38dSGEP+JYPRX76oPSBtBBPLYw1mZQfhvSXPX1npIQpGBE7
 MnJiHvQ8gQs8eCOaG4DvtrnB4hxWBV/7jCqhcJq0hur2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not change any functionality. A later patch will reuse
lock classes that have been freed. In combination with that patch this
patch wil have the effect of initializing lock class order lists once
instead of every time a lock class structure is reinitialized.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 7ca9ac392dde..9ab782378b3b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -735,6 +735,25 @@ static bool assign_lock_key(struct lockdep_map *lock)
 	return true;
 }
 
+/*
+ * Initialize the lock_classes[] array elements.
+ */
+static void init_data_structures_once(void)
+{
+	static bool initialization_happened;
+	int i;
+
+	if (likely(initialization_happened))
+		return;
+
+	initialization_happened = true;
+
+	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
+		INIT_LIST_HEAD(&lock_classes[i].locks_after);
+		INIT_LIST_HEAD(&lock_classes[i].locks_before);
+	}
+}
+
 /*
  * Register a lock's class in the hash-table, if the class is not present
  * yet. Otherwise we look it up. We cache the result in the lock object
@@ -775,6 +794,8 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 			goto out_unlock_set;
 	}
 
+	init_data_structures_once();
+
 	/*
 	 * Allocate a new key from the static array, and add it to
 	 * the hash:
@@ -793,8 +814,8 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	class->key = key;
 	class->name = lock->name;
 	class->subclass = subclass;
-	INIT_LIST_HEAD(&class->locks_before);
-	INIT_LIST_HEAD(&class->locks_after);
+	WARN_ON_ONCE(!list_empty(&class->locks_before));
+	WARN_ON_ONCE(!list_empty(&class->locks_after));
 	class->name_version = count_matching_names(class);
 	/*
 	 * We use RCU's safe list-add method to make
@@ -4176,6 +4197,8 @@ void lockdep_free_key_range(void *start, unsigned long size)
 	int i;
 	int locked;
 
+	init_data_structures_once();
+
 	raw_local_irq_save(flags);
 	locked = graph_lock();
 
@@ -4239,6 +4262,8 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 	unsigned long flags;
 	int j, locked;
 
+	init_data_structures_once();
+
 	raw_local_irq_save(flags);
 	locked = graph_lock();
 
-- 
2.20.0.rc2.403.gdbc3b29805-goog

