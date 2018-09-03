Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F247C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428CA2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428CA2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeICSsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:48:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34208 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeICSsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:48:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id g33-v6so908500wrd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 07:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TY06Ai6bYTbbS+qrbG4Xrza1Hq/jISH8yLquACFz/LM=;
        b=EebGpJVOTq++sUooJa2NyQudZ3F1E2YC4pRS2ozIz7WvwvDbji5Fp9QEQ4Dchoskyz
         i+dxkRvmQEFSI23EteFKMqocC+p+/ls0YXm5wQgyzPCKax0aDoyx3rYANTzn1luastcT
         9ucpqMAKVpDZk6mKUu/ohfQmoHp1T35eKD7ootaDN4LcE/XyF+Zhj0aht/f3rVLvHt29
         ekJSOnhuC00v8HVfFOMtcgcmdDaDZUbuMRGJFQUm6igT6hbvQMuYU9yY4NnxwRFmqrTR
         9+JMwXlBaoiFUuw7PBxGNCP/gMsgrVr+hfxa0AEV6SpCgX606fvwmFsTBt6J7v72ZQ7p
         wdww==
X-Gm-Message-State: APzg51BIPwajLSmsfUUS7noez2Tjh3xHDpuIqipj7tqv2trHW6dW4SIB
        4Y+7cUkf6JImFExoEZJbFJ8f5g==
X-Google-Smtp-Source: ANB0VdaQMoYnC7pJT9P3htmI4BU5VgU/ov7jEbGgCWscW0n92ukobuLgeTT3KpJoNaUyp3lE+UUjcg==
X-Received: by 2002:adf:bc44:: with SMTP id a4-v6mr20466755wrh.255.1535984900403;
        Mon, 03 Sep 2018 07:28:20 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.227.30])
        by smtp.gmail.com with ESMTPSA id b74-v6sm14175880wma.8.2018.09.03.07.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 07:28:19 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: [PATCH v5 1/5] sched/topology: Adding function partition_sched_domains_locked()
Date:   Mon,  3 Sep 2018 16:27:57 +0200
Message-Id: <20180903142801.20046-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903142801.20046-1-juri.lelli@redhat.com>
References: <20180903142801.20046-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Introducing function partition_sched_domains_locked() by taking
the mutex locking code out of the original function.  That way
the work done by partition_sched_domains_locked() can be reused
without dropping the mutex lock.

No change of functionality is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/sched/topology.h | 10 ++++++++++
 kernel/sched/topology.c        | 17 +++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 26347741ba50..57997caf61b6 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -162,6 +162,10 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 	return to_cpumask(sd->span);
 }
 
+extern void partition_sched_domains_locked(int ndoms_new,
+					   cpumask_var_t doms_new[],
+					   struct sched_domain_attr *dattr_new);
+
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 
@@ -206,6 +210,12 @@ extern void set_sched_topology(struct sched_domain_topology_level *tl);
 
 struct sched_domain_attr;
 
+static inline void
+partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
+			       struct sched_domain_attr *dattr_new)
+{
+}
+
 static inline void
 partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 			struct sched_domain_attr *dattr_new)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 56a0fed30c0a..fb7ae691cb82 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1850,15 +1850,15 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
  * ndoms_new == 0 is a special case for destroying existing domains,
  * and it will not create the default domain.
  *
- * Call with hotplug lock held
+ * Call with hotplug lock and sched_domains_mutex held
  */
-void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
-			     struct sched_domain_attr *dattr_new)
+void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
+				    struct sched_domain_attr *dattr_new)
 {
 	int i, j, n;
 	int new_topology;
 
-	mutex_lock(&sched_domains_mutex);
+	lockdep_assert_held(&sched_domains_mutex);
 
 	/* Always unregister in case we don't destroy any domains: */
 	unregister_sched_domain_sysctl();
@@ -1923,6 +1923,15 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	ndoms_cur = ndoms_new;
 
 	register_sched_domain_sysctl();
+}
 
+/*
+ * Call with hotplug lock held
+ */
+void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
+			     struct sched_domain_attr *dattr_new)
+{
+	mutex_lock(&sched_domains_mutex);
+	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
 	mutex_unlock(&sched_domains_mutex);
 }
-- 
2.17.1

