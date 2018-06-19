Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9864CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4798920693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DjILYyYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4798920693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757455AbeFSWOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:14:52 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34694 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755448AbeFSWO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:14:28 -0400
Received: by mail-pg0-f66.google.com with SMTP id q4-v6so500549pgr.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 15:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+NpMArTutrU+//2UVvjwhyz79n1hzg+Zn2qyoxW1OrY=;
        b=DjILYyYifnTCg7tpFsFcuQdbXufB00BEAp1FkOr5X+PNpU5v11V1hdr0YdSie9v+YE
         GgbOckXr5PGpcZpzHiWcUSJdU3scrf83XYjtcEsYJ6xn6eUdne+9a5ifMLm0i0GxB7YG
         y1ypyVYzPdr942Ed4hNPRiDn+4E4RJfGHxTCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+NpMArTutrU+//2UVvjwhyz79n1hzg+Zn2qyoxW1OrY=;
        b=lsPT7L8CvPpMrudD9VsmXVWFg7jfJDXQxtmcx2DZrTGc1U9vX2wUgIXeZbVdXBZpeP
         PeOE9QnPZiJH54kQTtmEFUpVG3nDaTwjK1H5tAIZdxntupQcHz4UhjMD09Xa/J0zB1t9
         8bFxqn9DTRUWoekvRvM286kDXrc3DkN7k8Q3BCb1V9ZupzUuWLQjlgVVRLWLc2QOqOlB
         fUv0LaSlVruGg979eUg1wLIyurKwFVIKp/ViL+vIoyUJ4o784sG5W32DzKBdz1efgj6A
         7AC9q7+W2/pIQMruwZ80oaFtrVqOjfboQK/L+Itk1zIBoOuSLgnkZhm690Z9Z/VWBLcZ
         mSAw==
X-Gm-Message-State: APt69E3NftsmhjLA5QgzGWveClPJ9bSPgsAFeJoEZVBEn/96WWwNOv/L
        fdxYrsH25XFWOvKWaK84+wimOD6ZZRg=
X-Google-Smtp-Source: ADUXVKI8sW1DfsZZh33fovkkCZLZD93Y8+zRWeaK+RPeG1fJARwb4gPlEjeGF59JKmXPNi4zT2HyEQ==
X-Received: by 2002:a65:5006:: with SMTP id f6-v6mr16456813pgo.116.1529446467699;
        Tue, 19 Jun 2018 15:14:27 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id n85-v6sm841389pfa.146.2018.06.19.15.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 15:14:27 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        peterz@infradead.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 2/3] rcutorture: Add support to detect if boost kthread prio is too low
Date:   Tue, 19 Jun 2018 15:14:18 -0700
Message-Id: <20180619221419.41340-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180619221419.41340-1-joel@joelfernandes.org>
References: <20180619221419.41340-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

When rcutorture is built as a built-in, we can detect that and raise the
priority of RCU's kthreads enough that rcutorture's boost threads will
not be able to starve them. We do so in earlier patches.

However, if rcutorture is built as a module, we wouldn't have raised the
RCU thread's priorities and we don't want to raise them for
non-rcutorture-builtin kernels since we don't want to risk folks who may
already be depending on the old thread priorities. For this reason,  we
can't test for boost if rcutorture is built as a module. This patch
detects this situation and prints an message from the rcutorture module
if such a scenario is detected so that the user knows what to do inorder
to remedy it (that is manually pass rcutree.kthread_prio of a higher
value so that boosting can be tested).

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu.h        |  2 ++
 kernel/rcu/rcutorture.c | 32 ++++++++++++++++++++++++++++----
 kernel/rcu/tree.c       |  7 +++++++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index b53745371bfb..0af6ce6d8b66 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -547,6 +547,7 @@ static inline void rcu_force_quiescent_state(void) { }
 static inline void rcu_bh_force_quiescent_state(void) { }
 static inline void rcu_sched_force_quiescent_state(void) { }
 static inline void show_rcu_gp_kthreads(void) { }
+static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
 #else /* #ifdef CONFIG_TINY_RCU */
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_bh_get_gp_seq(void);
@@ -555,6 +556,7 @@ unsigned long rcu_exp_batches_completed(void);
 unsigned long rcu_exp_batches_completed_sched(void);
 unsigned long srcu_batches_completed(struct srcu_struct *sp);
 void show_rcu_gp_kthreads(void);
+int rcu_get_gp_kthreads_prio(void);
 void rcu_force_quiescent_state(void);
 void rcu_bh_force_quiescent_state(void);
 void rcu_sched_force_quiescent_state(void);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index f2cde4dd432d..2d1af5ffe536 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1786,6 +1786,32 @@ static void rcu_torture_barrier_cleanup(void)
 	}
 }
 
+static bool rcu_torture_can_boost(void)
+{
+	static int boost_warn_once;
+	int prio;
+
+	if (!(test_boost == 1 && cur_ops->can_boost) && test_boost != 2)
+		return false;
+
+	prio = rcu_get_gp_kthreads_prio();
+	if (!prio)
+		return false;
+
+	if (prio < 2) {
+		if (boost_warn_once  == 1)
+			return false;
+
+		pr_alert("%s: WARN: RCU kthread priority too low to test boosting. "
+			 "Skipping RCU boost test. Try passing rcutree.kthread_prio > 1 "
+			 "on the kernel command line.\n", KBUILD_MODNAME);
+		boost_warn_once = 1;
+		return false;
+	}
+
+	return true;
+}
+
 static enum cpuhp_state rcutor_hp;
 
 static void
@@ -1830,8 +1856,7 @@ rcu_torture_cleanup(void)
 	torture_stop_kthread(rcu_torture_fqs, fqs_task);
 	for (i = 0; i < ncbflooders; i++)
 		torture_stop_kthread(rcu_torture_cbflood, cbflood_task[i]);
-	if ((test_boost == 1 && cur_ops->can_boost) ||
-	    test_boost == 2)
+	if (rcu_torture_can_boost())
 		cpuhp_remove_state(rcutor_hp);
 
 	/*
@@ -2055,8 +2080,7 @@ rcu_torture_init(void)
 		test_boost_interval = 1;
 	if (test_boost_duration < 2)
 		test_boost_duration = 2;
-	if ((test_boost == 1 && cur_ops->can_boost) ||
-	    test_boost == 2) {
+	if (rcu_torture_can_boost()) {
 
 		boost_starttime = jiffies + test_boost_interval * HZ;
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 92c29439eba6..7832dd556490 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -183,6 +183,13 @@ module_param(gp_init_delay, int, 0444);
 static int gp_cleanup_delay;
 module_param(gp_cleanup_delay, int, 0444);
 
+/* Retreive RCU kthreads priority for rcutorture */
+int rcu_get_gp_kthreads_prio(void)
+{
+	return kthread_prio;
+}
+EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
+
 /*
  * Number of grace periods between delays, normalized by the duration of
  * the delay.  The longer the delay, the more the grace periods between
-- 
2.18.0.rc1.244.gcf134e6275-goog

