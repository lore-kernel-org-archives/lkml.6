Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859CDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0F920856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbfAQIsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:48:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32828 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfAQIr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:47:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so10063086wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 00:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aOQfSRK6Cu00XkimRyJoEETFz42MVog205vqP9ZMoCo=;
        b=j++Zb85NJtYEANAmbti21Y+bYkU7YyLixgxE0Apf2gHd9EQzW3LIIOxotb13jLmI6N
         xYVDyLCh2VTLwjZ5JWwJ/tRKOSiEWYlfqgdZZKtoqUJCBKfmMMMMCE+3+JALToLlzlm2
         6zk7rcM3U40S91MJSITj8TjAl9ajexA59K9Sc2J0ojZIpYCNh/8xXhzgo7rpHzYNbP7J
         4k4Kcqn2DlsGpUKmsDoDvB4XS5Vyv1QVDcaHvxdaiUZby8KOzrq9rnoccZMx5tCR87CF
         T7jtGc2cy7jBUP+FyzSLEEfYWnPdL7pGyWcqC/cCY/EWD1pEVfz6Hqz/vg5Kz8vawVZu
         wyFQ==
X-Gm-Message-State: AJcUukcTbXC4n2f+eYPa2vHzkhV6a/Ao9zS3rhP8tyz+u8oPIoSmHBbZ
        TRMfxyJFiJS7ddbloMg1NvBCKA==
X-Google-Smtp-Source: ALg8bN4kO+MRynPH/Hg+MMkeoxMSfr8NhXS6RJVQH6Cl45cN7HUfzSVgOjY91IViK7B2m05VFxb27w==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr10532377wrv.308.1547714875758;
        Thu, 17 Jan 2019 00:47:55 -0800 (PST)
Received: from localhost.localdomain.home ([151.15.254.62])
        by smtp.gmail.com with ESMTPSA id 199sm41984992wmh.21.2019.01.17.00.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 00:47:55 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: [PATCH v6 1/5] sched/topology: Adding function partition_sched_domains_locked()
Date:   Thu, 17 Jan 2019 09:47:35 +0100
Message-Id: <20190117084739.17078-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190117084739.17078-1-juri.lelli@redhat.com>
References: <20190117084739.17078-1-juri.lelli@redhat.com>
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
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/topology.h | 10 ++++++++++
 kernel/sched/topology.c        | 17 +++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 6b9976180c1e..d69e7d56253a 100644
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
index 8d7f15ba5916..dd94000cb378 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1929,15 +1929,15 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
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
@@ -2002,6 +2002,15 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
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
2.17.2

