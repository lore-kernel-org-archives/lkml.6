Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6CA81C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2DE204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2DE204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935553AbeFMMRc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:17:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52421 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935510AbeFMMRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:17:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id p126-v6so4355006wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 05:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6SMVSyv+4v+rxLRex8lkbAGAQgAUiM++vv/TY3cqMeI=;
        b=Gg1MB1dsAAogV+kyQuqgwb1toy6M+yReE7CIa2N2fyGlW1ek+FrolvsPhQwxtIWUU3
         jIsrz2rbxy+pwxf0m1k4sjKwMIdS7wsqyY+fNL89hbtDN8R3PCSrSXGQCZ6Nro3xAzIc
         D9FzUNFre+mnB2Ul4NNGwwJ9yGPOIjEDTi5RuGz66ROxd1RIsO4DxQtQXihdGulgFp7n
         sk8RnFGQPptHKh22XEnD/3onjvU0gzhjgmKaSB71cPDrY0zOYHqH+TQBvmULpcCdabA1
         hCsL9u7cT5kLD+cKIaTisAiBeQHEzWXHpQTiV5+KE17wbl7PUQv9W/mcx3ybOCdhnz3G
         dqdw==
X-Gm-Message-State: APt69E1H+rUy1sOKVr+6cdy5tlrfk1zcyRt5pJmQIDH/M06MRCguXgal
        fVdkHmCIV+dS7tAf/SxSwtX3Rg==
X-Google-Smtp-Source: ADUXVKJrUg7/yEtigHzPV1FHxpEOcUhv+B2H8e0Dkwti7fiFOD6SLnbS+nXfqKfSPDalLcXk8iT85w==
X-Received: by 2002:a1c:3fc2:: with SMTP id m185-v6mr3233832wma.37.1528892248719;
        Wed, 13 Jun 2018 05:17:28 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id 137-v6sm4943673wmv.28.2018.06.13.05.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 05:17:28 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: [PATCH v4 2/5] sched/topology: Adding function partition_sched_domains_locked()
Date:   Wed, 13 Jun 2018 14:17:08 +0200
Message-Id: <20180613121711.5018-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180613121711.5018-1-juri.lelli@redhat.com>
References: <20180613121711.5018-1-juri.lelli@redhat.com>
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
 kernel/sched/topology.c        | 18 ++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

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
index 96eee22fafe8..25a5727d3b48 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1850,16 +1850,16 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
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
 
 	lockdep_assert_cpus_held();
-	mutex_lock(&sched_domains_mutex);
+	lockdep_assert_held(&sched_domains_mutex);
 
 	/* Always unregister in case we don't destroy any domains: */
 	unregister_sched_domain_sysctl();
@@ -1924,6 +1924,16 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	ndoms_cur = ndoms_new;
 
 	register_sched_domain_sysctl();
+}
 
+/*
+ * Call with hotplug lock held
+ */
+void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
+			     struct sched_domain_attr *dattr_new)
+{
+	lockdep_assert_cpus_held();
+	mutex_lock(&sched_domains_mutex);
+	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
 	mutex_unlock(&sched_domains_mutex);
 }
-- 
2.14.3

