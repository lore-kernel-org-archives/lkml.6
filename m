Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16C7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9693520811
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBGV3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:29:09 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:51875 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfBGV3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:29:08 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B1509C0004;
        Thu,  7 Feb 2019 21:29:03 +0000 (UTC)
Date:   Thu, 7 Feb 2019 22:29:02 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Greg Hartman <ghartman@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v2 1/2] sched/wait: introduce wait_event_freezable_hrtimeout
Message-ID: <83f5fae47b56e79aebaddcaecff1c1a6d9c292cf.1549564792.git.hle@owl.eu.com>
References: <cover.1549564792.git.hle@owl.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549564792.git.hle@owl.eu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

introduce wait_event_freezable_hrtimeout, an interruptible and freezable
version of wait_event_hrtimeout.

This helper will allow for simplifications in staging/android/vsoc.c, among
others.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
Changes in v2:
  - No change.

 include/linux/wait.h | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 5f3efabc36f4..c4cf5113f58a 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -483,7 +483,7 @@ do {										\
 	__ret;									\
 })
 
-#define __wait_event_hrtimeout(wq_head, condition, timeout, state)		\
+#define __wait_event_hrtimeout(wq_head, condition, timeout, state, cmd)		\
 ({										\
 	int __ret = 0;								\
 	struct hrtimer_sleeper __t;						\
@@ -500,7 +500,7 @@ do {										\
 			__ret = -ETIME;						\
 			break;							\
 		}								\
-		schedule());							\
+		cmd);							        \
 										\
 	hrtimer_cancel(&__t.timer);						\
 	destroy_hrtimer_on_stack(&__t.timer);					\
@@ -529,7 +529,23 @@ do {										\
 	might_sleep();								\
 	if (!(condition))							\
 		__ret = __wait_event_hrtimeout(wq_head, condition, timeout,	\
-					       TASK_UNINTERRUPTIBLE);		\
+					       TASK_UNINTERRUPTIBLE,		\
+					       schedule());			\
+	__ret;									\
+})
+
+/*
+ * like wait_event_hrtimeout() -- except it uses TASK_INTERRUPTIBLE to avoid
+ * increasing load and is freezable.
+ */
+#define wait_event_freezable_hrtimeout(wq_head, condition, timeout)		\
+({										\
+	int __ret = 0;								\
+	might_sleep();								\
+	if (!(condition))							\
+		__ret = __wait_event_hrtimeout(wq_head, condition, timeout,	\
+					       TASK_INTERRUPTIBLE,		\
+					       freezable_schedule());		\
 	__ret;									\
 })
 
@@ -555,7 +571,8 @@ do {										\
 	might_sleep();								\
 	if (!(condition))							\
 		__ret = __wait_event_hrtimeout(wq, condition, timeout,		\
-					       TASK_INTERRUPTIBLE);		\
+					       TASK_INTERRUPTIBLE,		\
+					       schedule());			\
 	__ret;									\
 })
 
-- 
2.20.1
