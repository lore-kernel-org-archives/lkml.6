Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA93DC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FC9214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="eKhl3CZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FC9214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbeLDA3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:29:46 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:46371 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbeLDA3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=4OvCUaMwx00J4g/5D3qOx/Ovy5uxi+NZV3TWG/vBn6I=; b=eKhl3CZmnFFb
        Xqylm5lJMeAIP6sfTXXs1YV5UdkxMHl7szmWirfztC4Aa+h2eokaM7NymxN6q/SwSNAyur2RaOad+
        a0crLta/Z+tFljXqVc8uJGdpG1OlMDwFnzgayxkqMlu9O/RsAlEjx/UY6FTpq5lYWRMCifkkWoG9U
        zTsyugYAXm9EvVQXmo32IarwVGQW3MbxWKhb65mM0xolyHg1W36nEGjxup8cze8ARIWW1HxOSaSuW
        M6KaBZZybL1jP+aKxi4zfsJpnbmH+5hGuaQCOgD8ljYPyLePHWknbwpJ8IcjQwbiRiOg+VKtv0+vM
        Dg3/VljIct+6lxgBY+yo8A==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gTyad-0008AN-IQ; Tue, 04 Dec 2018 01:29:32 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 207F4C06CF;
        Tue,  4 Dec 2018 01:29:24 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 20/24] locking/lockdep: Introduce __lockdep_free_key_range()
Date:   Mon,  3 Dec 2018 16:28:29 -0800
Message-Id: <20181204002833.55452-21-bvanassche@acm.org>
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
X-Filter-ID: EX5BVjFpneJeBchSMxfU5ljFmdCy8PBXEsQqtfFsfGR602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORoMI4n3mMFsvRHqF2Ra
 AxupSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVFg5Rj2g0fgHrO2rAGaVRcnzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/1fKPQPEuPra72LpiTN2rUT6Y9xm3kmEG6YzhU+GhpkbBQllJXXeGX8fAMzPNqrCG8d
 f68W0InH/+bTMKNm38MHmfnhF9U/dVeZ9xbDBH3UiCDt3yfQxlhCaKc8coJFU+8pOMQJvQ/Ck3ii
 U+4DQAj38VcpxSBd167NiiR0DMS/T4GvZUhi7BJ7QOeRk66G/m8FNKZFrpMP+RrTJ6+mm5EZCkhR
 fjuBfEvCgQr1YeT8MOmi4NCsWYMWmOQKSBgUT96qltsYPx2OGpapJQwbU6lxiSPQp1QN34zBsoOP
 LAVTMEsOC75ReJHeVybconOP07vieGH1wwKQhUuVJ6kr80wTGaiTXW7z2lMqAnbumOwh0pBt+CpM
 AQh13vqug5h3DxxUYtnclBs1wCMGXEtnGPydiTHvdUmxqsGQsz3hhUqp2pIAiDKO1d3jsySf+J0s
 zc3volzWZu5fe7ghC/HzOt6Mfqb5R4VemuUI6bcEARsm0JyPNwoZFF/BeruF9IPYgMLyX2cd5RrN
 VWdImRunoKaV5Izq4VabSfIGUY8RJ38dSGEP+JYPRX76oPSBtBBPLYw1mZQfhvSXPX1npIQpGBE7
 MnJiHvQ8gQs8eCOaG4DvtrnB4hxWBV/7jCqhcJq0hur2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not change any functionality but makes the next patch
in this series easier to read.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6d99f3f0757c..c936fce5b9d7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4478,14 +4478,12 @@ static void schedule_free_zapped_classes(void)
 }
 
 /*
- * Used in module.c to remove lock classes from memory that is going to be
- * freed; and possibly re-used by other modules.
- *
- * We will have had one sync_sched() before getting here, so we're guaranteed
- * nobody will look up these exact classes -- they're properly dead but still
- * allocated.
+ * Remove all lock classes from the class hash table and from the
+ * all_lock_classes list whose key or name is in the address range
+ * [start, start + size). Move these lock classes to the
+ * @zapped_classes list.
  */
-void lockdep_free_key_range(void *start, unsigned long size)
+static void __lockdep_free_key_range(void *start, unsigned long size)
 {
 	struct lock_class *class;
 	struct hlist_head *head;
@@ -4496,9 +4494,6 @@ void lockdep_free_key_range(void *start, unsigned long size)
 	raw_local_irq_save(flags);
 	locked = graph_lock();
 
-	/*
-	 * Unhash all classes that were created by this module:
-	 */
 	for (i = 0; i < CLASSHASH_SIZE; i++) {
 		head = classhash_table + i;
 		hlist_for_each_entry_rcu(class, head, hash_entry) {
@@ -4513,7 +4508,19 @@ void lockdep_free_key_range(void *start, unsigned long size)
 	if (locked)
 		graph_unlock();
 	raw_local_irq_restore(flags);
+}
 
+/*
+ * Used in module.c to remove lock classes from memory that is going to be
+ * freed; and possibly re-used by other modules.
+ *
+ * We will have had one sync_sched() before getting here, so we're guaranteed
+ * nobody will look up these exact classes -- they're properly dead but still
+ * allocated.
+ */
+void lockdep_free_key_range(void *start, unsigned long size)
+{
+	__lockdep_free_key_range(start, size);
 	/*
 	 * Do not wait for concurrent look_up_lock_class() calls. If any such
 	 * concurrent call would return a pointer to one of the lock classes
-- 
2.20.0.rc1.387.gf8505762e3-goog

