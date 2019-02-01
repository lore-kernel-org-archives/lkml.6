Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5C0C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA89820863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfBAFik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:38:40 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:59091 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfBAFij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:38:39 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C70C8E0002;
        Fri,  1 Feb 2019 05:38:35 +0000 (UTC)
Date:   Fri, 1 Feb 2019 06:38:35 +0100
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
Subject: [PATCH 2/3] sched/wait: introduce wait_event_freezable_hrtimeout
Message-ID: <647b057e1fef497c591d5009cbb20692e7df9785.1548998323.git.hle@owl.eu.com>
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

introduce wait_event_freezable_hrtimeout, an interruptible and freezable
version of wait_event_hrtimeout.

Among others this helper will allow for simplifications in
staging/android/vsoc.c.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
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
