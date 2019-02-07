Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FA0C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7579E21721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfBGUD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:03:57 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:40251 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfBGUD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:03:56 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 9E8851BF205;
        Thu,  7 Feb 2019 20:03:52 +0000 (UTC)
Date:   Thu, 7 Feb 2019 21:03:52 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] sched/wait: use freezable_schedule when possible
Message-ID: <20190207200352.GA27859@behemoth.owl.eu.com.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace schedule(); try_to_freeze() by freezable_schedule().

Tasks calling freezable_schedule() set the PF_FREEZER_SKIP flag
before calling schedule(). Unlike tasks calling schedule();
try_to_freeze() tasks calling freezable_schedule() are not awaken by
try_to_freeze_tasks(). Instead they call try_to_freeze() when they
wake up if the freeze is still underway.

It is not a problem since sleeping tasks can't do anything which isn't
allowed for a frozen task while sleeping.

The result is a potential performance gain during freeze, since less
tasks have to be awaken.

For instance on a bare Debian vm running a 4.19 stable kernel, the
number of tasks skipped in freeze_task() went up from 12 without the
patch to 32 with the patch (out of 448), an increase of > x2.5.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
Changes in v2:
  - Add test results to commit message.
  - Split from initial patch set[0] since this patch can go in separately
    [0] https://lkml.org/lkml/2019/2/1/19

 include/linux/wait.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index ed7c122cb31f..5f3efabc36f4 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -308,7 +308,7 @@ do {										\
 
 #define __wait_event_freezable(wq_head, condition)				\
 	___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0,		\
-			    schedule(); try_to_freeze())
+			    freezable_schedule())
 
 /**
  * wait_event_freezable - sleep (or freeze) until a condition gets true
@@ -367,7 +367,7 @@ do {										\
 #define __wait_event_freezable_timeout(wq_head, condition, timeout)		\
 	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
 		      TASK_INTERRUPTIBLE, 0, timeout,				\
-		      __ret = schedule_timeout(__ret); try_to_freeze())
+		      __ret = freezable_schedule_timeout(__ret))
 
 /*
  * like wait_event_timeout() -- except it uses TASK_INTERRUPTIBLE to avoid
@@ -588,7 +588,7 @@ do {										\
 
 #define __wait_event_freezable_exclusive(wq, condition)				\
 	___wait_event(wq, condition, TASK_INTERRUPTIBLE, 1, 0,			\
-			schedule(); try_to_freeze())
+			freezable_schedule())
 
 #define wait_event_freezable_exclusive(wq, condition)				\
 ({										\
-- 
2.20.1
