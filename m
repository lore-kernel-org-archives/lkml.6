Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F44C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F12020652
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="e93WQJoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfBWGfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:35:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33402 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbfBWGe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 01:34:59 -0500
Received: by mail-qt1-f196.google.com with SMTP id z39so5163131qtz.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 22:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jdV6wy+jDVHFrKow+yC2lWMVIASermFDO9APgnn8BDA=;
        b=e93WQJoNz7sL11KjqrcaGD5cGCsOh2htcsisG1aGdQYshASs4Jc8YIlLUcBv+PFM33
         D5SWT5Nbb9ONDe8CUUIld7RbTnOXcTah8lcBA2VAi3xuQVZszD3UQ2BKlE/VdsuMB5KH
         PaecNNtBBlmH9U1q0e7SJNBT9GNC8OsaTTc0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jdV6wy+jDVHFrKow+yC2lWMVIASermFDO9APgnn8BDA=;
        b=AF3YVYITjGWcW0mgGEtHVuEuBGz6eSYSja5b8+KjGoo/BK6jyrEq6KRxzTDn6aZHDx
         CQLbnLglOqTjCsLwMaxvLGV60RHc2hpaNDka2/lyUJkZ1gxIpiSWfZPFGGBRZUaEDqyN
         831/VOf07FoyuoaFXPZlDQHaJmKRdD5ltK5XKS9r5Zc3m1mP0IQ21fbWBFSljHB/6JwE
         BGMPEIsl4JbNYW+S0ru2afvK0rBxfiKqo+RoK9x7Fx7HKOOSU4FLhn8nBuShoJVVX2qY
         CgxhD6NONtiZCgajUWMcWJJHI0/r72UsF3IhKRuGoG/Tn9H1P61wv2bOSWIf7uI5e0s3
         MOzw==
X-Gm-Message-State: AHQUAubVPo8z2MBX3hjfDXbUrHpblxwGt0Cmh1JvkgX8apWBZoXww4AZ
        ZwCnRdr5R2aYIWYUmt3S/w3ERngc4Dc=
X-Google-Smtp-Source: AHgI3IYUzePHeJZ/2cTwvTYtmlfODE8tk06HOknOJmB1l0wnBlQb5lzZBnzUiwOy8RZ2bqcwHt/XFQ==
X-Received: by 2002:ac8:166b:: with SMTP id x40mr6020562qtk.363.1550903697258;
        Fri, 22 Feb 2019 22:34:57 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id d32sm2189408qtc.88.2019.02.22.22.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 22:34:56 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: [PATCH v2 4/6] sched_domain: Annotate RCU pointers properly
Date:   Sat, 23 Feb 2019 01:34:32 -0500
Message-Id: <20190223063434.6793-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190223063434.6793-1-joel@joelfernandes.org>
References: <20190223063434.6793-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scheduler uses RCU API in various places to access sched_domain
pointers. These cause sparse errors as below.

Many new errors show up because of an annotation check I added to
rcu_assign_pointer(). Let us annotate the pointers correctly which also
will help sparse catch any potential future bugs.

This fixes the following sparse errors:

