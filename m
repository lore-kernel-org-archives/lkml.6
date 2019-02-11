Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78EAC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9A420873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfBKKtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:49:53 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36229 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfBKKtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:49:52 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1BAngG13498603
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 02:49:42 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1BAnfaU3498600;
        Mon, 11 Feb 2019 02:49:41 -0800
Date:   Mon, 11 Feb 2019 02:49:41 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Luc Van Oostenryck <tipbot@zytor.com>
Message-ID: <tip-99687cdbb3f6c8e32bcc7f37496e811f30460e48@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com,
        luc.vanoostenryck@gmail.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org
Reply-To: hpa@zytor.com, luc.vanoostenryck@gmail.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <20190118144936.79158-1-luc.vanoostenryck@gmail.com>
References: <20190118144936.79158-1-luc.vanoostenryck@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology: Fix percpu data types in struct
 sd_data & struct s_data
Git-Commit-ID: 99687cdbb3f6c8e32bcc7f37496e811f30460e48
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

Commit-ID:  99687cdbb3f6c8e32bcc7f37496e811f30460e48
Gitweb:     https://git.kernel.org/tip/99687cdbb3f6c8e32bcc7f37496e811f30460e48
Author:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
AuthorDate: Fri, 18 Jan 2019 15:49:36 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 11 Feb 2019 08:02:15 +0100

sched/topology: Fix percpu data types in struct sd_data & struct s_data

The percpu members of struct sd_data and s_data are declared as:

	struct ... ** __percpu member;

So their type is:

	__percpu pointer to pointer to struct ...

But looking at how they're used, their type should be:

	pointer to __percpu pointer to struct ...

and they should thus be declared as:

	struct ... * __percpu *member;

So fix the placement of '__percpu' in the definition of these
structures.

This addresses a bunch of Sparse's warnings like:

	warning: incorrect type in initializer (different address spaces)
	  expected void const [noderef] <asn:3> *__vpp_verify
	  got struct sched_domain **

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190118144936.79158-1-luc.vanoostenryck@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched/topology.h | 8 ++++----
 kernel/sched/topology.c        | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index c31d3a47a47c..57c7ed3fe465 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -176,10 +176,10 @@ typedef int (*sched_domain_flags_f)(void);
 #define SDTL_OVERLAP	0x01
 
 struct sd_data {
-	struct sched_domain **__percpu sd;
-	struct sched_domain_shared **__percpu sds;
-	struct sched_group **__percpu sg;
-	struct sched_group_capacity **__percpu sgc;
+	struct sched_domain *__percpu *sd;
+	struct sched_domain_shared *__percpu *sds;
+	struct sched_group *__percpu *sg;
+	struct sched_group_capacity *__percpu *sgc;
 };
 
 struct sched_domain_topology_level {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 4ae9403420ed..93ff526e77b0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -705,7 +705,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 }
 
 struct s_data {
-	struct sched_domain ** __percpu sd;
+	struct sched_domain * __percpu *sd;
 	struct root_domain	*rd;
 };
 
