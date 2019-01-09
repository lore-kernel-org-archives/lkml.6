Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838B7C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4387C206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="S6P3eIca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfAIVCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:02:55 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:52169 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfAIVCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=cRHB6v+5M3SL4PGCzCmOYFq5nIo0S/bAGV5jvR/m8Qg=; b=S6P3eIcanpcD
        AUyBPggcYjDKqIzJvo8JmqgvJnbwJQF041RPxLRk460dQTKlUbzqU23zUvdQK7eDCjCtZhQKe9yCE
        iZ/w29CY36+7AikLf7QSj/Rg3R0Usb8eCD7K6np8scUNDYmsruhrfmJxMuYSqyFdHz47vOnVaDBn3
        +JJqqj20OY7slcKhTErZByQXle8gTu5/n02n0r1bQIEjixODz18+mC5bDSthQZwRb9aH8beX6moZ5
        /cFFr4xbg+5GamzrL1m9KabuUsHy2YNQy7mMWJRgruOGv0Eui+Jms1qyB91CCio9wF/9NAX1i4e2C
        55Q4m6hXArZrmUi9TEtxIw==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1ghKzr-0009DF-81; Wed, 09 Jan 2019 22:02:43 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 1A127C07CD;
        Wed,  9 Jan 2019 22:02:37 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v6 10/16] locking/lockdep: Introduce lockdep_next_lockchain() and lock_chain_count()
Date:   Wed,  9 Jan 2019 13:01:58 -0800
Message-Id: <20190109210204.192109-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190109210204.192109-1-bvanassche@acm.org>
References: <20190109210204.192109-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5vr+MVtpjktRCjFUZUKSUQt602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORqM+52BNrKIKoSNp67Z
 WA7eSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVH6GzPz+r852EXXeYX4ImMyzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/1fKPQPEuPra72LpiTN2rUT6Y9xm3kmEG6YzhU+GhpkbBQllJXXeGX8fAMzPNqrCG8d
 f68W0InH/+bTMKNm38MHmfnhF9U/dVeZ9xbDBH3UiCDt3yfQxlhCaKc8coJFU+8pOMQJvQ/Ck3ii
 U+4DQAj38VcpxSBd167NiiR0DMS/T4GvZUhi7BJ7QOeRk66G/m8jRjgifve2wm5/91NPphLv+z+B
 LZcNbgROkcUUt9xVJMkbDexj3GNq3Ba9L8bPF+CqltsYPx2OGpapJQwbU6lxiSPQp1QN34zBsoOP
 LAVTMEsOC75ReJHeVybconOP07vieGH1wwKQhUuVJ6kr80wTGaiTXW7z2lMqAnbumOwh0pBt+CpM
 AQh13vqug5h3Dxw3R6uDCaZaKNta3utckIYDWOxZERl7aun/zIs3KN8kA5IAiDKO1d3jsySf+J0s
 zc1uD9pAwuLhqtxw5exj8Aw7fqb5R4VemuUI6bcEARsm0JyPNwoZFF/BeruF9IPYgMLyX2cd5RrN
 VWdImRunoKaV5Izq4VabSfIGUY8RJ38dSGEP+JYPRX76oPSBtBBPLYw1mZQfhvSXPX1npIQpGBE7
 MnJiHvQ8gQs8eCOaG4DvtrnB4hxWBV/7jCqhcJq0hur2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not change any functionality but makes the next patch in
this series easier to read.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c           | 16 +++++++++++++++-
 kernel/locking/lockdep_internals.h |  3 ++-
 kernel/locking/lockdep_proc.c      | 12 ++++++------
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5e8a3a17bb94..ef3809e21fa9 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2110,7 +2110,7 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 	return 0;
 }
 
-unsigned long nr_lock_chains;
+static unsigned long nr_lock_chains;
 struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
 int nr_chain_hlocks;
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
@@ -2244,6 +2244,20 @@ static int check_no_collision(struct task_struct *curr,
 	return 1;
 }
 
+/*
+ * Given an index that is >= -1, return the index of the next lock chain.
+ * Return -2 if there is no next lock chain.
+ */
+long lockdep_next_lockchain(long i)
+{
+	return i + 1 < nr_lock_chains ? i + 1 : -2;
+}
+
+unsigned long lock_chain_count(void)
+{
+	return nr_lock_chains;
+}
+
 /*
  * Adds a dependency chain into chain hashtable. And must be called with
  * graph_lock held.
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 88c847a41c8a..ba8a4ac7bd04 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -96,7 +96,8 @@ struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i);
 
 extern unsigned long nr_lock_classes;
 extern unsigned long nr_list_entries;
-extern unsigned long nr_lock_chains;
+long lockdep_next_lockchain(long i);
+unsigned long lock_chain_count(void);
 extern int nr_chain_hlocks;
 extern unsigned long nr_stack_trace_entries;
 
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 3d31f9b0059e..9c49ec645d8b 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -104,18 +104,18 @@ static const struct seq_operations lockdep_ops = {
 #ifdef CONFIG_PROVE_LOCKING
 static void *lc_start(struct seq_file *m, loff_t *pos)
 {
+	if (*pos < 0)
+		return NULL;
+
 	if (*pos == 0)
 		return SEQ_START_TOKEN;
 
-	if (*pos - 1 < nr_lock_chains)
-		return lock_chains + (*pos - 1);
-
-	return NULL;
+	return lock_chains + (*pos - 1);
 }
 
 static void *lc_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	(*pos)++;
+	*pos = lockdep_next_lockchain(*pos - 1) + 1;
 	return lc_start(m, pos);
 }
 
@@ -268,7 +268,7 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 
 #ifdef CONFIG_PROVE_LOCKING
 	seq_printf(m, " dependency chains:             %11lu [max: %lu]\n",
-			nr_lock_chains, MAX_LOCKDEP_CHAINS);
+			lock_chain_count(), MAX_LOCKDEP_CHAINS);
 	seq_printf(m, " dependency chain hlocks:       %11d [max: %lu]\n",
 			nr_chain_hlocks, MAX_LOCKDEP_CHAIN_HLOCKS);
 #endif
-- 
2.20.1.97.g81188d93c3-goog

