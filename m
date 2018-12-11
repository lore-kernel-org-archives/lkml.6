Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4118BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C65720849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C65720849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeLKPaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:30:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51205 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeLKPaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:30:13 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFTe4g4041563
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:29:40 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFTetc4041559;
        Tue, 11 Dec 2018 07:29:40 -0800
Date:   Tue, 11 Dec 2018 07:29:40 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-fe27b0de8dfcdf8482558ce5d25e697fe74d851e@git.kernel.org>
Cc:     johannes@sipsolutions.net, sasha.levin@oracle.com,
        longman@redhat.com, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, bvanassche@acm.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, bvanassche@acm.org,
          torvalds@linux-foundation.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, sasha.levin@oracle.com,
          johannes@sipsolutions.net, mingo@kernel.org, longman@redhat.com
In-Reply-To: <20181207011148.251812-14-bvanassche@acm.org>
References: <20181207011148.251812-14-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Stop using RCU primitives to
 access 'all_lock_classes'
Git-Commit-ID: fe27b0de8dfcdf8482558ce5d25e697fe74d851e
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

Commit-ID:  fe27b0de8dfcdf8482558ce5d25e697fe74d851e
Gitweb:     https://git.kernel.org/tip/fe27b0de8dfcdf8482558ce5d25e697fe74d851e
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 6 Dec 2018 17:11:37 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 14:54:56 +0100

locking/lockdep: Stop using RCU primitives to access 'all_lock_classes'

Due to the previous patch all code that accesses the 'all_lock_classes'
list holds the graph lock. Hence use regular list primitives instead of
their RCU variants to access this list.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: johannes.berg@intel.com
Cc: tj@kernel.org
Link: https://lkml.kernel.org/r/20181207011148.251812-14-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 737d2dd3ea56..5c837a537273 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -629,7 +629,8 @@ static int static_obj(void *obj)
 
 /*
  * To make lock name printouts unique, we calculate a unique
- * class->name_version generation counter:
+ * class->name_version generation counter. The caller must hold the graph
+ * lock.
  */
 static int count_matching_names(struct lock_class *new_class)
 {
@@ -639,7 +640,7 @@ static int count_matching_names(struct lock_class *new_class)
 	if (!new_class->name)
 		return 0;
 
-	list_for_each_entry_rcu(class, &all_lock_classes, lock_entry) {
+	list_for_each_entry(class, &all_lock_classes, lock_entry) {
 		if (new_class->key - new_class->subclass == class->key)
 			return class->name_version;
 		if (class->name && !strcmp(class->name, new_class->name))
@@ -803,7 +804,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	/*
 	 * Add it to the global list of classes:
 	 */
-	list_add_tail_rcu(&class->lock_entry, &all_lock_classes);
+	list_add_tail(&class->lock_entry, &all_lock_classes);
 
 	if (verbose(class)) {
 		graph_unlock();
@@ -4141,7 +4142,7 @@ static void zap_class(struct lock_class *class)
 	 * Unhash the class and remove it from the all_lock_classes list:
 	 */
 	hlist_del_rcu(&class->hash_entry);
-	list_del_rcu(&class->lock_entry);
+	list_del(&class->lock_entry);
 
 	RCU_INIT_POINTER(class->key, NULL);
 	RCU_INIT_POINTER(class->name, NULL);
