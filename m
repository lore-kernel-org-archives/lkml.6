Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3EEC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD6F20863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfBAFiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:38:10 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:57195 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfBAFiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:38:10 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B02B420003;
        Fri,  1 Feb 2019 05:38:05 +0000 (UTC)
Date:   Fri, 1 Feb 2019 06:38:05 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Greg Hartman <ghartman@google.com>,
        Alistair Strachan <strachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 1/3] sched/wait: use freezable_schedule when possible
Message-ID: <d9b2ed186ed6fcacaaecd876bb66dca8fa329d8b.1548998323.git.hle@owl.eu.com>
References: <cover.1548998323.git.hle@owl.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548998323.git.hle@owl.eu.com>
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

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
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
