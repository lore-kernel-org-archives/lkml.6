Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5268BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0DF206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="S4rXoscp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0DF206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbeIHC2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:28:15 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:23620 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbeIHC2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356719; x=1567892719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qRCzs//SMvr7g8Nh36wgd8B2yoMLD5wBUcLhukFY21U=;
  b=S4rXoscppFfr3J4rBF3xbkupAm+RRhUONCNPMm7NQpSNcSzJVRNMZxhM
   SmHFjQbVWBdY73XWYlypmU+3Z2zdnNT+fjx0XqRS2iP8JoZuVSD9B5gKo
   jdhpdoC/0w+j0w4cfKHrl6QyHEndjMlkxGYWOfbKV3NkzMkoBkQ80DClw
   E=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="757370597"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-2eab95aa.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:36 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2b-2eab95aa.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LfFhe125512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:17 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LfDjR027113
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:14 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LfDHB027112;
        Fri, 7 Sep 2018 23:41:13 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 03/60] sched: Setup sched_domain_shared for all sched_domains
Date:   Fri,  7 Sep 2018 23:39:50 +0200
Message-Id: <20180907214047.26914-4-jschoenh@amazon.de>
X-Mailer: git-send-email 2.9.3.1.gcba166c.dirty
In-Reply-To: <20180907214047.26914-1-jschoenh@amazon.de>
References: <20180907214047.26914-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relax the restriction to setup a sched_domain_shared only for domains
with SD_SHARE_PKG_RESOURCES. Set it up for every domain.

This restriction was imposed since the struct was created via commit
24fc7edb92ee ("sched/core: Introduce 'struct sched_domain_shared'") for
the lack of another use case. This will change soon.

Also, move the structure definition below kernel/sched/. It is not used
outside and in the future it will carry some more internal types that
we don't want to expose.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 include/linux/sched/topology.h |  6 ------
 kernel/sched/sched.h           |  6 ++++++
 kernel/sched/topology.c        | 12 ++++--------
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 26347741ba50..530ad856372e 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -68,12 +68,6 @@ extern int sched_domain_level_max;
 
 struct sched_group;
 
-struct sched_domain_shared {
-	atomic_t	ref;
-	atomic_t	nr_busy_cpus;
-	int		has_idle_cores;
-};
-
 struct sched_domain {
 	/* These fields must be setup */
 	struct sched_domain *parent;	/* top domain must be null terminated */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b4d0e8a68697..f6da85447f3c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -915,6 +915,12 @@ struct rq {
 #endif
 };
 
+struct sched_domain_shared {
+	atomic_t	ref;
+	atomic_t	nr_busy_cpus;
+	int		has_idle_cores;
+};
+
 static inline int cpu_of(struct rq *rq)
 {
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 56a0fed30c0a..8b64f3f57d50 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1184,15 +1184,11 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->idle_idx = 1;
 	}
 
-	/*
-	 * For all levels sharing cache; connect a sched_domain_shared
-	 * instance.
-	 */
-	if (sd->flags & SD_SHARE_PKG_RESOURCES) {
-		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
-		atomic_inc(&sd->shared->ref);
+	/* Setup a shared sched_domain_shared instance */
+	sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
+	atomic_inc(&sd->shared->ref);
+	if (sd->flags & SD_SHARE_PKG_RESOURCES)
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
-	}
 
 	sd->private = sdd;
 
-- 
2.9.3.1.gcba166c.dirty

