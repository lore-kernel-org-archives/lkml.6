Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEB9C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173E72084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="v4a1ZtcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173E72084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeLKWP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:15:28 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:50703 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbeLKWOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=znBliYpxPlA7DmxOIWwjDPHMuL97y4/gv61rTzz6u7A=; b=v4a1ZtcPd/S6
        USJ2j0G4GFoVw6peqtZ8tGZ6XYxVNFla0Lzk+L8pT+BLhjFRJh+08Lp3tk52y8senGBGc461us4+j
        uJj/+oUCenmOQRF25LJkWlwVxYCHd7UD0bDXIU+AhEWLUuqolIVG/zVEykdYjEiDxyXvWdeV+xtCD
        7vGmgKArJW7A1l8PzRWQvKYucAGkhtEwCwVvXcfLHDRDfTqoxmRoHFVmJPhlc61y8mAHtnGJ1QXcf
        caP519Og5udRib4P80+3MRUJ65NCuS/vPVajlveWJAn6u4Dk6sBYx75ntRbmm7YoZQV1C0FL0q5B5
        glECglXaWB5EshyhsNtuZA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gWqHu-0006r6-2A; Tue, 11 Dec 2018 23:13:58 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 0A16AC075C;
        Tue, 11 Dec 2018 23:13:38 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v4 02/15] locking/lockdep: Make zap_class() remove all matching lock order entries
Date:   Tue, 11 Dec 2018 14:13:08 -0800
Message-Id: <20181211221321.196536-3-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5kLQXEUPbmxzXjmsudaBN3J602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORofa0IoK7bmZVFWkPkt
 YyLjSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVH6GzPz+r852EXXeYX4ImMyzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/1fKPQPEuPra72LpiTN2rUT6Y9xm3kmEG6YzhU+GhpkbBQllJXXeGX8fAMzPNqrCG8d
 f68W0InH/+bTMKNm38MHmfnhF9U/dVeZ9xbDBH3UiCDt3yfQxlhCaKc8coJFU+8pOMQJvQ/Ck3ii
 U+4DQAj38VcpxSBd167NiiR0DMS/T4GvZUhi7BJ7QOeRk66G/m8jRjgifve2wm5/91NPphLvwHwc
 YQ4sJw/BhHqUYLW11GDHm9Up7LfTG3yoeF6ndmWqltsYPx2OGpapJQwbU6lxiSPQp1QN34zBsoOP
 LAVTMEsOC75ReJHeVybconOP07vieGH1wwKQhUuVJ6kr80wTGaiTXW7z2lMqAnbumOwh0pBt+CpM
 AQh13vqug5h3DxwLP7iG9/ikbKp5KDVEThGRH3H/eN4qk0fc6CZfoUDf1ZIAiDKO1d3jsySf+J0s
 zc3volzWZu5fe7ghC/HzOt6Mfqb5R4VemuUI6bcEARsm0JyPNwoZFF/BeruF9IPYgMLyX2cd5RrN
 VWdImRunoKaV5Izq4VabSfIGUY8RJ38dSGEP+JYPRX76oPSBtBBPLYw1mZQfhvSXPX1npIQpGBE7
 MnJiHvQ8gQs8eCOaG4DvtrnB4hxWBV/7jCqhcJq0hur2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that all lock order entries that refer to a class are removed
from the list_entries[] array when a kernel module is unloaded.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/lockdep.h  |  1 +
 kernel/locking/lockdep.c | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index c5335df2372f..71caa1118f4c 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -178,6 +178,7 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
 struct lock_list {
 	struct list_head		entry;
 	struct lock_class		*class;
+	struct lock_class		*links_to;
 	struct stack_trace		trace;
 	int				distance;
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6b89fc39fcf0..7ca9ac392dde 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -859,7 +859,8 @@ static struct lock_list *alloc_list_entry(void)
 /*
  * Add a new dependency to the head of the list:
  */
-static int add_lock_to_list(struct lock_class *this, struct list_head *head,
+static int add_lock_to_list(struct lock_class *this,
+			    struct lock_class *links_to, struct list_head *head,
 			    unsigned long ip, int distance,
 			    struct stack_trace *trace)
 {
@@ -873,6 +874,7 @@ static int add_lock_to_list(struct lock_class *this, struct list_head *head,
 		return 0;
 
 	entry->class = this;
+	entry->links_to = links_to;
 	entry->distance = distance;
 	entry->trace = *trace;
 	/*
@@ -1918,14 +1920,14 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 * Ok, all validations passed, add the new lock
 	 * to the previous lock's dependency list:
 	 */
-	ret = add_lock_to_list(hlock_class(next),
+	ret = add_lock_to_list(hlock_class(next), hlock_class(prev),
 			       &hlock_class(prev)->locks_after,
 			       next->acquire_ip, distance, trace);
 
 	if (!ret)
 		return 0;
 
-	ret = add_lock_to_list(hlock_class(prev),
+	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
 			       &hlock_class(next)->locks_before,
 			       next->acquire_ip, distance, trace);
 	if (!ret)
@@ -4128,15 +4130,20 @@ void lockdep_reset(void)
  */
 static void zap_class(struct lock_class *class)
 {
+	struct lock_list *entry;
 	int i;
 
 	/*
 	 * Remove all dependencies this lock is
 	 * involved in:
 	 */
-	for (i = 0; i < nr_list_entries; i++) {
-		if (list_entries[i].class == class)
-			list_del_rcu(&list_entries[i].entry);
+	for (i = 0, entry = list_entries; i < nr_list_entries; i++, entry++) {
+		if (entry->class != class && entry->links_to != class)
+			continue;
+		list_del_rcu(&entry->entry);
+		/* Clear .class and .links_to to avoid double removal. */
+		WRITE_ONCE(entry->class, NULL);
+		WRITE_ONCE(entry->links_to, NULL);
 	}
 	/*
 	 * Unhash the class and remove it from the all_lock_classes list:
-- 
2.20.0.rc2.403.gdbc3b29805-goog

