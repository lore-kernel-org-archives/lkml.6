Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02267C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B58218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbeLSNfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:35:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55389 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbeLSNfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:35:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so6060185wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yxQqjWOIpPFjphv8cd9U8LQMva1zRKA2JWoAw2dI/3k=;
        b=F9OwjvYyeneRFfN5b1OrEOQF5eaK3SRGlWzuucEHnH4EWRqCml+k6A63e8kdjoKjuk
         400XGsXeMnexYI8b2uZ96Tk2KSpF+mLblq3jh2Uxi0GzLc/Ts2wt9ZMBfwY5a/p6zH0I
         dCxEE+ctgSWQRJA95JdCnS2N8PZ6I8Qm+VtGJQKfgmVfQ0pOyxA00ysCXovlZlIP/S95
         X8J5HyRu3r7taxE3XJ5Lr4iM21QI2Hoz6ODRN0Zjm30Uc+e/tP6+o85TCPx4j0zMhrRW
         oytHXHn5VW1LxJg1Ul0VAJU1AXpdS+kJimHn9ksdpA+8AFnfMwkTpVga8ANQrcQt/tgJ
         LLvg==
X-Gm-Message-State: AA+aEWYISj4eUWzKXZLgf2THoD5zKeDDMyGC3/VQ1KV+2TdzUc2gNU/D
        iodllFUeojoKIYI+9JRGkOxk9A==
X-Google-Smtp-Source: AFSGD/W2Q5/b7r1G37HpS5l9jMdsGdv/FkUzJfFw/4YFno+bJlVKkEKlqCajHyHc5tRvDmm7yWo39A==
X-Received: by 2002:a1c:c008:: with SMTP id q8mr6641073wmf.99.1545226507466;
        Wed, 19 Dec 2018 05:35:07 -0800 (PST)
Received: from localhost.localdomain.home ([151.15.249.65])
        by smtp.gmail.com with ESMTPSA id o16sm6251542wrn.11.2018.12.19.05.35.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 05:35:06 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     lizefan@huawei.com, mingo@redhat.com, peterz@infradead.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 1/2] cgroup/cpuset: Update stale generate_sched_domains() comments
Date:   Wed, 19 Dec 2018 14:34:44 +0100
Message-Id: <20181219133445.31982-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fc560a26acce ("cpuset: replace cpuset->stack_list with
cpuset_for_each_descendant_pre()") removed the local list (q)
that was used to perform a top-down scan of all cpusets;
however, comments mentioning it were not updated.

Update comments to reflect current implementation.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/cgroup/cpuset.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f0decd8165e7..f0822a730879 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -725,11 +725,10 @@ static inline int nr_cpusets(void)
  * Must be called with cpuset_mutex held.
  *
  * The three key local variables below are:
- *    q  - a linked-list queue of cpuset pointers, used to implement a
- *	   top-down scan of all cpusets.  This scan loads a pointer
- *	   to each cpuset marked is_sched_load_balance into the
- *	   array 'csa'.  For our purposes, rebuilding the schedulers
- *	   sched domains, we can ignore !is_sched_load_balance cpusets.
+ *    cp - cpuset pointer, used (together with pos_css) to perform a
+ *	   top-down scan of all cpusets. For our purposes, rebuilding
+ *	   the schedulers sched domains, we can ignore !is_sched_load_
+ *	   balance cpusets.
  *  csa  - (for CpuSet Array) Array of pointers to all the cpusets
  *	   that need to be load balanced, for convenient iterative
  *	   access by the subsequent code that finds the best partition,
@@ -760,7 +759,7 @@ static inline int nr_cpusets(void)
 static int generate_sched_domains(cpumask_var_t **domains,
 			struct sched_domain_attr **attributes)
 {
-	struct cpuset *cp;	/* scans q */
+	struct cpuset *cp;	/* top-down scan of cpusets */
 	struct cpuset **csa;	/* array of all cpuset ptrs */
 	int csn;		/* how many cpuset ptrs in csa so far */
 	int i, j, k;		/* indices for partition finding loops */
-- 
2.17.2

