Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7631EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E474206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="BMa/X5ss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfAIVDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:03:07 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:43691 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbfAIVDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=Q7xA0GDmMHhgRMqMFsp8hECvSOtsZQmF1tF+hJRQ2fk=; b=BMa/X5ssa7yg
        obU5+6XsZQKrlTPSchEb/YzmH0ATenKP7fiz6eUvWV63koSEFgI60e21lJaiEng6QgkehbwBSyrlS
        YBeJk87pqcs5uzf2JgyotXcuDvDG5HBDT0fA7xp38bOf3/ck6Ow0boGtrqjrO2TT5uhjKbHeOaqzt
        ChHXKs0S9MMVcDLBcpAurNVtUnR5qOdK5faNjMtMDryeITNe65gEFfkFn2PgF/198KPYDwAP/cTVM
        xRVWKLaWvm4fPgGWNivxKlWEO6zPCYFjZsPWlu8b2nyoBZHF2YdKvWTPhfIrcziyXN2GhoH13ML74
        xkbMo0h/k95ueghJEXHmVQ==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1ghKzm-0009Cq-56; Wed, 09 Jan 2019 22:02:39 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id AC4BFC07CD;
        Wed,  9 Jan 2019 22:02:17 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v6 01/16] locking/lockdep: Fix reported required memory size
Date:   Wed,  9 Jan 2019 13:01:49 -0800
Message-Id: <20190109210204.192109-2-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5sKHZyMAipyrB7uNJOZQLZ1602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORp/uw+YHA3mEyeVo9Hz
 0srwSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVFg5Rj2g0fgHrO2rAGaVRcnzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/1fKPQPEuPra72LpiTN2rUT6Y9xm3kmEG6YzhU+GhpkbBQllJXXeGX8fAMzPNqrCG8d
 f68W0InH/+bTMKNm38MHmfnhF9U/dVeZ9xbDBH3UiCDt3yfQxlhCaKc8coJFU+8pOMQJvQ/Ck3ii
 U+4DQAj38VcpxSBd167NiiR0DMS/T4GvZUhi7BJ7QOeRk66G/m8FNKZFrpMP+RrTJ6+mm5EZqn84
 guK+3dw+Jq9e0+PM/iXff8kj6gUf0g36VNvpM6CqltsYPx2OGpapJQwbU6lxiSPQp1QN34zBsoOP
 LAVTMEsOC75ReJHeVybconOP07vieGH1wwKQhUuVJ6kr80wTGaiTXW7z2lMqAnbumOwh0pBt+CpM
 AQh13vqug5h3Dxz7BcNfbYM5loyLRH+tfKltr4ttQvpOaAie0al3Riym7JIAiDKO1d3jsySf+J0s
 zc1uD9pAwuLhqtxw5exj8Aw7fqb5R4VemuUI6bcEARsm0JyPNwoZFF/BeruF9IPYgMLyX2cd5RrN
 VWdImRunoKaV5Izq4VabSfIGUY8RJ38dSGEP+JYPRX76oPSBtBBPLYw1mZQfhvSXPX1npIQpGBE7
 MnJiHvQ8gQs8eCOaG4DvtrnB4hxWBV/7jCqhcJq0hur2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the sizeof(array element time) * (array size) expressions into
sizeof(array). This fixes the size computations of the classhash_table[]
and chainhash_table[] arrays. Commit a63f38cc4ccf ("locking/lockdep:
Convert hash tables to hlists") namely changed the type of the elements
of that array from struct list_head into struct hlist_head.

Lock chains are only tracked with CONFIG_PROVE_LOCKING=y. Do not report
the memory required for the lock chain array if CONFIG_PROVE_LOCKING=n.
See also commit ca58abcb4a6d ("lockdep: sanitise CONFIG_PROVE_LOCKING").

Include the size of the chain_hlocks[] array.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 95932333a48b..cb3fa7042886 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4278,20 +4278,21 @@ void __init lockdep_init(void)
 	printk("... MAX_LOCKDEP_CHAINS:      %lu\n", MAX_LOCKDEP_CHAINS);
 	printk("... CHAINHASH_SIZE:          %lu\n", CHAINHASH_SIZE);
 
-	printk(" memory used by lock dependency info: %lu kB\n",
-		(sizeof(struct lock_class) * MAX_LOCKDEP_KEYS +
-		sizeof(struct list_head) * CLASSHASH_SIZE +
-		sizeof(struct lock_list) * MAX_LOCKDEP_ENTRIES +
-		sizeof(struct lock_chain) * MAX_LOCKDEP_CHAINS +
-		sizeof(struct list_head) * CHAINHASH_SIZE
+	printk(" memory used by lock dependency info: %zu kB\n",
+	       (sizeof(list_entries) +
+		sizeof(lock_classes) +
+		sizeof(classhash_table) +
+		sizeof(chainhash_table)
 #ifdef CONFIG_PROVE_LOCKING
-		+ sizeof(struct circular_queue)
+		+ sizeof(lock_cq)
+		+ sizeof(lock_chains)
+		+ sizeof(chain_hlocks)
 #endif
 		) / 1024
 		);
 
-	printk(" per task-struct memory footprint: %lu bytes\n",
-		sizeof(struct held_lock) * MAX_LOCK_DEPTH);
+	printk(" per task-struct memory footprint: %zu bytes\n",
+	       sizeof(((struct task_struct *)NULL)->held_locks));
 }
 
 static void
-- 
2.20.1.97.g81188d93c3-goog

