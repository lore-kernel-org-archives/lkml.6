Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5059ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F05421470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F05421470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeJSRkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:40:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54405 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSRkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:40:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9J9YN9G1183636
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 Oct 2018 02:34:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9J9YNm81183633;
        Fri, 19 Oct 2018 02:34:23 -0700
Date:   Fri, 19 Oct 2018 02:34:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-01a14bda11add9dcd4a59200f13834d634559935@git.kernel.org>
Cc:     mingo@kernel.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, will.deacon@arm.com,
        peterz@infradead.org, longman@redhat.com, hpa@zytor.com
Reply-To: longman@redhat.com, hpa@zytor.com, akpm@linux-foundation.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          will.deacon@arm.com, peterz@infradead.org,
          paulmck@linux.vnet.ibm.com, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <1539913518-15598-2-git-send-email-longman@redhat.com>
References: <1539913518-15598-2-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Make global debug_locks*
 variables read-mostly
Git-Commit-ID: 01a14bda11add9dcd4a59200f13834d634559935
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

Commit-ID:  01a14bda11add9dcd4a59200f13834d634559935
Gitweb:     https://git.kernel.org/tip/01a14bda11add9dcd4a59200f13834d634559935
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Thu, 18 Oct 2018 21:45:18 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Oct 2018 07:53:18 +0200

locking/lockdep: Make global debug_locks* variables read-mostly

Make the frequently used lockdep global variable debug_locks read-mostly.
As debug_locks_silent is sometime used together with debug_locks,
it is also made read-mostly so that they can be close together.

With false cacheline sharing, cacheline contention problem can happen
depending on what get put into the same cacheline as debug_locks.

Signed-off-by: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/1539913518-15598-2-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/debug_locks.h | 4 ++--
 lib/debug_locks.c           | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
index 120225e9a366..257ab3c92cb8 100644
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -8,8 +8,8 @@
 
 struct task_struct;
 
-extern int debug_locks;
-extern int debug_locks_silent;
+extern int debug_locks __read_mostly;
+extern int debug_locks_silent __read_mostly;
 
 
 static inline int __debug_locks_off(void)
diff --git a/lib/debug_locks.c b/lib/debug_locks.c
index 124fdf238b3d..ce51749cc145 100644
--- a/lib/debug_locks.c
+++ b/lib/debug_locks.c
@@ -21,7 +21,7 @@
  * that would just muddy the log. So we report the first one and
  * shut up after that.
  */
-int debug_locks = 1;
+int debug_locks __read_mostly = 1;
 EXPORT_SYMBOL_GPL(debug_locks);
 
 /*
@@ -29,7 +29,7 @@ EXPORT_SYMBOL_GPL(debug_locks);
  * 'silent failure': nothing is printed to the console when
  * a locking bug is detected.
  */
-int debug_locks_silent;
+int debug_locks_silent __read_mostly;
 EXPORT_SYMBOL_GPL(debug_locks_silent);
 
 /*