rt.c:1681:9: error: incompatible types in comparison expression
deadline.c:1904:9: error: incompatible types in comparison expression
core.c:519:9: error: incompatible types in comparison expression
core.c:1634:17: error: incompatible types in comparison expression
fair.c:6193:14: error: incompatible types in comparison expression
fair.c:9883:22: error: incompatible types in comparison expression
fair.c:9897:9: error: incompatible types in comparison expression
sched.h:1287:9: error: incompatible types in comparison expression
topology.c:612:9: error: incompatible types in comparison expression
topology.c:615:9: error: incompatible types in comparison expression
sched.h:1300:9: error: incompatible types in comparison expression
topology.c:618:9: error: incompatible types in comparison expression
sched.h:1287:9: error: incompatible types in comparison expression
topology.c:621:9: error: incompatible types in comparison expression
sched.h:1300:9: error: incompatible types in comparison expression
topology.c:624:9: error: incompatible types in comparison expression
topology.c:671:9: error: incompatible types in comparison expression
stats.c:45:17: error: incompatible types in comparison expression
fair.c:5998:15: error: incompatible types in comparison expression
fair.c:5989:15: error: incompatible types in comparison expression
fair.c:5998:15: error: incompatible types in comparison expression
fair.c:5989:15: error: incompatible types in comparison expression
fair.c:6120:19: error: incompatible types in comparison expression
fair.c:6506:14: error: incompatible types in comparison expression
fair.c:6515:14: error: incompatible types in comparison expression
fair.c:6623:9: error: incompatible types in comparison expression
fair.c:5970:17: error: incompatible types in comparison expression
fair.c:8642:21: error: incompatible types in comparison expression
fair.c:9253:9: error: incompatible types in comparison expression
fair.c:9331:9: error: incompatible types in comparison expression
fair.c:9519:15: error: incompatible types in comparison expression
fair.c:9533:14: error: incompatible types in comparison expression
fair.c:9542:14: error: incompatible types in comparison expression
fair.c:9567:14: error: incompatible types in comparison expression
fair.c:9597:14: error: incompatible types in comparison expression
fair.c:9421:16: error: incompatible types in comparison expression
fair.c:9421:16: error: incompatible types in comparison expression

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/sched/topology.h |  4 ++--
 kernel/sched/sched.h           | 14 +++++++-------
 kernel/sched/topology.c        | 10 +++++-----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index c31d3a47a47c..4819c9e01e42 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -76,8 +76,8 @@ struct sched_domain_shared {
 
 struct sched_domain {
 	/* These fields must be setup */
-	struct sched_domain *parent;	/* top domain must be null terminated */
-	struct sched_domain *child;	/* bottom domain must be null terminated */
+	struct sched_domain __rcu *parent;	/* top domain must be null terminated */
+	struct sched_domain __rcu *child;	/* bottom domain must be null terminated */
 	struct sched_group *groups;	/* the balancing groups of the domain */
 	unsigned long min_interval;	/* Minimum balance interval ms */
 	unsigned long max_interval;	/* Maximum balance interval ms */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2ab545d40381..ca6a79f57e7a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -866,8 +866,8 @@ struct rq {
 	atomic_t		nr_iowait;
 
 #ifdef CONFIG_SMP
-	struct root_domain	*rd;
-	struct sched_domain	*sd;
+	struct root_domain		*rd;
+	struct sched_domain __rcu	*sd;
 
 	unsigned long		cpu_capacity;
 	unsigned long		cpu_capacity_orig;
@@ -1305,13 +1305,13 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
 	return sd;
 }
 
-DECLARE_PER_CPU(struct sched_domain *, sd_llc);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
-DECLARE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
-DECLARE_PER_CPU(struct sched_domain *, sd_numa);
-DECLARE_PER_CPU(struct sched_domain *, sd_asym_packing);
-DECLARE_PER_CPU(struct sched_domain *, sd_asym_cpucapacity);
+DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 extern struct static_key_false sched_asym_cpucapacity;
 
 struct sched_group_capacity {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 3f35ba1d8fde..0844ee757dad 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -586,13 +586,13 @@ static void destroy_sched_domains(struct sched_domain *sd)
  * the cpumask of the domain), this allows us to quickly tell if
  * two CPUs are in the same cache domain, see cpus_share_cache().
  */
-DEFINE_PER_CPU(struct sched_domain *, sd_llc);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
-DEFINE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
-DEFINE_PER_CPU(struct sched_domain *, sd_numa);
-DEFINE_PER_CPU(struct sched_domain *, sd_asym_packing);
-DEFINE_PER_CPU(struct sched_domain *, sd_asym_cpucapacity);
+DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 
 static void update_top_cache_domain(int cpu)
-- 
2.21.0.rc0.258.g878e2cd30e-goog

