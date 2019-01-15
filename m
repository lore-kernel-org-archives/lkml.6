Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AC4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CD020656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfAOKT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:19:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58347 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfAOKT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:19:28 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0FAItGc2471815
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Jan 2019 02:18:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0FAItPr2471812;
        Tue, 15 Jan 2019 02:18:55 -0800
Date:   Tue, 15 Jan 2019 02:18:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-a4cffdad731447217701d3bc6da4587bbb4d2cbd@git.kernel.org>
Cc:     paulmck@linux.ibm.com, mingo@kernel.org, tglx@linutronix.de,
        fweisbec@gmail.com, linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: paulmck@linux.ibm.com, mingo@kernel.org, tglx@linutronix.de,
          hpa@zytor.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20181220170525.GA12579@linux.ibm.com>
References: <20181220170525.GA12579@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] time: Move CONTEXT_TRACKING to
 kernel/time/Kconfig
Git-Commit-ID: a4cffdad731447217701d3bc6da4587bbb4d2cbd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a4cffdad731447217701d3bc6da4587bbb4d2cbd
Gitweb:     https://git.kernel.org/tip/a4cffdad731447217701d3bc6da4587bbb4d2cbd
Author:     Paul E. McKenney <paulmck@linux.ibm.com>
AuthorDate: Thu, 20 Dec 2018 09:05:25 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 15 Jan 2019 11:16:41 +0100

time: Move CONTEXT_TRACKING to kernel/time/Kconfig

Both CONTEXT_TRACKING and CONTEXT_TRACKING_FORCE are currently defined
in kernel/rcu/kconfig, which might have made sense at some point, but
no longer does given that RCU refers to neither of these Kconfig options.

Therefore move them to kernel/time/Kconfig, where the rest of the
NO_HZ_FULL Kconfig options live.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: https://lkml.kernel.org/r/20181220170525.GA12579@linux.ibm.com


---
 kernel/rcu/Kconfig  | 30 ------------------------------
 kernel/time/Kconfig | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 939a2056c87a..37301430970e 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -87,36 +87,6 @@ config RCU_STALL_COMMON
 config RCU_NEED_SEGCBLIST
 	def_bool ( TREE_RCU || PREEMPT_RCU || TREE_SRCU )
 
-config CONTEXT_TRACKING
-       bool
-
-config CONTEXT_TRACKING_FORCE
-	bool "Force context tracking"
-	depends on CONTEXT_TRACKING
-	default y if !NO_HZ_FULL
-	help
-	  The major pre-requirement for full dynticks to work is to
-	  support the context tracking subsystem. But there are also
-	  other dependencies to provide in order to make the full
-	  dynticks working.
-
-	  This option stands for testing when an arch implements the
-	  context tracking backend but doesn't yet fullfill all the
-	  requirements to make the full dynticks feature working.
-	  Without the full dynticks, there is no way to test the support
-	  for context tracking and the subsystems that rely on it: RCU
-	  userspace extended quiescent state and tickless cputime
-	  accounting. This option copes with the absence of the full
-	  dynticks subsystem by forcing the context tracking on all
-	  CPUs in the system.
-
-	  Say Y only if you're working on the development of an
-	  architecture backend for the context tracking.
-
-	  Say N otherwise, this option brings an overhead that you
-	  don't want in production.
-
-
 config RCU_FANOUT
 	int "Tree-based hierarchical RCU fanout value"
 	range 2 64 if 64BIT
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 58b981f4bb5d..e2c038d6c13c 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -117,6 +117,35 @@ config NO_HZ_FULL
 
 endchoice
 
+config CONTEXT_TRACKING
+       bool
+
+config CONTEXT_TRACKING_FORCE
+	bool "Force context tracking"
+	depends on CONTEXT_TRACKING
+	default y if !NO_HZ_FULL
+	help
+	  The major pre-requirement for full dynticks to work is to
+	  support the context tracking subsystem. But there are also
+	  other dependencies to provide in order to make the full
+	  dynticks working.
+
+	  This option stands for testing when an arch implements the
+	  context tracking backend but doesn't yet fullfill all the
+	  requirements to make the full dynticks feature working.
+	  Without the full dynticks, there is no way to test the support
+	  for context tracking and the subsystems that rely on it: RCU
+	  userspace extended quiescent state and tickless cputime
+	  accounting. This option copes with the absence of the full
+	  dynticks subsystem by forcing the context tracking on all
+	  CPUs in the system.
+
+	  Say Y only if you're working on the development of an
+	  architecture backend for the context tracking.
+
+	  Say N otherwise, this option brings an overhead that you
+	  don't want in production.
+
 config NO_HZ
 	bool "Old Idle dynticks config"
 	depends on !ARCH_USES_GETTIMEOFFSET && GENERIC_CLOCKEVENTS
