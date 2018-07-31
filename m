Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1AFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4086208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4086208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbeGaCgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:36:24 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:49423 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731785AbeGaCgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:36:24 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 31 Jul 2018 09:58:42 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.222.33)
        by 156.147.1.125 with ESMTP; 31 Jul 2018 09:58:42 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@lge.com, ying.huang@intel.com, peterz@infradead.org,
        mingo@kernel.org, jiangshanlai@gmail.com,
        paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        joel@joelfernandes.org, len.brown@intel.com, glider@google.com,
        peter@hurleysoftware.com, aik@ozlabs.ru
Subject: [QUESTION] llist: Comment releasing 'must delete' restriction before traversing
Date:   Tue, 31 Jul 2018 09:58:36 +0900
Message-Id: <1532998716-5037-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

I'm careful in saying.. and curious about..

In restrictive cases like only addtions happen but never deletion, can't
we safely traverse a llist? I believe llist can be more useful if we can
release the restriction. Can't we?

If yes, we may add another function traversing starting from a head. Or
just use existing funtion with head->first.

Thank a lot for your answers in advance :)

----->8-----
From 1e73882799b269cd86e7a7c955021e3a18d1e6cf Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul.park@lge.com>
Date: Tue, 31 Jul 2018 09:31:57 +0900
Subject: [QUESTION] llist: Comment releasing 'must delete' restriction before
 traversing

llist traversing can run without deletion in restrictive cases all
items are added but never deleted like a rculist traversing such as
list_for_each_entry_lockless. So add the comment.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/llist.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 85abc29..d012d3e 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -32,8 +32,12 @@
  * operation, with "-" being no lock needed, while "L" being lock is needed.
  *
  * The list entries deleted via llist_del_all can be traversed with
- * traversing function such as llist_for_each etc.  But the list
- * entries can not be traversed safely before deleted from the list.
+ * traversing function such as llist_for_each etc.  Normally the list
+ * entries cannot be traversed safely before deleted from the list
+ * except the cases items are added to the list but never deleted.  In
+ * that restrictive cases the list may be safely traversed concurrently
+ * with llist_add.
+ *
  * The order of deleted entries is from the newest to the oldest added
  * one.  If you want to traverse from the oldest to the newest, you
  * must reverse the order by yourself before traversing.
@@ -116,7 +120,9 @@ static inline void init_llist_head(struct llist_head *list)
  *
  * In general, some entries of the lock-less list can be traversed
  * safely only after being deleted from list, so start with an entry
- * instead of list head.
+ * instead of list head.  But in restrictive cases items are added to
+ * the list but never deleted, the list may be safely traversed
+ * concurrently with llist_add.
  *
  * If being used on entries deleted from lock-less list directly, the
  * traverse order is from the newest to the oldest added entry.  If
@@ -135,7 +141,9 @@ static inline void init_llist_head(struct llist_head *list)
  *
  * In general, some entries of the lock-less list can be traversed
  * safely only after being deleted from list, so start with an entry
- * instead of list head.
+ * instead of list head.  But in restrictive cases items are added to
+ * the list but never deleted, the list may be safely traversed
+ * concurrently with llist_add.
  *
  * If being used on entries deleted from lock-less list directly, the
  * traverse order is from the newest to the oldest added entry.  If
@@ -153,7 +161,9 @@ static inline void init_llist_head(struct llist_head *list)
  *
  * In general, some entries of the lock-less list can be traversed
  * safely only after being removed from list, so start with an entry
- * instead of list head.
+ * instead of list head.  But in restrictive cases items are added to
+ * the list but never deleted, the list may be safely traversed
+ * concurrently with llist_add.
  *
  * If being used on entries deleted from lock-less list directly, the
  * traverse order is from the newest to the oldest added entry.  If
@@ -175,7 +185,9 @@ static inline void init_llist_head(struct llist_head *list)
  *
  * In general, some entries of the lock-less list can be traversed
  * safely only after being removed from list, so start with an entry
- * instead of list head.
+ * instead of list head.  But in restrictive cases items are added to
+ * the list but never deleted, the list may be safely traversed
+ * concurrently with llist_add.
  *
  * If being used on entries deleted from lock-less list directly, the
  * traverse order is from the newest to the oldest added entry.  If
-- 
1.9.1

