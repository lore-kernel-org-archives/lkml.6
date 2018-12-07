Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0141DC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B672B20850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="tiC2qez4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B672B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeLGBPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:15:09 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:56471 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeLGBNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=5pg6AfA10YSgD61y57szkhFAxsqm2kI8Rgun7xGpR9E=; b=tiC2qez4+OJt
        vKe1WoZy1HmVgwkitUSAQYOu/le/NMDoDfoozOk4Ft5YUNhaS6SqMagua27KAi3DLgTxKijLwWPTN
        kEHX614KfvB76oxSinySa8JnO4t+YK9BEVyH2hX97D2ZN3zccG3a4YVBMVfCeiwjW7JsnhWA5egu2
        BxlmahiUApCGKlasVCe+92iDx8/7iYzazkgWYuBzsnUMKBIJyERnZEHVCovJOP8j+7IZ4MrDfANJJ
        7vlOgNLLCN5dtAauvUQJJnnoIFKi1hGpUmIk0Sqfla5lRUMxMUItcJD2B97iP8urVVzoYCjfZMYhX
        odRxSwaqpn1l2QN/JU16OQ==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gV4hU-000C7H-0g; Fri, 07 Dec 2018 02:13:04 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 0D253C0D81;
        Fri,  7 Dec 2018 02:13:00 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v3 13/24] locking/lockdep: Stop using RCU primitives to access all_lock_classes
Date:   Thu,  6 Dec 2018 17:11:37 -0800
Message-Id: <20181207011148.251812-14-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.05)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5m/8PGk7DiZSCgLklVQX/jp602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORrIl93SQzXnjRCGFIkR
 cpN0SNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVH6GzPz+r852EXXeYX4ImMyzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/1fKPQPEuPra72LpiTN2rUT6Y9xm3kmEG6YzhU+GhpkbBQllJXXeGX8fAMzPNqrCG8d
 f68W0InH/+bTMKNm38MHmfnhF9U/dVeZ9xbDBH3UiCDt3yfQxlhCaKc8coJFU+8pOMQJvQ/Ck3ii
 U+4DQAj38VcpxSBd167NiiR0DMS/T4GvZUhi7BJ7QOeRk66G/m8jRjgifve2wm5/91NPphLv04Yk
 5+tCKJSS3QOMraKc09hAOAMaVmW0WD9d74ysVl6qltsYPx2OGpapJQwbU6lxiSPQp1QN34zBsoOP
 LAVTMEsOC75ReJHeVybconOP07vieGH1wwKQhUuVJ6kr80wTGaiTXW7z2lMqAnbumOwh0pBt+CpM
 AQh13vqug5h3DxxORtDNg61aKjCvuQXTQEQygW5/GXyyil1Nb8x7ffd+WJIAiDKO1d3jsySf+J0s
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
 kernel/locking/lockdep.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 737d2dd3ea56..5c837a537273 100644
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
@@ -4141,7 +4142,7 @@ static void zap_class(struct lock_class *class)
 	 * Unhash the class and remove it from the all_lock_classes list:
 	 */
 	hlist_del_rcu(&class->hash_entry);
-	list_del_rcu(&class->lock_entry);
+	list_del(&class->lock_entry);
 
 	RCU_INIT_POINTER(class->key, NULL);
 	RCU_INIT_POINTER(class->name, NULL);
-- 
2.20.0.rc2.403.gdbc3b29805-goog

