Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C7CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D7F20890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D7F20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbeG3VQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:16:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35285 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731816AbeG3VQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:16:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6UJdrEw2423016
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 12:39:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6UJdqtT2423013;
        Mon, 30 Jul 2018 12:39:52 -0700
Date:   Mon, 30 Jul 2018 12:39:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Joel Fernandes (Google)" <tipbot@zytor.com>
Message-ID: <tip-fc91a3c4c27acdca0bc13af6fbb68c35cfd519f2@git.kernel.org>
Cc:     arnd@arndb.de, yang.shi@linux.alibaba.com, hpa@zytor.com,
        longman@redhat.com, tglx@linutronix.de, joel@joelfernandes.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, joel@joelfernandes.org,
          yang.shi@linux.alibaba.com, arnd@arndb.de, longman@redhat.com,
          hpa@zytor.com
In-Reply-To: <20180723212531.202328-1-joel@joelfernandes.org>
References: <20180723212531.202328-1-joel@joelfernandes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/debugobjects] debugobjects: Make stack check warning more
 informative
Git-Commit-ID: fc91a3c4c27acdca0bc13af6fbb68c35cfd519f2
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

Commit-ID:  fc91a3c4c27acdca0bc13af6fbb68c35cfd519f2
Gitweb:     https://git.kernel.org/tip/fc91a3c4c27acdca0bc13af6fbb68c35cfd519f2
Author:     Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate: Mon, 23 Jul 2018 14:25:31 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 30 Jul 2018 21:36:37 +0200

debugobjects: Make stack check warning more informative

While debugging an issue debugobject tracking warned about an annotation
issue of an object on stack. It turned out that the issue was due to the
object in concern being on a different stack which was due to another
issue.

Thomas suggested to print the pointers and the location of the stack for
the currently running task. This helped to figure out that the object was
on the wrong stack.

As this is general useful information for debugging similar issues, make
the error message more informative by printing the pointers.

[ tglx: Massaged changelog ]

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Yang Shi <yang.shi@linux.alibaba.com>
Cc: kernel-team@android.com
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: astrachan@google.com
Link: https://lkml.kernel.org/r/20180723212531.202328-1-joel@joelfernandes.org

---
 lib/debugobjects.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 994be4805cec..24c1df0d7466 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -360,9 +360,12 @@ static void debug_object_is_on_stack(void *addr, int onstack)
 
 	limit++;
 	if (is_on_stack)
-		pr_warn("object is on stack, but not annotated\n");
+		pr_warn("object %p is on stack %p, but NOT annotated.\n", addr,
+			 task_stack_page(current));
 	else
-		pr_warn("object is not on stack, but annotated\n");
+		pr_warn("object %p is NOT on stack %p, but annotated.\n", addr,
+			 task_stack_page(current));
+
 	WARN_ON(1);
 }
 
