Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CD2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAD72147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="A3JbZHRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfBTEJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:09:14 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34139 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbfBTEJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 23:09:13 -0500
Received: by mail-qk1-f193.google.com with SMTP id a15so1152675qkc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 20:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xEHb23Q2l1fYivVKgVEsDTK7wpL+EEEEuo8D6bsBm4g=;
        b=A3JbZHRJxkJwV8HNuhnHXbDyTIP+RTNQzkhc2x3XKphSexBqf4wuhin81QHZEZngot
         QnyMIJAPqNF3zVB9NzqO65BWwX6NomXaVgjc5fnE7IlTDPQZiWcH9U7Is4ShPStkmTQQ
         bUq7nf+6uLHJjpTXhBXZSWxdyYG4jjk0yTHTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xEHb23Q2l1fYivVKgVEsDTK7wpL+EEEEuo8D6bsBm4g=;
        b=gDg/ydhiQy0DpmdMknK6XzUBjGhgNNx66FLk4hmKbQyXLGa/Nl1tP7mXoNC7BLgPp+
         rfrHlKY79XDm5Hkh4zuEEL2LNBCtR9WkLk0s9zdPsAJR+Jq0dOIeJv/unhHLiYHlnCp1
         9ZNAa5ZXQImXFFH2qeJbQciJEVO5gy8u/ncdA2AttDAsZoQerrVEPC3ClvSjenzl5CkI
         xYtv4L7sJxxZHfi1IA34m1lUOlFbxv9Kt0VeUkuy/Aw22bq2Tj2BPIl1QTheDw1WBe48
         l4PQLDGhNczwC6WncKDRiyucFjHzYrlAJy3wIkLtKLd5V2YUJ9XH6Q/OSo4+nri2BOJ2
         EbJQ==
X-Gm-Message-State: AHQUAubq9MrWPjUDO/9X7DJXNbszu6HPRE/exhDb7SUWzjQGaJPv0lZK
        7hCJPgZwjElPgWc7HPnmdlZRrIGrchs=
X-Google-Smtp-Source: AHgI3IboGx25ZRVgXIhky8qlIO/xQSM4TjFE3Jy4ldzyjuTU9bV27fcPP40P/CjEZcVRCpd1Pw/TJg==
X-Received: by 2002:a0c:d0db:: with SMTP id b27mr74215qvh.223.1550635751731;
        Tue, 19 Feb 2019 20:09:11 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id s19sm2024593qth.80.2019.02.19.20.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 20:09:10 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>, paulmck@linux.ibm.com
Subject: [RFC 3/5] sched/cpufreq: Fix incorrect RCU API usage
Date:   Tue, 19 Feb 2019 23:08:25 -0500
Message-Id: <20190220040827.136184-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190220040827.136184-1-joel@joelfernandes.org>
References: <20190220040827.136184-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Fernandes <joel@joelfernandes.org>

Recently I added an RCU annotation check to rcu_assign_pointer(). All
pointers assigned to RCU protected data are to be annotated with __rcu
inorder to be able to use rcu_assign_pointer() similar to checks in
other RCU APIs.

This resulted in a sparse error: kernel//sched/cpufreq.c:41:9: sparse:
error: incompatible types in comparison expression (different address
spaces)

Fix this by using the correct APIs for RCU accesses. This will
potentially avoid any future bugs in the code. If it is felt that RCU
protection is not needed here, then the rcu_assign_pointer call can be
dropped and replaced with, say, WRITE_ONCE or smp_store_release. Or, may
be we add a new API to do it. But calls rcu_assign_pointer seems an
abuse of the RCU API.

Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/sched/cpufreq.c | 8 ++++++--
 kernel/sched/sched.h   | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 22bd8980f32f..c9aeb3bf5dc2 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -7,7 +7,7 @@
  */
 #include "sched.h"
 
-DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+DEFINE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
 /**
  * cpufreq_add_update_util_hook - Populate the CPU's update_util_data pointer.
@@ -34,8 +34,12 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
 	if (WARN_ON(!data || !func))
 		return;
 
-	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
+	rcu_read_lock();
+	if (WARN_ON(rcu_dereference(per_cpu(cpufreq_update_util_data, cpu)))) {
+		rcu_read_unlock();
 		return;
+	}
+	rcu_read_unlock();
 
 	data->func = func;
 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d04530bf251f..2ab545d40381 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2166,7 +2166,7 @@ static inline u64 irq_time_read(int cpu)
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
 
 #ifdef CONFIG_CPU_FREQ
-DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+DECLARE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
 /**
  * cpufreq_update_util - Take a note about CPU utilization changes.
-- 
2.21.0.rc0.258.g878e2cd30e-goog

